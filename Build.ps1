[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$InstallSourcePath,
    [Parameter(Mandatory = $true)]
    [string]$Registry,
    [Parameter(Mandatory = $false)]
    [array]$Tags = @("*"),
    [Parameter(Mandatory = $false)]
    [ValidateSet("WhenChanged", "Always", "Never")]
    [string]$PushMode = "WhenChanged"
)

function Find-BuildSpecifications
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
        [string]$InstallSourcePath
    )

    Get-ChildItem -Path $Path -Filter "build.json" -Recurse | ForEach-Object {
        $data = Get-Content -Path $_.FullName | ConvertFrom-Json
        $tag = $data.tag
        $sources = @()
        $baseImages = @()

        # Resolve the full path on each source file
        $data.sources | ForEach-Object {
            $sources += (Join-Path $InstallSourcePath $_)
        }

        # Find base images
        Get-ChildItem -Path $_.Directory.FullName -Filter "Dockerfile" | ForEach-Object {
            Get-Content -Path $_.FullName | Where-Object { $_.StartsWith("FROM ") } | ForEach-Object { Write-Output $_.Replace("FROM ", "").Trim() } | ForEach-Object {
                $image = $_

                if ($image -like "* as *")
                {
                    $image = $image.Substring(0, $image.IndexOf(" as "))
                }

                if ([string]::IsNullOrEmpty($image))
                {
                    throw ("Invalid Dockerfile '{0}', no FROM image was found?" -f $_.FullName)
                }

                $baseImages += $image
            }
        }

        Write-Output (New-Object PSObject -Property @{
                Tag      = $tag;  
                Base     = $baseImages;                      
                Path     = $_.Directory.FullName;
                Sources  = $sources;
                Priority = $null;
                Include  = $null;
            })
    }
}

# Setup
$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

$rootPath = (Join-Path $PSScriptRoot "\images")

# Specify priority for each tag, used to ensure base images are build first. This is the most simple approach I could come up with for handling dependencies between images. If needed in the future, look into something like https://en.wikipedia.org/wiki/Topological_sorting.
$defaultPriority = 1000
$priorities = New-Object System.Collections.Specialized.OrderedDictionary
$priorities.Add("^sitecore-base:(.*)$", 100)
$priorities.Add("^sitecore-openjdk:(.*)$", 200)
$priorities.Add("^(.*)$", $defaultPriority)
    
# Find out what to build
$unsortedSpecs = Find-BuildSpecifications -Path $rootPath -InstallSourcePath $InstallSourcePath

# Update specs, include or not
$unsortedSpecs | ForEach-Object {
    $spec = $_
    $spec.Include = ($Tags | ForEach-Object { $spec.Tag -like $_ }) -contains $true
}

# Update specs, set priority according to rules
$unsortedSpecs | ForEach-Object {
    $spec = $_
    $rule = $priorities.Keys | Where-Object { $spec.Tag -match $_ } | Select-Object -First 1
    
    $spec.Priority = $priorities[$rule]
}

# Reorder specs, priorities goes first
$specs = [System.Collections.ArrayList]@()
$specs.AddRange(($unsortedSpecs | Where-Object { $_.Priority -lt $defaultPriority } | Sort-Object -Property Priority))
$specs.AddRange(($unsortedSpecs | Where-Object { $_.Priority -eq $defaultPriority }))

# Print results
$specs | Select-Object -Property Tag, Include, Priority, Base | Format-Table

Write-Host "### Build specifications loaded..." -ForegroundColor Green

# Pull latest external images
$specs | Select-Object -ExpandProperty Base | Where-Object { $_ -notmatch "^sitecore-(.*)$" } | Select-Object -Unique | ForEach-Object {
    $tag = $_

    docker pull $tag

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

    Write-Host ("### External image '{0}' is latest." -f $tag)
}

Write-Host "### External images is up to date..." -ForegroundColor Green

# Start build...
$specs | Where-Object { $_.Include } | Sort-Object -Property Version, Order | ForEach-Object {
    $spec = $_
    $tag = $spec.Tag

    Write-Host ("### Processing '{0}'..." -f $tag)
    
    # Save the digest of previous builds for later comparison
    $previousDigest = $null
    
    if ((docker image ls $tag --quiet))
    {
        $previousDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
    }

    # Copy any missing source files into build context
    $spec.Sources | ForEach-Object {
        $sourcePath = $_
        $sourceItem = Get-Item -Path $sourcePath
        $targetPath = Join-Path $spec.Path $sourceItem.Name

        if (!(Test-Path -Path $targetPath))
        {
            Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
        }
    }
    
    # Build image
    docker image build --isolation "hyperv" --memory 4GB --tag $tag $spec.Path

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

    # Tag image
    $fulltag = "{0}/{1}" -f $Registry, $tag

    docker image tag $tag $fulltag

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

    # Check to see if we need to stop here...
    if ($PushMode -eq "Never")
    {
        Write-Warning ("### Done with '{0}', but not pushed since 'PushMode' is '{1}'." -f $tag, $PushMode)

        return
    }

    # Determine if we need to push
    $currentDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }

    if (($PushMode -eq "WhenChanged") -and ($currentDigest -eq $previousDigest))
    {
        Write-Host ("### Done with '{0}', but not pushed since 'PushMode' is '{1}' and the image has not changed since last build." -f $tag, $PushMode) -ForegroundColor Green

        return
    }

    # Push image
    docker image push $fulltag

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

    Write-Host ("### Done with '{0}', image pushed." -f $fulltag) -ForegroundColor Green
}

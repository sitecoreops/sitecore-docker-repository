# Repository of Sitecore Docker base images

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Build your own Docker images out of every released Sitecore version since 8.2 rev. 170407 (Update 3) - the first version that officially supported Windows Server 2016. There are some older versions too if your interested! See [Current images](#current-images) for an up-to-date list of which base images available and [Current variants](#current-variants) for variants (base images with additional modules installed). You can use this repository (preferably from a fork) from you own build server and have it build and push images to your own private Docker registry. Jump to the [How to use](#how-to-use) section for more details.

## Changelog

- [Added] Added Sitecore 9.1.1 XM and XP on 1903. Thanks [@jballe](https://github.com/jballe) :+1:
- [Added] Node support for JSS CM images, the integrated Mode require node on the instance for Server-Side Rendering (SSR). [@bplasmeijer](https://github.com/bplasmeijer)
- [Changed] Fixed tags for JSS images, was tagged with 10.0.1 instead of 11.0.1 which is the version installed, see [#35](https://github.com/sitecoreops/sitecore-images/issues/35). Thanks [@mikkelvalentinsorensen](https://github.com/mikkelvalentinsorensen) :+1:
- [Changed] Sitecore 9.1.1 XM and XP SQL images are now based on the new `mssql-developer:2017-windowsservercore-ltsc2019` image.
- [Added] Microsoft SQL Server 2017 base image on ltsc2019 added.
- [Added] New variant: Sitecore 9.1.1 with Sitecore Experience Accelerator (SXA). Thanks [@bplasmeijer](https://github.com/bplasmeijer) :+1:
- [Added] New variant: Sitecore 9.1.1 with Sitecore JavaScript Services (JSS). Thanks [@bplasmeijer](https://github.com/bplasmeijer) :+1:
- [Added] New variant: Sitecore 9.1.1 with PowerShell Extensions (PSE). Thanks [@bplasmeijer](https://github.com/bplasmeijer) :+1:
- [Added] New variants build support. See [How to use](#how-to-use) and [Current variants](#current-variants).
- [Changed] Sitecore 9.1.1 IIS app pools now runs as `LocalSystem` so they are allowed to write to volume mounts on Windows Server 2016/2019 hosts.
- [Fixed] Sitecore Solr images on 1809 now runs as `ContainerAdministrator` again to fix access denied errors, see [#27](https://github.com/sitecoreops/sitecore-images/issues/27). Thanks [@joostmeijles](https://github.com/joostmeijles) :+1:
- [**Breaking**] Sitecore 9.1.1 XM images renamed **back** to `xm1`, see [#28](https://github.com/sitecoreops/sitecore-images/issues/28). Thanks [@sergeyshushlyapin](https://github.com/sergeyshushlyapin) :+1:
- [Changed] Sitecore 9.1.1 images now overrides default `ENTRYPOINT` to get `ServiceMonitor` to monitor and inject Docker defined environment variables into the Application Pool that runs Sitecore. Thanks [@jballe](https://github.com/jballe) :+1:
- [Changed] Sitecore 9.1.1 XP Solr image now runs the additional xConnect Solr core configuration from `App_Data`. Thanks [@joostmeijles](https://github.com/joostmeijles) :+1:
- [Added] Sitecore 9.1.1 XM and XP on ltsc2019/1809, ~~please notice that the `xm1` tags is now just `xm`~~.
- [**Breaking**] Sitecore 9.1.0 images tagged with `9.1.001564` is renamed to `9.1.0` to align with the [new Sitecore NuGet versioning](https://sitecore.myget.org/feed/sc-packages/package/nuget/Sitecore.Kernel/9.1.0).
- [Added] Sitecore 7.5.150212 CM/CD and SQL on 1803.
- [Added] Sitecore 8.2.161221 CM/CD and SQL on 1709/1803.
- [Fixed] Removed VOLUME instructions from 9.1.0/9.0.2 Solr and SQL on 1809/ltsc2019/1803, see [#22](https://github.com/sitecoreops/sitecore-images/issues/22).
- [Fixed] Build process now takes tag filters into account when pulling external base images.
- [Added] Sitecore 9.1.0 XP CM/CD/xConnect on ltsc2019, SQL Developer and Solr (7.2.1) on 1809.
- [Added] Sitecore 9.1.0 XP CM/CD/xConnect on 1803, SQL Developer and Solr (7.2.1) on 1803.
- [Added] Sitecore 8.2.180406 Solr on nanoserver-1809.
- [Added] Sitecore 8.2.180406 CD/CM/Processing and Reporting on windowsservercore-ltsc2019.
- [Fixed] Solr `write.lock` files are now deleted before Solr start, see [#15](https://github.com/sitecoreops/sitecore-images/issues/15).
- [Added] Sitecore 9.0.2 XP CM/CD/xConnect, SQL Developer and Solr on 1803.
- [Added] Sitecore 9.0.2 XM1 CM/CD, SQL Developer and Solr on 1709.
- [Added] Sitecore 9.1.0 XM1 CM/CD, SQL Developer and Solr (7.2.1) on 1803. Please note the new XM1 specific tags for SQL and Solr.
- [Changed] Restructured Sitecore 9.1.0 XM1 CM/CD/base docker files to use multi-stage builds, number of layers reduced from 25 to 13 and the size is also reduced to 5.06 GB on ltsc2019.
- [Added] Sitecore 9.1.0 XM1 CM/CD, SQL Developer on ltsc2019 and Solr (7.2.1) on 1809. Please note the new XM1 specific tags for SQL and Solr.
- [Changed] Updated Sitecore 9.0.1, 9.0.2 Solr images to latest patch release: 6.6.3.
- [Changed] Updated openjdk base images used for Solr to latest version: java-1.8.0-openjdk-1.8.0.191-1.b12.
- [Added] Sitecore 9.0.2 XM1 CM/CD, SQL Developer on ltsc2019 and Solr on 1809.
- [Changed] Migrated Microsoft base images to use the [new official registry "mcr.microsoft.com"](https://azure.microsoft.com/en-us/blog/microsoft-syndicates-container-catalog/).
- [Added] Sitecore 8.2.180406 Solr on nanoserver-1803.
- [Added] Sitecore 8.2.180406 SQL Developer on windowsservercore-1803.
- [Added] CD, CM, Processing and Reporting roles to Sitecore 8.2.180406 on windowsservercore-1803.
- [Added] Sitecore 8.2.* on windowsservercore-1803.
- [Added] Sitecore 9.0.2 XM1 CM/CD, SQL Developer and Solr on 1803.
- [Added] Sitecore 9.0.1 on windowsservercore-1803.
- [Added] Sitecore 9.0.1 Solr on nanoserver-1803.
- [Added] Sitecore 9.0.1 SQL Developer on windowsservercore-1803.
- [Added] Sitecore 9.0.1 Solr on windowsservercore-1709.
- [Added] Sitecore 9.0.1 SQL Developer on windowsservercore-1709.
- [**Breaking**] Restructured versions and tags to support multiple Windows channels (ltsc2016, 1709, 1803 etc), there are now more repositories per version, one for each topology/role. See [Tags and Windows versions](#tags-and-windows-versions).
- [**Breaking**] Decoupled image tags from structure by specifying full tag in "build.json".
- [Added] Sitecore 8.2 Update 7.
- [Fixed] Added UrlRewrite outbound rule to handle Sitecore redirect after login when container is running on another port than 80 (possible in Windows 10 1803).
- [Fixed] Solr build errors regarding downloads from github (TLS 1.2 now used).
- [Added] Specialized Solr image with all Sitecore cores embedded **and** volume support, for Sitecore 9.0.1 (which defaults to use Solr).
- [Added] Specialized SQL Server images with all Sitecore databases embedded **and** volume support, for Sitecore 9.
- [Changed] all Sitecore 9 images now default has connection strings matching the new specialized SQL Server images.
- [Added] XM1 CM and CD role images for Sitecore 9.

## Current images

| Version | Repository | OS  | Build | Tag |
| ------- | ---------- | --- | -----------| --- |
| 9.1.1 | sitecore-xp-xconnect-indexworker | windowsservercore | ltsc2019 | `sitecore-xp-xconnect-indexworker:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-xconnect-indexworker/Dockerfile) |
| 9.1.1 | sitecore-xp-xconnect-automationengine | windowsservercore | ltsc2019 | `sitecore-xp-xconnect-automationengine:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-xconnect-automationengine/Dockerfile) |
| 9.1.1 | sitecore-xp-xconnect | windowsservercore | ltsc2019 | `sitecore-xp-xconnect:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-xconnect/Dockerfile) |
| 9.1.1 | sitecore-xp-standalone | windowsservercore | ltsc2019 | `sitecore-xp-standalone:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-standalone/Dockerfile) |
| 9.1.1 | sitecore-xp-sqldev | windowsservercore | ltsc2019 | `sitecore-xp-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xp-cd | windowsservercore | ltsc2019 | `sitecore-xp-cd:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-cd/Dockerfile) |
| 9.1.1 | sitecore-xp-base | windowsservercore | ltsc2019 | `sitecore-xp-base:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xp-base/Dockerfile) |
| 9.1.1 | sitecore-xm1-sqldev | windowsservercore | ltsc2019 | `sitecore-xm1-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xm1-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xm1-cm | windowsservercore | ltsc2019 | `sitecore-xm1-cm:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xm1-cm/Dockerfile) |
| 9.1.1 | sitecore-xm1-cd | windowsservercore | ltsc2019 | `sitecore-xm1-cd:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-xm1-cd/Dockerfile) |
| 9.1.1 | sitecore-base | windowsservercore | ltsc2019 | `sitecore-base:9.1.1-windowsservercore-ltsc2019` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-ltsc2019/sitecore-base/Dockerfile) |
| 9.1.1 | sitecore-xp-xconnect-indexworker | windowsservercore | 1903 | `sitecore-xp-xconnect-indexworker:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-xconnect-indexworker/Dockerfile) |
| 9.1.1 | sitecore-xp-xconnect-automationengine | windowsservercore | 1903 | `sitecore-xp-xconnect-automationengine:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-xconnect-automationengine/Dockerfile) |
| 9.1.1 | sitecore-xp-xconnect | windowsservercore | 1903 | `sitecore-xp-xconnect:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-xconnect/Dockerfile) |
| 9.1.1 | sitecore-xp-standalone | windowsservercore | 1903 | `sitecore-xp-standalone:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-standalone/Dockerfile) |
| 9.1.1 | sitecore-xp-sqldev | windowsservercore | 1903 | `sitecore-xp-sqldev:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xp-solr | nanoserver | 1903 | `sitecore-xp-solr:9.1.1-nanoserver-1903` [Dockerfile](images/9.1.1%20rev.%20002459/nanoserver-1903/sitecore-xp-solr/Dockerfile) |
| 9.1.1 | sitecore-xp-cd | windowsservercore | 1903 | `sitecore-xp-cd:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-cd/Dockerfile) |
| 9.1.1 | sitecore-xp-base | windowsservercore | 1903 | `sitecore-xp-base:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xp-base/Dockerfile) |
| 9.1.1 | sitecore-xm1-sqldev | windowsservercore | 1903 | `sitecore-xm1-sqldev:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xm1-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xm1-solr | nanoserver | 1903 | `sitecore-xm1-solr:9.1.1-nanoserver-1903` [Dockerfile](images/9.1.1%20rev.%20002459/nanoserver-1903/sitecore-xm1-solr/Dockerfile) |
| 9.1.1 | sitecore-xm1-cm | windowsservercore | 1903 | `sitecore-xm1-cm:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xm1-cm/Dockerfile) |
| 9.1.1 | sitecore-xm1-cd | windowsservercore | 1903 | `sitecore-xm1-cd:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-xm1-cd/Dockerfile) |
| 9.1.1 | sitecore-base | windowsservercore | 1903 | `sitecore-base:9.1.1-windowsservercore-1903` [Dockerfile](images/9.1.1%20rev.%20002459/windowsservercore-1903/sitecore-base/Dockerfile) |
| 9.1.1 | sitecore-xp-solr | nanoserver | 1809 | `sitecore-xp-solr:9.1.1-nanoserver-1809` [Dockerfile](images/9.1.1%20rev.%20002459/nanoserver-1809/sitecore-xp-solr/Dockerfile) |
| 9.1.1 | sitecore-xm1-solr | nanoserver | 1809 | `sitecore-xm1-solr:9.1.1-nanoserver-1809` [Dockerfile](images/9.1.1%20rev.%20002459/nanoserver-1809/sitecore-xm1-solr/Dockerfile) |
| 9.1.0 | sitecore-xp-xconnect-indexworker | windowsservercore | ltsc2019 | `sitecore-xp-xconnect-indexworker:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-xconnect-indexworker/Dockerfile) |
| 9.1.0 | sitecore-xp-xconnect-automationengine | windowsservercore | ltsc2019 | `sitecore-xp-xconnect-automationengine:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-xconnect-automationengine/Dockerfile) |
| 9.1.0 | sitecore-xp-xconnect | windowsservercore | ltsc2019 | `sitecore-xp-xconnect:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-xconnect/Dockerfile) |
| 9.1.0 | sitecore-xp-standalone | windowsservercore | ltsc2019 | `sitecore-xp-standalone:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-standalone/Dockerfile) |
| 9.1.0 | sitecore-xp-sqldev | windowsservercore | ltsc2019 | `sitecore-xp-sqldev:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-sqldev/Dockerfile) |
| 9.1.0 | sitecore-xp-cd | windowsservercore | ltsc2019 | `sitecore-xp-cd:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-cd/Dockerfile) |
| 9.1.0 | sitecore-xp-base | windowsservercore | ltsc2019 | `sitecore-xp-base:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xp-base/Dockerfile) |
| 9.1.0 | sitecore-xm1-sqldev | windowsservercore | ltsc2019 | `sitecore-xm1-sqldev:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xm1-sqldev/Dockerfile) |
| 9.1.0 | sitecore-xm1-cm | windowsservercore | ltsc2019 | `sitecore-xm1-cm:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xm1-cm/Dockerfile) |
| 9.1.0 | sitecore-xm1-cd | windowsservercore | ltsc2019 | `sitecore-xm1-cd:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-xm1-cd/Dockerfile) |
| 9.1.0 | sitecore-base | windowsservercore | ltsc2019 | `sitecore-base:9.1.0-windowsservercore-ltsc2019` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-ltsc2019/sitecore-base/Dockerfile) |
| 9.1.0 | sitecore-xp-solr | nanoserver | 1809 | `sitecore-xp-solr:9.1.0-nanoserver-1809` [Dockerfile](images/9.1.0%20rev.%20001564/nanoserver-1809/sitecore-xp-solr/Dockerfile) |
| 9.1.0 | sitecore-xm1-solr | nanoserver | 1809 | `sitecore-xm1-solr:9.1.0-nanoserver-1809` [Dockerfile](images/9.1.0%20rev.%20001564/nanoserver-1809/sitecore-xm1-solr/Dockerfile) |
| 9.1.0 | sitecore-xp-xconnect-indexworker | windowsservercore | 1803 | `sitecore-xp-xconnect-indexworker:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-xconnect-indexworker/Dockerfile) |
| 9.1.0 | sitecore-xp-xconnect-automationengine | windowsservercore | 1803 | `sitecore-xp-xconnect-automationengine:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-xconnect-automationengine/Dockerfile) |
| 9.1.0 | sitecore-xp-xconnect | windowsservercore | 1803 | `sitecore-xp-xconnect:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-xconnect/Dockerfile) |
| 9.1.0 | sitecore-xp-standalone | windowsservercore | 1803 | `sitecore-xp-standalone:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-standalone/Dockerfile) |
| 9.1.0 | sitecore-xp-sqldev | windowsservercore | 1803 | `sitecore-xp-sqldev:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-sqldev/Dockerfile) |
| 9.1.0 | sitecore-xp-solr | nanoserver | 1803 | `sitecore-xp-solr:9.1.0-nanoserver-1803` [Dockerfile](images/9.1.0%20rev.%20001564/nanoserver-1803/sitecore-xp-solr/Dockerfile) |
| 9.1.0 | sitecore-xp-cd | windowsservercore | 1803 | `sitecore-xp-cd:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-cd/Dockerfile) |
| 9.1.0 | sitecore-xp-base | windowsservercore | 1803 | `sitecore-xp-base:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xp-base/Dockerfile) |
| 9.1.0 | sitecore-xm1-sqldev | windowsservercore | 1803 | `sitecore-xm1-sqldev:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xm1-sqldev/Dockerfile) |
| 9.1.0 | sitecore-xm1-solr | nanoserver | 1803 | `sitecore-xm1-solr:9.1.0-nanoserver-1803` [Dockerfile](images/9.1.0%20rev.%20001564/nanoserver-1803/sitecore-xm1-solr/Dockerfile) |
| 9.1.0 | sitecore-xm1-cm | windowsservercore | 1803 | `sitecore-xm1-cm:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xm1-cm/Dockerfile) |
| 9.1.0 | sitecore-xm1-cd | windowsservercore | 1803 | `sitecore-xm1-cd:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-xm1-cd/Dockerfile) |
| 9.1.0 | sitecore-base | windowsservercore | 1803 | `sitecore-base:9.1.0-windowsservercore-1803` [Dockerfile](images/9.1.0%20rev.%20001564/windowsservercore-1803/sitecore-base/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cm | windowsservercore | ltsc2019 | `sitecore-xm1-cm:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-xm1-cm/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cd | windowsservercore | ltsc2019 | `sitecore-xm1-cd:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-xm1-cd/Dockerfile) |
| 9.0.180604 | sitecore-sqldev | windowsservercore | ltsc2019 | `sitecore-sqldev:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-sqldev/Dockerfile) |
| 9.0.180604 | sitecore-base | windowsservercore | ltsc2019 | `sitecore-base:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-base/Dockerfile) |
| 9.0.180604 | sitecore-solr | nanoserver | 1809 | `sitecore-solr:9.0.180604-nanoserver-1809` [Dockerfile](images/9.0.2%20rev.%20180604/nanoserver-1809/sitecore-solr/Dockerfile) |
| 9.0.180604 | sitecore-xp-xconnect-indexworker | windowsservercore | 1803 | `sitecore-xp-xconnect-indexworker:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-xconnect-indexworker/Dockerfile) |
| 9.0.180604 | sitecore-xp-xconnect-automationengine | windowsservercore | 1803 | `sitecore-xp-xconnect-automationengine:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-xconnect-automationengine/Dockerfile) |
| 9.0.180604 | sitecore-xp-xconnect | windowsservercore | 1803 | `sitecore-xp-xconnect:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-xconnect/Dockerfile) |
| 9.0.180604 | sitecore-xp-standalone | windowsservercore | 1803 | `sitecore-xp-standalone:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-standalone/Dockerfile) |
| 9.0.180604 | sitecore-xp-sqldev | windowsservercore | 1803 | `sitecore-xp-sqldev:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-sqldev/Dockerfile) |
| 9.0.180604 | sitecore-xp-solr | nanoserver | 1803 | `sitecore-xp-solr:9.0.180604-nanoserver-1803` [Dockerfile](images/9.0.2%20rev.%20180604/nanoserver-1803/sitecore-xp-solr/Dockerfile) |
| 9.0.180604 | sitecore-xp-cd | windowsservercore | 1803 | `sitecore-xp-cd:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-cd/Dockerfile) |
| 9.0.180604 | sitecore-xp-base | windowsservercore | 1803 | `sitecore-xp-base:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xp-base/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cm | windowsservercore | 1803 | `sitecore-xm1-cm:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xm1-cm/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cd | windowsservercore | 1803 | `sitecore-xm1-cd:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xm1-cd/Dockerfile) |
| 9.0.180604 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 9.0.180604 | sitecore-solr | nanoserver | 1803 | `sitecore-solr:9.0.180604-nanoserver-1803` [Dockerfile](images/9.0.2%20rev.%20180604/nanoserver-1803/sitecore-solr/Dockerfile) |
| 9.0.180604 | sitecore-base | windowsservercore | 1803 | `sitecore-base:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-base/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cm | windowsservercore | 1709 | `sitecore-xm1-cm:9.0.180604-windowsservercore-1709` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1709/sitecore-xm1-cm/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cd | windowsservercore | 1709 | `sitecore-xm1-cd:9.0.180604-windowsservercore-1709` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1709/sitecore-xm1-cd/Dockerfile) |
| 9.0.180604 | sitecore-sqldev | windowsservercore | 1709 | `sitecore-sqldev:9.0.180604-windowsservercore-1709` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1709/sitecore-sqldev/Dockerfile) |
| 9.0.180604 | sitecore-solr | nanoserver | 1709 | `sitecore-solr:9.0.180604-nanoserver-1709` [Dockerfile](images/9.0.2%20rev.%20180604/nanoserver-1709/sitecore-solr/Dockerfile) |
| 9.0.180604 | sitecore-base | windowsservercore | 1709 | `sitecore-base:9.0.180604-windowsservercore-1709` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1709/sitecore-base/Dockerfile) |
| 9.0.171219 | sitecore-sqldev | windowsservercore | ltsc2016 | `sitecore-sqldev:9.0.171219-windowsservercore-ltsc2016` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-ltsc2016/sitecore-sqldev/Dockerfile) |
| 9.0.171219 | sitecore-solr | nanoserver | ltsc2016 | `sitecore-solr:9.0.171219-nanoserver-ltsc2016` [Dockerfile](images/9.0.1%20rev.%20171219/nanoserver-ltsc2016/sitecore-solr/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cm | windowsservercore | 1803 | `sitecore-xm1-cm:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-xm1-cm/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cd | windowsservercore | 1803 | `sitecore-xm1-cd:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-xm1-cd/Dockerfile) |
| 9.0.171219 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 9.0.171219 | sitecore-solr | nanoserver | 1803 | `sitecore-solr:9.0.171219-nanoserver-1803` [Dockerfile](images/9.0.1%20rev.%20171219/nanoserver-1803/sitecore-solr/Dockerfile) |
| 9.0.171219 | sitecore-base | windowsservercore | 1803 | `sitecore-base:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-base/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cm | windowsservercore | 1709 | `sitecore-xm1-cm:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-xm1-cm/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cd | windowsservercore | 1709 | `sitecore-xm1-cd:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-xm1-cd/Dockerfile) |
| 9.0.171219 | sitecore-sqldev | windowsservercore | 1709 | `sitecore-sqldev:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-sqldev/Dockerfile) |
| 9.0.171219 | sitecore-solr | nanoserver | 1709 | `sitecore-solr:9.0.171219-nanoserver-1709` [Dockerfile](images/9.0.1%20rev.%20171219/nanoserver-1709/sitecore-solr/Dockerfile) |
| 9.0.171219 | sitecore-base | windowsservercore | 1709 | `sitecore-base:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-base/Dockerfile) |
| 9.0.171002 | sitecore-sqldev | windowsservercore | ltsc2016 | `sitecore-sqldev:9.0.171002-windowsservercore-ltsc2016` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-ltsc2016/sitecore-sqldev/Dockerfile) |
| 9.0.171002 | sitecore-xm1-cm | windowsservercore | 1709 | `sitecore-xm1-cm:9.0.171002-windowsservercore-1709` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-1709/sitecore-xm1-cm/Dockerfile) |
| 9.0.171002 | sitecore-xm1-cd | windowsservercore | 1709 | `sitecore-xm1-cd:9.0.171002-windowsservercore-1709` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-1709/sitecore-xm1-cd/Dockerfile) |
| 9.0.171002 | sitecore-base | windowsservercore | 1709 | `sitecore-base:9.0.171002-windowsservercore-1709` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-1709/sitecore-base/Dockerfile) |
| 8.2.180406 | sitecore-sqldev | windowsservercore | ltsc2019 | `sitecore-sqldev:8.2.180406-windowsservercore-ltsc2019` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-ltsc2019/sitecore-sqldev/Dockerfile) |
| 8.2.180406 | sitecore-reporting | windowsservercore | ltsc2019 | `sitecore-reporting:8.2.180406-windowsservercore-ltsc2019` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-ltsc2019/sitecore-reporting/Dockerfile) |
| 8.2.180406 | sitecore-processing | windowsservercore | ltsc2019 | `sitecore-processing:8.2.180406-windowsservercore-ltsc2019` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-ltsc2019/sitecore-processing/Dockerfile) |
| 8.2.180406 | sitecore-cm | windowsservercore | ltsc2019 | `sitecore-cm:8.2.180406-windowsservercore-ltsc2019` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-ltsc2019/sitecore-cm/Dockerfile) |
| 8.2.180406 | sitecore-cd | windowsservercore | ltsc2019 | `sitecore-cd:8.2.180406-windowsservercore-ltsc2019` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-ltsc2019/sitecore-cd/Dockerfile) |
| 8.2.180406 | sitecore | windowsservercore | ltsc2019 | `sitecore:8.2.180406-windowsservercore-ltsc2019` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-ltsc2019/sitecore/Dockerfile) |
| 8.2.180406 | sitecore-solr | nanoserver | 1809 | `sitecore-solr:8.2.180406-nanoserver-1809` [Dockerfile](images/8.2%20rev.%20180406/nanoserver-1809/sitecore-solr/Dockerfile) |
| 8.2.180406 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 8.2.180406 | sitecore-solr | nanoserver | 1803 | `sitecore-solr:8.2.180406-nanoserver-1803` [Dockerfile](images/8.2%20rev.%20180406/nanoserver-1803/sitecore-solr/Dockerfile) |
| 8.2.180406 | sitecore-reporting | windowsservercore | 1803 | `sitecore-reporting:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-reporting/Dockerfile) |
| 8.2.180406 | sitecore-processing | windowsservercore | 1803 | `sitecore-processing:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-processing/Dockerfile) |
| 8.2.180406 | sitecore-cm | windowsservercore | 1803 | `sitecore-cm:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-cm/Dockerfile) |
| 8.2.180406 | sitecore-cd | windowsservercore | 1803 | `sitecore-cd:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-cd/Dockerfile) |
| 8.2.180406 | sitecore | windowsservercore | 1803 | `sitecore:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore/Dockerfile) |
| 8.2.180406 | sitecore | windowsservercore | 1709 | `sitecore:8.2.180406-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1709/Dockerfile) |
| 8.2.171121 | sitecore | windowsservercore | 1803 | `sitecore:8.2.171121-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20171121/windowsservercore-1803/Dockerfile) |
| 8.2.171121 | sitecore | windowsservercore | 1709 | `sitecore:8.2.171121-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20171121/windowsservercore-1709/Dockerfile) |
| 8.2.170728 | sitecore | windowsservercore | 1803 | `sitecore:8.2.170728-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170728/windowsservercore-1803/Dockerfile) |
| 8.2.170728 | sitecore | windowsservercore | 1709 | `sitecore:8.2.170728-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20170728/windowsservercore-1709/Dockerfile) |
| 8.2.170614 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:8.2.170614-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170614/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 8.2.170614 | sitecore | windowsservercore | 1803 | `sitecore:8.2.170614-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170614/windowsservercore-1803/Sitecore/Dockerfile) |
| 8.2.170614 | sitecore | windowsservercore | 1709 | `sitecore:8.2.170614-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20170614/windowsservercore-1709/Dockerfile) |
| 8.2.170407 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:8.2.170407-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170407/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 8.2.170407 | sitecore | windowsservercore | 1803 | `sitecore:8.2.170407-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170407/windowsservercore-1803/Sitecore/Dockerfile) |
| 8.2.170407 | sitecore | windowsservercore | 1709 | `sitecore:8.2.170407-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20170407/windowsservercore-1709/Dockerfile) |
| 8.2.161221 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:8.2.161221-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20161221/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 8.2.161221 | sitecore | windowsservercore | 1803 | `sitecore:8.2.161221-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20161221/windowsservercore-1803/sitecore/Dockerfile) |
| 8.2.161221 | sitecore-sqldev | windowsservercore | 1709 | `sitecore-sqldev:8.2.161221-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20161221/windowsservercore-1709/sitecore-sqldev/Dockerfile) |
| 8.2.161221 | sitecore | windowsservercore | 1709 | `sitecore:8.2.161221-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20161221/windowsservercore-1709/sitecore/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1903 | `sitecore-openjdk:8-nanoserver-1903` [Dockerfile](images/sitecore-openjdk/nanoserver-1903/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1809 | `sitecore-openjdk:8-nanoserver-1809` [Dockerfile](images/sitecore-openjdk/nanoserver-1809/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1803 | `sitecore-openjdk:8-nanoserver-1803` [Dockerfile](images/sitecore-openjdk/nanoserver-1803/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1709 | `sitecore-openjdk:8-nanoserver-1709` [Dockerfile](images/sitecore-openjdk/nanoserver-1709/Dockerfile) |
| 7.5.150212 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:7.5.150212-windowsservercore-1803` [Dockerfile](images/7.5%20rev.%20150212/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 7.5.150212 | sitecore | windowsservercore | 1803 | `sitecore:7.5.150212-windowsservercore-1803` [Dockerfile](images/7.5%20rev.%20150212/windowsservercore-1803/sitecore/Dockerfile) |
| 2017 | mssql-developer | windowsservercore | ltsc2019 | `mssql-developer:2017-windowsservercore-ltsc2019` [Dockerfile](images/mssql-developer-2017/windowsservercore-ltsc2019/Dockerfile) |
| 2017 | mssql-developer | windowsservercore | 1903 | `mssql-developer:2017-windowsservercore-1903` [Dockerfile](images/mssql-developer-2017/windowsservercore-1903/Dockerfile) |


## Current variants

| Version | Repository | OS  | Build | Tag |
| ------- | ---------- | --- | -----------| --- |
| 9.1.1 | sitecore-xp-sxa-1.8.1-standalone | windowsservercore | ltsc2019 | `sitecore-xp-sxa-1.8.1-standalone:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-sxa-1.8.1-standalone/Dockerfile) |
| 9.1.1 | sitecore-xp-sxa-1.8.1-sqldev | windowsservercore | ltsc2019 | `sitecore-xp-sxa-1.8.1-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-sxa-1.8.1-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xp-sxa-1.8.1-cd | windowsservercore | ltsc2019 | `sitecore-xp-sxa-1.8.1-cd:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-sxa.1.8.1-cd/Dockerfile) |
| 9.1.1 | sitecore-xp-pse-5.0-standalone | windowsservercore | ltsc2019 | `sitecore-xp-pse-5.0-standalone:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-pse-5.0-standalone/Dockerfile) |
| 9.1.1 | sitecore-xp-pse-5.0-sqldev | windowsservercore | ltsc2019 | `sitecore-xp-pse-5.0-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-pse-5.0-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xp-jss-11.0.1-standalone | windowsservercore | ltsc2019 | `sitecore-xp-jss-11.0.1-standalone:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-jss-11.0.1-standalone/Dockerfile) |
| 9.1.1 | sitecore-xp-jss-11.0.1-sqldev | windowsservercore | ltsc2019 | `sitecore-xp-jss-11.0.1-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-jss-11.0.1-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xp-jss-11.0.1-cd | windowsservercore | ltsc2019 | `sitecore-xp-jss-11.0.1-cd:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xp-jss.11.0.1-cd/Dockerfile) |
| 9.1.1 | sitecore-xm1-sxa-1.8.1-sqldev | windowsservercore | ltsc2019 | `sitecore-xm1-sxa-1.8.1-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-sxa-1.8.1-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xm1-sxa-1.8.1-cm | windowsservercore | ltsc2019 | `sitecore-xm1-sxa-1.8.1-cm:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-sxa-1.8.1-cm/Dockerfile) |
| 9.1.1 | sitecore-xm1-sxa-1.8.1-cd | windowsservercore | ltsc2019 | `sitecore-xm1-sxa-1.8.1-cd:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-sxa.1.8.1-cd/Dockerfile) |
| 9.1.1 | sitecore-xm1-pse-5.0-sqldev | windowsservercore | ltsc2019 | `sitecore-xm1-pse-5.0-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-pse-5.0-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xm1-pse-5.0-cm | windowsservercore | ltsc2019 | `sitecore-xm1-pse-5.0-cm:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-pse-5.0-cm/Dockerfile) |
| 9.1.1 | sitecore-xm1-jss-11.0.1-sqldev | windowsservercore | ltsc2019 | `sitecore-xm1-jss-11.0.1-sqldev:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-jss-11.0.1-sqldev/Dockerfile) |
| 9.1.1 | sitecore-xm1-jss-11.0.1-cm | windowsservercore | ltsc2019 | `sitecore-xm1-jss-11.0.1-cm:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-jss-11.0.1-cm/Dockerfile) |
| 9.1.1 | sitecore-xm1-jss-11.0.1-cd | windowsservercore | ltsc2019 | `sitecore-xm1-jss-11.0.1-cd:9.1.1-windowsservercore-ltsc2019` [Dockerfile](variants/9.1.1/ltsc2019/sitecore-xm1-jss.11.0.1-cd/Dockerfile) |

### Tags and Windows versions

This repository now supports multiple Windows versions and support channels ie. "ltsc2016", "1709" and "1803". Read more about [Windows Container Version Compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility).

Here is the convention used when tagging images:

```text
 registry.example.com/sitecore-xm1-cm:9.0.171219-windowsservercore-1709
 \__________________/ \_____________/ \________/ \____________________/
           |                 |             |               |
   registry/org/user    repository    sc version       os version
```

>Please note that the `sc version` part of the tags matches the corresponding NuGet package version for a given Sitecore version and **not** the "marketing version" ie 9.0.1, 9.0.2 etc. This is to make it clear in the implementing projects which NuGet package versions goes with which tags.  

## How to use

### Prerequisites

- A **private** Docker repository. Any will do, but the easiest is to use a [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/) or to sign-up for a private plan on [https://hub.docker.com](https://hub.docker.com), you need at least the "Small" plan at $12/mo.
- A file share that your build agents can reach, where you have placed zip files downloaded from [https://dev.sitecore.net/](https://dev.sitecore.net/) **and** your license.xml.
- Some kind of build server for example TeamCity, with agents that runs:
  - Windows 10 or Windows Server 2016 that is up to date and on latest build.
  - Hyper-V and Containers Windows features installed.
  - Latest stable Docker engine and cli.

### Configure your build server

1. Trigger a build on changes to this git repository - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.

Example:

```PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

# Build and push base images
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\images") ` 
    -InstallSourcePath "PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML" `
    -Registry "YOUR REGISTRY NAME" ` # On Docker Hub it's your username or organization, else it's the hostname of your private registry.
    -Tags "*" ` # optional (default "*"), set to for example "sitecore-openjdk:*-1809", "sitecore-*:9.1.1*ltsc2019" to only build 9.1.1 images on ltsc2019/1809.
    -PushMode "WhenChanged" # optional (default "WhenChanged"), can also be "Never" or "Always".

# Build and push variants
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\variants") ` 
    -InstallSourcePath "PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML" `
    -Registry "YOUR REGISTRY NAME" ` # On Docker Hub it's your username or organization, else it's the hostname of your private registry.
    -Tags "*" ` # optional (default "*"), set to for example "sitecore-xm1-sxa-*:9.1.1*ltsc2019" to only build 9.1.1 images on ltsc2019/1809.
    -PushMode "WhenChanged" # optional (default "WhenChanged"), can also be "Never" or "Always".
```

---
created: 2026-02-14
---
![[2026-scratch-pad-20260221.png]]

```
c:\Code\ScpCloud>docker compose -f "C:\Code\ScpCloud\docker-compose.yml" - "C:\Code\ScpCloud\docker-compose. override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build nosqldata

c:\Code\ScpCloud>docker compose -f "C:\Code\ScpCloud\docker-compose.yml" -f "C:\Code\ScpCloud\docker-compose.override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build sqldata

c:\Code\ScpCloud>docker compose - "C:\Code\ScpCloud\docker-compose.yml" - "C:\Code\ScpCloud\docker-compose.override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build sqldata
```

`docker push scpcloud.azurecr.io/nosqldata`

`az storage file copy --help`
`az storage file delete --share-name scpnosqldata-new --path "/_tmp"`







 
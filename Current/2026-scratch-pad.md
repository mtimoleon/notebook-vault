---
created: 2026-02-14
---


 
ipereira@hovione.com operator 79eb3abe-d61e-472c-886b-1665f7d8dcbe
rbento@hovione.com operator 64b414a7-0dda-44c5-b93d-2b818746b7a4





```
c:\Code\ScpCloud>docker compose -f "C:\Code\ScpCloud\docker-compose.yml" - "C:\Code\ScpCloud\docker-compose. override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build nosqldata

c:\Code\ScpCloud>docker compose -f "C:\Code\ScpCloud\docker-compose.yml" -f "C:\Code\ScpCloud\docker-compose.override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build sqldata

c:\Code\ScpCloud>docker compose - "C:\Code\ScpCloud\docker-compose.yml" - "C:\Code\ScpCloud\docker-compose.override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build sqldata
```

`docker push scpcloud.azurecr.io/nosqldata`

`az storage file copy --help`
`az storage file delete --share-name scpnosqldata-new --path "/_tmp"`






 
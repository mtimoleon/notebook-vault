---
created: 2026-02-14
---
![[2026-scratch-pad-20260218.png|300]]

baseline



```
c:\Code\ScpCloud>docker compose -f "C:\Code\ScpCloud\docker-compose.yml" - "C:\Code\ScpCloud\docker-compose. override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build nosqldata

c:\Code\ScpCloud>docker compose -f "C:\Code\ScpCloud\docker-compose.yml" -f "C:\Code\ScpCloud\docker-compose.override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build sqldata

c:\Code\ScpCloud>docker compose - "C:\Code\ScpCloud\docker-compose.yml" - "C:\Code\ScpCloud\docker-compose.override.ym1" - "C:\Code\ScpCloud\docker-compose.azure.yml" build sqldata
```

`docker push scpcloud.azurecr.io/nosqldata`

`az storage file copy --help`
`az storage file delete --share-name scpnosqldata-new --path "/_tmp"`




```bash
docker run --rm --name nosqldata_backup \
  -e BACKUP_CRON="*/3 * * * *" \
  -e RUN_ON_START=1 \
  -e MONGO_HOST=host.docker.internal \
  -e MONGO_PORT=27017 \
  -e BACKUP_RETENTION_DAYS=3 \
  -v nosqldata_backup_volume:/backup \
  nosqldata_backup:local
  
  
  
  $env:BACKUP_CRON="*/3 * * * *"; $env:BACKUP_RETENTION_DAYS="5"; docker compose -f docker.compose.yaml up -d --build

```



 
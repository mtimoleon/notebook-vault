---
categories:
  - "[[Work]]"
created: 2026-02-26
product:
component: Docker
tags:
  - documentation/intelligen
---
Docker compose command to build BE:

```bash
docker compose  -f "C:\Users\michael\developer\scpCloud\docker-compose.yml" -f "C:\Users\michael\developer\scpCloud\docker-compose.override.yml" -f "C:\Users\michael\developer\scpCloud\obj\Docker\docker-compose.vs.debug.g.yml" -f "C:\Users\michael\developer\scpCloud\docker-compose.vs.debug.yml" -p dockercompose15380257336922976358 --ansi never build admin-api keycloak mssqlscripts nosqldata planning-api production-api rabbitmq sqldata webadminbff webplanningbff webproductionbff
```

και μετά για up:
```shell
docker compose  -f "C:\Users\michael\developer\scpCloud\docker-compose.yml" -f "C:\Users\michael\developer\scpCloud\docker-compose.override.yml" -f "C:\Users\michael\developer\scpCloud\obj\Docker\docker-compose.vs.debug.g.yml" -f "C:\Users\michael\developer\scpCloud\docker-compose.vs.debug.yml" -p dockercompose15380257336922976358 up -d
```


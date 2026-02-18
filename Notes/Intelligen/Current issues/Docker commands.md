---
categories:
  - "[[Resources]]"
created: 2026-02-18
url:
tags:
  - topic/code
  - tech/docker
---

## To see which volumes a container uses:

- Quick summary (mounts): `docker inspect <container> --format "{{json .Mounts}}"`
- Human-readable full inspect: `docker inspect <container>`
- From inside the container: `docker exec -it <container> sh -lc "mount || cat /proc/mounts"`

To list named volumes and inspect one:
- `docker volume ls`
- `docker volume inspect <volume_name>`

If it’s a compose container and you want the volume names:
- `docker compose -f docker-compose.yml ps`
- `docker compose -f docker-compose.yml config`

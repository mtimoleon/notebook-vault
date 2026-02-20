---
categories:
  - "[[Resources]]"
created: 2026-02-18
url:
tags:
  - topic/code
  - tech/docker
---

## Common cmds

Get into a container:  `docker exec -it <container_name_or_id> sh`

## Networks

Δες όλα τα docker networks:

```
docker network ls
```

Inspect network:
```
docker network inspect <name or id>
```

See port of container:
```
docker port documentdb-container
```

Attach container σε υπάρχον network:
```
docker network connect <network_name> <container_name>
```


## Volumes

- Quick summary (mounts): `docker inspect <container> --format "{{json .Mounts}}"`
- Human-readable full inspect: `docker inspect <container>`
- From inside the container: `docker exec -it <container> sh -lc "mount || cat /proc/mounts"`

#### To list named volumes and inspect one:
- `docker volume ls`
- `docker volume inspect <volume_name>`

If it’s a compose container and you want the volume names:
- `docker compose -f docker-compose.yml ps`
- `docker compose -f docker-compose.yml config`

#### To create a volume
`docker volume create <volume-name>`

Verify: `docker volume ls | grep  <volume-name>` (or docker `volume inspect  <volume-name>`)
Then rerun: docker compose up -d

## Scaling services

Παρακάτω είναι ένα compose:

```yaml
name: scp-nosqldata-backup
services:
  nosqldata_backup:
    image: scpcloud.azurecr.io/nosqldata_backup:latest
    build: .
    environment:
      # Cron schedule (minute hour day month weekday)
      - BACKUP_CRON=0 3 * * *
      # Connection (prefer MONGO_URI if password includes special characters)
      # Local testing tip: if MongoDB is published on your host (e.g. localhost:27017),
      # use host.docker.internal on Windows/Mac.
      - MONGO_HOST=host.docker.internal
      - MONGO_PORT=27017
      - MONGO_AUTH_SOURCE=admin
      # Retention
      - BACKUP_RETENTION_DAYS=30
      - BACKUP_FILE_PREFIX=nosqldata
      # - MONGO_USERNAME=<username>
      # - MONGO_PASSWORD=<password>
      # - MONGO_URI=mongodb://user:pass@nosqldata:27017/?authSource=admin
    volumes:
      - nosqldata_backup_volume:/backup

volumes:
  nosqldata_backup_volume:
    external: true
```

Όταν το τρέξω θα γίνει:

![[Notes/Intelligen/assets/Current issues/DocumentDB test/image-2.png]]

Το `name: scp-nosqldata-backup` είναι αυτό που βλέπεις στην πρώτη γραμμή. Αν δεν το βάλεις θα πάρει το όνομα του folder που βρίσκεται το compose που έτρεξες.

Το -1 μπαίνει επειδή το Docker Compose ονομάζει τα containers ως “replicas” του service.
- Μορφή: `<service>-<index>` (στο νέο naming scheme) ή `<project>_<service>_<index>` (στο παλιότερο).
- Το -1 σημαίνει “πρώτο instance” του service nosqldata_backup.
- Αν κάνεις scale θα δεις και nosqldata_backup-2, nosqldata_backup-3, κλπ.

Αν θες _σταθερό_ όνομα χωρίς -1, μπορείς να βάλεις στο [docker-compose.yml](https://file+.vscode-resource.vscode-cdn.net/c%3A/Users/michael/.vscode/extensions/openai.chatgpt-0.4.76-win32-x64/webview/#):

```yaml
services: 
  nosqldata_backup: 
    container_name: nosqldata_backup
```


(Σημείωση: με `container_name` δεν μπορείς να κάνεις scale σε >1 replicas για το ίδιο service.)

> [!INFO] Command για να δημιουργήσεις πολλά replica services (δηλαδή scale):
> ```
docker compose -f docker-compose.yml up -d --scale nosqldata_backup=<number-of-replica-services>
> ```


---
categories:
  - "[[Work]]"
created: 2026-02-17
product: MongoDB
component:
status: open
tags:
  - issues/intelligen
---
## Context
Backup MongoDB in Azure containers
[MongoDb-backup-in-container files](D:\develop-tasks\MongoDb-backup-in-container)
## Notes

Script to backup Mongo: `mongo_backup.sh`

```bash
#!/bin/sh
set -eu

BACKUP_PATH="${BACKUP_PATH:-/backup}"
BACKUP_FILE_PREFIX="${BACKUP_FILE_PREFIX:-nosqldata}"
BACKUP_RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-30}"

timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
outfile="${BACKUP_PATH%/}/${BACKUP_FILE_PREFIX}_${timestamp}.archive.gz"

if [ -n "${MONGO_URI:-}" ]; then
  uri="$MONGO_URI"
else
  host="${MONGO_HOST:-nosqldata}"
  port="${MONGO_PORT:-27017}"
  auth_source="${MONGO_AUTH_SOURCE:-admin}"

  if [ -n "${MONGO_USERNAME:-}" ] && [ -n "${MONGO_PASSWORD:-}" ]; then
    uri="mongodb://${MONGO_USERNAME}:${MONGO_PASSWORD}@${host}:${port}/?authSource=${auth_source}"
  else
    uri="mongodb://${host}:${port}"
  fi
fi

mkdir -p "$BACKUP_PATH"

echo "Starting mongodump to $outfile ..."
mongodump --uri="$uri" --archive="$outfile" --gzip
echo "Backup completed."

if [ -n "$BACKUP_RETENTION_DAYS" ]; then
  if echo "$BACKUP_RETENTION_DAYS" | grep -Eq '^[0-9]+$'; then
    find "$BACKUP_PATH" -type f -name '*.archive.gz' -mtime +"$BACKUP_RETENTION_DAYS" -delete || true
  else
    echo "WARN: BACKUP_RETENTION_DAYS is not a number: $BACKUP_RETENTION_DAYS" >&2
  fi
fi

```


### How to setup backup to run

Δύο κορυφαίες επιλογές για να το ενσωματώσετε στο `compose`:

#### Επιλογή Α: Το "Sidecar" Container (Η πιο επαγγελματική λύση)

Δημιουργείτε ένα δεύτερο, ελαφρύ container (π.χ. με Alpine) που έχει μόνο τα εργαλεία της Mongo και το Cron. Αυτό "βλέπει" το ίδιο Azure File Share.

**1. Dockerfile για το backup-service:**

```DockerFile
FROM alpine:3.18

RUN apk add --no-cache mongodb-tools ca-certificates tzdata

COPY entrypoint.sh /scripts/entrypoint.sh
COPY mongo_backup.sh /scripts/mongo_backup.sh

RUN chmod +x /scripts/entrypoint.sh /scripts/mongo_backup.sh

ENTRYPOINT ["/scripts/entrypoint.sh"]
```


**2. Entrypoint.sh:**

 - Creates folders `backup`, `scripts`
 - Creates `cron` job
 - Sets retention dates to 30 by default

_Cron job syntax Format: `minute hour day month weekday`, so below is `every day at 03:00`_

```bash
#!/bin/sh
set -eu

BACKUP_CRON="${BACKUP_CRON:-0 3 * * *}"
BACKUP_PATH="${BACKUP_PATH:-/backup}"
BACKUP_RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-30}"

mkdir -p /scripts "$BACKUP_PATH" /var/log

write_export() {
  name="$1"
  value="${2-}"

  if [ -z "${value}" ]; then
    return 0
  fi

  escaped="$(printf '%s' "$value" | sed "s/'/'\\\\''/g")"
  printf "export %s='%s'\n" "$name" "$escaped" >> /etc/backup.env
}

: > /etc/backup.env
write_export BACKUP_PATH "$BACKUP_PATH"
write_export BACKUP_FILE_PREFIX "${BACKUP_FILE_PREFIX-}"
write_export BACKUP_RETENTION_DAYS "$BACKUP_RETENTION_DAYS"
write_export MONGO_URI "${MONGO_URI-}"
write_export MONGO_HOST "${MONGO_HOST-}"
write_export MONGO_PORT "${MONGO_PORT-}"
write_export MONGO_USERNAME "${MONGO_USERNAME-}"
write_export MONGO_PASSWORD "${MONGO_PASSWORD-}"
write_export MONGO_AUTH_SOURCE "${MONGO_AUTH_SOURCE-}"

{
  echo "$BACKUP_CRON /bin/sh -c '. /etc/backup.env; /scripts/mongo_backup.sh >> /var/log/mongo_backup.log 2>&1'"
} > /etc/crontabs/root

if [ "${RUN_ON_START:-0}" = "1" ]; then
  /bin/sh -c '. /etc/backup.env; /scripts/mongo_backup.sh >> /var/log/mongo_backup.log 2>&1'
fi

exec crond -f -l 8 -L /var/log/cron.log
```


**2. Docker Compose:**

```yaml
name: scp-nosqldata-backup
services:
  nosqldata_backup:
    container_name: scp-nosqldata-backup
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

_Σημείωση: Στο script σας, η εντολή θα γίνει `mongodump --host database --out /backup`._

#### Επιλογή Β: Custom MongoDB Image (Η πιο απλή λύση)

Αν θέλετε οπωσδήποτε **ένα container**, πρέπει να φτιάξετε ένα δικό σας `image` που ξεκινάει και τη Mongo και το Cron (χρησιμοποιώντας ένα entry point script).

**Dockerfile:**

```dockefile
FROM mongo:latest
RUN apt-get update && apt-get install -y cron
COPY mongo_backup.sh /mongo_backup.sh
RUN chmod +x /mongo_backup.sh
RUN echo "0 2 * * * /mongo_backup.sh >> /var/log/cron.log 2>&1" | crontab -
# Script για να ξεκινάνε και τα δύο
CMD cron && docker-entrypoint.sh mongod
```

Γιατί η Επιλογή Α είναι καλύτερη;

1. **Isolation:** Αν κολλήσει το cron, η βάση συνεχίζει να δουλεύει.
2. **Security:** Το backup container μπορεί να έχει read-only πρόσβαση αν χρησιμοποιείτε replica sets.
3. **Updates:** Μπορείτε να αναβαθμίσετε τη Mongo χωρίς να πειράξετε το backup logic.


### Restore Plan (MongoDB + Azure Container Apps)

This document describes a practical restore procedure when the MongoDB data volume becomes corrupted and the container crashes (e.g. WiredTiger corruption). The goal is:

1) stop MongoDB
2) delete/recreate the MongoDB data volume
3) restore from the latest backup produced by this repo (mongodump `--archive` + `--gzip`)

Backups produced by this repo are files like:

- `/backup/<prefix>_YYYY-mm-dd_HH-MM-SS.archive.gz`

##### Important notes

- RPO (Recovery Point Objective): you may lose data since the last successful backup.
- RTO (Recovery Time Objective): depends on how long it takes to recreate storage and complete the restore/validation steps.
- Backups must be reachable: the restore step needs access to the backup share/location.
- Auth: use `MONGO_URI` for restore if you use authentication.
- This is a runbook: adapt names/paths to your Azure resources.

---

#### Local restore runbook (Docker)

Assumptions:
- MongoDB runs in a container (or compose project) and stores data in a named volume (e.g. `nosqldata_volume` mounted at `/data/db`).
- Backups are stored in a named volume (e.g. `nosqldata_backup_volume` mounted at `/backup`).

### 1) Stop and remove MongoDB container

```bash
docker stop nosqldata
docker rm nosqldata
```

### 2) Delete and recreate the MongoDB data volume

```bash
docker volume rm nosqldata_volume
docker volume create nosqldata_volume
```

### 3) Start MongoDB with the new empty volume

If you run MongoDB with Docker Compose, start it again after recreating the volume:

```bash
docker compose -f <mongo-compose.yml> up -d
```

If you want the container to have a custom name run:

```bash
docker compose -p <custom-name> -f <mongo-compose.yml> up -d
```

Notes:
- Your compose file must mount the (new) data volume to `/data/db` (e.g. `nosqldata_volume:/data/db`).
- If the volume name is project-scoped (e.g. `<project>_nosqldata_volume`), recreate that exact volume name before running `up -d`.

### 4) Restore the latest backup archive

From inside the backup agent container shell, list available backups (newest first):

```bash
ls -1t /backup/*.archive.gz
```

Restore the backup you want with `mongorestore`:

```bash
mongorestore --uri="$MONGO_URI" --archive="/backup/nosqldata_YYYY-mm-dd_HH-MM-SS.archive.gz" --gzip --drop
```

Example for local installation:

```bash
mongorestore --uri="mongodb://host.docker.internal:27017" --archive="/backup/nosqldata_2026-02-18_11-44-52.archive.gz" --gzip --drop
```

Notes:
- `MONGO_URI` must be set correctly inside the container.

### 5) Validate

```bash
mongosh "mongodb://localhost:27017" --eval "db.adminCommand({ping:1})"
```

---

#### Azure Container Apps restore runbook (high level)

You typically have:
- A MongoDB Container App that mounts an Azure File Share at `/data/db` (your mongo volume).
- A backup Container App (this repo image) that mounts an Azure File Share at `/backup` (your backup volume).

The simplest safe flow is:

##### 1) Stop writes / stop MongoDB

- Scale the MongoDB app to 0 replicas (or stop it), and stop any apps writing to it.

##### 2) Identify the backup to restore

- Look at the backup share (Azure File Share) and pick the newest `*.archive.gz`.

##### 3) Recreate the MongoDB data share

Two options:
- Replace the share: delete the Azure File Share used for `/data/db`, then create a new empty share with the same name.
- New share name: create a brand-new share name and update the MongoDB Container App mount to point to it.

Example names from this project’s Azure setup:
- Storage account: `scpcloudstorage`
- MongoDB data share: `scpnosqldata` (mounted at `/data/db`)
- Backup share (example): `scp-nosqldata-backup` (mounted at `/backup`)

Recommended approach:
- Create a new empty data share (e.g. `scpnosqldata_clean`) and point the Mongo app’s `/data/db` mount to it.

##### 4) Start MongoDB on the empty volume

- Scale the MongoDB app back up (e.g. 1 replica) and wait until it is listening.

##### 5) Restore from the running backup container

Assumption: the backup agent Container App is already running (this repo image), has the backup share mounted at `/backup`, and has `MONGO_URI` set.

Open a shell into the backup agent container:

```sh
az containerapp exec --resource-group <rg> --name <backup-containerapp> --command /bin/sh
```

Then, inside that shell:

```sh
ls -lht /backup/*.archive.gz
mongorestore --uri="$MONGO_URI" --archive="/backup/<backup-file>.archive.gz" --gzip --drop
```

Set `MONGO_URI` to whatever is correct in your Container Apps environment (internal FQDN/host + auth).

##### 6) Validate and resume traffic

- Validate with a ping, and (optionally) validate expected collections/doc counts.
- Re-enable apps/writers.

---

#### Do we really have to delete the volume?

Deleting/recreating the volume is the cleanest when you suspect on-disk corruption.
If the goal is only "restore a point-in-time copy", you can also restore into an existing volume with `--drop`, but that will not remove low-level file corruption if it exists.


## Links
[Task implementation files](D:\develop-tasks\MongoDb-backup-in-container)
[[Back Up a Self-Managed Deployment with Filesystem Snapshots]]

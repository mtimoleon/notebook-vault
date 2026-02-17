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
## Notes
Script to backup Mongo
mongo_backup.sh

```bash
#!/bin/bash

# Settings
CONTAINER_NAME="<container_name"
BACKUP_PATH="/backup" # The path inside container (the mount point of Azure Share)
DATE=$(date +%Y-%m-%d_%H-%M)

# Exceute backup with compression
echo "Starting backup for $DATE..."
docker exec $CONTAINER_NAME mongodump --gzip --out "$BACKUP_PATH/$DATE"

# Additionaly: Delete backups older than 30 days in Azure Share
# find /path/to/mounted/share/* -mtime +30 -exec rm -rf {} \;

echo "Backup completed successfully."
```

### How to setup backup to run

Δύο κορυφαίες επιλογές για να το ενσωματώσετε στο `compose`:

#### Επιλογή Α: Το "Sidecar" Container (Η πιο επαγγελματική λύση)

Δημιουργείτε ένα δεύτερο, ελαφρύ container (π.χ. με Alpine) που έχει μόνο τα εργαλεία της Mongo και το Cron. Αυτό "βλέπει" το ίδιο Azure File Share.

**1. Dockerfile για το backup-service:**

dockerfile

```
FROM alpine:3.18
# Εγκατάσταση mongodb-tools και crond
RUN apk add --no-cache mongodb-tools bash
# Αντιγραφή του script που φτιάξαμε πριν
COPY mongo_backup.sh /scripts/mongo_backup.sh
RUN chmod +x /scripts/mongo_backup.sh
# Προσθήκη στο crontab
RUN echo "0 2 * * * /scripts/mongo_backup.sh" > /etc/crontabs/root
# Εκκίνηση του cron στο foreground
CMD ["crond", "-f"]
```

Χρησιμοποιήστε τον κώδικα με προσοχή.

**2. Docker Compose:**

yaml

```
services:
  database:
    image: mongo:latest
    volumes:
      - mongo_data:/data/db

  backup_agent:
    build: .
    depends_on:
      - database
    environment:
      - MONGO_HOST=database
    volumes:
      - my_azure_share:/backup # Το κοινόχρηστο Azure volume

volumes:
  mongo_data:
  my_azure_share:
    driver: azure_file
    driver_opts:
      share_name: <name>
      storage_account_name: <account>
      storage_account_key: <key>
```

Χρησιμοποιήστε τον κώδικα με προσοχή.

_Σημείωση: Στο script σας, η εντολή θα γίνει `mongodump --host database --out /backup`._

#### Επιλογή Β: Custom MongoDB Image (Η πιο απλή λύση)

Αν θέλετε οπωσδήποτε **ένα container**, πρέπει να φτιάξετε ένα δικό σας `image` που ξεκινάει και τη Mongo και το Cron (χρησιμοποιώντας ένα entrypoint script).

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

Χρησιμοποιήστε τον κώδικα με προσοχή.

Γιατί η Επιλογή Α είναι καλύτερη;

1. **Isolation:** Αν κολλήσει το cron, η βάση συνεχίζει να δουλεύει.
2. **Security:** Το backup container μπορεί να έχει read-only πρόσβαση αν χρησιμοποιείτε replica sets.
3. **Updates:** Μπορείτε να αναβαθμίσετε τη Mongo χωρίς να πειράξετε το backup logic.


### Recovery plan

Επειδή το `mongorestore` απαιτεί μια **ενεργή** βάση δεδομένων, η διαδικασία διαφέρει ελαφρώς ανάλογα με την αρχιτεκτονική που επιλέξατε (βλέπε παραπάνω). Σε κάθε περίπτωση, το πρώτο βήμα είναι να **διαγράψετε τα corrupted δεδομένα** από το volume της Mongo ώστε το container να ξεκινήσει επιτυχώς σε "clean state".

**Καθαρισμός του corrupted volume**

Εφόσον η Mongo δεν ξεκινά, το τρέχον volume είναι άχρηστο. Πρέπει να το αδειάσετε για να μπορέσει το container να ξεκινήσει "φρέσκο" και να δεχθεί το restore.

- Αν χρησιμοποιείτε **named volume** (π.χ. `mongo_data`):
```bash
   docker volume rm <project_name>_mongo_data
   docker volume create <project_name>_mongo_data
```
  
- Αν χρησιμοποιείτε **bind mount** (φάκελο στο disk): Διαγράψτε τα περιεχόμενα του φακέλου (αφού κρατήσετε ένα manual backup για παν ενδεχόμενο).

#### Επιλογή Α: Restore μέσω του Sidecar Container

Σε αυτή την περίπτωση, χρησιμοποιείτε το ελαφρύ container που έχει ήδη πρόσβαση στο Azure Share για να "σπρώξετε" τα δεδομένα στο container της MongoDB.

1. **Βεβαιωθείτε ότι η MongoDB τρέχει** (άδεια): `docker-compose up -d database`
2. **Εκτελέστε το restore από το sidecar:**

```bash
   # Αν το backup είναι φάκελος (mongodump default)
   docker-compose exec backup_agent mongorestore --host database --dir /backup/YYYY-MM-DD_HH-MM/
   
   # Αν το backup είναι συμπιεσμένο αρχείο (.gz)
   docker-compose exec backup_agent mongorestore --host database --gzip --archive=/backup/YYYY-MM-DD_HH-MM/full_backup.gz
```

_Σημείωση: Χρησιμοποιούμε το `--host database` γιατί στο Docker δίκτυο η επικοινωνία γίνεται μέσω του ονόματος του service._

---

#### Επιλογή Β: Restore εντός του Ενιαίου Container (Custom Image)

Αν έχετε ενσωματώσει το Cron και τα εργαλεία μέσα στο ίδιο image της MongoDB, η διαδικασία γίνεται απευθείας:

1. **Ξεκινήστε το container:** `docker-compose up -d mongodb`
2. **Εκτελέστε την εντολή εσωτερικά:**

```bash
   # Είσοδος στο container και εκτέλεση
   docker exec -it <container_id_or_name> mongorestore --gzip --out /backup/YYYY-MM-DD_HH-MM/
```

_Αν το `mongodump` έγινε με την παράμετρο `--out`, τότε το restore χρειάζεται το path του φακέλου της συγκεκριμένης ημερομηνίας._

---

Tips για επιτυχημένο Restore

- **--drop:** Αν η βάση σας δεν είναι εντελώς άδεια και θέλετε να αντικαταστήσετε τα υπάρχοντα δεδομένα, προσθέστε την παράμετρο `--drop` στην εντολή MongoDB Database Tools.
- **Έλεγχος Azure Mount:** Αν το restore αποτυγχάνει με μήνυμα "file not found", βεβαιωθείτε ότι το Azure File Share είναι σωστά mounted εκτελώντας:  
    `docker exec <container_name> ls -l /backup`
- **Πιστοποίηση:** Αν η Mongo έχει ενεργοποιημένο το auth, προσθέστε τα credentials:  
    `--username <user> --password <pass> --authenticationDatabase admin` Microsoft Azure MongoDB Backup Guide.

### How to run the various commands in Azure

Εάν το container σας δεν ξεκινάει λόγω corruption στο **WiredTiger**, το Azure θα προσπαθεί συνεχώς να το κάνει restart (CrashLoopBackOff). Για να το "σώσετε", πρέπει να κάνετε **Override** το `ENTRYPOINT` ή το `Command` ώστε το container να παραμείνει "ζωντανό" χωρίς να τρέξει τη βάση, επιτρέποντάς σας να μπείτε μέσα και να κάνετε το restore.

Ανάλογα με την υπηρεσία Azure που χρησιμοποιείτε:

#### Στο Azure Container Instances (ACI)

Αν το σηκώνετε μέσω του Azure Portal:

1. Πηγαίνετε στο **Container Group** -> **Settings** -> **Containers**.
2. Στο πεδίο **Command override**, γράψτε:  
    `tail -f /dev/null`  
    _(Αυτό κρατάει το container ανοιχτό χωρίς να τρέχει τη Mongo)_.
3. Αφού ξεκινήσει, χρησιμοποιήστε το **Terminal** στο Portal για να τρέξετε το `mongorestore` χειροκίνητα.

#### Στο Azure Web App for Containers (App Service)

Στο Azure Portal:

1. Πηγαίνετε στο **Configuration** -> **General Settings**.
2. Στο πεδίο **Startup Command**, βάλτε:  
    `mongod --repair`  
    _(Αυτό θα προσπαθήσει να διορθώσει τα αρχεία WiredTiger και μετά θα κλείσει. Μετά το αφαιρείτε για να ξεκινήσει κανονικά)._
3. **Εναλλακτικά**, για να κάνετε το restore από το backup:  
    `tail -f /dev/null` και μετά μπείτε με το **SSH** tool του App Service.

#### Στο Azure Kubernetes Service (AKS)

Πρέπει να τροποποιήσετε προσωρινά το `YAML` του Deployment ή του StatefulSet:

```yaml
spec:
  containers:
  - name: mongodb
    image: mongo
    command: ["/bin/sh", "-c"]
    args: ["tail -f /dev/null"] # Override για να μην κρασάρει
```


Μετά τρέχετε το restore μέσω `kubectl exec`:  
`kubectl exec -it <pod-name> -- mongorestore --dir /backup/YYYY-MM-DD`

Τα απαραίτητα Arguments για το Restore

Μόλις μπείτε στο container (αφού έχετε κάνει το override), η εντολή που θα "σώσει" την κατάσταση είναι:

```bash
mongorestore --host localhost \
             --db <onoma_vasis> \
             --drop \
             --gzip \
             --archive=/backup/path_to_your_file.gz
```

Χρησιμοποιήστε τον κώδικα με προσοχή.

**Κρίσιμα σημεία:**

- **--drop**: Διαγράφει ό,τι έχει μείνει από τα corrupted collections πριν γράψει τα καθαρά δεδομένα MongoDB Manual.
- **--db**: Αν θέλετε να επαναφέρετε μόνο τη βάση της εφαρμογής σας και όχι τα συστήματα της Mongo.

**Προσοχή:** Μόλις τελειώσετε το restore, **θυμηθείτε να αφαιρέσετε το Override** (Command/Startup Command) για να ξαναρχίσει το container να λειτουργεί ως βάση δεδομένων.

## Links
[[Back Up a Self-Managed Deployment with Filesystem Snapshots]]

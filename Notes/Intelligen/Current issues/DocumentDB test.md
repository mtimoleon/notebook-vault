---
categories:
  - "[[Work]]"
created: 2026-02-19
product:
component: DocumentDb
status: open
tags:
  - issues/intelligen
---
## Context
Explore DocumentDB as alternative to MongoDb

## Notes

### Install DocumentDB on Docker
1. Τι είναι το “Azure DocumentDB” σήμερα

* Το Azure DocumentDB είναι managed MongoDB-compatible υπηρεσία που βασίζεται στο open-source DocumentDB engine (πάνω σε PostgreSQL, με MongoDB wire protocol). ([Microsoft for Developers][1])
* Στο PC σου δεν “τρέχεις Azure service”, αλλά μπορείς να τρέξεις το αντίστοιχο open-source local image: **DocumentDB Local**. ([GitHub][2])

2. Local εγκατάσταση σε Docker (DocumentDB Local)
   2.1 Docker run (ο πιο γρήγορος τρόπος)

* Pull + run (με credentials που ορίζεις εσύ):

```bash
docker pull ghcr.io/documentdb/documentdb/documentdb-local:latest
docker tag ghcr.io/documentdb/documentdb/documentdb-local:latest documentdb
docker run -dt -p 10260:10260 --name documentdb-container documentdb --username <USER> --password <PASS>
```

Αυτό είναι το “official” quick start από το repo του DocumentDB. ([GitHub][2])

* Connection string (MongoDB driver):

  * Η local σύνδεση γίνεται με TLS και συνήθως θες να επιτρέψεις invalid certs (local dev):

```text
mongodb://<USER>:<PASS>@localhost:10260/?tls=true&tlsAllowInvalidCertificates=true
```

([GitHub][2])

2.2 Docker Compose (αν θες πιο “μόνιμο” setup)

* `compose.yml`:

```yaml
services:
  documentdb:
    image: ghcr.io/documentdb/documentdb/documentdb-local:latest
    container_name: documentdb
    ports:
      - "10260:10260"
    command: ["--username", "devuser", "--password", "devpass"]
    restart: unless-stopped
```

* Εκκίνηση:

```bash
docker compose up -d
```

3. Πρακτικές σημειώσεις για αντικατάσταση Mongo

* Πόρτα: τα docs δείχνουν **10260** για να μη συγκρούεται με άλλα (π.χ. Mongo στο 27017). Μπορείς να το αλλάξεις, αλλά τότε αλλάζει και το connection string. ([GitHub][2])
* Συμβατότητα: είναι MongoDB-compatible, αλλά μην το θεωρήσεις 100% drop-in χωρίς smoke tests (aggregation pipeline, indexes, BSON edge cases). Αυτό είναι εμπειρική γνώση από migrations σε “Mongo-compatible” engines.

4. Τι να κάνεις αμέσως μετά

* 1) Σήκωσε container και κάνε ένα απλό CRUD από την εφαρμογή σου με το υπάρχον MongoDB driver.
* 2. Τρέξε τα βασικά σου aggregations/queries (τα “βαριά” endpoints).
* 3. Αν περάσουν, τότε μόνο σκέψου data migration.

Συμπέρασμα

* Για “Azure DocumentDB” εμπειρία σε PC με Docker: **τρέχεις DocumentDB Local container** και συνδέεσαι με τον υπάρχοντα MongoDB driver σου μέσω TLS στο `localhost:10260`. ([GitHub][2])

[1]: https://devblogs.microsoft.com/cosmosdb/azure-documentdb-is-now-generally-available/?utm_source=chatgpt.com "Azure DocumentDB is Now Generally Available"
[2]: https://github.com/documentdb/documentdb "GitHub - documentdb/documentdb: MongoDB-compatible database engine for cloud-native and open-source workloads. Built for scalability, performance, and developer productivity."


### Connect Compass

1. Connection string για Compass
   Χρησιμοποιείς το ίδιο URI που θα έδινες σε Mongo driver:

```
mongodb://<USER>:<PASS>@localhost:10260/?tls=true&tlsAllowInvalidCertificates=true
```

Παράδειγμα:

```
mongodb://devuser:devpass@localhost:10260/?tls=true&tlsAllowInvalidCertificates=true
```

Αυτό βασίζεται στο official DocumentDB local setup που εκθέτει Mongo wire endpoint στη 10260 με TLS ενεργό. (πηγή: GitHub DocumentDB repo docs)

### Offline migration με mongodump/mongorestore

1. Dump από MongoDB σε docker container

Για όλη τη βάση σε ένα archive (βολικό για μεταφορά):

```
docker exec nosqldata mongodump --archive="dump.archive" --gzip
```

Αν θέλω σε τοπικό δίσκο έξω από το container:

```
docker exec nosqldata mongodump --archive > D:/dump.archive --gzip
```

2. Restore σε Azure DocumentDB (στόχος)

Αν ο στόχος σου έχει TLS (συνήθως ναι), κάνεις restore με TLS flags/params:

```
docker exec nosqldata \
 mongorestore \
  --uri="mongodb://user:pass@documentdb-container:10260"
  --tls --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames \
  --archive="dump.archive" --gzip \
  --drop
```


Σημειώσεις:

`--drop` σβήνει collections πριν το restore (χρήσιμο για repeatable migrations).

Αν είσαι σε local DocumentDB που θέλει self-signed, πρόσθεσε:

`&tlsAllowInvalidCertificates=true&tlsAllowInvalidHostnames=true` στο URI (όπως και στο Compass).

Η Microsoft προτείνει αυτό το ζευγάρι εργαλείων ως “best” για πλήρη μεταφορά.

## Links

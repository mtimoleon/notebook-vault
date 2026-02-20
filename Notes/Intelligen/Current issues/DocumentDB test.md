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

If you want to do it with compose:
Add this service to a `docker-compose.yml` (or into your existing one under `services:`):

```yaml
services:
  documentdb-container:
    image: documentdb
    container_name: documentdb-container
    ports:
      - "10260:10260"
    command: ["--username", "${DOCUMENTDB_USER}", "--password", "${DOCUMENTDB_PASS}"]
    restart: unless-stopped
```

Run it like:
```
DOCUMENTDB_USER=<USER> DOCUMENTDB_PASS=<PASS> docker compose up -d documentdb-container
```
(Or put `DOCUMENTDB_USER` / `DOCUMENTDB_PASS` in a .env file next to the compose file.)

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
  --uri="mongodb://user:pass@documentdb-container:10260" \
  --ssl --tlsInsecure \
  --archive=/backup/nosqldata_2026-02-19_15-35-49.archive.gz --gzip \
  --drop
  --nsExclude='admin.*' \
  --nsExclude='config.*' \
  --nsExclude='local.*'
```

Αν τρέξω το command at local containers and do not want to use my local disk for resolving the file, need to add `MSYS2_ARG_CONV_EXCL="*"` before running the command:

```
MSYS2_ARG_CONV_EXCL="*" docker exec -i scp-nosqldata-backup mongorestore \
  --uri="mongodb://user:pass@documentdb-container:10260" \
  --ssl --tlsInsecure \
  --archive="/backup/nosqldata_2026-02-19_15-35-49.archive.gz" --gzip \
  --drop \
  --nsExclude='admin.*' \
  --nsExclude='config.*' \
  --nsExclude='local.*'

```
Σημειώσεις:

In case container cannot see each other, put documentdb container in the same network of nosqldata-backup container using info from [[Docker notes]].

`--drop` σβήνει collections πριν το restore (χρήσιμο για repeatable migrations).

#### Measure speed

Run on a database with 50000 items the following aggregation:

```
[
  // Find global previous publish
  { $match: { PublishedAt: { $lt: ISODate("2025-10-22T07:43:14.944Z") } } },
  { $group: { _id: null, firstPublish: { $max: "$PublishedAt" } } },
  // FirstBatch = last doc with PublishedAt == firstPublish, per Id
  {
    $lookup: {
      from: "archived-batches",
      let: {
        fp: "$firstPublish"
      },
      pipeline: [
        { $match: { $expr: { $eq: ["$PublishedAt", "$$fp"] } } },
        { $sort: { Id: 1, _id: 1 } }, 
        { $group: { _id: "$Id", FirstBatch: { $last: "$$ROOT" } } },
        {
          // For efficiency we can do specific batch projection here
          $project: { FirstBatch: 1, LastBatch: { $literal: null } }
        }
      ],
      as: "prevRows"
    }
  },
  { $unwind: { path: "$prevRows", preserveNullAndEmptyArrays: true } },
  { $replaceRoot: { newRoot: "$prevRows" } },

  // LastBatch = first doc with PublishedAt >= lastDate, per Id
  {
    $unionWith: {
      coll: "archived-batches",
      pipeline: [
        {
          $match: {
            PublishedAt: {
              $gte: ISODate(
                "2025-10-22T07:43:15.184Z"
              )
            }
          }
        },
        {
          $sort: {
            Id: 1,
            PublishedAt: 1,
            _id: 1
          }
        },
        {
          $group: {
            _id: "$Id",
            LastBatch: {
              $first: "$$ROOT"
            }
          }
        },

        // For efficiency we can do specific batch projection here
        {
          $project: {
            FirstBatch: {
              $literal: null
            },
            LastBatch: 1
          }
        }
      ]
    }
  },

  {
    $group: {
      _id: "$_id",
      // $max acts as "pick non-null" if there are any null objects in the list
      FirstBatch: { $max: "$FirstBatch" },
      LastBatch: { $max: "$LastBatch" }
    }
  },

  {
    $match: {
      $expr: {
        $or: [ {$ne: ["$FirstBatch", null]}, { $ne: ["$LastBatch", null]} ]
      }
    }
  },
  {
    $sort: {
      _id: 1
    }
  },

  // If there is specific projection before there is no need to project here
  {
    $project: {
      FirstBatchId: "$FirstBatch.Id",
      FirstBatchName: "$FirstBatch.Name",
      FirstBatch: "$FirstBatch.PublishedAt",
      LastBatchId: "$LastBatch.Id",
      LastBatchName: "$LastBatch.Name",
      LastBatch: "$LastBatch.PublishedAt"
    }
  }
]
```

DocumentDb results:
```
{
 "stage": "COLLSCAN",
 "nReturned": 49950,
 "executionTimeMillis": 877,
 "totalKeysExamined": 49950,
 "totalDocsExamined": 49950,
 "totalDocsRemovedByRuntimeFilter": 0,
 "numBlocksFromCache": 182759,
 "numBlocksFromDisk": 34185
}
```
![[DocumentDB test-20260220.png|300]]


MongoDB results:
```
{
 "stage": "GROUP",
 "planNodeId": 3,
 "nReturned": 1,
 "executionTimeMillisEstimate": 367,
 "opens": 1,
 "closes": 1,
 "saveState": 20,
 "restoreState": 19,
 "isEOF": 1,
 "projections": {
  "8": "newObj(\"_id\", s6, \"firstPublish\", s7) "
 },
 "docsExamined": 0,
 "keysExamined": 0
}
{
 "stage": "COLLSCAN",
 "planNodeId": 1,
 "nReturned": 49950,
 "executionTimeMillisEstimate": 349,
 "opens": 1,
 "closes": 1,
 "saveState": 20,
 "restoreState": 19,
 "isEOF": 1,
 "numTested": 49950,
 "filter": {
  "PublishedAt": {
   "$lt": "2025-10-22T07:43:14.944Z"
  }
 },
 "direction": "forward",
 "docsExamined": 49950,
 "keysExamined": 0
}
```

![[DocumentDB test-20260220 1.png]]
## Links

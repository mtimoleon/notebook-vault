---
categories:
  - "[[Resources]]"
created: 2025-06-24T10:24
product:
component:
tags:
  - topic/code
---

### 1. Full Snapshot-Based Undo

- **Περιγραφή**: Κάθε φορά που γίνεται σημαντική αλλαγή, κρατάς ολόκληρο αντίγραφο της οντότητας στο history schema.
- **Πλεονεκτήματα**:
    - Απλό σε εφαρμογή
    - Περιέχει ολόκληρη την εικόνα (σχεδόν πάντα "επαναφέρσιμη")
- **Μειονεκτήματα**:
    - Χρησιμοποιεί πολύ αποθηκευτικό χώρο
    - Δεν είναι βέλτιστο για συχνές μικρές αλλαγές
 
### 2. Incremental Change Tracking (Διαφορές πεδίων / Deltas)

- **Περιγραφή**: Αντί να αποθηκεύεις ολόκληρη την εγγραφή, κρατάς μόνο **τι άλλαξε** (field name, παλιά τιμή, timestamp).
- **Παράδειγμα**:
	{ "Entity": "Product", "EntityId": 42, "Field": "Price", "OldValue": "10.00", "NewValue": "15.00", "ChangedAt": "2025-06-24" }
- **Υλοποίηση**:
    - Custom AuditLog table
    - Ή Entity Framework ChangeTracker hooks (π.χ. SaveChangesInterceptor)
- **Πλεονεκτήματα**:
    - Εξαιρετικά αποδοτικό αποθηκευτικά
    - Ιδανικό για audit και selective undo
- **Μειονεκτήματα**:
    - Undo logic είναι πιο σύνθετο (π.χ. apply all deltas in reverse)
    - Δεν υποστηρίζει καλά structural changes (π.χ. αλλαγή children collections)
 
### 3. Command Sourcing (ή Event Sourcing-light)

- **Περιγραφή**: Αποθηκεύεις τις εντολές/επεξεργασίες που έγιναν (π.χ. "Product renamed", "Price changed to X")
- **Παράδειγμα**:
	{ "Command": "UpdatePrice", "Entity": "Product", "Id": 42, "Value": 15.00 }
- **Πλεονεκτήματα**:
    - Πολύ καλό για επανάληψη ή επανεφαρμογή αλλαγών
    - Ιστορικό αλλαγών εντοπισμένο στις πραγματικές business εντολές
- **Μειονεκτήματα**:
    - Θέλει δικό του pattern (CQRS, event replay)
    - Δεν είναι πάντα καθαρό το reverse ενός command
 
### 4. Temporal Tables (SQL Server)

- **Περιγραφή**: SQL Server υποστηρίζει **system-versioned temporal tables**, όπου κάθε αλλαγή κρατά snapshot στον ίδιο πίνακα (με system columns για valid time range).
- **Πλεονεκτήματα**:
    - Native SQL Server υποστήριξη
    - Μπορείς με ένα query να πεις "πώς ήταν αυτό το row την 01/01/2024"
- **Μειονεκτήματα**:
    - Λειτουργεί σε επίπεδο raw rows, όχι πλήρως συνδεδεμένων entities
    - Όχι undo, αλλά "πες μου πώς ήταν τότε"
 
### 5. Memento Pattern (In-memory Undo only)

- **Περιγραφή**: Καταγράφεις το προηγούμενο state στο memory cache πριν αλλάξει το object, μόνο για runtime undo (π.χ. UI changes ή draft changes).
- **Πλεονεκτήματα**:
    - Εύκολο, lightweight
    - Ιδανικό για προσωρινές αλλαγές
- **Μειονεκτήματα**:
    - Δεν επιβιώνει restart ή crash
    - Δεν προσφέρει persistence/ιστορικό
 
### 6. Audit Log + Rehydrate (Hybrid)

- **Περιγραφή**: Κρατάς audit log με field-level changes αλλά έχεις δυνατότητα να "χτίσεις" το entity πίσω στο παλιό state με aggregation.
- **Χρήσιμο για**:
    - Business-critical audit trails
    - Selective revert (π.χ. μόνο Price πίσω στο προηγούμενο)
 
**Επιλογή Τεχνικής Ανάλογα με Use Case**

| **Χαρακτηριστικά**     | **Κατάλληλη Τεχνική**                 |
| ---------------------- | ------------------------------------- |
| Πλήρες Undo με Restore | Full Snapshot (ιστορικό schema)       |
| Περιορισμένος χώρος    | Incremental (Διαφορές ανά πεδίο)      |
| Χρειάζεσαι audit trail | Audit Log ή Temporal Tables           |
| Business Events (DDD)  | Command ή Event Sourcing              |
| In-memory Undo στο UI  | Memento Pattern / Memory Cache        |
| Selective undo         | Audit + Rehydrate ή Hybrid με mapping |

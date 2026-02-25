---
categories:
  - "[[Resources]]"
created: 2026-02-24
url:
tags:
  - topic/ef
  - topic/code
---
Πλήρης πίνακας DeleteBehavior
- Όροι:
    1. Principal = ο “γονιός” (το referenced row).
    2. Dependent = ο “παιδί” (το row που έχει το FK).
    3. Client = EF Core ChangeTracker/runtime (όχι browser/χρήστης).

|DeleteBehavior|EF Core όταν σβήνεις principal ή σπας σχέση|Τι FK δημιουργεί στη βάση (τυπικά)|
|---|---|---|
|Cascade|EF διαγράφει dependents (tracked).|ON DELETE CASCADE|
|ClientCascade|EF διαγράφει dependents (tracked), αλλά|στη βάση **μη-cascading** (συνήθως NO ACTION).|
|SetNull|EF θέτει FK = NULL (tracked)|ON DELETE SET NULL|
|ClientSetNull|EF θέτει FK = NULL (tracked)|στη βάση **μη-cascading** (συνήθως NO ACTION). Default για optional σχέσεις.|
|Restrict|EF δεν κάνει cascade delete. Συμπεριφορά “μπλοκάρισμα” πρακτικά από DB constraint (σε tracked graphs μπορεί να σε οδηγήσει σε FK violation).|μη-cascading constraint (ιστορικά μπερδεύει ως mapping).|
|NoAction|EF δεν κάνει cascade delete. Στη βάση αφήνει “NO ACTION”.|μη-cascading constraint.|
|ClientNoAction|EF **δεν κάνει τίποτα** (ούτε set-null, ούτε cascade) σε tracked dependents.|μη-cascading constraint.|
Σημαντικές διευκρινίσεις που αποφεύγουν παρεξηγήσεις
1. “Client*” σημαίνει: το EF θα κάνει κάτι μόνο για **tracked** entities. Αν δεν είναι φορτωμένα/tracked, η βάση πρέπει να το σηκώσει μόνη της, αλλιώς θα πάρεις FK violation.
2. `ClientNoAction` είναι το πιο “σκληρό”: δεν σου καθαρίζει τίποτα. Αν έχεις FK “NO ACTION” στη DB, τότε για να περάσει delete πρέπει εσύ να καθαρίσεις FK (set null / delete dependents) πριν. Αυτό ακριβώς ζεις.
3. `Restrict` vs `NoAction`: στην EF Core πράξη είναι πολύ κοντά/μπερδεμένα και συχνά καταλήγουν σε ίδια DB συμπεριφορά (μη-cascading). Μη βασίζεσαι στο όνομα σαν να είναι “εγγύηση” διαφορετικού ON DELETE.


---
created: 2025-01-20
---

[https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQZSjdHLhTmzPZXcvxMBLnZVVKq?projector=1&messagePartId=0.1](https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQZSjdHLhTmzPZXcvxMBLnZVVKq?projector=1&messagePartId=0.1)
 
Dataset Popularity Score Calculation  
Formula for Popularity Score  
The formula for calculating a dataset&#39;s popularity score is as follows:  
Popularity Score= w_1* Size+ w_2*Complexity+ w_3*Experiment Count- w_4* Execution Time  
Weights (ω)  
w_1: 0.3 (Size)  
w_2 :0.2 (Complexity)  
w_3: 0.4 (**Experiment Count**) ==--Evdokimos suggestion==  
w_4: 0.1 (**Execution Time**) ==--Evdokimos suggestion==  
Example Dataset  
Dataset Properties:  
-Size:670 MB  
-Experiments Count:130  
- Rows:2,340  
- Columns:12  
- Execution Time:10 minutes (600 seconds)  
Popularity Score = 0.3 * 670 + 0.2 * (2340*12) + 0.4*130 + 0.1*600 = 5929
 
Next to define  
Normalization technique (Ilektra)  
Collection of metrics
   

σε πρώτη φάση θα κρατούσα μόνο το Experiment Count (αριθμός πειραμάτων ανά εβομάδα/μήνα) και το Execution Time το οποίο πρέπει να μας το στείλει  
ή η TCR μαζί με τα άλλα στατιστικά  
ή ο Mikel μόλις τελειώσει το πείραμα (σαν statistics της εκτέλεσης του πειράματος)
 \> Από \<[https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQZSjdHLhTmzPZXcvxMBLnZVVKq](https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQZSjdHLhTmzPZXcvxMBLnZVVKq)\>
---
categories:
  - "[[Work]]"
  - "[[Issues]]"
created: 2025-04-23T11:55
tags:
  - intelligen
status: completed
product: ScpCloud
component:
ticket:
---

EocData  
- [x] Return Batches array  
public int Id { get; set; }  
public string Name { get; set; }  
public int Color { get; set; }  
ConcurrencyToken  
~~public bool IsScheduled { get; set; }~~  
~~public bool HasConflicts { get; set; }~~
 
- [x] Return Campaigns array  
public int Id { get; set; }  
public string Name { get; set; }  
public int Color { get; set; }  
~~public bool IsScheduled { get; set; }~~  
~~public bool HasConflicts { get; set; }~~
 
- [x] Add information in latest batch  
CampaignName  
CampaignColorIndex
   

Σχετικά με το ότι μπορεί να έχουμε stale δεδομένα για ένα OperationEntry στο web production.

![Exported image](Exported%20image%2020260209135813-0.png)








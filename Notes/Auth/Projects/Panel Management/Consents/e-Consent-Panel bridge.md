---
categories:
  - "[[Work]]"
created: 2022-05-30
product:
component:
tags: []
---

![liid NC type NC value associationld associatio n O...](e-Consent-Panel%20bridge-20260217%209.png)

- A panel management organization is the user (the account) of e-Consent service. This means that jwt is created for organization owner? or the actual organization? We need to create (hardcoded) Admin account for each organization-owner. ![econsentdb.users Docu ments Aggregations ALTER ADD...](e-Consent-Panel%20bridge-20260217%208.png)  

The ==accountId== column can be the uuid of the organization in panel management and ==role== should be Admin=2
    
- ~~Have an action button `Request consent`~~
    
    ~~and this should open a dialog box to choose consent template and send triggers to consent. With in this process a project:~~
    
    - ~~if not exist will be created in e-consent service along with studies, users, subjects.~~
    - ~~if it exists an update will take place of subjects~~
      
    
- When adding a new or updating a manager, if project has consents enabled, we update project and add or update user in e-consent (depends if user has e-consent id) - When adding a new member in a project, if project has consents enabled we add or update the member to consent subjects (depends if member has e-consent id)
    
![userlds Array v studies Array v e Object id studya...](e-Consent-Panel%20bridge-20260217%207.png) ![O created_at O updated_at 193 valid _ organization...](e-Consent-Panel%20bridge-20260217%205.png)        ![_id objectld secc4dbt14S4eascfc12bssd contactNetho...](e-Consent-Panel%20bridge-20260217%206.png)                                                                                                                             ![_id objectld sec33271c99adfsa142ceeea contactethod...](e-Consent-Panel%20bridge-20260217%204.png)                                     ![export enum UserRole User e, SuperUser I, Admin 2,...](e-Consent-Panel%20bridge-20260217%203.png)     

- User μπορεί να είναι  
οι managers  
- SuperUser ο owner

To organizationId μεταφέρεται όπως είναι στο  
accountId

![O created_at O updated at RBC name RBC alias RBC d...](e-Consent-Panel%20bridge-20260217%202.png) ![_id objectld secc4dbt14S4eascfc12bssd contactNetho...](e-Consent-Panel%20bridge-20260217%201.png)    

The role of an organization  
will be Admin=2  
The organization acts like a service = Admin

The id of mongo db should be the ==eConsentId== in panel management

Registration of an organization  
in eConsent can take place with the  
POST /users with the following Postman object  

```
{
    "role": 2,
    "firstname": "ASSOS",
    "lastname": "ASSOS",
    "email": "bamidis@gmail.com",
    "contactMethods": [
        {
            "type": "moblie",
            "value": "+306945123456"
        }
    ]
}
```

This can be an organization owner email and contact

==Add eConsentId==  
==in organization==  
==Add eConsentToken==  
==in organization==

**The flow to add organization as a service in eConsent:**
 
1. Add organization as a user in eConsent
2. Create a hard coded token ([https://jwt.io/](https://jwt.io/)) :

{  
"sub": "service",  
"id": "\<the id from step 1",  
"iat": \<issued epoch time\>,  
"exp": \<expiration epoch time\>,  
"role": "Admin",  
"accountId": "\<organizationId\> from panel management"  
}
 5. Add the token from step 2 in organization in panel management db

![_id objectld 62de847681esfsscssb2ee94 contactethod...](e-Consent-Panel%20bridge-20260217.png)

![[e-Consent-Panel bridge-20260217.svg]]

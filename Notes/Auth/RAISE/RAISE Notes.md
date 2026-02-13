---
created: 2025-10-15
---

- **RAISE Notes**
    - RAISE flows: [https://drive.google.com/drive/folders/1eSSgIME0fxqQhVNSdDVg8X3q5LT-s2nJ](https://drive.google.com/drive/folders/1eSSgIME0fxqQhVNSdDVg8X3q5LT-s2nJ)
    - Drive document for integrations: [https://docs.google.com/document/d/1uuGzFLrX1lz3_z0k2b5T0B7aFcIfm4ewvVYS_kgU1C4](https://docs.google.com/document/d/1uuGzFLrX1lz3_z0k2b5T0B7aFcIfm4ewvVYS_kgU1C4) #important
    - **Tasks we are involved** **RAISE Tasks**
        - ## T3.2 RAISE FAIR Catalogue and Portal for data discovery (INTRA)
            
        
        Na doyme to code analysis statistics (Natsos)
        
        - ## T3.4 RAI Registration Service (WITA)
            
        - ## T3.5 RAI Finder service (AUTH)
            
        - ## T3.6 RAISE FAIR Results Repository (AUTH)
            
        
        χρειαζόμαστε την WITA για να προχωρήσουμε, τώρα τοπικά αποθηκεύουμε κάποιες πληροφορίες.
        
        - ## T3.8 Popular Dataset Preservation and Multi Tenant RAI node (AUTH)
            
        
        περιμένουμε meeting με TCR για να δούμε πως θα προχωρήσουμε
        
          
        - ## T3.10 FAIR publishing of RAIs (AUTH)
            
        
        είμαστε καλά
        
          
        - ## T3.12 RAI Production and resources deployment (AUTH)
            
    - **Partner implementations**
        - ## **Portal upload script for experiment**
            
        
        ## TCR is responsible for repo and scripts creating swhID
        
        [https://mail.google.com/mail/u/0/?tab=rm&ogbl#search/label%3A_%CE%B1%CF%80%CE%B8-raise+gepelde%40vicomtech.org/FMfcgzQVwnVJtJGQWwmtGqfVqZmvKhpp](https://mail.google.com/mail/u/0/?tab=rm&ogbl#search/label%3A_%CE%B1%CF%80%CE%B8-raise+gepelde%40vicomtech.org/FMfcgzQVwnVJtJGQWwmtGqfVqZmvKhpp)
        
    - **Raise pid handbook**
        - Url: [https://pid.raise-science.eu/](https://pid.raise-science.eu/)
        - Αφού αλλάξουμε το PID structure we need to update documentation
        - [PID structure Version 2.0](PID%20structure%20Version%202.0.md)
        - [PID RAI Resolver discussion](PID%20RAI%20Resolver%20discussion.md)
    - **UI fill the metadata for the dataset, in 2 or 3 steps**
    
    ## API which is called from UOM (Kartesidis) and takes information from AUTH dataset
    
      
    - **Dataset FAIRness assessment, technical approach**
    
    [https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQVxlTfmVldgRgvSVbVSVmCLrhL](https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQVxlTfmVldgRgvSVbVSVmCLrhL)
    
      
    - **T3.5 - T3.6 - T3.10 Redefine RAI id according to EOSC policy**
    
    The re-definition of RAI ID was delayed for the next milestone M28 upon development priorities discussion
    
      
    - **RAISE - Policy Engine API - SOTON**
    - **Plagiarism checker flow**

## T3.2 RAISE FAIR Catalogue and Portal for data discovery (INTRA)

## T3.4 RAI Registration Service (WITA)

## T3.5 RAI Finder service (AUTH)

Πρέπει να αλλάξουμε το PID σύμφωνα με το εμαιλ του Gorka [https://mail.google.com/mail/u/0/?tab=rm&ogbl#label/_%CE%91%CE%A0%CE%98%2FRAISE/FMfcgzQVxtmdWDZfJntvqvQSjnhbjDWL](https://mail.google.com/mail/u/0/?tab=rm&ogbl#label/_%CE%91%CE%A0%CE%98%2FRAISE/FMfcgzQVxtmdWDZfJntvqvQSjnhbjDWL)
 
και τις οδηγίες που περιγράφονται στο παρακάτω συνημμένο

![[2024-08-01 PID RAI Resolver.docx]]
 ![Exported image](Exported%20image%2020260211204157-0.png)

[https://swimlanes.io/d/MPS7xsqPw](https://swimlanes.io/d/MPS7xsqPw)
 
Kostas Filippopolitis  
Το plagiarism checker database είναι deployed στο [http://88.197.53.15:8000](http://88.197.53.15:8000/)  
Swagger: [http://88.197.53.15:8000/docs#/](http://88.197.53.15:8000/docs#/)
 \> Από \<[https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQXJQKRNZbJZjphZsJjwggScrhS](https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/FMfcgzQXJQKRNZbJZjphZsJjwggScrhS)\>   
I dockerized the API and pushed the relevant Docker files to the repository. While doing that, I also remembered that the API uses a code-first database approach, meaning you do not need to create any database or collection in advance; the model creates it automatically on the first run. Additionally, I changed the method of credential retrieval from a config file to a .env file (please remember to modify and rename example.env to .env). I tested it on my linux server, and it seems to be working with a simple "docker compose up" command. Please let me know if you have any further issues or if you need any information related to the functionalities of the API.
 
**Database :** policy_database  
**collections****:**  
data_policies  
script_policies  
   
For the connection string, please update config.py (host, user, password). The existing connection string works for mongo in  [https://cloud.mongodb.com/](https://cloud.mongodb.com/) . You may need to change the MONGO_DETAILS  string (in app.py) if you will be using localhost or another type of connection.
    
## API which is called from UOM (Kartesidis) and takes information from AUTH dataset

## TCR is responsible for repo and scripts creating swhID

## **Portal upload script for experiment**

## T3.12 RAI Production and resources deployment (AUTH)
 
## T3.10 FAIR publishing of RAIs (AUTH)
 
## T3.8 Popular Dataset Preservation and Multi Tenant RAI node (AUTH)

## T3.6 RAISE FAIR Results Repository (AUTH)
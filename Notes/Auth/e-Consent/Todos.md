---
created: 2025-01-08
---

- [x] Create ssh keys and add to jenkins and server  
- [x] Temporarily copy files from captain server to e-consent server  
- [x] Copy database from Captain server to e-consent-server  
[https://stackoverflow.com/questions/5495137/how-do-i-copy-a-database-from-one-mongodb-server-to-another](https://stackoverflow.com/questions/5495137/how-do-i-copy-a-database-from-one-mongodb-server-to-another)  
- [x] Create the e-consent services, production and develop  
- [x] Check if service is working  
- [x] Stop service  
- [ ] Update jenkins pipline using the new keys and server  

```
pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'my-ssh-key', keyFileVariable: 'KEY_FILE', usernameVariable: 'USER')]) {
                    sh "ssh -i $KEY_FILE $USER@your-server 'your-command'"
                }
            }
        }
    }
}
```
 - [ ] Upgrade application packages to latest versions  
- [ ] Deploy to the new server  
- [x] Check flow described here: [https://docs.google.com/document/d/1T-OAsXGD2NHtFzlLksog1PB3c1vnLGAF/edit](https://docs.google.com/document/d/1T-OAsXGD2NHtFzlLksog1PB3c1vnLGAF/edit)  
- [ ] Add api endpoints

UserRole {  
User = 0,  
SuperUser = 1,  
Admin = 2,  
SuperAdmin = 3,  
}
 
sub {  
service  
user  
}
   

- First we need an account id: 1616d626-026f-11eb-ba9c-00505692f913
- Then add a user for this account id with role 2, Admin
- Then we need to create the admin token for this account, using the appropriate secret base64 encoded, also in the dev app temprarily we do not check for token expiration
- Then add a project
- Then add a subject
- Then upload a template
- Ask for consent

{  
"_id": {  
"$oid": "62de84768105f58c68b20e94"  
},  
"contactMethods": [],  
"accountId": "1616d626-026f-11eb-ba9c-00505692f913",  
"role": 2,  
"firstname": "mi",  
"lastname": "timo",  
"email": "mitimo@gmail.com",  
"__v": 0  
}  
{  
"sub": "user",  
"id": "62de842b8105f58c68b20e93",  
"iat": 1516239022,  
"exp": 1916239999,  
"role": "Admin",  
"accountId": "1616d626-026f-11eb-ba9c-00505692f913"  
}
   

- [ ] They will add a callback url in the study.  
- [ ] When a user accepts, rejects or withraw consent we will post the relative information to their url.  
- [ ] if they want different languages they have to create the corresponding Studies  
- [ ] We need to create a queue to record the unsuccessful requests  
- [ ] When a study gets updated the pending requests should get the new caleback url from the updated stuly.  
- [ ] We need to implement consent withdrawal.
---
categories:
  - "[[Work]]"
created: 2026-02-14
product:
component:
tags: []
---

Clipped from: [https://www.freecodecamp.org/news/cjn-is-your-mysql-secured-7793e5444cf5/](https://www.freecodecamp.org/news/cjn-is-your-mysql-secured-7793e5444cf5/)
 ![How to make sure your MySQL database is secured](Exported%20image%2020260211203947-0.png) _Some basic information before we get started:_

Source: [Center for Internet Security’s (CIS) Oracle MySQL Community Server 5.7](http://www.itsecure.hu/library/image/CIS_Oracle_MySQL_Community_Server_5.7_Benchmark_v1.0.0.pdf)  
**Operating system:** Windows 10  
**Where to execute:** command line  
mysql -u USERNAME -p  
**Target application:** Oracle MySQL Community Server 5.7

### **Auditing and logging for information systems**

Logs play a crucial role for security when there is a suspected cyberattack. A manual review of logs is painstaking for security personnel, and they must use log review tools to extract information and analyze it. Logs should use a WORM (write once read many) storage technology and encryption to avoid corruption and losing log data. Also, logs should have a standardized format for ease of maintenance, access and comparison.

_Ensure “log_error” is not empty_

**command:**  
SHOW variables LIKE ‘log_error’;

![l3RqZv9978n6JjOZ46JpcdAjzpkwCOMZBZRZ](Exported%20image%2020260211203949-1.png)

error logging  
Error logs contains data on events when mysqld starts or stops. It also shows when a table needs to be assessed or repaired. It must generate a “value”. The reason for enabling error logging is it helps increase the ability to detect malicious attempts against MySQL and other vital messages.

_Ensure log files are stored on a non-system partition_

**command:**  
SELECT [@@global.log_bin_basename](mailto:@@global.log_bin_basename);  
Log files of MySQL can be stored anywhere in the filesystem and set using the MySQL configuration. Also, it is a best practice is to ensure that the logs in the filesystem are not cluttered with other logs such as application logs. You must ensure that the value returned does not indicate that it is in the root “(‘/’)”, “/var”, or “/usr”. The reason for this is that partitioning will decrease the likelihood of denial of service if the available disk space to the operating system is depleted.

![nhcvpYZlHHOOhdfs6yvaV5HcGFDxgJpVqBK](Exported%20image%2020260211203950-2.png)

**Log files in non-system partition**

_Ensure “log_error_verbosity” is not set to “1”_

**command:**  
SHOW GLOBAL VARIABLES LIKE ‘log_error_verbosity’;  
This check provides additional information to what functionalities the MySQL log has or has enabled on error messages. A value of 1 enables the logging of error messages. A value of 2 enables both the logging of error and warning messages. A value of 3 enables logging of error, warning, and note messages. This helps detect malicious behavior by logging communication errors and aborted connections.

![iRTm8K9NxMBl1IB7NHFBauh0rrJu9oCgY0k](Exported%20image%2020260211203951-3.png)

**Log error verbosity**

_Ensure audit logging is enabled_

Enabling audit logging is crucial for production environment for interactive user sessions and application sessions. With audit logging, it helps identify who changed what and when. It can also help to identify what an attacker has done and can even be used as evidence in investigations.  
command:  
SELECT NAME FROM performance_schema.setup_instruments WHERE NAME LIKE ‘%/alog/%’;

![Liy1Sl4SLwpwWpLuNvjVreSc5MRwp3zNiP7](Exported%20image%2020260211203955-4.png)

**Audit log 1**

![iG5c9r9fh9SvrpBk37okSv21nTa33qqaKZZ](Exported%20image%2020260211203956-5.png)

**Audit log 2**

![9vNTODm1dLPjcAcWykuXDrygS2i86JGSwPvC](Exported%20image%2020260211203958-6.png)

**No audit log plugins**  
**command:**  
SET GLOBAL general_log = ‘ON’ ;

![LL5kVryyQDopuKWWMneeagTdkJRwO2lmtF](Exported%20image%2020260211203959-7.png)

**General log query**  
**command:** CREATE USER ‘user1’@’localhost’ IDENTIFIED BY PASSWORD ‘not-so-secret’;  
The log’s path in Windows 10 can be found by using Services application, looking to see if MySQL is running, and right-click properties.  
The log in the author’s system was located in: C:\ProgramData\MySQL\MySQL Server 5.7\Data\DJ-JASON-CLARK.log

![cGkM1MPU2GPoQ8ja7mFWjQKYj15UJBUezO](Exported%20image%2020260211204001-8.png)

**General log in the system**

![acgtKwuMOxUL42WJQTUe5kwNawpnkS0NpfP](Exported%20image%2020260211204002-9.png)

**MySQL Enterprise Audit process**

### **Authentication for information system**

Authentication makes sure the credentials provided by the user or machine are matched with the database of authorized users in a local operating system or in an authentication server. Authentication is then followed by authorization, which is granted by an administrator to users or machines. An authentication that is commonly used in both private and public networks is password-based authentication.

_Ensure passwords are not stored in the global configuration_

The [client] section of a MySQL configuration file allows the creation of a user and password to be set. The check is important because allowing a user and password in the configuration file impacts the confidentiality of the user’s password negatively.  
To audit, open MySQL configuration file and examine the [client] section — it must not have any password stored. No password was set in the author’s system (see figure below). If a password was set in the configuration file, use mysql_config_editor to store passwords in the encrypted form in .mylogin.cnf.

![Q88ION6J2v8yvZZhOHi6W92WEeEEPYxlrSRL](Exported%20image%2020260211204003-10.png)

**[client] section of MySQL configuration file**

_Ensure ‘sql_mode’ contains ‘NO_AUTO_CREATE_USER’_

The “no_auto_create_user” is an option to prevent the auto creation of user when authentication information is not provided.  
**command:**  
SELECT [@@global.sql_mode](mailto:@@global.sql_mode);

![04EKee02Rr3Irs1pSUzonmRFNtDcpX8Samq](Exported%20image%2020260211204007-11.png)

**No auto create user in global**  
**command:**  
SELECT [@@session.sql_mode](mailto:@@session.sql_mode);

![joKBhVTvSWObegwcx4rysRngCVzRu12PacM](Exported%20image%2020260211204009-12.png)

**No auto create user in session**

_Ensure passwords are set for all MySQL accounts_

A user can create a blank password. Having a blank password is risky as anyone can just assume the user’s identity, enter the user’s loginID and connect to the server. This bypasses authentication, which is bad.  
**command:**  
SELECT User,host FROM mysql.user WHERE authentication_string=’’;

![ZpvRueSkBNE2pSDpDhJe0ypEFwGCxofYfg1](Exported%20image%2020260211204010-13.png)

**Users with blank passwords**

_Ensure ‘default_password_lifetime’ is less than or equal to ‘90’_

Changing the password lifetime to 90 days decreases the time available for the attacker to compromise the password, and thus decreases the likelihood of getting attacked.  
**command:**  
SHOW VARIABLES LIKE ‘default_password_lifetime’;

![CJO2VduUgpaCDsqUwf4J7BhVeNJERQhrFLu](Exported%20image%2020260211204011-14.png)

**Default password lifetime with 0 value**  
**command:**  
SET GLOBAL default_password_lifetime=90;

![OnRfHJLsHIqyo9FVYPtYH8tLowjEeBhaiko](Exported%20image%2020260211204012-15.png)

**Setting default password lifetime to 90**

_Ensure password complexity is in place_

Password complexity adds security strength to authentications and includes adding or increasing length, case, numbers and special characters. The more complex the password, the harder for attackers to use brute force to obtain the password. Weak passwords are easily obtained in a password dictionary.  
**command:**  
SHOW VARIABLES LIKE ‘validate_password%’;

![x25sxKvZfaRQPK4ZmcfroMLHSRwIr4MqEV9J](Exported%20image%2020260211204013-16.png)

**Check for password complexity**

![YRlXHe0O0kFZDla6r0lCPv0krGHw8OIg5fKi](Exported%20image%2020260211204014-17.png)

**Implement password complexity**

_Ensure no users have wildcard hostnames_

Users with wildcard hostnames (%) are granted permission to any location. It is best to avoid creating wildcard hostnames. Instead, create users and give them specific locations from which a given user may connect to and interact with the database.  
**command:**  
SELECT user, host FROM mysql.user WHERE host = ‘%’;

![vPYOo8ZvwxKBGIxAI3ghiCSv7taKUF9wtRng](Exported%20image%2020260211204018-18.png)

**Wildcard hostname**

![VYixR1Z4ccQn3mhyIojKjVFPi5PFfHvb8Ka](Exported%20image%2020260211204019-19.png)

**Change wildcard hostname**

_Ensure no anonymous accounts exist_

Users can have an anonymous (empty or blank) username. These anonymous usernames have no passwords and any other user can use that anonymous username to connect to the MySQL server. Removal of these anonymous accounts ensures only identified and trusted users can access the MySQL server.  
**command:**  
SELECT user,host FROM mysql.user WHERE user = ‘’;

![yCiBhUnSoYw8hiTde0V7fSimGjVyjMjetWLW](Exported%20image%2020260211204020-20.png)

**No anonymous accounts**

### **Network connection to MySQL server**

The network connection plays an important role for communication between the user and the MySQL server. Insecure network connections are very vulnerable to attacks. The following are checks for network connection security.

_Ensure ‘have_ssl’ is set to ‘YES’_

To avoid malicious attackers peeking inside your system, it is best to use SLL/TLS for all network traffic when using untrusted networks.  
**command:**  
WHERE variable_name = ‘have_ssl’;

![ut3VeJpXP6eYKjT2al0QaVZYurNRXqhBSgbE](Exported%20image%2020260211204021-21.png)

**No SSL**

_Ensure ‘ssl_type’ is set to ‘ANY’, ‘X509’, or ‘SPECIFIED’ for all remote users_

SSL/TLS should be configured per user. This further prevents eavesdropping of malicious attackers.  
**command:**  
SELECT user, host, ssl_type FROM mysql.user WHERE NOT HOST IN (‘::1’, ‘127.0.0.1’, ‘localhost’);

![4lluCsRhf5Kgz4AUpGPWiDb7pZYv6Tnt5W3i](Exported%20image%2020260211204022-22.png)

**No ssl_type**

### **Replication**

Checking for replication status lets you monitor performance and security vulnerabilities. Microsoft SQL Server Management Studio has the following tools to monitor replication:

1. view snapshot agent status,
2. view log reader agent status, and
3. view synchronization status.

_Ensure replication traffic is secured_

Replication traffic between servers must be secured. During replication transfers, passwords could leak.  
To audit, check if they’re using: a private network, a VPN, SSL/TLS or a SSH Tunnel. Hopefully the author’s system is using a private network. Correct if otherwise, and secure by using the private network, a VPN, SSL/TLS or a SSH Tunnel.

![0RM3gzfomxLEWKzwnf1CKynDJNAqhfXPaKX](Exported%20image%2020260211204023-23.png)

**Private network**

_Ensure ‘MASTER_SSL_VERIFY_SERVER_CERT’ Is Set to ‘YES’ or ‘1’_

‘MASTER_SSL_VERIFY_SERVER_CERT’ checks whether the replica should verify the primary's certificate or not. The replica should verify the primary's certificate to authenticate the primary before continuing the connection.  
**command:**  
SELECT ssl_verify_server_cert FROM mysql.slave_master_info;

![4WAxSQDlSxjC43Z5nFCbnYLkfaxyH6hkcm](Exported%20image%2020260211204024-24.png)

**No SSL for replica-primary check**

_Ensure ‘master_info_repository’ is set to ‘TABLE’_

The ‘master_info_repository’ determines where the replica logs the primary's status and connection information. The password is stored in the primary info repository that is a plain text file. Storing the password in the TABLE master_info is a safer.  
**command:**  
SHOW GLOBAL VARIABLES LIKE ‘master_info_repository’;

![n74mT9wp5NnY6ROIoij9BJ05F5ElPOLPR](Exported%20image%2020260211204028-25.png)

**Primary info repository value**

_Ensure ‘super_priv’ is not set to ‘Y’ for replication users_

The “SUPER” privilege (‘super_priv’) located in the “mysql.user” table has functions like “CHANGE”, “MASTER TO”, “KILL”, “mysqladmin kill”, “PURGE BINARY LOGS”, “SET GLOBAL”, “mysqladmin debug”, and other logging controls. Giving a user the “SUPER” privilege allows the user to view and terminate currently executing SQL statements, even for password management. If the attacker exploits and gains the “SUPER” privilege, they can disable, alter, or destroy logging data.  
**command:**  
SELECT user, host FROM mysql.user WHERE user=’repl’ and Super_priv = ‘Y’;

![vy8xJdaYwOOAzIWyvrVaRm27JL4h9KqPIuzM](Exported%20image%2020260211204029-26.png)

**Replication check for users with SUPER privilege**

_Ensure no replication users have wildcard hostnames_

MySQL allows you to grant permissions to wildcard hostnames. Wildcard hostnames should be avoided, and you should create or modify users and give them specific locations from which a given user may connect to and interact with the database.

![7XVbzJBQYHEr8pVq41eL0QmJZvM27aQfSXe](Exported%20image%2020260211204030-27.png)

**Replication check for wildcard hostnames**

### **Conclusion**

The following checks are made for a single work environment using MySQL as the information system on both the application-side and the user-side.  
The assessment is imperative to check for standard logging of MySQL and enabling additional logging functions (it also enables checking for authentication vulnerabilities). Network checks are important to prevent other users with malicious intent from peeking into your network. Always implement SSL/TLS to encrypt. Securing one-way transfer is necessary. Securing replication traffic adds a defensive layer.  
The result of the assessment can inform you if the system is able to operate at a level of trust.  
Thank you for reading my blog! You have now started the path to securing your MySQL database.=)
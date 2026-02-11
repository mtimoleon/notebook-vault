Another plugin type (reader)
       
follows data protocols  
like open mHealth, FIHR etc.
 
Choosing a plugin for download, server will save the plugin  
into folder configured ready to run as an instance of the plugin.  
This will facilitate the run of a plugin  
multiple times for different users for example.  
Also a facilitator can add plugins manually eg from a flash drive.

Runs the executable directly from  
the instances folders, following the  
configuration object created from server

Each plugin contains:

- executable (script or compiled) for deployment
- executable GUI for configuration (if it needs configuration, eg fitbit)
- json file with the above description for server use eg.
    - script or compiled,
    - version,
    - uuid,
    - config requirement
    - mqtt data export type (open mHealth etc)
    - description
    - instructions

Plugins dashboard

- Health view for server
- View with available plugins on server
- View with plugins
    - to download
    
    - [x] to configure a plugin for server/mqtt etc  
    - [x] to run plugin specific configuration executable
    

- [ ] display running children  
- [x] display broker status  
- [x] to run  
- [x] to stop  
- [ ] to kill

**Plugin configuration** file created by server during setup

- uuid
- name
- version
- description
- ~~Publish channels~~
- ~~Subscribe channels~~
- Broker ip
- Broker user
- Broker pass
- params: array of objects

**Plugin instances** folder contains configuration file(s) -\> json = instance

- uuid of plugin
- Name of plugin
- description
- version
- Process id PID  
**Plugin info json**

- uuid,
- name,
- version,
- description
- instructions
- type: script or compiled,
- cli command to run
- cli args
- explicit config requirement
- config cli command
- config cli args
- mqtt data export type (open mHealth etc)
- configParams: the parameter names to config

Folders

- uploads: the folder where a plugin zip is written before extraction
- plugins: where the configured plugins are stored
- instances: where the running instances are stored

download  
get plugin and write zip into uploads  
unzip into temporary
 
setup  
unzip plugin into plugins folder,  
config,  
create configuration file  
run

**GENERAL FLOW**

2. write files to server
    1. if files are raw, in a folder named inside uploads
    2. if is a zip file, unzip in a folder inside uploads
3. show the downloaded plugins available for setup in dashboard
4. setup plugin
    1. run setup executable or show view
    2. write config-uuid.config.json inside plugins folder
5. run plugin
    1. create an instance of plugin running as a spawned process
    2. write instance info file in instances folder and keep it in sync
    3. if server stops all child processes should stop with kill sig
      
      
    
   

![NOdeJS 1 Thread Main Thread A much lighter option ...](Exported%20image%2020260211205213-0.png) 
 
Requirement:  
- having access to the internet  
- login to RAI and get token  
- Data transformation

![[Sensors integration - Ink.svg]]

---
categories:
  - "[[Work]]"
created: 2024-01-27
product:
component:
tags: []
---

**Signposting**

## **Things to consider:**

- RAISE PID records
    - Record data types registry
        - [https://faircore4eosc.eu/eosc-core-components/eosc-data-type-registry-dtr](https://faircore4eosc.eu/eosc-core-components/eosc-data-type-registry-dtr)
        - Read the handle net documentation to clarify types, handle is based on
        - [https://dtr-test.pidconsortium.eu/#](https://dtr-test.pidconsortium.eu/#)
          
          - **Alignment with the Proposed PID**:
    - The proposed PID structure covers essential elements (author, paper, additional data).
    - However, the EOSC policy may have specific requirements or recommendations.
    - To ensure compatibility, consider the following:
    - **Standardization**: Check if the proposed PIDs align with recognized standards (e.g., DOI, ORCID).
    - **FAIR Principles**: Ensure that the PIDs contribute to making research data Findable, Accessible, Interoperable, and Reusable.
    - **Certification Criteria**: Review the EOSC criteria for PID certification[2](https://eosc.eu/advisory-groups/pid-policy-implementation). - **Adaptation**:
    - Adapt the proposed PID structure to meet EOSC’s specific expectations.
    - Consider any additional metadata required by EOSC (e.g., provenance, versioning). 
- RAISE PID handbook structure
    - [https://docs.pidinst.org/en/latest/white-paper/index.html#table-of-contents](https://docs.pidinst.org/en/latest/white-paper/index.html#table-of-contents)
    - [https://project-thor.readme.io/docs/getting-started](https://project-thor.readme.io/docs/getting-started)
    - [https://www.swhid.org/specification/v1.1/1.Scope/](https://www.swhid.org/specification/v1.1/1.Scope/)
    - Overview
    
    Information amout the site and what info it provides
    
    - RAISE PIDs
        - Description of what is a RAISE PID
        - Perhaps explain RAISE PID records
            - Explain what is the kernel info
            - Explain metadata info
        - What kind of info do we get resolving a RAISE PID
    - RAISE PID Metada schema
        - Describe the metadata schema
    - Landing page content    - Need to realize what will is kernel information and what is metadata information.
    1. The resolve address
    2. A number representing the creation date?
    3. The flags for the admin rights

We can say that this is the kernel information?  
Also when you resolve the doi to the digital object the data you get back follow the doi metadata schema (check if this is correct)

- Decide how much info we will put inside kernel and what will go to metadata
    1. Guid lines to apply:
        1. Apply identifiers to the primary resources in your dataset, i.e., the things that consumers of your data are likely to ask for individually
        2. Restrict the data that are returned for an identifier to those data immediately related to the resource, and closely related sub-resources.
        3. When assessing what forms a “dataset”, consider which set of records could be transferred to another curating institution.
        4. Consider whether resources you are identifying can be independently curated.

- ==Initial version -==  ==https://docs.google.com/document/d/1jEEcKGnq-Vmxp0hKU1tj37-Q3dZStXVJv4UKxA1q_tg/edit#heading=h.k6gpxhuyemn8==
- ==Updated for integrity validation -==  ==https://docs.google.com/document/d/1uv-tOd2IHbKeg_240QjMtuWUP4mrOWTuCitXHoAjjE4/edit#heading=h.hu8ikll8izyp== \> Από \<[https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/QgrcJHsHkwqRQvqbcHwjpgbrZbhbqcWbnLl](https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/QgrcJHsHkwqRQvqbcHwjpgbrZbhbqcWbnLl)\>     

ORCID AND DATACITE INTEROPERABILITY NETWORK

![[ODINWP4WorkflowInteroperability00021_0.pdf]]

![[PID records.json]]

![[markmap.html]]

- **Additional Data**:
    - **Keywords**: Encode keywords as a list of strings (e.g., [“glacier”, “sea level”, “climate change”]).
    - **Citation Count**: Represent the count as an integer (e.g., 50).
    - **Download Count**: Represent the count as an integer (e.g., 100).
    - **License Information**: Encode the license type (e.g., “CC BY-SA 4.0”).
      
     
Here’s a sample of a resolved PID (based on the vitalise project and extended with the above information):  
For the public/private marking we asume that everything is private unless it is checked as public

![[pid.json]]

![[pid 1.json]]

![[ODINWP4WorkflowInteroperability00021_0 1.pdf]]

![[PID records 1.json]]

![[markmap 1.html]]
                        
\> Από \<[https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/QgrcJHsHkwqRQvqbcHwjpgbrZbhbqcWbnLl](https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox/QgrcJHsHkwqRQvqbcHwjpgbrZbhbqcWbnLl)\>        

• Universally unique – a system to ensure each generated identifier is unique worldwide. Generation normally involves a defined algorithm or process that creates a new unique identifier.  
• Independent generation – it should be possible to generate an identifier without the need for a centralised system. This requires a defined process and format for defining the identifier structure.  
• Unchanging – the identifier should never change (both the identifier itself and the resource the identifier is applied to).  
• Opaque – it should not be possible to determine any detail about the identified resource by looking at the identifier alone.  
• Actionable (sometimes) – the identifier can be de-referenced so that the data about the resource can be retrieved. This is also called resolution of an identif
 
- Do not simply use database record identifiers as Persistent Identifiers.
- Do define a context name under your control to ensure the global uniqueness of your identifiers.
- Do use your context name to define the scope of your identifiers.
- Do put management processes in place to ensure Persistent Identifiers and their associated data are always synchronised, so that when database records change the Persistent Identifiers for those records are reviewed promptly.
- Do choose context names that are institution independent, i.e. project names rather than organisation names. Larger, more vital projects will obviously be a more likely permanent context name due to the fact that the community is more likely to ensure the survival of the name. - Most identifier mechanisms follow some or all of the principles that define an ideal identifier. Most of these principles can be summarised as: - When to change the identifier if the data changes
    - Define the types of resources that are being identified.
    - Define what constitutes “data” and what constitutes “metadata” with respect to your resource types.
    - Define the fundamental properties of each resource type that define that resource. These properties should be values that, when changed, will change the meaning and understanding of that resource.
    - Define relationships between resources. Check that if any properties of a resource change, that this will not fundamentally change the meaning of the relationships with other resources.
    - Define the degree to which each property can change before it results in a different resource. Sometimes this will be nil, where a value cannot change at all, and sometimes there will be a degree of tolerance of change.
    - Examine the number of changes applied to your dataset over a period of time. Be aware that the scale of change may not be consistent over time – a dataset may undergo a period of intense data cleaning prior to internet publication, after which the number of changes may be fewer.
    - Consider making public the scale of changes to your data so that those referencing your data using Persistent Identifiers are aware of this dimension.
- Versioning of identifiers

When the data for a resource do change to a degree that results in a fundamentally different resource, you will need to decide how to handle this. In some cases you may decide that it does result in a completely new resource, and sometimes you may decide it results in a different version of the same resource. Either way it is important to maintain links between the two editions of the resource

- Checklist for implementing Persistent Identifiers

 Pick a context name for scoping your identifiers (section 1e).  
 Assess the robustness and opacity of the format of your identifier (section 1e).  
 Assess any current identifiers for your digital resources and decide if they will remain unchanged into perpetuity and hence be usable as part of the external Persistent Identifiers (section 1d).  
 Pick a Persistent Identifier format, e.g. LSID, URI (section 2).  
 Define the management processes for connecting your digital resources / database records to the Persistent Identifiers (section 3).  
 Define which type of resources you will be providing Persistent Identifiers for (section 3a).  
 Decide how to handle data changes (section 3b).  
 Define management processes for handling changes to your data and versioning of your resources (section 3c).  
 Decide on vocabularies and schema(s) to represent your data (section 4b).  
 Ensure there are no existing Persistent Identifiers that you could reuse, before creating new ones (section 4c).  
 Decide on what subset (or perhaps all) of your data you want to make available. Keep in mind this subset could be relocated at some point in the future (Section 4d).  
 Decide if you would like to follow Linked Data practices (section 4f).  
 Decide on the web services that will be required for your Persistent Identifiers. At a minimum this should include basic HTTP resolution of the identifiers, or use 3rd party identifier hosting services if this is preferred (section 4g).
  
Doi id has only 3 records.  
- Data and Metadata
Another source of confusion when assigning Persistent Identifiers arises because the terms “data” and “metadata” can often be used interchangeably (and sometimes the difference is not clear).  
Generally “data” have been described as the information about the resource in question, and “metadata” are “data about data”. Sometimes the boundaries of these two are blurred and some people even believe that all information in the biodiversity informatics domain is metadata because we are discussing physical resources and events. Data are also believed to be more enduring, whereas metadata may often change.  
Overall it does not matter too much whether data or metadata are the subject of a specific Persistent Identifier so long as the identifier always refers to the same resource.
    
- Get some ideas from
             
Here is the prototype 1 from Vitalise  

```
{
   "raiNode":{
      "raiNodeId": "f4f2fb3b-9c5b-42dd-a83a-d97e72920802",
      "rootPublicUrl":" https://vitalise-node2.med.auth.gr"
  },
  "experimentId": "string", =\> We get it from request coming from the discovery portal
  "dataSet": {
    "hash": "string", =\> Right now fixed to ‘heart_rate’, in the future “hash_query_real”
    "id": "string", =\> The id for us is currently the hash_query_real, so we don't need it
    "sourceId": ["uuid (string)"], =\> Right now empty, but according to the user requirements, it is interesting to fill this with the results of the filter / query for SD / AD, to know which datasets (e.g. study A, study B) .
    "metadata": "string"
  },
  "processingScript": {
    "processingScriptDescription": "string", =\> At the moment no description is requested to the External Researcher of the experiment, to be included in the future.
    "hash": "string", 
    “encryptedCode”:”string”,\<NEW according to T3.5 desc\> =\>Think about need for the discovery portal to give the decryption code if the External Researcher (owner of the code) gives the OK
    "id": "string",
    "sourceId": "string",
    "metadata": "string",
  },
  "author": {
    "hash": "string", =\> I don't think it is necessary
    "authorName": "string", =\> It might be interesting, although it might be enough to go and have the Discovery Portal show you whatever corresponds to the author id, once a RAI id has been resolved.
    "id": "string", =\> Return a uuid now, in the future we should take it out of authentication & authorisation.
    "sourceId": "string",
    "metadata": "string"
  },
  "processingResult": {
    "processingResultDescription": "string", =\>  "Description of results",
    "results": "string", =\>  Contents of the results file in minio
    "hash": "string", =\> Compute SHA256
    "id": "string",
    "sourceId": "string",
    "metadata": "string"
  },
  "metadata": {},
  "processingScriptStorage": true, =\> enable storage of processingScript inside RCS
  "processingResultStorage": true =\> (Default value: true) is valued false to prevent results to be stored inside RCS, otherwise result are by default stored inside RCS.
}
```
 
[https://jsoneditoronline.org/#left=cloud.107979bdbe43433fa1e2f2d707dff337&right=local.tojamu](https://jsoneditoronline.org/#left=cloud.107979bdbe43433fa1e2f2d707dff337&right=local.tojamu)  

```
{
  "session": {
    "id": "f4f2fb3b-9c5b-42dd-a83a-d97e72920000",
    "createDate": "\<2024-01-01T10:00:00\> //ISO8601 UTC date-time, use this format because data bases are agnostic of time zones",
    "metadata": {}
  },
  "experimentId": "\<string\>, //We get it from request coming from the discovery portal",
  "authors": [
    {
      "orcid": "\<Open Researcher and Contributor ID\>",
      "authorName": "\<string\>, //It might be interesting, although it might be enough to go and have the Discovery Portal show you whatever corresponds to the author id, once a RAI id has been resolved.",
      "rorId": "\<The affiliation, institution or organization with which the author is associated\>",
      "id": "\<string\>, //Return a uuid now, in the future we should take it out of authentication & authorization.",
      "sourceId": "\<string\>,// What does this mean?",
      "metadata": {}
    }
  ],
  "dataSet": {
    "id": "\<string\>, //The id for us is currently the hash_query_real, so we don't need it This can be another PID created from raise, or just a unique id, it is under discussion",
    "hash": "\<string\>, //Right now fixed to ‘heart_rate’, in the future “hash_query_real",
    "sourceId": "\<uuid (string)\>, //Right now empty, but according to the user requirements, it is interesting to fill this with the results of the filter / query for SD / AD, to know which  datasets (e.g. study A, study B)",
    "metadata": {
      "authors": [
        {
          "orcid": "Open Researcher and Contributor ID",
          "authorName": "string, //It might be interesting, although it might be enough to go and have the Discovery Portal show you whatever corresponds to the author id, once a RAI id has been resolved.",
          "rorId": "The affiliation, institution or organization with which the author is associated"
        }
      ],
      "usesCount": "Number of times used",
      "isPublic": "boolean",
      "dataSetBaseId": "Dataset inherited from PID",
      "raiNodeId": "\<string\>",
      "raiNodeAddress": "\<Physical storage address/node\>"
    }
  },
  "processingScript": {
    "id": "Script identification (SWHID created from us)",
    "description": "\<string\>, //At the moment no description is requested to the External Researcher of  the experiment, to be included in the future.",
    "hash": "string",
    "encryptedCode": "\<string\>, //\<NEW according to T3.5 desc\> =\>Think about need for the discovery portal to give the  decryption code if the External Researcher (owner of the code)  gives the OK",
    "sourceId": "\<string\>",
    "metadata": {
      "scriptLanguage": "\<string\>",
      "isPublic": "\<boolean\>",
      "raiNodeId": "\<string\>",
      "raiNodeAddress": "\<Physical storage address/node\>",
      "processingScriptStorage": "\<true\>, // enable storage of processingScript inside RCS"
    }
  },
  "processingResult": {
    "processingResultDescription": "\<string\>, //Description of results",
    "results": "\<string\>, //Contents of the results file in minio",
    "hash": "\<string\>, //Compute SHA256",
    "id": "string",
    "sourceId": "string",
    "metadata": {
      "processingResultStorage": "\<true\>, // (Default value: true) is valued false to prevent results to be stored inside RCS otherwise result are by default stored inside RCS.",
      "raiNodeId": "\<string\>",
      "raiNodeAddress": "\<Physical storage address/node\>"
    }
  },
  "raiNode": {
    "raiNodeId": "f4f2fb3b-9c5b-42dd-a83a-d97e72920802",
    "rootPublicUrl": " https://vitalise-node2.med.auth.gr"
  }
}
```
   

- RAISE PID finder service
    - What kind and type of information to display to user
    - Search possibility isnide data
    - Links and information display from Pid records             

- RAISE PID metadata schema/structure
    - Resolved Content, Schema Respresentation
        
        - XSD/XML
            - DOI schema
            
            [https://www.doi.org/resources/DOICoreSpecificationv1.pdf](https://www.doi.org/resources/DOICoreSpecificationv1.pdf)  
            [https://www.doi.org/doi_schemas/DOIMetadataKernel.xsd](https://www.doi.org/doi_schemas/DOIMetadataKernel.xsd)  
            [https://www.doi.org/doi_schemas/DOIAVS.xsd](https://www.doi.org/doi_schemas/DOIAVS.xsd)
            
            - Orcid schema
            - [https://metadata.raid.org/en/latest/index.html#](https://metadata.raid.org/en/latest/index.html#)
        
        - RDF is a different type of PID content data representation instead of xml/xsd
            - [https://www.linkeddatatools.com/](https://www.linkeddatatools.com/)
            - [https://www.dublincore.org/specifications/dublin-core/](https://www.dublincore.org/specifications/dublin-core/)
              
            
    - Resolved Content information of RAISE PID records
        - Author/Authors
            - Another PID with records the authors info
                - Author information (See RAID)
                    - Name: The full name of the author.
                    - ORCID (Open Researcher and Contributor ID)
                    - Affiliation: The institution or organization with which the author is associated. (ROR id?)
        - DataSet used for expirement
            - Dataset identification (ID)
            - Authors array of dataset
                - Name: The full name of the author.
                - ORCID (Open Researcher and Contributor ID)
                - Affiliation: The institution or organization with which the author is associated.
            - Physical storage address/node
            - Number of times used
            - Dataset inherited PID
            - Private/Public indication
            - Hash key of dataset
        - Software script
            - Script identification (SWHID)
            
            [https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html](https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html)
            
              
            
            Here is the link to the SWHID specifications:  [https://swhid.org/specification/v1.1/](https://swhid.org/specification/v1.1/)  
            and the swhid WG:  [https://www.swhid.org/](https://www.swhid.org/)
            
              
            
            A tutorial on how to archive and reference software in Software Heritage:  [https://www.softwareheritage.org/howto-archive-and-reference-your-code/](https://www.softwareheritage.org/howto-archive-and-reference-your-code/)  
            Also the Scholarly infrastructures for research software : report from the EOSC Executive Board Working Group (WG) Architecture Task Force (TF) SIRS, Publications Office, 2020,  [https://data.europa.eu/doi/10.2777/28598](https://data.europa.eu/doi/10.2777/28598)
            
              
            
            _Despite we need to further read documentation, I foresee possible issues, when somebody reads a SWHID on our PIDs metadata and tries to resolve it against_  _https://archive.softwareheritage.org/\<identifier\>__.  I guess we will need to figure out a way to say that's not resolvable / only resolvable in the RAISE ecosystem in our PID's metadata and PID related information in our portal._
            
              
            - Physical storage address/node
            - Script language
            - Private/Public indication
        - Results document or structure
            - Hash key of result
            - Registration timestamp/ publication date
            - Related previous result document pid (previous session result of the same experiment)
            - Citation count
          
        
    - Implement inheritance through a base PID and other PIDs deriving from base
      

## **Things to consider:**
      

In that line we should create pids like: **21.T15999/raise.1** which could be resolved @ [https://raise-eu.org/record/1](https://raise-eu.org/record/1)  
Record 1 should be the main record in our database with foreign keys to other tables containing kernel and metada info of the pid.

![Exported image](Exported%20image%2020260211204235-1.png)

- [ ] Example of provisiong resolvable pid
 
- [https://www.go-fair.org/fair-principles/fairification-process/](https://www.go-fair.org/fair-principles/fairification-process/)
- [https://faircookbook.elixir-europe.org/content/recipes/findability/identifiers.html](https://faircookbook.elixir-europe.org/content/recipes/findability/identifiers.html)
- Best Practices for PID Managers: [https://docs.google.com/presentation/d/17L_deP11Mlvnwoj3ICXZEUi_YoI-4McvLYTMt0cWr3s/edit#slide=id.g29da710bbe1_0_0](https://docs.google.com/presentation/d/17L_deP11Mlvnwoj3ICXZEUi_YoI-4McvLYTMt0cWr3s/edit#slide=id.g29da710bbe1_0_0)  
- [ ] EOSC policy, FAIR, process to fairification
    
|                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                  |                                                                                                                                                    |                                            |                                                                                                                                                                                                                        |
| ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _DIGITAL OBJECT IDENTIFIER RESOLUTION PROTOCOL SPECIFICATION (DOI)_ | _A Beginner’s Guide to Persistent Identifiers_                                                                                                                                                                                                                                                                                                                                                                                                   | _Identifiers for the 21st century: How to design, provision, and reuse persistent identifiers to maximize utility and impact of life science data_ | _Persistent Identification of Instruments_ | _RDA Recommendation on PID Kernel Information_final_                                                                                                                                                                   |
| ![[DO-IRPV3.0--2022-06-30.pdf]]                                     | ![[persistent_identifiers_guide_en_v1.pdf]]                                                                                                                                                                                                                                                                                                                                                                                                      | ![[117812.full.pdf]]                                                                                                                               | ![[1135-1-7520-2-10-20200506.pdf]]         | [https://www.rd-alliance.org/system/files/RDA%20Recommendation%20on%20PID%20Kernel%20Information_final.pdf](https://www.rd-alliance.org/system/files/RDA%20Recommendation%20on%20PID%20Kernel%20Information_final.pdf) |
| [DONA DO-IRP notes](DONA%20DO-IRP%20notes.md)                       | - they should be invisible to most users.<br>- identifier itself should not contain any readily identifiable information<br>- it is best to refer back to the existing identifier within the<br><br>information associated with the new identifier<br><br>- Decide on an approach to assigning your identifiers early on and stick to this decision, whether that decision is to apply identifiers to physical resources or conceptual resources |                                                                                                                                                    |                                            |                                                                                                                                                                                                                        |
|                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                  |                                                                                                                                                    |                                            |                                                                                                                                                                                                                        |
   

[https://chatgpt.com/share/67c48938-0f18-8010-9d41-c54234893ddd](https://chatgpt.com/share/67c48938-0f18-8010-9d41-c54234893ddd)
       ![Exported image](Exported%20image%2020260211204233-0.png)  

**RESOLVE: 21.T11998/0000-001A-3905-F**
 
[https://www.cordra.org/index.html](https://www.cordra.org/index.html)  
[https://www.pidconsortium.net/pid_demo/](https://www.pidconsortium.net/pid_demo/)  
[https://www.handle.net/proxy_servlet.html](https://www.handle.net/proxy_servlet.html)  
[https://dtr-pit.pidconsortium.net/](https://dtr-pit.pidconsortium.net/)  
[https://project-thor.readme.io/docs/getting-started](https://project-thor.readme.io/docs/getting-started)  
[https://docs.pidinst.org/en/latest/white-paper/overview.html](https://docs.pidinst.org/en/latest/white-paper/overview.html)  
[https://faircore4eosc.eu/eosc-core-components/eosc-data-type-registry-dtr](https://faircore4eosc.eu/eosc-core-components/eosc-data-type-registry-dtr)  
[https://pidmr.devel.argo.grnet.gr/](https://pidmr.devel.argo.grnet.gr/)

![[RAI PID NOTES - Ink.svg]]

---
categories:
  - "[[Work]]"
created: 2026-02-14
product:
component:
tags: []
---
![[Drawing 2026-03-05 21.10.01.excalidraw|900]]
- A panel management organization is the user (the account) of e-Consent service. This means that jwt is created for organization owner? or the actual organization? We need to create (hardcoded) Admin account for each organization-owner. 
![[e-Consent-Panel bridge-1772737943728.png|351]]	The accountId  column can be the uuid of the organization in panel management and role should be Admin=2
-  Have an action button `Request consent` 
	and this should open a dialog box to choose consent template and send triggers to consent. With in this process a project:
	○ if not exist will be created in e-consent service along with studies, users, subjects.
	○ if it exists an update will take place of subjects
-  When adding a new or updating a manager, if project has consents enabled, we update project and add or update user in e-consent (depends if user has e-consent id)
- When adding a new member in a project, if project has consents enabled we add or update the member to consent subjects (depends if member has e-consent id)

The flow to add organization as a service in eConsent:
	1. Add organization as a user in eConsent
	2. Create a hard coded token (https://jwt.io/) : 
	{
	  "sub": "service",
	  "id": "<the id from step 1",
	  "iat": <issued epoch time>,
	  "exp": <expiration epoch time>,
	  "role": "Admin",
	  "accountId": "<organizationId> from panel management"
	}
	3. Add the token from step 2 in organization in panel management db
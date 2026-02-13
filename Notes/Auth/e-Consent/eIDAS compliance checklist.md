---
created: 2026-02-11
---

To become **eIDAS compliant**, you need to ensure that your service meets the requirements for electronic identification, authentication, and trust services as outlined by the eIDAS Regulation. Here are the key steps you should take:

1. **Electronic Identification (eID)**: Implement a system for electronic identification that complies with eIDAS standards. This means your users should be able to authenticate themselves using a recognized eID method.
2. **Qualified Trust Services**: Ensure that your service uses qualified trust services, such as qualified electronic signatures, qualified electronic seals, qualified electronic time stamps, and qualified website authentication certificates. These services must be provided by a qualified trust service provider (QTSP) recognized by an EU member state2.
3. **Data Integrity and Security**: Implement measures to ensure the integrity and security of the data exchanged through your service. This includes using secure communication channels, encryption, and ensuring that the hashed PDFs are stored securely.
4. **Legal Framework**: Make sure your service complies with the legal framework established by eIDAS, including mutual recognition of eIDs and trust services across EU member states.
5. **User Consent and Transparency**: Clearly inform users about how their data will be used and obtain their explicit consent. Ensure transparency in your data processing activities.
6. **Audit and Compliance**: Regularly audit your service to ensure ongoing compliance with eIDAS requirements. This may involve working with a supervisory body or an external auditor.

By following these steps, you can ensure that your service is eIDAS compliant and provides a secure and legally recognized environment for electronic transactions.  
Does this help clarify what you need to do?  
How can I use docusign or harica for the 1  
To use **DocuSign** or **HARICA** for eIDAS compliance, you can follow these steps:  
**Using DocuSign:**

1. **Sign Up**: Create an account with DocuSign and choose a plan that suits your needs.
2. **eIDAS Compliance**: Ensure that you use DocuSign's eSignature solutions that comply with eIDAS standards. DocuSign provides advanced and qualified electronic signatures that meet eIDAS requirements1.
3. **Implement eIDAS Features**: Use DocuSign's features to implement electronic signatures, timestamps, and seals that are legally recognized across the EU.
4. **Integration**: Integrate DocuSign with your service to allow users to sign documents electronically. This can be done through APIs or by embedding DocuSign's signing capabilities into your web application1.
5. **Security**: Ensure that all communications and stored documents are secure, using encryption and other security measures.

**Using HARICA:**

1. **Sign Up**: Create an account with HARICA and choose the appropriate eSignature or eSeal services.
2. **Qualified Trust Services**: Use HARICA's qualified electronic signatures (QES) and electronic seals (eSeal) that comply with eIDAS regulations.
3. **Implementation**: Implement HARICA's services to allow users to sign and seal documents electronically. This can be done through their platform or by integrating their services into your application.
4. **Security**: Ensure that all communications and stored documents are secure, using encryption and other security measures.
5. **Compliance**: Regularly audit your service to ensure ongoing compliance with eIDAS requirements.

Both DocuSign and HARICA offer robust solutions for eIDAS compliance, so the choice depends on your specific needs and preferences. Do you have any other questions or need further assistance with implementation?  
If I have clients with digital signature from a usb device what flow should I have in my web app to allow digital signing in a pdf document  
To allow digital signing in a PDF document using a USB device in your web app, you can follow this flow:

1. **User Authentication**: Ensure the user is authenticated and authorized to sign documents.
2. **Upload PDF**: Allow the user to upload the PDF document they want to sign.
3. **Connect USB Device**: Prompt the user to connect their USB device (e.g., smart card or USB token) to their computer.
4. **Verify Device**: Verify that the USB device is connected and recognized by the browser.
5. **Digital Signature**: Use a web service or API (e.g., [Signer.Digital](https://Signer.Digital) Web Server with REST API) to handle the digital signature process. The API will interact with the USB device to capture the user's digital signature2.
6. **Sign PDF**: The web service will sign the PDF document using the digital signature from the USB device.
7. **Download Signed PDF**: Provide the user with the signed PDF document, either by downloading it directly or displaying it within the web app.
 
User Authentication -\> Upload PDF -\> Connect USB Device -\> Verify Device -\> Digital Signature -\> Sign PDF -\> Download Signed PDF
 
Here's an elaborated flow for integrating HARICA's services to allow digital signing in a PDF document using a USB device:

1. **User Authentication**: Ensure the user is authenticated and authorized to sign documents.
2. **Upload PDF**: Allow the user to upload the PDF document they want to sign.
3. **Connect USB Device**: Prompt the user to connect their USB device (e.g., smart card or USB token) to their computer.
4. **Verify Device**: Verify that the USB device is connected and recognized by the browser.
5. **HARICA Integration**: Use HARICA's API to handle the digital signature process. The API will interact with the USB device to capture the user's digital signature.
6. **Sign PDF**: HARICA's service will sign the PDF document using the digital signature from the USB device.
7. **Download Signed PDF**: Provide the user with the signed PDF document, either by downloading it directly or displaying it within the web app.

**Detailed Steps:**

1. **User Authentication**: Implement a secure login system to verify the identity of the user.
2. **Upload PDF**: Provide an interface for users to upload the PDF document they wish to sign.
3. **Connect USB Device**: Display instructions for users to connect their USB device (e.g., smart card or USB token) to their computer.
4. **Verify Device**: Use HARICA's API to check if the USB device is connected and recognized by the browser.
5. **HARICA Integration**: Integrate HARICA's API to handle the digital signature process. This API will interact with the USB device to capture the user's digital signature.
6. **Sign PDF**: Use HARICA's service to sign the PDF document using the digital signature from the USB device. Ensure that the document is signed in compliance with eIDAS regulations.
7. **Download Signed PDF**: Provide the user with the signed PDF document. This can be done by allowing the user to download the signed document directly or by displaying it within the web app.

By following these steps, you can ensure a secure and seamless digital signing process for your users using HARICA's services. Does this help with your implementation?

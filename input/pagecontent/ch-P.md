
|------------------------------------------------|
| Editor replace existing Volume 1 Appendix P with the following |
{:.grid .bg-info}

TODO: add section on Security-Labeling-Service possibile implementations.

This Appendix provides information about when consent could be automated and consequently when the BPPC Profile could be used. Privacy consent can be summarized as: "I agree on my personal data being disclosed to someone under specific conditions".

Conditions are based on various factor(s) for example:

- type of person the data is disclosed to;
- type of data disclosed;
- type of access (normal access, emergency access...);
- security level in which the disclosure takes place (weak authentication vs. strong authentication);
- type of purpose for which the data is disclosed;
- timeframe (period of validity of the consent, window of disclosure...);
BPPC could be used when conditions can be described with a limited number of factors and when the factors can be defined and be easily interpreted by a Document Consumer implementing the Basic Patient Privacy Enforcement Option.

The XDS Affinity Domain Privacy Consent Policies could result in various actions, for example:

- limitation of the display of the existence of specific documents to the users of a Document Consumer
- limitation of the access to specific documents by the users of a Document Consumer
- display of a warning note (either concerning this access or to inform that further disclosure is not allowed, limited to some defined population, needed further consent...)
- collection of new consent (oral consent, patient authentication, electronically signed consent, paper consent...)

## P.1 Consents in a sensitivity labeled and role based access control environment

One possible implementation may have a collection of policies and sensitivity markers that would form an access control matrix. An example simple access control matrix is shown in the table below.

**Table P-1: Sample Access Control Policies**

| Sensitivity Functional Role | Billing Information | Administrative Information | Dietary Restrictions | General Clinical Information | Sensitive Clinical Information | Research Information | Mediated by Direct Care Provider |
|---------------------------------| - | - | - | - | - | - | - |
| Administrative Staff            | X | X
| Dietary Staff                   |   | X | X |
| General Care Provider           |   | X | X | X |
| Direct Care Provider            |   | X | X | X | X |   | X |
| Emergency Care Provider         |   | X | X | X | X |   | X |
| Researcher                      |   |   |   |   |   | X |
| Patient or Legal Representative | X | X | X | X | X |   |   |
{:.grid}

Each instance of the matrix results in a single Patient Privacy Policy. This vocabulary must then be configured in the XDS Affinity Domain. Thus configuring each application in the XDS Affinity Domain to recognize for each Patient Privacy Policy identified, and which sensitivity (confidentialityCode); what types of accesses are allowed. Using the example above, the Patient Privacy Policy might look like.

**Table P-2: Patient Privacy Policies When Expressed by Document Sensitivity**

| Privacy Consent Policy | Description |
|------------------------| -- |
| Billing Information    | May be accessed by administrative staff and the patient or their legal representative.
| Administrative Information | May be accessed by administrative or dietary staff or general, direct or emergency care providers, the patient or their legal representative.
| Dietary Restrictions | May be accessed by dietary staff, general, direct or emergency care providers, the patient or their legal representative.
| General Clinical Information | May be accessed by general, direct or emergency care providers, the patient or their legal representative.
| Sensitive Information | May be accessed by direct or emergency care providers, the patient or their legal representative.
| Research Information | May be accessed by researchers.
| Mediated by Direct Care Provider | May be accessed by direct or emergency care providers.
{:.grid}

Other divisions of the access control matrix are possible, so long as a Patient Privacy Policy covers each layout of the matrix.

The following list of references is provided as good references to understand the terms and concepts presented here. These references are not required by this profile.

- ISO/TS 21298 "Health informatics – Functional and structural roles".
- ISO/TS 22600 "Health Informatics – Privilege Management and Access Controls".
- CEN prEN 13606-4 "Health informatics — Electronic health record communication — Part 4: Security requirements and distribution rules"

## P.2 Possible checklist for implementations

### General (before anything else)

- Granularity of confidentiality implementation:
  - Granularity of document: all documents, document type, each document.
  - Granularity of user: all users, user type, each type.
- Depth of confidentiality implementation:
  - Is the existence (metadata) about a document that can't be read by the user shown in a list of available documents for this patient?
  - Is the user informed there are / might be not shown documents and how much?
  - Is there the possibility to manage different depth of confidentiality depending on users or document type?
- How to identify users, documents and policy?
- Does confidentiality management spread through further use (once the document is downloaded by a user)

### While implementing

- Definition of default codes depending on site / hardware, document type, author, patient...
- Implementing options:
  - possibility of a list to choose from and how the list is constituted (out of all the possible value, out of the value acknowledged by patient...)
  - possibility to change default codes prior to publication
  - possibility to use different format depending on the confidentiality policy (only non-downloadable image, pdf, word...)
- Later modification of policy (possible directly when requesting a document or have to be validated before)

### Prior to publication

- What elements should be checked before publication:
  - existence of a policy
  - existence of the policy used
  - existence of a consent for that policy
  - What additional information should be given (general consent policy, patient's specific consent policy...?)

### Prior to allowing access to a document

- What elements should be checked before publication:
  - accessing user role
  - existence of the policy used vs. accessing user
- Specific accesses and impact on confidentiality policy:
  - emergency (specific policy, short cut of confidentiality policy...)
  - break glass
- What additional information should be given (general consent policy, patient' specific consent policy...)

## P.3 Potential obligations

Possible things that the BPPC policies might include are not fully known at this time. The following is a list that has been discovered through use by researchers, health information exchanges, and vendors. The following are some thoughts of things that might be orchestrated by BPPC Policies.

### General

- Is the existence (metadata) about a document that can't be read by the user shown in a list of available documents for this patient
- Map local role codes into some Affinity Domain defined role codes

### Prior to implementation

- the specific Document Source is configured with one site specific “normal” code to publish all of that Document Source documents against. For example, an automatic blood-pressure device being used by one specific patient.
- prompt user for the code to apply to the document (drop-down-list)
- document-type based codes

### Prior to publication

- validate that the code to be published against has been acknowledged
- support for a XDS Affinity Domain Patient Privacy Policy that forbids the publication and/or use of documents in the XDS Affinity Domain (aka Opt-Out).

### Prior to allowing access to a document

- should documents with unrecognized codes be shown?
- prompt the user with some site defined text "do you really want to do this?"
- allow the user to review the base consent policy
- allow the user to review the patient's specific Patient Privacy Policy Acknowledgement Documents
- allow the user to override a consent block (break-glass)
- require that a new consent be acquired from the patient before using the documents in the XDS Affinity Domain
- support for a XDS Affinity Domain Patient Privacy Policy that forbids the publication and/or use of documents in the XDS Affinity Domain (aka Opt-Out).
- validate that the code on the document has been acknowledged
- confidentialityCode that would indicate that the Document can only be viewed, it cannot be incorporated or copied.
- use of this document shall result in an ATNA emergency access audit event

## P.4 Dynamic Use Models

It has also been suggested that documents should simply be published with the expected codes, and that only on use of a document that ALL current Patient Privacy Policy Acknowledgements are evaluated against with the code on the document. In this way revocation is more dynamic.

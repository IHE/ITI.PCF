
|------------------------------------------------|
| Editor replace existing Volume 1 Appendix P with the following |
{:.grid .bg-info}

TODO: include defined terms.
TODO: remove XDS specifics, Affinity Domain (privacy domain)

This Appendix provides information about when consent could be automated and consequently when the BPPC, APPC, or PCF Profiles could be used. Privacy consent can be summarized as: "I agree on my personal data being disclosed to someone under specific conditions".

Conditions are based on various factor(s) for example:

- role of person the data is disclosed to;
- type of data disclosed;
- security level in which the disclosure takes place (weak authentication vs. strong authentication);
- type of purpose for which the data is disclosed;
- timeframe (period of validity of the consent, window of disclosure...);

Some Consent needs require a more basic record, where as other intermediate or advanced needs require a more structured and coded consent record. The more advanced need must support both the recording of the patient specific parameters, and the ability to distinguish the accesses that would be impacted by those specific parameters. 

A domain's Privacy Consent Policies could result in various actions, for example:

- limitation of the fact that specific documents exist at all
- limitation of the access to specific documents by specific users
- display of a warning note (either concerning this access or to inform that further disclosure is not allowed, limited to some defined population, needed further consent...)
- collection of new consent (oral consent, patient authentication, electronically signed consent, paper consent...)

## P.1 Consents in a sensitivity labeled and role based access control environment

TODO: make this more clear that this is defining a way of describing a overriding policy that might be accepted or rejected by the patient. This does not represent parameters that would be selected by the patient.

One possible implementation may have a collection of policies and sensitivity markers that would form an access control matrix. An example simple access control matrix is shown in the table below, where an `X` indicates that the given role would have access to the given sensitivity of data.

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

Within a deployment domain, they will define a similar matrix, and that matrix results in a single Patient Privacy Policy. This vocabulary must then be configured in the Access Control and Enforcement Points.  Using the example above, the Patient Privacy Policy might look like.

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

The following list of references is provided as good references to understand the terms and concepts presented here. These references are not required by IHE.

- ISO/TS 21298 "Health informatics – Functional and structural roles".
- ISO/TS 22600 "Health Informatics – Privilege Management and Access Controls".
- CEN prEN 13606-4 "Health informatics — Electronic health record communication — Part 4: Security requirements and distribution rules"

## P.2 Possible checklist for implementations

The following is some steps that a domain implementing privacy should consider.

### General (before anything else)

- Granularity of classification of data:
  - Granularity of document: all documents, document type, each document.
  - Granularity of user: all users, user type, each type.
- Depth of classification implementation:
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

The full scope of privacy policies is potentially infinite. The following is a list that has been discovered through use by researchers, health information exchanges, and vendors. The following are some thoughts of things that might be orchestrated by BPPC Policies.

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

## P.4 Security Labeling Service Models

Data may be "Normal" medical data or "Restricted" medical data. The distinction is for this IG focused purely on data classification for sensitive topics. 

The various clinical Resources in FHIR are very complex and highly varable. Although Observation is the most often used Resource, sensitve data may exist in ANY other FHIR resoruce including Allergies, Procedures, CarePlan, Medication, Problems, DiagnosticReport, DocumentReference, ImagingStudy, Genomics, etc... By assessing the sensitity classification and placing that assessment into a well-known location found in all FHIR Resources - `.meta.security`, the Access Control does not need to be aware of the kind of FHIR Resource, it can just process the data as a DomainResource and simply look at the `.meta.security` element.

The classification of data into sensitive topcs is the role of the Security Labeling Service (SLS). The SLS inspects the data, and may use the context of the data to identify the sensitivity classification. It is expected that most data will not be considered sensitive, aka "Normal".

### Data tagging Considerations

Some data are directl and clearly in a sensitive category. But there can be indirect relationships, such as three medications prescribed together are a clear indication of a sensitive category but are  not individually.  

Some data may also not be sensitive in the coding, but rather sensitive in the narrative, this would be poor data quality but it is a reality that should be considered. Thus an SLS may need to include some Natural Language Processing to find sensitive human words in narrative.

Some approaches use well-defined ValueSets, where others use a list of words. The list of words can be search accross the data without regard for the data structure, which has the benefit of not needing to have the SLS data schema aware. The list of words can be codes, such as snomed numeric codes.

### Architecture approaches to data tagging

When the SLS is executed is a systems design decision. General alternatives are:

#### Pre Tagging data
Tagging the data as it is created, updated, or imported. 


<div>
{%include sls-batch.svg%}
</div>
<br clear="all">

Which has the advantage that the access to the data does not need to assess the data, it just uses the existing sensitvity tag. 


<div>
{%include sls-pre.svg%}
</div>
<br clear="all">

This solution is likely to be more performant on use of data, but may not have as accurate sensitivity tags due to the dynamic nature of policies around sensitivty, and dynamic nature of data relationships. This solution also requires that the EHR database support data tags.

#### Use time tagging data

Alternative is that the data are temporarly tagged prior to use, thus the sensitivity is freshly determined and used only for that access enforcement


<div>
{%include sls-query.svg%}
</div>
<br clear="all">

This solution does not require that the EHR database be updated to support tagging of data, but may incure a peformance impact on data use.

### Example ValueSets

One way to understand a very basic SLS is that it looks for clinical codes in the data. It might do this using ValueSets, but likely would need to do this in a more performing way. 

- [Set of codes that indicate ETH (alcohol and drug)](ValueSet-SlsSensitiveETH.html)
  - [Set of codes that indicate ETHUD (alcohol)](ValueSet-SlsSensitiveETHUD.html)
  - [Set of codes that indicate OPIOIDUD (drugs)](ValueSet-SlsSensitiveOPIOIDUD.html)
- [Set of codes that indicate PSY](ValueSet-SlsSensitivePSY.html)
- [Set of codes that indicate SEX](ValueSet-SlsSensitiveSEX.html)
- [Set of codes that indicate HIV](ValueSet-SlsSensitiveHIV.html)


### Example Data with tags

- [Observation of Alcohol Use](Observation-ex-ObservationAlcoholUse.html) marked with `ETHUD`
- [Observation of a Blood Sugar](Observation-ex-bloodSugarB-0.html) not marked sensitive


|------------------------------------------------|
| Editor replace existing Volume 1 Appendix P with the following<br/>This Appendix exists in the Final Text Technical Framework but only covers BPPC. This version expands on the scope, and updates the details. |
{:.grid .bg-info}

Privacy policies are an important part of an organization's overall risk management strategy. They help to protect the organization from potential legal liability, as well as from reputational damage. Privacy policies should be aligned with other policies within the organization, such as data security policies, employee training policies, and incident response plans.

Privacy policies should be reviewed and updated regularly to ensure that they reflect the latest legal and regulatory requirements. They should also be communicated to employees and customers in a clear and concise way.

Here are some of the other policies within an organization that privacy policies relate to:

- Data security policies: Data security policies outline the steps that an organization will take to protect its data from unauthorized access, use, disclosure, disruption, modification, or destruction. Privacy policies should be aligned with data security policies to ensure that the organization is taking all necessary steps to protect the privacy of its customers' data.
- Employee training policies: Employee training policies outline the training that employees will receive on topics such as data privacy, security, and compliance. Privacy policies should be included in employee training programs to ensure that employees are aware of the organization's privacy practices and how to comply with them.
- Incident response plans: Incident response plans outline the steps that an organization will take in the event of a data breach or other security incident. Privacy policies should be included in incident response plans to ensure that the organization is prepared to respond to a privacy incident in a timely and effective manner.

This Appendix provides information about Privacy Policies and when consent could be automated and consequently when the BPPC, APPC, or PCF Profiles could be used. 

Concepts (This set of concepts is a non-exhaustive subset of terms relevant to Privacy Consent, and the definitions given here have been simplified for that scope. ):

- **Trust Domain** - Systems and entities that are trusted due to membership in a domain, where this membership includes agreement with the policies of the trust domain. A Trust Domain often spans multiple domains, such as a Health Information Exchange or a Federation of Health Information Domains. An example is the [XDS Affinity Domain](https://profiles.ihe.net/ITI/TF/Volume1/ch-10.html), or the [XCA Community](https://profiles.ihe.net/ITI/TF/Volume1/ch-18.html).
- **Patient Privacy Policy Domain** - The domain (Trust Domain) for which a Patient Privacy Policy applies. The Patient Privacy Policy Domain may cover an Organization, Health Information Exchange, or a defined set of Communities. The Patient Privacy Policy Domain is a Trust Domain.
- **Domain Privacy Policy** / **Overarching Policy** - Defines acceptable use of private data within the domain. The overarching policy are defined and enforced in the broader context of a law, regulation, or organizational policy that defines the scope, authority, and limitations. Within the Domain Privacy Policy will be a set of Patient Privacy Policies, that are used at the Privacy Consent level. The Domain Privacy Policy is responsible for defining users, roles, classifications, and the possible parameters the patient will be offered during the Privacy Consent Ceremony. The Domain Privacy Policy must address the appropriate use of data when no Consent has been captured, how conflicting policies are to be resolved, and when a restriction may cause a patient or operator safety concern (e.g. Break-Glass).
- **Patient Privacy Policy** - A Patient Privacy Policy explains appropriate use of data/documents in a way that provides choices to the patient. The Patient Privacy Policy sits within the Domain Privacy Policy. A Patient Privacy Policy will identify who has access to information, and what information is governed by the policy (e.g., under what conditions will **data** be marked as containing that type of information). The Patient Privacy Policy may be a consent policy, dissent policy, authorization policy, etc.
- **Patient Privacy Consent Resource** - (a.k.a., Privacy Consent) A record resource that follows the BPPC profile or the PCF profile and captures the act of the consent ceremony and the details. The Consent references the basis Patient Privacy Policy. The Consent may be agreement with the policy, dissent with the policy, or may contain further constraints and authorizations based on the Patient Privacy Policy.
- **Patient Privacy Policy Identifier** - A Patient Privacy Policy Domain-assigned globally unique identifier that identifies the Patient Privacy Policy.
- **Patient Identified Data** -  Are data about an identified Patient. This may be health information, but for the purposes of this Appendix it is any personally identifiable information (PII).
- **Data Holder** / **Custodian** - A controlling entity of some set of Patient Identifiable Data.
- **Patient** / **Subject of data** / **Consumer** - the patient is the human-subject of health-related data. The use of the term patient is not to imply only subjects under current treatment.
- **Privacy Consent** - (a.k.a., Consent) Binding agreement between the Patient / Subject of the data and the Data Holder as to the appropriate use of data. The consent may include constraints and obligations. The agreement may be executed by delegates, and the agreement may include other parties that are held to the terms. Consent term is used here in broad definition not limited by the definition of consent in regulation or laws.
- **Privacy Consent Ceremony** - All the steps leading up to and including the acceptance by the Patient and Custodian of the terms of a Privacy Consent. The ceremony is responsible for assuring the patient is well informed and understands the terms. The ceremony may include many people and tools.
- **Privacy Parameters** - rules that are allowed to be specified by the patient as deviations from the Patient Privacy Policy. Such as limiting access to data published in a date range, data published by a given author, or data with a specific kind of restricted health sensitivity.
- **Privacy Preferences** - Published by the Patient as desired privacy conditions. These preferences may be used during a Consent ceremony to inform the privacy conditions.
- **Data Access Requests** - defined interactions in which data are shared within a Trust Domain in keeping with the Patient Privacy Consent terms. Requests for data to leave the control of the Data Holder. Most requests will be from within a broader Trust Domain, but some requests may be to parties outside a Trust Domain.
- **Authentic Requests** - requests that can be proven to be from within the trust domain. Authentic Requests carry well-defined parameters of the request including identity of data recipient, purpose of use the data will be used, and the data characteristics scope.
- **Data Classification** -  Patient identifiable data is considered health information and is subject to a set of constraints as given to normal health information.
- **Security Labeling Service** - a service that classifies data into a defined set of sensitivity classifications. See [below](#SLS) for further discussion and deployment models.
- **Normal Health Data** - The majority of Patient Identified Data are health information and is considered more sensitive than non-health information, this data would be classified as Normal Health Data. Normal Health Data is sensitive.
- **Restricted Health Data** - Some Patient Identifiable Data are considered more sensitive and is classified as Restricted Health Data. Data may be considered Restricted by regulation or laws, or may be deemed by the patient to be more sensitive. Some examples of restricted health data are data that describes a stigmatizing sensitive health topic such as mental health, drug abuse, sexual health, or other.
- **Users** - are an identifiable agent, usually human, that has some defined role within the Organization within which they operate. A User may be the Patient herself, a patient related party, clinician, researcher, billing clerk, etc. These different functional roles will have different needs to access data. For example registration clerks may need to be able to access patient demographics, billing, and contacts; but would not need access to clinical content.

The Privacy Policy includes appropriate access rules that define conditions on various factor(s) for example:

- the kinds of data being managed;
- the kinds of use of these data that could be allowed;
- the kinds of users for which privacy policies and consent rules would apply;
- the safety risk to privacy risk management;
- the subject of the data;
- role of users or organizations for which the data may be disclosed to;
- type of data disclosed;
- security level in which the disclosure takes place (weak authentication vs. strong authentication);
- type of purpose for which the data is disclosed;
- timeframe of use (period of validity of the consent, window of disclosure...);
- etc.

Some Privacy Consent needs require a more basic record, where as other Consents require intermediate or advanced needs. The more advanced need must support both the recording of the patient specific parameters, and the ability to distinguish the accesses that would be impacted by those specific parameters.

The Privacy Consent Ceremony and the development of the Privacy Policies is not constrained or described by IHE. The Privacy Preferences is a potential way to improve the Patient Experience, by allowing the Patient to express their desired privacy conditions and parameters. These Privacy Preferences would not be enforceable as they are as statement of desire, and not agreed to by a Data Holder. The Consent ceremony could take these preferences as input, and thus present the terms that the Data Holder is willing to enforce. Thus at the end of the Consent Ceremony there would be a Patient Privacy Consent Resource that expresses the terms that the Data Holder and Patient have agreed to.

<figure>
{%include preferences-workflow.svg%}
<figcaption><b>Figure: Preferences to Enforcement possible workflow</b></figcaption>
</figure>
<br clear="all">

A domain's Privacy Consent Policies could result in various actions, for example:

- limitation on the fact that specific documents exist at all
- limitation of collection and recording of data
- limitation of the access to specific documents by specific users
- display of a warning note (either concerning this access or to inform that further disclosure is not allowed, limited to some defined population, needed further consent...)
- collection of new consent (oral consent, patient authentication, electronically signed consent, paper consent...)

## P.1 Consents in a sensitivity labeled and role based access control environment

There is always a need to have overarching policies that define for a user what kind of activities and data access is allowed. This overarching policy would define all of the access control rules that are independent from any patient choice. Within an organization these overarching policies would include activities allowed, such as not allowing a janitor to prescribe drugs. One possible implementation may have a collection of roles vs object types, that would form an access control matrix. An example of a simple access control matrix is shown in the table below, where an `X` indicates that the given role would have access to the given object type.

**Table P-1: Sample Access Control Policies**

| Object Type vs Functional Role | Billing Information | Administrative Information | Dietary Restrictions | General Clinical Information | Sensitive Clinical Information | Research Information | Mediated by Direct Care Provider |
|---------------------------------| - | - | - | - | - | - | - |
| Administrative Staff            | X | X
| Dietary Staff                   |   | X | X |
| General Care Provider           |   | X | X | X |
| Direct Care Provider            |   | X | X | X | X |   | X |
| Emergency Care Provider         |   | X | X | X | X |   | X |
| Researcher                      |   |   |   |   |   | X |
| Patient or Legal Representative | X | X | X | X | X |   |   |
| Janitor                         |
{:.grid}

Within a trust domain, they will define a similar matrix, and that matrix results in a single Domain Privacy Policy. This vocabulary must then be configured in the Access Control and Enforcement Points.  Using the example above, the Domain Privacy Policy might look like.

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
| Janitors | Shall not have access to any data.
{:.grid}

This method can be used to define the Patient Privacy Policy. Variations may also be defined covering the differences between Patient Privacy Policy available, and the effects of a Patient rejecting the Patient Privacy Policy.

Note that a Patient Privacy policy will focus on who has access to data. Other Consents, like Consent-to-Treat or Medical-Advanced-Directives (living wills), focus more on authorization for activities.

### P.1.1 Consents in a Role Based Access Control (RBAC) Environment

The above closely matches Role Based Access Control (RBAC), where users are grouped into one or more roles. These groupings might be by where the user reports to or works, called 'structural roles'; or may be indicated by what the user is currently doing, called 'functional roles'. Regardless of if a role is a structural or functional role, it may authorize activities and access to data. These roles will have rules associated with them, like the matrix above. Thus when any request is being made by a user, their roles are compared to the data access request to determine if the data should be given.

RBAC works well when object types are clearly needed or forbidden by a given role. This is often the case in many industries.

### P.1.2 Consents in an Attribute Based Access Control (ABAC) Environment

Healthcare struggles with RBAC as some data needs to have different rules due to the data values, rather than the kind of data. The most clear example of this comes with Restricted sensitivity data, but is also true within Normal sensitive data. As shown above there is some need for Dietary Staff, providing the hospital rooms with meals, to know some of the healthcare indicators such as allergies and current recovery status. Thus the Dietary Staff needs access to some Normal sensitive data, but not other Normal sensitive data. One could just write policy that tells Dietary Staff to not look at any data they should not be looking at, and possibly watch the audit logs for deviations from this policy. This might work within an organization, but will not work very well within a network Trust Domain.

Attribute Based Access Control (ABAC) is where users are given clearances, which at this level are not too much different than roles. The big difference is that these clearances provide access to data based on the attributes of the data. So for example with the Dietary Staff their clearance may give them access to a subset of observations, where that subset is a list of types of observation.

The use of ABAC in a Consent enables Consent policies to have rules based on things like:

- The timeframe within which the data was authored
- The Individual or Organization that authored the data
- The identifier of data
- The relationship this data has with an identified encounter or care-plan

The ultimate use of ABAC is when the data have been classified by the data sensitivity and confidentiality. The classification of data is a hard task, see [Security Labeling Service](#SLS) below. However if data is classified, then the classification can be used in ABAC. Many classification tags systems place the tag in a common place that is independent of the object type. For example in XDS, there is a metadata element `confidentialityCode` that can carry the sensitivity and confidentiality classification of the data regardless of the format of the data. In FHIR, there is a `meta.security` element that is at the top of all kinds of FHIR resources, that can carry this classification. In both of these cases the Access Control decision and enforcement does not need to look at the kind of the data, it simply looks at the classification.

In a Consent these attribute parameters can enable various consent provisions:

- I allow all my data to be shared with the national network for treatment purposes, except for the data recorded in 2004
- I allow all my data to be used by any treatment purpose, but any other purpose can only get normal data.
- I authorize clinical research project betty to access the data associated with my care-plan identified as 1234

### P.1.3 References

The following list of references is provided as good references to understand the terms and concepts presented here. These references are not required by IHE.

- ISO/TS 21298 "Health informatics – Functional and structural roles".
- ISO/TS 22600 "Health Informatics – Privilege Management and Access Controls".
- CEN prEN 13606-4 "Health informatics — Electronic health record communication — Part 4: Security requirements and distribution rules"

## P.2 Possible checklist for implementations

The following are some steps that a domain implementing privacy should consider.

### P.2.1 General (before anything else)

- Granularity of classification of data:
  - Granularity of document: all documents, document by type, each document.
  - Granularity smaller than document: sections within documents, each data element (FHIR Resource), sub elements.
  - Granularity of user: all users, user role, individual user.
- Depth of classification implementation:
  - Is the existence (metadata) about a protected resource that can't be read by the user?
  - Is the user informed that there are data they are not being shown?
  - What level of Consent parameters is allowed?
- How to identify users, objects, and policy?
- Obligations and Refrain policies:
  - Are there actions that should be forbidden (Refrain) or mandated (Obligation)?
    - Some examples: Do not Print, Do not Persist, Must encrypt before storing, Must get additional Consent before further disclosure, etc.
  - Can these Obligations and Refrains be incorporated into the overall Policy, or the meaning of a Consent Policy
  - Using Obligations or Refrains at the transactional level is not well implemented and often not necessary when it can be imposed at the policy level.
- Trust Domain support:
  - What capability do the members in a Trust Domain support?
- Remediation and Investigation
  - Define the policy for addressing privacy breaches

### P.2.2 While implementing Consent Management

- Definition of codes to be used. Depending on site / hardware, document type, author, patient.
- Implementing options:
  - possibility of a list to choose from and how the list is constituted (out of all the possible value, out of the value acknowledged by patient...)
  - possibility to change default codes prior to publication
  - possibility to use different format depending on the confidentiality policy (only non-downloadable image, pdf, word...)
- Later modification of policy (possible directly when requesting a document or have to be validated before)

### P.2.3 Prior to publication

- What elements should be checked before publication:
  - existence of a policy
  - existence of the policy used
  - existence of a consent for that policy
  - What additional information should be given (general consent policy, patient's specific consent policy...?)

### P.2.4 Prior to allowing access to a document

- What elements should be checked before publication:
  - accessing user role
  - existence of the policy used vs. accessing user
- Specific accesses and impact on confidentiality policy:
  - emergency (specific policy, short cut of confidentiality policy...)
  - break glass
- What additional information should be given (general consent policy, patient' specific consent policy...)

### P.2.5 Continued Management

- Review of Access Denied to be sure that they are appropriate
- Review of Break-Glass instances to be sure that they are appropriate
- Mechanism to address complaints that access was allowed at some time in the past.
  - This would need to address any changes in the Patient Consent record during that time
    - Where the record changed, is there FHIR _history support to give access to older version?
    - Where the record changed, is there AuditEvent or Provenance to indicate why it changed and when and by whom?
  
## P.3 Potential obligations and refrains

The full scope of privacy policies is potentially infinite. The following are some considerations of obligations and refrains that a Patient Privacy Policy may require of an Access Control Enforcement Point. Where Obligations are activities that must be done, and Refrains are activities that must not be done. Many of these obligations and refrains have been given codes in the HL7 Security Control ValueSets

[Obligation](https://terminology.hl7.org/ValueSet-v3-ObligationPolicy.html)  - Security label metadata that segments an IT resource by conveying the mandated workflow action that an information custodian, receiver, or user must perform. For Example: Encrypt, mask, comply with policy
[Refrain](https://terminology.hl7.org/ValueSet-v3-RefrainPolicy.html) - Security label metadata that segments an IT resource by conveying actions which an information custodian, receiver, or user is not permitted to perform unless otherwise authorized or permitted under specified circumstances. For Example: Do not disclose without consent, no reuse

Obligations may also be expressed in oAuth scopes such as those defined in [SMART-App-Launch](https://www.hl7.org/fhir/smart-app-launch)

<a name="FHIR-Explainer"> </a>

## P.4 Explainer of FHIR Consent Model

This section includes explanation of some example scenarios and points at example
Consent resources for them.
These example scenarios are provided for educational use only, they are not an
endorsement of these scenarios.

### P.4.1 Notice of Privacy Policy

Some realms only require that the patient be given access to the organizations privacy policy.
In these realms the patient is not given the choice to accept, reject, or change the terms of privacy policy.
The expectation is that the patient can stop the engagement with the healthcare provider if they don't like the privacy policy (yes, we know this is a fallacy in many situations).

These realms may use the Consent resource to indicate that the ceremony of providing access to the privacy policy has happened, when it happened, who presented the policy, and which version of the policy was presented. The specific version of privacy policy recorded can also be helpful to know when a given patient needs to be presented with the new version of the privacy policy.

- status - would indicate `active`
- category - would indicate `patient consent` specifically a `notice of privacy practices`
- subject - would indicate the **Patient** resource reference for the given patient
- dateTime - would indicate **when** the privacy policy was presented
- grantor - would indicate **who** presented the privacy policy
- grantee - would indicate the **Patient** resource if the patient was presented, a **RelatedPerson** for parent or guardian
- controller - would indicate the **Organization** who presented  the privacy policy, and which is going to enforce that privacy policy
- policyText - would indicate the **privacy policy** that was presented. Usually the **url** to the version specific policy
- provision.type - `permit` - given there is no way to deny, this would be fixed at permit.

Other elements would not be needed.

#### example

Given:

- Patient: Peter James Chalmers
- dateTime: March 11, 2022 at 12:22 pm
- grantee: is the patient
- grantor: Registration Desk Clerk - John Moehrke
- controller: Burgers MC
- policyText: policy at https://example.org/privacy-policy-v1.html

sushi:

```fs
Instance: example-notice
InstanceOf: Consent
Title: "Example of a Notice of Privacy Policy"
* status = #active
* category[+] = https://loinc.org#59284-0 "Patient Consent"
* category[+] = http://terminology.hl7.org/CodeSystem/consentcategorycodes#npp
* dateTime = 2022-03-11T12:22
* subject = Reference(Patient/example)
* grantee = Reference(Patient/example)
* grantor = Reference(Practitioner/example-clerk)
* controller = Reference(Organization/f001)
* policyText = Reference(DocumentReference/example-privacy-policy-v1)
* provision.type = #permit
```

support resources

```fs
Instance: example-privacy-policy-v1
InstanceOf: DocumentReference
Title: "Burgers Organization privacy policy"
* status = #current
* docStatus = #final
* type = https://loinc.org#57017-6 "Privacy policy Organization Document"
* category = https://loinc.org#57017-6 "Privacy policy Organization Document"
* content.attachment.contentType = application-pdf
* content.attachment.url = https://example.org/privacy-policy-v1.html

Instance: example-clerk
InstanceOf: Practitioner
Title: "Registration Desk Clerk example"
* active = true
* name.text = "John Moehrke"
```

#### Security / Privacy Considerations

Organizations that never allow a patient to be in a `deny` mode never need to look at Consent for access-control reasons as there is no difference if the Patient has been given notice or not. In these cases the Consent is there for record keeping only. See Change to opt-out below.

### P.4.2 Basic signed acknowledgement

This section covers the most basic of privacy consents, that simply records an acknowledgement to a given privacy policy permitting data sharing.
This is only slightly different than the Notice of Privacy Policy, in that with this example, there is some evidence captured from the ceremony.
Such as a patient initialing or signing a form indicating they have received the Privacy Policy.
Similar to the Notice of Privacy Policy, the Patient is not given a choice to reject or change the terms of the privacy policy.
The specific version of privacy policy recorded can also be helpful to know when a given patient needs to be presented with the new version of the privacy policy.

The Consent is the same as with Notice of Privacy Policy with the following additions:

- sourceReference - would hold a **DocumentReference** that has an image of the form that the patient signed. This image may be scanned copy of the ink on paper signature from the patient, or may be a digitally captured signature from the patient.

Other elements would not be needed.

#### example

Given: the same example attributes as above with the addition of a signed form. Thus the only addition is the sourceReference, which points at a scanned image of the signature in a DocumentReference resource.

sushi:

```fs
Instance: example-acknowledge
InstanceOf: Consent
Title: "Example of an acknowledged Notice of Privacy Policy"
* status = #active
* category[+] = https://loinc.org#59284-0 "Patient Consent"
* category[+] = http://terminology.hl7.org/CodeSystem/consentcategorycodes#npp
* dateTime = 2022-03-11T12:22
* subject = Reference(Patient/example)
* grantee = Reference(Patient/example)
* grantor = Reference(Practitioner/example-clerk)
* controller = Reference(Organization/f001)
* policyText = Reference(DocumentReference/example-privacy-policy-v1)
* provision.type = #permit
* sourceReference = Reference(DocumentReference/example-signed-acknowledgement-20220311)
```

support resources

```fs
Instance: example-signed-acknowledgement
InstanceOf: DocumentReference
Title: "Patient Peter James Chalmers signed an acknowledgement of the Privacy Policy"
* status = #current
* docStatus = #final
* type = https://loinc.org#57016-8 "Privacy policy acknowledgement Document"
* content.attachment.contentType = application-pdf
* content.attachment.data =  "SGVsbG8gV29ybGQ="
```

#### Security / Privacy Considerations

Organizations that never allow a patient to be in a `deny` mode never need to look at Consent for access-control reasons as there is no difference if the Patient has signed a consent or not. In these cases the Consent is there for record keeping only. See Change to opt-out below.

### P.4.3 Change to deny sharing

This section covers the case where a basic permit has been used, but for some reason the authorization is revoked or rejected.
An example might be where the organization does allow the patient to reject a previously permitted action, and the patient has expressed they want to deny sharing now.
Another example might be where legal action has happened compelling an organization to revoke the consent.

The example scenario here describes methods where there would be only one Consent on record for a given Patient.
Thus the current status would be simply discoverable by looking for the Consent for a given Patient and checking the `.status` element and `.provision.type`.
This logic presumes that where no Consent is found, that an implied `permit` is the default.
Thus one must look for both the existence of a Consent for the given Patient, and that the Consent.provision.type is `permit`.

Alternatives are shown:

1. One possibly is that the existing Consent instance is revised to change the `.status` to `inactive`. When this is done the `.lastUpdated` will automatically indicate the date and time this change happened.
2. If more details are needed, this change to the Consent instance could be tracked with an AuditEvent and/or a Provenance resource to indicate who made the change, what change was made, why the change was made, and other details as necessary.
3. Advanced alternative possibility is to record a new Consent with the details of the change in `Consent.status`, the existing Consent would be marked as `inactive` same as above, and the AuditEvent and/or Provenance would further indicate the new Consent replaces the old Consent. Shown below using Provenance.

Note that at some point after this, the consent may go back to `active`. This transition would follow the same process with the .status changes in the other direction.

#### example

Alternative 1 is not shown, as it is simply changing the .status.

##### Alternative 2

Given:

- existing Consent resource `example-acknowledge` is revised as Alternative 1
  - for visibility the examples assumes that the server supports versioning. This is not required of the alternative.
- Provenance states
  - who - Lawyer David Pyke
  - when - March 3rd, 2022 at 4:56pm
  - why - Legal hold

sushi:

```fs
Instance: example-change-consent
InstanceOf: Provenance
Title: "Consent revoked"
* target = Reference(Consent/example-acknowledge/_history/2)
* entity.what = Reference(Consent/example-acknowledge/_history/1)
* entity.role = #revision
* dateTime = 2022-03-11T16:56
* activity = http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle#hold
* patient = Reference(Patient/example)
* agent.type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#enterer
* agent.who = Reference(Practitioner/example-lawyer)
 
Instance: example-lawyer
InstanceOf: Practitioner
Title: "Corporate Lawyer example"
* active = true
* name.text = "David Pyke"
```

#### Security Considerations

That organizations that never allow a patient to be in a `deny` mode never need to look at Consent for access control reasons as there is no difference if the Patient has been given notice, or signed anything.
In these cases the Consent is there for record keeping only.
With the support for Change to opt-out, there is now a need for access-control to always look for Consent status.
The most simple access-control will simply look for the existence of a Consent, check that it is `.status = active`, and that it is `.provision.type = deny`; if it is anything else then the access-control rule is that which is represented by the privacy policy.

### P.4.4 Some patient specific provisions

The above examples were recording blanket agreement or disagreement by a given patient to a given policy. This is not as flexible as the Consent resource can support. The Consent resource can also record deviations, and special cases. These are recorded in the `.provisions` structure. The root level `.provision` simply sets the context as shown above. There is nested `.provision`(s) that can exist within the root level `.provision`, and even within other nested `.provisions`.  Each level of nesting would contain the exceptions to the rules set down in the prior level, thus each successive level of nesting reverses the `permit` vs `deny`. In this way one can encode situations where broad sharing is allowed, but not sharing with Dr. Bob. The following is an example fragment of just the `.provision`. Note that the second nested provision is a `deny` provision with the only other element populated is the actor.reference of Dr. Bob.

```fs
...
* provision.type = #permit
* provision.provision[0].type = #deny
* provision.provision[0].actor[0].reference = Reference(example-dr-bob)

Instance: example-dr-bob
InstanceOf: Practitioner
Title: "Dr. Bob"
* active = true
* name.text = "Dr. Bob"
```

#### AND relationship between elements

Each `.provision` has elements that describe the setting for that `permit` or `deny`. Each element within a given `.provision` is in an AND relationship with the other elements in that given `.provision`. An element that is not populated indicates that for that kind of element there is no constraint. Thus in the above example, the `deny` provision for Dr. Bob has none of the other elements in that `.provision` filled out, so this means that Dr. Bob is forbidden access regardless of the `role` he might take on, or the `purpose` of use, or the `action`, or the `class` of data, or the `dataPeriod` timeframe of the data, etc.

Thus to say that Dr. Bob is not to get access to the data, except for patient directed purpose of use; one would have a Deny of all access by Dr. Bob, and a nested Permit of Dr. Bob AND patient directed purpose of use AND normal confidentiality data (not restricted). 

```fs
...
* provision.type = #deny
* provision.provision[0].type = #permit
* provision.provision[0].actor[0].reference = Reference(example-dr-bob)
* provision.provision[0].purpose = http://terminology.hl7.org/CodeSystem/v3-ActReason#PATRQT "patient requested"
* provision.provision[0].securityLabel = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N "normal"

```

#### OR relationship within an element

Repetitions within an element are in an OR relationship. Thus to say that Dr. Bob is allowed this access, not just patient requested, but also family requested, and power of attorney; one would just put them all as alternatives on the purpose element.

```fs
...
* provision.type = #deny
* provision.provision[0].type = #permit
* provision.provision[0].actor[0].reference = Reference(example-dr-bob)
* provision.provision[0].purpose[0] = http://terminology.hl7.org/CodeSystem/v3-ActReason#PATRQT "patient requested"
* provision.provision[0].purpose[1] = http://terminology.hl7.org/CodeSystem/v3-ActReason#FAMRQT "family requested"
* provision.provision[0].purpose[2] = http://terminology.hl7.org/CodeSystem/v3-ActReason#PWATRNY "power of attorney"
* provision.provision[0].securityLabel = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N "normal"

```

### P.4.5 time scoped provisions

The `provision.period` is used to indicate that this provision is only active during a period of time. This is useful to indicate that Dr. Bob should be denied access until 2024, because I will be moving away from Dr. Bob in 2022.

```fs
...
* provision.type = #permit
* provision.provision[0].type = #deny
* provision.provision[0].period.end = 2024
* provision.provision[0].actor[0].reference = Reference(example-dr-bob)
```

#### timeframe for data

The provision elements are very powerful. We are not going to explain examples of all of them.

The `provision.dataPeriod` element is very useful, as it is not uncommon for a patient to remember a timeframe when they had a specifically sensitive healthcare episode. Thus it is easy to give a timeframe, where any data that was authored or last updated within that timeframe would be the context of that provision. The further advantage of this mechanism is that there is no indication of why or what is sensitive; just a timeframe.

For example, deny access to any data authored or last updated in 2018. This will block all data, regardless of what kind of data, or who is asking for the data.

<a name="SLS"> </a>

## P.5 Security Labeling Service Models

Data may be "Normal" medical data or "Restricted" medical data. The distinction here focused purely on data classification for stigmatizing sensitive topics. The discussion below focuses on FHIR, but the same can apply to [Document Sharing](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html) metadata `confidentiailtyCode` tag.

The various clinical Resources in FHIR are very complex and highly variable. Although [Observation](http://hl7.org/fhir/observation.html) is the most often used Resource, sensitive data may exist in ANY other FHIR resource including [Allergies](http://hl7.org/fhir/allergyintolerance.html), [Procedures](http://hl7.org/fhir/servicerequest.html), [CarePlan](http://hl7.org/fhir/careplan.html), [Medication](http://hl7.org/fhir/medicationstatement.html), [Problems](http://hl7.org/fhir/condition.html), [DiagnosticReport](http://hl7.org/fhir/diagnosticreport.html), [ImagingStudy](http://hl7.org/fhir/imagingstudy.html), [Genetics](https://www.hl7.org/fhir/molecularsequence.html), etc... By assessing the [sensitivity classification](https://www.hl7.org/fhir/security-labels.html) and placing that assessment into a [well-known location found in all FHIR Resources](https://www.hl7.org/fhir/security-labels.html#rsl) - `.meta.security`, the Access Control does not need to be aware of the kind of FHIR Resource, it can just process the data as a DomainResource and simply look at the `.meta.security` element.

The following example fragment shows data tagged with both alcohol use sensitive data and thus that the confidentality evaluation is Restricted. The complete [Observation of Alcohol Use](Observation-ex-alcoholUse.html) example.

```fs
...
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActCode#ETHUD
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R
* code = http://loinc.org#74013-4
* valueQuantity = 5 '{wine glasses}/d' 
...
```

The classification of the data may be a manual process, but that is not a very scalable solution. The [HL7 Security Workgroup](http://www.hl7.org/Special/committees/secure/index.cfm) proposes a tht the classification of data into sensitive topics is the role of the [Security Labeling Service (SLS)](https://www.hl7.org/implement/standards/product_brief.cfm?product_id=360). The SLS inspects the data, and may use the context of the data to identify the sensitivity classification. It is expected that most data will not be considered sensitive, aka "Normal".

### P.5.1 Data tagging Considerations

Some data are direct and clearly in a sensitive category. But there can be indirect relationships, such as three medications prescribed together are a clear indication of a sensitive category but are not individually sensitive.  

Some data may also not be sensitive in the coding, but rather sensitive in the narrative, this would be poor data quality but it is a reality that should be considered. Thus an SLS may need to include some Natural Language Processing to find sensitive human words in narrative.

Some approaches use well-defined ValueSets, where others use a list of words. The list of words can be search across the data without regard for the data structure, which has the benefit of not needing to have the SLS data schema aware. The list of words can be codes, such as SNOMED numeric codes.

### P.5.2 Architecture approaches to data tagging

When the SLS is executed is a systems design decision. General alternatives are:

#### Pre Tagging data
Tagging the data as it is created, updated, or imported.

<div>
{%include sls-batch.svg%}
</div>
<br clear="all">

Which has the advantage that the access to the data does not need to assess the data, it just uses the existing sensitivity tag.

<div>
{%include sls-pre.svg%}
</div>
<br clear="all">

This solution is likely to be more performant on use of data, but may not have as accurate sensitivity tags due to the dynamic nature of policies around sensitivity, and dynamic nature of data relationships. This solution also requires that the EHR database support data tags.

#### Use time tagging data

Alternative is that the data are temporarily tagged prior to use, thus the sensitivity is freshly determined and used only for that access enforcement

<div>
{%include sls-query.svg%}
</div>
<br clear="all">

This solution does not require that the EHR database be updated to support tagging of data, but may incur a performance impact on data use.

### P.5.3 Example ValueSets

One way to understand a very basic SLS is that it looks for clinical codes in the data. It might do this using ValueSets, but likely would need to do this in a more performing way. The following are some examples of ValueSets of codes that when these codes are found within data, that the data could be considered of the identified sensitivity classification. ValueSets like this should not be considered authoritative or stable, as the sensitive classes are dynamic in nature and thus the ValueSets you use would need to be revised on a regular basis. Thus these valueSets might be used as advice, but the content of them needs to be vetted and adjusted to meet current understanding and the practice of medicine within your organization.

- [Set of codes that indicate ETH (alcohol and drug)](ValueSet-SlsSensitiveETH.html)
  - [Set of codes that indicate ETHUD (alcohol)](ValueSet-SlsSensitiveETHUD.html)
  - [Set of codes that indicate OPIOIDUD (drugs)](ValueSet-SlsSensitiveOPIOIDUD.html)
- [Set of codes that indicate PSY](ValueSet-SlsSensitivePSY.html)
- [Set of codes that indicate SEX](ValueSet-SlsSensitiveSEX.html)
- [Set of codes that indicate HIV](ValueSet-SlsSensitiveHIV.html)

Note these ValueSets are also focused on directly identifying codes. These ValueSets do not address when different objects may be normal sensitive alone, but when they appear in a patient record the combination is sensitive. These ValueSets also do not address narrative text that might indicate sensitivity.

For example since these valueSets were originally authored ICD10 and ICD11 codeSystems have been published and are used. Thus the valueSets indicating codes in ICD9 may still find data in historic records, but to catch new data there would need to be codes from ICD10 or ICD11 defined.

### P.5.4 Example Data with tags

The following examples show where the sensitivity tag is maintained.

- [Observation of Alcohol Use](Observation-ex-alcoholUse.html) marked with `ETHUD`
- [Observation of a Blood Sugar](Observation-ex-bloodSugar.html) not marked sensitive


Supports patient privacy consents on FHIR in a Health Information Exchange scope.

The **Privacy Consent on FHIR (PCF)** builds upon a basic Identity and Authorization model such as [Internet User Authorization (IUA)](https://profiles.ihe.net/ITI/IUA/index.html) or [HL7 SMART-on-FHIR](https://hl7.org/fhir/smart-app-launch/) to provide basic access control. The Privacy Consents on FHIR is thus focused only on Access Control decisions regarding the parameters of the data subject (patient) privacy consent. The Privacy Consents on FHIR leverages these basic Identity and Authorization decisions as context setting for the authorization decision and enforcement. For example a user that would never be allowed access, would have been denied access at the IUA or SMART-on-FHIR level, but the identity properties provided by the IUA or SMART-on-FHIR level are input to the Privacy authorization decision that is the focus of PCF.

This is to say that PCF does not define:

- how one identifies the patient, this is the role of other Implementation Gudies like PDQm, PIXm, PIMR, etc;
- how the patient experiences the ceremony of the consent act, this is systems design, user interface design, and policy language;
- how one asks for data or communicates data, this is the role of other Implementation Guides like MHD, QEDm, MHDS, etc;
- how one tags data with security/privacy sensitivty lables, this is the role of a systems design that might utalize a **Security labeling Service**; and
- how users or applications are identified and foundationally authorized, this is the role of other Implementation Guides like IUA, and SMART.

But PCF enhances and relies upon these other Implementation Guides.

## 1:X.1 PCF Actors, Transactions, and Content Modules <a name="actors-and-transactions"> </a>

This section defines the actors and transactions in this implementation guide.

Figure below shows the actors directly
involved in the PCF
Profile and the relevant transactions between them.

<div>
{%include ActorsAndTransactions.svg%}
</div>
<br clear="all">

**Figure: PCF Actor Diagram**

The actors participate in the following Transactions.

**Table XX.1-1: PCF Profile - Actors and Transactions**

| Actors              | Transactions     | Direction | Optionality | Reference      |
|---------------------|------------------|-----------|-------------|----------------|
| Consent Capture     | Access Consent   | Initiator | R           | ITI TF-2: 3.Y1 |
| Consent Registry    | Access Consent   | Responder | R           | ITI TF-2: 3.Y1 |
| Consent Authorized  | Access Consent   | Responder | R           | ITI TF-2: 3.Y1 |
| Consent Decider     | Access Consent   | Initiator | R           | ITI TF-2: 3.Y1 |
|                     | Authorize Access | Responder | R           | ITI TF-2: 3.Y2 |
| Consent Enforcer    | Authorize Access | Responder | R           | ITI TF-2: 3.Y2 |
{: .grid}

### XX.1.1 Actors

The actors in this profile are described in more detail in the sections below.

#### XX.1.1.1 Consent Capture <a name="consentcapture"> </a>

The **Consent Capture** actor is responsible for the capturing of consent from the Patient given policies available. This actor is responsible for assuring that the Patient fully understood the terms of the Consent, and also assures that the Consent terms agreed to are acceptable to the organization responsible and the abilities of the **Consent Decider** and **Consent Enforcer** Actors.

The **Consent Capture** may utalize other resources to interact with the Patient, and to capture the evidence of the Consent ceremony. The interaction with the Patient can be a very complex system that utalizes applications, web user interface, and forms; but may also be a paper process that results in ink signatures on paperwork. The workflow leading up to the **Consent Capture** may also use FHIR Resources such as a FHIR Questionnaire or a DocumentReference / Binary. Where a DocumentReference and Binary are used to capture the Consent ceremony, the preservation should utalize the [MHD](https://profiles.ihe.net/ITI/MHD) implementation guide.

FHIR Capability Statement for [Consent Capture](CapabilityStatement-IHE.PCF.capture.html)

#### XX.1.1.2 Consent Registry <a name="consentregistry"> </a>

The **Consent Registry** actor holds Consent resources. This includes active, inactive, and expired Consents. The **Consent Registry** does not have special understanding of the Consent other than as a FHIR `Consent` Resource. It thus is not responsible for assuring that the Consent terms are acceptable or enforceable, this is the responsibility of the **Consent Capture** Actor.

FHIR Capability Statement for [Consent Registry](CapabilityStatement-IHE.PCF.registry.html)

#### XX.1.1.3 Consent Authorized <a name="consentclient"> </a>

The **Consent Authorized** actor is a client that makes use of the **Consent Decider** actor to get authorization token to use with various FHIR REST and Operation requests made to a Resource Server by way of the **Consent Enforcer** actor.

TODO: The expectation is that the interaction is indistinguisable from an IUA or SMART interaction from the perspective of the Consent Authorization Client.

#### XX.1.1.4 Consent Decider <a name="consentdecider"> </a>

The **Consent Decider** actor makes authorization decisions based on a given access requested context (e.g. oAuth, query/operation parameters), organizational policies, and current active `Consent` resources. The **Consent Decider** is often implemented utalizing other authorization services, taking input from the user identity (e.g. Open-ID-Connect), and application identity and authorization (e.g. IUA). These predicate authorizations provide the security context upon which the Privacy `Consent` constraints are applied. The result is an authorization token used to request access resources, and is used by the **Consent Enforcer** actor.

FHIR Capability Statement for [Consent Authorization Server](CapabilityStatement-IHE.PCF.decider.html)

#### XX.1.1.5 Consent Enforcer <a name="consentenforce"> </a>

The **Consent Enforcer** actor enforces consent decisions made by the **Consent Decider** actor. This includes deny, permit, and permit with filtering of results.

FHIR Capability Statement for [Consent Enforcement Resource Server](CapabilityStatement-IHE.PCF.enforce.html)

### XX.1.2 Transaction Descriptions

The transactions in this profile are summarized in the sections below.

#### XX.1.2.1 ITI-Y1 Access Consent transaction

This transaction is used to Create, Read, Update, Delete, and Search on Consent resources.

For more details see the detailed [Access Consent](ITI-Y1.html)

#### XX.1.2.2 ITI-Y2 Get Access Token transaction

This transaction is used to request an authorization decision based on Consents. This transaction is a refinement of the [IUA Get Access Token \[ITI-71\]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71).

For more details see the detailed [Get Access Token](ITI-Y2.html)

#### XX.1.2.3 ITI-Y3 Introspect Token transaction

This transaction is used to query the **Consent Authorization Server** to determine the set of claims for a given token. This transaction is a refinement of the [IUA Introspect Token \[ITI-102\]](https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102).

For more details see the detailed [Introspect Token](ITI-Y3.html)

## XX.2 PCF Actor Options <a name="actor-options"> </a>

Options that may be selected for each actor in this implementation guide, are listed in Table 3.2-1 below. Dependencies
between options when applicable are specified in notes.

| Actor              | Option Name |
|--------------------|-------------|
| Consent Capture    | Implicit  |
| Consent Capture    | Explicit Basic |
| Consent Capture    | Explicit Intermediate |
| Consent Capture    | Explicit Advanced |
| Consent Registry   | none |
| Consent Authorized | none |
| Consent Decider    | Implicit  |
| Consent Decider    | Explicit Basic |
| Consent Decider    | Explicit Intermediate |
| Consent Decider    | Explicit Advanced |
| Consent Enforcer   | Implicit  |
| Consent Enforcer   | Explicit Basic |
| Consent Enforcer   | Explicit Intermediate |
| Consent Enforcer   | Explicit Advanced |
{: .grid}

There are three levels of maturity, in incrementally more difficult to implement steps, defined:
Support for these Basic, Intermediate, and Advanced policies is support for the ability to provide these capabilties. The actual policy provided to the Patient would be some subset of this support that the data custodian is willing to enforce.

### XX.2.1 Implicit Option

The Implicit Policy Option indicates that there is a default policy that is used when there is no Consent found on file for a given patient. This Implicit Policy shall support the following "overarching" policies:

1. Permit for clinicians that have authorization for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users.
2. Permit for all authorized users. This presumes that basic user access control will only allow authorized users and purpose of use.
3. Deny for all authorized users, except when the user is a clinician with authorization to declare a medical patient-safety override (aka Break-Glass).
4. Deny all.

Other overarching policies may also be implemented, but their behaviour is not defined in PCF. 

The operational environment chooses which of these policies they will use, so in operational use only one of these is in effect.

Implicit Option has no ability to have Patient specific parameters. When Patient specific parameters are needed, then Explicit options are required.

When the Implicit Option is not declared to be implemented, then PCF expects "Deny all" overarching policy.

### XX.2.2 Explicit Basic Option

The Explicit Basic Option allows for patient specific consent to be recorded, and changed. This option sets the foundation for consents that expire, and consents that change based on organization and patient agreements. The lack of a consent for a given patient would be covered by the Implicit Option.

The Explicit Basic Option indicates that there is support for a basic set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. The overarching policy that the patient and organization have agreed upon. Where there are a defined set of behavour defined overarching policies as defined in the Implicit Option.
2. The timeframe for which the consent applies. Enabling consents that have a time limit.
3. Who is permitted/denied: This may be a device, relatedPerson, Practitioner, or Organization. This parameter enables the naming of agents that should be allowed access or denied access. This presumes that the identified agent is appropriately identified (provisioned) and authorized to make the request; typically through some application authorization and role-based-access-control. The user identity is mapped to a FHIR agent type Resource using the agent type Resource `.identifier` element (e.g. Practitioner.identifier would hold the user id).
4. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explitally identified as an authorized purposeOfUse or denied purposeOfuse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Decider is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, Operations, and Break-Glass
5. Timeframe within which data authored or last updated.
6. Explicit FHIR Resources can be identified using their `.id` value.

See [Basic Consent](ITI-Z1.html) Content Profile

### XX.2.3 Explicit Intermediate Option

The Explicit Intermediate Option indicates that there is support for an intermediate set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. Named Research projects. This is beyond the HL7 purposeOfUse codes.
2. Specific author of data.
3. Data relationship to explicit data object permitted/denied (e.g. data involved in a given Encounter, or CarePlan)

The Explicit Intermediate Option supports use-cases where the Access Control decision impacts more fine grain filtering of results based on context or data attributes.

See [Intermediate Consent](ITI-Z2.html) Content Profile

### XX.2.4 Explicit Advanced Option

The Explicit Advanced Option indicates that there is support for an advanced set of patient specific parameters. The Advanced policies allow for Patient specific permit/deny parameters on sensitive health topics and requires the use of security tagged data. The security tagged data might be implemented using a **Security Labeling Service** that is not defined here; or other systems design. This opton is required to support sensitive health topic segmentation such as substance abuse, mental health, sexuality and reproductive health, etc.

See [Advanced Consent](ITI-Z3.html) Content Profile

## XX.3 PCF Required Actor Groupings <a name="required-groupings"> </a>

**TODO Describe any requirements for actors in this profile to be grouped
with other actors. Possibilities**

- ATNA because Audit Logging is so critical to Privacy
- IUA or SMART? or is this not manditory, so would be later in XX.6?

## XX.4 PCF Overview <a name="overview"> </a>

Use cases are informative, not normative, and “SHALL” language is
not allowed in use cases.
The Use cases define the set of needs addressed by the Transactions and Content profiling.

The PCF Profile enables authorized access to data according to terms agreed by the Patient and the Organization protecting the data. These terms represent Privacy controls on the use of the data. The Privacy controls augment an overarching policy upon which these Privacy controls build. The writing of overarching policies, and the act of informing the patient and capturing their agreement is a predicate to the use-cases of the PCF.

### XX.4.1 Concepts

Consent is is a patient specific set of parameters that work within an overarching policy. For a discussion of policy, consent policy, and other concepts see [Appendix P: Privacy Access Policies](ch-P.html).

TODO: Need to better harmonize the following with ch-P

Concepts:

- Data Holder - a controlling entity of some set of patient identifiable data.
- Patient / Subject of data - the patient is the human-subject of health-related data. The use of the term patient is not to imply only subjects under current treatment.
- Consent - Agreement between the Subject of the data and the Data Holder as to the appropriate use of data. The consent may include constraints and obligations.
- Requests of the Data Holder - defined ways in which data are shared within a Trust Domain in keeping with the Consent terms
- Authentic Requests -- requests that can be proven to be from within the trust domain. Authentic Requests carry well-defined parameters of the request including identity of data recipient, purpose of use the data will be used, and the data characteristics scope.
- Data Classification -  Patient identifiable data is considered health information and is subject to a set of constraints as given to normal health information. Some patient identifiable data are considered more sensitive such as data that is deemed by the patient to be more sensitive, or by the nature of the data to be describing a sensitive health topic such as mental health, drug abuse, sexual health, or other.
- Users - are an identifable agent, usually human, that has some defined role within the Organization within which they operate. A User may be the Patient themself, a patient related party, clinician, researcher, billing clerk, etc. These different functional rules will have different needs to access data. For example registration clerks may need to be able to access patient demographics, billing, and contacts; but would not need access to clinical content.
- Patient Privacy Policy - A Patient Privacy Policy explains appropriate use of data/documents in a way that provides choices to the patient. ~~The BPPC Profile places no requirements on the content of these policies nor the method used to develop these policies~~ (See [ITI TF-1 Appendix P](ch-P.html) for some guidance on developing these policies). A Patient Privacy Policy will identify who has access to information, and what information is governed by the policy (e.g., under what conditions will ~~a document~~ **data** be marked as containing that type of information). The Patient Privacy Policy may be a consent policy, dissent policy, authorization policy, etc.
- Patient Privacy Policy - A Patient Privacy Policy will identify who has access to information, and what information is governed by the policy (e.g., under what conditions will a document be marked as containing that type of information). The policy may also describe the patient's rights to specify their consent preferences, notifications, complaints, or requests as well as the mechanism that allows them to do so.
- Patient Privacy Consent Resource - (aka Consent) A FHIR Consent resource that follows the PCF profile and captures the act of the consent ceremony and the details. The Consent references the basis Patient Privacy Policy. The Consent may be agreement with the policy, dissent with the policy, or may contain further constraints and authorizations based on the Patient Privacy Policy.
- Patient Privacy Policy Domain - The domain for which a Patient Privacy Policy applies. The Patient Privacy Policy Domain may cover an Organization, Health Information Exchange, or a defined set of Communities. The Patient Privacy Policy Domain is a Trust Domain.
- Patient Privacy Policy Identifier - A Patient Privacy Policy Domain-assigned globally unique identifier that identifies the Patient Privacy Policy.

Requests for data to leave the control of the Data Holder. Most requests will be from within a broader Trust Domain, but some requests may be to parties outside a Trust Domain.

### XX.4.2 Use Cases

PCF defines some transactions and some content. The content specifications define the variations on Consent that are used to enable consent parameters. The transactions utalize these content and carry out the privacy protection defined within a patient specific consent.

#### XX.4.2.1 Use Case \#1: Capture new consent

When a patient does not have a consent on file, and there is a need to capture consent. The Capture New Consent usecase is used to record the details of the Consent ceremony.

##### XX.4.2.1.1 Capture New Consent Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is no consent on file for a given Patient
When they present their Patient Privacy Policies to a given Patient
And the Patient either agrees, disagrees, or adds acceptable parameters
Then a Consent is captured by the **Consent Capture** actor and stored in the **Consent Registry**

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.

##### XX.4.2.1.2 Capture New Consent Process Flow

The following flow shows the activities involved in the Capture new Consent flow.

<div>
{%include usecase1-processflow.svg%}
</div>
<br clear="all">

**Figure XX.4.2.1-1: Capture new Consent**

The diagrammed steps:

1. Query for existing Consent. This step may not be necessary but is important to establish the Capture New Consent use-case from the Update Existing Consent use-case.
2. None is found. Given that no existing Consent exists, there are no preconditions, just default expectations for the workflow (TODO: This is where a Privacy Preferences could guide the flow).
3. Consult with the Patient. There is some interaction with the Patient. Within this interaction the patient needs to be appropriately informed of the details of the Patient Privacy Policy and the parameters the patient can control. This user Inteface might use a FHIR Questionnaire resulting in a QuestionnaireResult as documentation of the ceremony. This User Interface might use some other technical means, or might be a paper process.  This User Interface is not constrained by the PCF.
4. The results of the ceremony are captured to the satisfaction of the controlling Organization.  This might be a QuestionnarireResponse, or a scanned image of the signed paperwork recorded using a DocumentReference (See [MHD](https://profiles.ihe.net/ITI/MHD/index.html))
5. The Consent resource constrained by the Consent constraints defined in Volume 3 is then saved to the **Consent Registry** actor using Transaction [ITI-Y1].
6. An AuditEvent is recorded by both **Consent Capture** and **Consent Registry** actors.

#### XX.4.2.2 Use Case \#2: Update Existing Consent

When a patient has an existing consent on file, and there is a need to capture a new consent. The Update Existing Consent usecase is used to record the details of the new Consent ceremony and assure that the previous consent is no longer used.

##### XX.4.2.2.1 Update Existing Consent Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is a consent on file for a given Patient
When they present their Patient Privacy Policies to a given Patient
And the Patient either agrees, disagrees, or adds acceptable parameters
Then a Consent is captured by the **Consent Capture** actor and stored in the **Consent Registry**
And the new Consent overrites or invalidates the previous Consent

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.

##### XX.4.2.2.2 Update Existing Consent Process Flow

The following flow shows the activities involved in the Update Existing Consent flow.

<div>
{%include usecase2-processflow.svg%}
</div>
<br clear="all">

**Figure XX.4.2.2-1: Update Existing Consent Flow**

The diagrammed steps:

1. Query for existing Consent. This step may not be necessary but is important to establish the Capture New Consent use-case from the Update Existing Consent use-case. This step is also useful to retrieve the current Consent parameters so that the User Interface can start with appropriate settings informed by the past.
2. A Consent is found. More than one Consent may be found, for which the PCF does not address how to address this case. The overarching policy would need to be consulted. (TODO: This is where a Privacy Preferences could guide the flow).
3. Consult with the Patient. There is some interaction with the Patient. Within this interaction the patient needs to be appropriately informed of the details of the Patient Privacy Policy and the parameters the patient can control. This user Inteface might use a FHIR Questionnaire resulting in a QuestionnaireResult as documentation of the ceremony. This User Interface might use some other technical means, or might be a paper process.  This User Interface is not constrained by the PCF.
4. The results of the ceremony are captured to the satisfaction of the controlling Organization.  This might be a QuestionnarireResponse, or a scanned image of the signed paperwork recorded using a DocumentReference (See [MHD](https://profiles.ihe.net/ITI/MHD/index.html))
5. The Consent resource constrained by the Consent constraints defined in Volume 3 is then saved to the **Consent Registry** actor using Transaction [ITI-Y1]. This is typically a FHIR Update action so as to replace the previous Consent. It is also possible to delete the previous and save the Consent as a new instance.
6. An AuditEvent is recorded by both **Consent Capture** and **Consent Registry** actors.

#### XX.4.2.3 Use Case \#3: Consent Access Control

Given that an application needs access to resources, the following use-case assures that any data made available is authorized by the Consent. Note that this use-case presumes that business rules and security access control are incorporated into either the foundational oAuth flow, or some other process outside of this flow.

##### XX.4.2.3.1 Consent Access Control Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is a consent on file for a given Patient
When a request for patient identifiable data is made
Then the Consents are used by the **Consent Decider** actor as stored in the **Consent Registry** to make Access Control Decisions
And the **Consent Enforcer** assures that only data authorized by the Consent Access Control Decision are allowed to be exposed.

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.


##### XX.4.2.3.2 simple name Process Flow

The following flow shows the activities involved in the Consent Access Control flow.

<div>
{%include usecase3-processflow.svg%}
</div>
<br clear="all">

**Figure XX.4.2.3-1: Consent Access Control Flow**

The diagrammed steps:

1. a **Consent Authorized** actor, an abstraction of an app and possibly a user, requests an Access Token of the **Consent Decider** actor with some defined patient, user, app, and data parameters. This is the access request context that the **Conent Decider** will make Consent Access Control Decisions upon.
2. The **Consent Decider** gets user identiy information, if available. Such using one or more Open-ID Connect authority. Adding any details to the access request context --> Note that failure to identify a user may be a failure-mode.
3. The **Consent Decider** gets access token, if availble. Such as using IUA or SMART. Adding any details to the access request context --> Note that failure to get an authorization token may be a failure-mode.
4. The **Consent Decider** looks for Patient Consents at the **Consent Registry** actor(s). The access request context may be used to limit the Consent resources returned.
5. The **Consent Decider** receives the available consents. --> Note that failure to get a consent means that the default Implicit policy that is active is enforced. 
6. The **Consent Decider** determines the best match or matches of Consents returned to the access control request context (patient, user, app, purposeOfUse, data parameters, etc).
7. The **Consent Decider** makes the Access Control Decision based on the Consents
8. The **Consent Decider** combines the Consent Access Control Decision with the decisions returned in step 2 and 3
9. The **Consent Decider** encodes the combined Access Control Decision into an oAuth token. This is tyically just assiciating the conditions of the Access Control Decision with the opaque oAuth token returned such that later in step 12 the ITI-Y3 transaction can be used to get the details. This combined Access Control decision indicates what is permitted, denied and any obligations or refrains that must be applied.
10. The **Consent Decider** returns this combined token to the **Consent Authorized**. --> Note that failure-modes will not return a success token but rather an access denied. 
11. The **Consent Authorized** encapsulates the given oAuth token, using ITI-72, to indicate the authorization given where the grouped transaction is as defined by the data access implementation guide that is grouped. Meaning the transaction is otherwise as defined elsewhere. The **Consent Enforcer** receives the ITI-72 and extracts the oAuth token.
12. The **Consent Enforcer** request introspection using [ITI-Y3]. ITI-Y3 is based on ITI-102, but communicates the Consent Access Control decision details.
13. The **Consent Enforcer** may be able to enforce some of the Consent Access Control prior to retrieving the data requested. Such as where the Consent Access Control decision would forbid a kind of FHIR Resource.
14. The **Consent Enforcer** would use undefined means to retrieve the requested data from the FHIR Server. This may be by executing the grouped transaction with privileged access.
15. The **Consent Enforcer** would inspect the results and further enforce the Consent Access Control decision. This might be to filter out specific resources that could not have been filtered out otherways.
16. The **Consent Enforcer** returns the authorized data to the **Consent Authorized** actor. 

#### XX.4.2.4 Basic Consent Content

TODO

**Pre-conditions**:

Very briefly (typically one sentence) describe the conditions or
timing when this content module would be used.

**Main Flow**:

Typically in an enumerated list, describe the clinical workflow
when, where, and how this content module would be used.

**Post-conditions:**

Very briefly (typically one sentence) describe the state of the
clinical scenario after this content module has been created including
examples of potential next steps.

#### XX.4.2.5 Intermediate Consent Content

TODO

**Pre-conditions**:

Very briefly (typically one sentence) describe the conditions or
timing when this content module would be used.

**Main Flow**:

Typically in an enumerated list, describe the clinical workflow
when, where, and how this content module would be used.

**Post-conditions:**

Very briefly (typically one sentence) describe the state of the
clinical scenario after this content module has been created including
examples of potential next steps.

#### XX.4.2.6 Advanced Consent Content

TODO

**Pre-conditions**:

Very briefly (typically one sentence) describe the conditions or
timing when this content module would be used.

**Main Flow**:

Typically in an enumerated list, describe the clinical workflow
when, where, and how this content module would be used.

**Post-conditions:**

Very briefly (typically one sentence) describe the state of the
clinical scenario after this content module has been created including
examples of potential next steps.


## XX.5 PCF Security Considerations <a name="security-considerations"> </a>

**TODO** usually filled out after whole profile is written

See ITI TF-2x: [Appendix Z.8 “Mobile Security Considerations”](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations)

A change to Overarching policy need to be carefully managed. A change to Overarching policy may have no impact on the Consent, or may foundationally invalidate all Consents. The Overarching Policy identification is a foundational element of a Consent, and thus when the Overarching policy terms change, one can identify all Consents that were based on the prior Patient Privacy Policy Identifier. In some cases, such as jurisdictional rules backed by laws, the overarching policy may change, effectively changing the effect of the rules of a Consent based on that Overarching policy.


## XX.6 PCF Cross-Profile Considerations <a name="other-grouping"> </a>

**TODO Possibilities**
* MHDS - would explain how this is used vs the Consent method in MHDS
* QEDm / IPA 
  

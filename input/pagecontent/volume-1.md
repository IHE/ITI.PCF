
Supports patient privacy consents on FHIR in a Health Information Exchange scope.

The **Privacy Consent on FHIR (PCF)** builds upon a basic Identity and Authorization model such as [Internet User Authorization (IUA)](https://profiles.ihe.net/ITI/IUA/index.html) or [HL7 SMART-on-FHIR](https://hl7.org/fhir/smart-app-launch/) to provide basic access control. The Privacy Consent on FHIR is thus focused only on Access Control decisions regarding the parameters of the data subject (patient) privacy consent. The Privacy Consent on FHIR leverages these basic Identity and Authorization decisions as context setting for the authorization decision and enforcement. For example a user that would never be allowed access, would have been denied access at the IUA or SMART-on-FHIR level, but the identity properties provided by the IUA or SMART-on-FHIR level are input to the Privacy authorization decision that is the focus of PCF.

This is to say that PCF does not define:

- how one identifies the patient, this is the role of other Implementation Guides like PDQm, PIXm, PIMR, etc;
- how the patient experiences the ceremony of the consent act, this is systems design, user interface design, and policy language;
- how one asks for data or communicates data, this is the role of other Implementation Guides like MHD, QEDm, MHDS, etc;
- how one tags data with security/privacy sensitivity labels, this is the role of a systems design that might utilize a [Security labeling Service](ch-P.html#SLS); and
- how users or applications are identified and foundationally authorized, this is the role of other Implementation Guides like IUA, and SMART.

But PCF enhances and relies upon these other Implementation Guides.

TODO: Likely need a diagram that is more human workflow focused?

<a name="actors-and-transactions"> </a>

## X.1 PCF Actors, Transactions, and Content Modules

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

| Actors                       | Transactions     | Direction | Optionality | Reference      |
|------------------------------|------------------|-----------|-------------|----------------|
| Consent Recorder             | Access Consent   | Initiator | R           | ITI TF-2: 3.110 |
| Consent Registry             | Access Consent   | Responder | R           | ITI TF-2: 3.110 |
| Consent Authorization Client | Access Consent   | Responder | R           | ITI TF-2: 3.110 |
| Consent Authorization Server | Access Consent   | Initiator | R           | ITI TF-2: 3.110 |
|                              | Authorize Access | Responder | R           | ITI TF-2: 3.108 |
|                              | Introspect Consent Token | Responder | R           | ITI TF-2: 3.109 |
| Consent Enforcement Point    | Authorize Access | Responder | R           | ITI TF-2: 3.108 |
|                              | Introspect Consent Token | Initiator | R           | ITI TF-2: 3.109 |
{: .grid}

### XX.1.1 Actors

The actors in this profile are described in more detail in the sections below.

<a name="consentRecorder"> </a>

#### XX.1.1.1 Consent Recorder

The **Consent Recorder** actor is responsible for the capturing of consent from the Patient given policies available. This actor is responsible for assuring that the Patient fully understood the terms of the Consent, and also assures that the Consent terms agreed to are acceptable to the organization responsible and the abilities of the **Consent Authorization Server** and **Consent Enforcement Point** Actors.

The **Consent Recorder** may utilize other resources to interact with the Patient, and to capture the evidence of the Consent ceremony. The interaction with the Patient can be a very complex system that utilizes applications, web user interface, and forms; but may also be a paper process that results in ink signatures on paperwork. The workflow leading up to the **Consent Recorder** may also use FHIR Resources such as a FHIR Questionnaire or a DocumentReference / Binary. Where a DocumentReference and Binary are used to capture the Consent ceremony, the preservation should utilize the [MHD](https://profiles.ihe.net/ITI/MHD) implementation guide.

FHIR Capability Statement for [Consent Recorder](CapabilityStatement-IHE.PCF.consentRecorder.html)

<a name="consentRegistry"> </a>

#### XX.1.1.2 Consent Registry

The **Consent Registry** actor holds Consent resources. This includes active, inactive, and expired Consents. The **Consent Registry** does not have special understanding of the Consent other than as a FHIR `Consent` Resource. It thus is not responsible for assuring that the Consent terms are acceptable or enforceable, this is the responsibility of the **Consent Recorder** Actor.

FHIR Capability Statement for [Consent Registry](CapabilityStatement-IHE.PCF.consentRegistry.html)

<a name="consentAuthorizationClient"> </a>

#### XX.1.1.3 Consent Authorization Client

The **Consent Authorization Client** actor is a client that makes use of the **Consent Authorization Server** actor to get authorization token to use with various FHIR REST and Operation requests made to a Resource Server by way of the **Consent Enforcement Point** actor.

TODO: The expectation is that the interaction is indistinguishable from an IUA or SMART interaction from the perspective of the Consent Authorization Client.

<a name="consentAuthorizationServer"> </a>

#### XX.1.1.4 Consent Authorization Server

The **Consent Authorization Server** actor makes authorization decisions based on a given access requested context (e.g. oAuth, query/operation parameters), organizational policies, and current active `Consent` resources. The **Consent Authorization Server** is often implemented utilizing other authorization services, taking input from the user identity (e.g. Open-ID-Connect), and application identity and authorization (e.g. IUA). These predicate authorizations provide the security context upon which the Privacy `Consent` constraints are applied. The result is an authorization token used to request access resources, and is used by the **Consent Enforcement Point** actor.

<a name="consentEnforcementPoint"> </a>

#### XX.1.1.5 Consent Enforcement Point

The **Consent Enforcement Point** actor enforces consent decisions made by the **Consent Authorization Server** actor. This includes deny, permit, and permit with filtering of results.

### XX.1.2 Transaction Descriptions

The transactions in this profile are summarized in the sections below.

#### XX.1.2.1 ITI-110 Access Consent transaction

This transaction is used to Create, Read, Update, Delete, and Search on Consent resources.

For more details see the detailed [Access Consent](ITI-110.html)

#### XX.1.2.2 ITI-108 Get Consent Access Token transaction

This transaction is used to request an authorization decision based on Consents. This transaction is a refinement of the [IUA Get Consent Access Token \[ITI-71\]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71).

For more details see the detailed [Get Consent Access Token](ITI-108.html)

#### XX.1.2.3 ITI-109 Introspect Consent Token transaction

This transaction is used to query the **Consent Authorization Server** to determine the set of claims for a given token. This transaction is a refinement of the [IUA Introspect Consent Token \[ITI-102\]](https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102).

For more details see the detailed [Introspect Consent Token](ITI-109.html)

<a name="actor-options"> </a>

## XX.2 PCF Actor Options

Options that may be selected for each actor in this implementation guide, are listed in Table 3.2-1 below. Dependencies
between options when applicable are specified in notes.

| Actor              | Option Name |
|--------------------|-------------|
| Consent Recorder    | Implicit  |
| Consent Recorder    | Explicit Basic |
| Consent Recorder    | Explicit Intermediate Data Timeframe |
| Consent Recorder    | Explicit Intermediate Data by id |
| Consent Recorder    | Explicit Intermediate Data Author |
| Consent Recorder    | Explicit Intermediate Data Relationship |
| Consent Recorder    | Explicit Intermediate Additional PurposeOfUse |
| Consent Recorder    | Explicit Advanced |
| Consent Registry   | none |
| Consent Authorization Client | none |
| Consent Authorization Server    | Implicit  |
| Consent Authorization Server    | Explicit Basic |
| Consent Authorization Server    | Explicit Intermediate Data Timeframe |
| Consent Authorization Server    | Explicit Intermediate Data by id |
| Consent Authorization Server    | Explicit Intermediate Data Author |
| Consent Authorization Server    | Explicit Intermediate Data Relationship |
| Consent Authorization Server    | Explicit Intermediate Additional PurposeOfUse |
| Consent Authorization Server    | Explicit Advanced |
| Consent Enforcement Point   | Implicit  |
| Consent Enforcement Point   | Explicit Basic |
| Consent Enforcement Point   | Explicit Intermediate Data Timeframe |
| Consent Enforcement Point   | Explicit Intermediate Data by id |
| Consent Enforcement Point   | Explicit Intermediate Data Author |
| Consent Enforcement Point   | Explicit Intermediate Data Relationship |
| Consent Enforcement Point   | Explicit Intermediate Additional PurposeOfUse |
| Consent Enforcement Point   | Explicit Advanced |
{: .grid}

Note 1: Explicit Intermediate options and Explicit Advanced option require that Explicit Basic Option is selected

There are three levels of maturity, in incrementally more difficult to implement steps, defined:
Support for these Basic, Intermediate, and Advanced policies is support for the ability to provide these capabilities. The actual policy provided to the Patient would be some subset of this support that the data custodian is willing to enforce.

### XX.2.1 Implicit Option

The Implicit Policy Option indicates that there is a default policy that is used when there is no Consent found on file for a given patient. This Implicit Policy shall support the following "overarching" policies:

1. Permit for clinicians that have authorization for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users.
2. Permit for all authorized users. This presumes that basic user access control will only allow authorized users and purpose of use.
3. Deny for all authorized users, except when the user is a clinician with authorization to declare a medical patient-safety override (aka Break-Glass).
4. Deny all.

Other overarching policies may also be implemented, but their behavior is not defined in PCF.

The operational environment chooses which of these policies they will use, so in operational use only one of these is in effect.

Implicit Option has no ability to have Patient specific parameters. When Patient specific parameters are needed, then Explicit options are required.

When the Implicit Option is not declared to be implemented, then PCF expects "Deny all" overarching policy.

### XX.2.2 Explicit Basic Option

The Explicit Basic Option allows for patient specific consent to be recorded, and changed. This option sets the foundation for consents that expire, and consents that change based on organization and patient agreements. The lack of a consent for a given patient would be covered by the Implicit Option.

The Explicit Basic Option indicates that there is support for a basic set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. The overarching policy that the patient and organization have agreed upon. Where there are a defined set of behavior defined overarching policies as defined in the Implicit Option.
2. The timeframe for which the consent applies. Enabling consents that have a time limit.
3. Who is permitted/denied: This may be a device, relatedPerson, Practitioner, or Organization. This parameter enables the naming of agents that should be allowed access or denied access. This presumes that the identified agent is appropriately identified (provisioned) and authorized to make the request; typically through some application authorization and role-based-access-control. The user identity is mapped to a FHIR agent type Resource using the agent type Resource `.identifier` element (e.g. Practitioner.identifier would hold the user id).
4. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explicably identified as an authorized purposeOfUse or denied purposeOfuse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Authorization Server is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, Operations, and Break-Glass.

See [Basic Consent](content.html#basic) Content Profile

### XX.2.3 Explicit Intermediate options

The following Options shall be used in conjunction with **Explicit Basic Option**, and may be used with **Explicit Advanced Option**. The Intermediate Options can be implemented and/or used individually or combined. When combined within one parameter the logic provided by each option is combined. The data scoping intermediate options are not expected to be found combined on one parameter, but may be combined within a Consent providing different data scoping capability. For example: A consent that indicates that a data timeframe is used to deny insurance access, with a different parameter indicting that a data relationship is allowed access to a research project.

See [Intermediate Consent](content.html#intermediate) Content Profile

#### XX.2.3.1 Explicit Intermediate Data Timeframe Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a timeframe within which data authored or last updated.

#### XX.2.3.2 Explicit Intermediate Data by id Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a FHIR Resources by `.id` value.

#### XX.2.3.3 Explicit Intermediate Data Author Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of an indicated author. This option is useful when the consent provision is limiting access to data that was authorized by a given doctor.

#### XX.2.3.4 Explicit Intermediate Data Relationship Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of that data being related in a given way to a given identified data object. This option is useful for indicating a consent provision that is limiting/authorizing access to data that was created as part of an encounter, care plan, or episode of care.

#### XX.2.3.5 Explicit Intermediate Additional PurposeOfUse Option

This option provides for the Consent to have one or more permit/deny parameter that indicates a purposeOfUse that is not listed in the **Explicit Basic Option** vocabulary. This would tend to be used with Clinical Research projects, where the purposeOfUse is a code assigned to a specific Clinical Research Project. This may be used for other purposeOfUse codes. Where **Explicit Basic Option** has some well-known purposeOfUse codes, this option is used for other codes.

### XX.2.4 Explicit Advanced Option

The Explicit Advanced Option indicates that there is support for an advanced set of patient specific parameters. The Advanced policies allow for Patient specific permit/deny parameters on sensitive health topics and requires the use of security tagged data. The security tagged data might be implemented using a [Security labeling Service](ch-P.html#SLS) that is not defined here; or other systems design. This option is required to support sensitive health topic segmentation such as substance abuse, mental health, sexuality and reproductive health, etc.

See [Advanced Consent](content.html#advanced) Content Profile

<a name="required-groupings"> </a>

## XX.3 PCF Required Actor Groupings

**TODO Describe any requirements for actors in this profile to be grouped
with other actors. Possibilities**

- ATNA because Audit Logging is so critical to Privacy
- IUA or SMART? or is this not mandatory, so would be later in XX.6?

<a name="overview"> </a>

## XX.4 PCF Overview

Use cases are informative, not normative, and “SHALL” language is
not allowed in use cases.
The Use cases define the set of needs addressed by the Transactions and Content profiling.

The PCF Profile enables authorized access to data according to terms agreed by the Patient and the Organization protecting the data. These terms represent Privacy controls on the use of the data. The Privacy controls augment an overarching policy upon which these Privacy controls build. The writing of overarching policies, and the act of informing the patient and capturing their agreement is a predicate to the use-cases of the PCF.

### XX.4.1 Concepts

Consent is is a patient specific set of parameters that work within an overarching policy. For a discussion of policy, consent policy, and other concepts see [Appendix P: Privacy Access Policies](ch-P.html). The concepts outlined in [Appendix P: Privacy Access Policies](ch-P.html) are critical to understanding this implementation guide.

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
Then a Consent is captured by the **Consent Recorder** actor and stored in the **Consent Registry**

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
2. None is found. Given that no existing Consent exists, there are no preconditions, just default expectations for the workflow.
3. Consult with the Patient. There is some interaction with the Patient. Within this interaction the patient needs to be appropriately informed of the details of the Patient Privacy Policy and the parameters the patient can control. This user Interface might use a FHIR Questionnaire resulting in a QuestionnaireResult as documentation of the ceremony. This User Interface might use some other technical means, or might be a paper process.  This User Interface is not constrained by the PCF.
4. The results of the ceremony are captured to the satisfaction of the controlling Organization.  This might be a QuestionnaireResponse, or a scanned image of the signed paperwork recorded using a DocumentReference (See [MHD](https://profiles.ihe.net/ITI/MHD/index.html))
5. The Consent resource constrained by the Consent constraints defined in Volume 3 is then saved to the **Consent Registry** actor using Transaction [ITI-110].
6. An AuditEvent is recorded by both **Consent Recorder** and **Consent Registry** actors.

#### XX.4.2.2 Use Case \#2: Update Existing Consent

When a patient has an existing consent on file, and there is a need to capture a new consent. The Update Existing Consent usecase is used to record the details of the new Consent ceremony and assure that the previous consent is no longer used.

##### XX.4.2.2.1 Update Existing Consent Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is a consent on file for a given Patient
When they present their Patient Privacy Policies to a given Patient
And the Patient either agrees, disagrees, or adds acceptable parameters
Then a Consent is captured by the **Consent Recorder** actor and stored in the **Consent Registry**
And the new Consent overwrites or invalidates the previous Consent

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
2. A Consent is found. More than one Consent may be found, for which the PCF does not address how to address this case. The overarching policy would need to be consulted.
3. Consult with the Patient. There is some interaction with the Patient. Within this interaction the patient needs to be appropriately informed of the details of the Patient Privacy Policy and the parameters the patient can control. This user Interface might use a FHIR Questionnaire resulting in a QuestionnaireResult as documentation of the ceremony. This User Interface might use some other technical means, or might be a paper process.  This User Interface is not constrained by the PCF.
4. The results of the ceremony are captured to the satisfaction of the controlling Organization.  This might be a QuestionnaireResponse, or a scanned image of the signed paperwork recorded using a DocumentReference (See [MHD](https://profiles.ihe.net/ITI/MHD/index.html))
5. The Consent resource constrained by the Consent constraints defined in Volume 3 is then saved to the **Consent Registry** actor using Transaction [ITI-110]. This is typically a FHIR Update action so as to replace the previous Consent. It is also possible to delete the previous and save the Consent as a new instance.
6. An AuditEvent is recorded by both **Consent Recorder** and **Consent Registry** actors.

#### XX.4.2.3 Use Case \#3: Consent Access Control

Given that an application needs access to resources, the following use-case assures that any data made available is authorized by the Consent. Note that this use-case presumes that business rules and security access control are incorporated into either the foundational oAuth flow, or some other process outside of this flow.

##### XX.4.2.3.1 Consent Access Control Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is a consent on file for a given Patient
When a request for patient identifiable data is made
Then the Consents are used by the **Consent Authorization Server** actor as stored in the **Consent Registry** to make Access Control Decisions
And the **Consent Enforcement Point** assures that only data authorized by the Consent Access Control Decision are allowed to be exposed.

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.

##### XX.4.2.3.2 Consent Access Control Process Flow

The following flow shows the activities involved in the Consent Access Control flow.

<div>
{%include usecase3-processflow.svg%}
</div>
<br clear="all">

**Figure XX.4.2.3-1: Consent Access Control Flow**

The diagrammed steps:

1. a **Consent Authorization Client** actor, an abstraction of an app and possibly a user, requests an Access Token of the **Consent Authorization Server** actor with some defined patient, user, app, and data parameters. This is the access request context that the **Consent Authorization Server** will make Consent Access Control Decisions upon.
2. The **Consent Authorization Server** gets user identity information, if available. Such using one or more Open-ID Connect authority. Adding any details to the access request context --> Note that failure to identify a user may be a failure-mode.
3. The **Consent Authorization Server** gets access token, if available. Such as using IUA or SMART. Adding any details to the access request context --> Note that failure to get an authorization token may be a failure-mode.
4. The **Consent Authorization Server** looks for Patient Consents at the **Consent Registry** actor(s). The access request context may be used to limit the Consent resources returned.
5. The **Consent Authorization Server** receives the available consents. --> Note that failure to get a consent means that the default Implicit policy that is active is enforced. 
6. The **Consent Authorization Server** determines the best match or matches of Consents returned to the access control request context (patient, user, app, purposeOfUse, data parameters, etc).
7. The **Consent Authorization Server** makes the Access Control Decision based on the Consents
8. The **Consent Authorization Server** combines the Consent Access Control Decision with the decisions returned in step 2 and 3
9. The **Consent Authorization Server** encodes the combined Access Control Decision into an oAuth token. This is typically just associating the conditions of the Access Control Decision with the opaque oAuth token returned such that later in step 12 the ITI-109 transaction can be used to get the details. This combined Access Control decision indicates what is permitted, denied and any obligations or refrains that must be applied.
10. The **Consent Authorization Server** returns this combined token to the **Consent Authorization Client**. --> Note that failure-modes will not return a success token but rather an access denied.
11. The **Consent Authorization Client** encapsulates the given oAuth token, using ITI-72, to indicate the authorization given where the grouped transaction is as defined by the data access implementation guide that is grouped. Meaning the transaction is otherwise as defined elsewhere. The **Consent Enforcement Point** receives the ITI-72 and extracts the oAuth token.
12. The **Consent Enforcement Point** request introspection using [ITI-109]. ITI-109 is based on ITI-102, but communicates the Consent Access Control decision details.
13. The **Consent Enforcement Point** may be able to enforce some of the Consent Access Control prior to retrieving the data requested. Such as where the Consent Access Control decision would forbid a kind of FHIR Resource.
14. The **Consent Enforcement Point** would use undefined means to retrieve the requested data from the FHIR Server. This may be by executing the grouped transaction with privileged access.
15. The **Consent Enforcement Point** would inspect the results and further enforce the Consent Access Control decision. This might be to filter out specific resources that could not have been filtered out other ways.
16. The **Consent Enforcement Point** returns the authorized data to the **Consent Authorization Client** actor. 

#### XX.4.2.4 Implicit Content

These use-cases will outline the justification for the alternatives within the **Implicit Option**

**Pre-conditions**:

Given there is no consent for a given patient. This may be because:

- no consent is available, or
- that there is no mechanism to capture consent, or
- that the existence of a consent does not impact Access Control. Such as when consent is used to simply flag that this patient has been presented with the privacy policy.

**Main Flow**:

- The Business has chosen one of the **Implicit Consent Option** defined alternatives
- There is no Access Control use of any Consent resource in **Implicit Consent Option**

**Post-conditions**:

- The alternative protects access (see below)

##### XX.4.2.4.1 Permit Clinical Treatment

Permit for clinicians that have authorization for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users and legitimate clinical purpose.

**Pre-conditions**:

The controlling Organization has identified Clinical roles that would have access for Treatment, and has mechanisms in place to prevent any inappropriate use.

**Main Flow**:

- Business Access Control prevents inappropriate users, applications, purposes, and activities. Allowing only Clinical users access under Treatment purpose.
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access, thus clinical users get access for clinical treatment need.

##### XX.4.2.4.2 Permit all Authorized

Permit for all authorized users. This presumes that basic user access control will only allow authorized users and for authorized purpose of use.

**Pre-conditions**:

The controlling Organization has identified various roles that would have access for given purpose, and has mechanisms in place to prevent any in appropriate use. This is distinct from the previous use-case in that the roles and purpose are not limited to Clinical and Treatment.

**Main Flow**:

- Business Access Control prevents inappropriate users, applications, purposes, and activities.
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access.

##### XX.4.2.4.3 Deny except for Break-Glass

Deny for all uses except when explicit override reason is given by user that is authorized to use explicit override (aka Break-Glass).

**Pre-conditions**:

The controlling Organization has identified various roles that would have the ability to declare an access override (aka Break-Glass), and has mechanisms in place to prevent any inappropriate use. There is no expectation that the Break-Glass is only for treatment, although the controlling Organization policy may be specific to treatment. In this way this option can be used for any purposeOfUse and override rational that the controlling Organization deems appropriate.

**Main Flow**:

- Business Access Control prevents inappropriate users, applications, purposes, and activities.
  - The access denial will be indicated as either absolute, or potential to invoke break-glass
- User that is authorized to declare an explicit override provides reason for override
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access.

An explicit record of the declared break-glass reason is made for each allowed access.

##### XX.4.2.4.4 Deny All

Deny for all uses without exceptions. This is an unusual setting for a purely Implicit consent environment, but is intended to be paired with an Explicit consent. When paired with an Explicit consent, the **Deny All** functions as the default policy when no explicit consent is on record. This might also be used on a system that is designed simply to record data with no access to that data (e.g., an Audit log repository).

**Pre-conditions**:

The controlling Organization has controls in place to prevent all access.

**Main Flow**:

- Business Access Control prevents all access by any users, applications, purposes, and activities.
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access.

#### XX.4.2.5 Basic Consent Content

The **Basic Consent** content provides for recording that a Consent has been given and this option is the basis of all explicit consent options. The goal of a basic consent content is to express how a Consent is recorded, Updated, Removed, and Expired. The basic consent content also shows how one finds relevant Consent instances, and determines if they are still valid.

**Pre-conditions**:

The controlling Organization has identified various roles and the kinds of purpose of use those roles are authorized to participate in. The Controlling Organization defines the default policy to be used when no consent is found, possibly choosing from the **Implicit Options** policies. The Controlling Organization defines the policy to be used with the explicit basic consent, the policy that will be enforced when the patient has agreed to a consent.

**Main Flow**:

- The Business Access Control prevents inappropriate users, applications, purposes, and activities
- when a consent is found to apply to the user / application and purpose of use (given patient, organization, and policy)
  - And that consent has not expired
    - When that consent is a Permit of the access requested
      - Then Access Control allows access
    - When that consent is a Deny
      - Then Access Control enforces the deny policy
- When no consent is found or has expired
  - Then Access Control enforces the chosen default policy

**Post-conditions:**

Appropriate use is allowed, in appropriate use is denied

**Content:**

The following set of patient specific parameters may be used to permit or deny:

1. The overarching policy that the patient and organization have agreed upon. Where there are a defined set of behavior defined overarching policies as defined in the Implicit Option.
2. The timeframe for which the consent applies. Enabling consents that have a time limit.
3. Who is permitted/denied: This may be a device, relatedPerson, Practitioner, or Organization. This parameter enables the naming of agents that should be allowed access or denied access. This presumes that the identified agent is appropriately identified (provisioned) and authorized to make the request; typically through some application authorization and role-based-access-control. The user identity is mapped to a FHIR agent type Resource using the agent type Resource `.identifier` element (e.g. Practitioner.identifier would hold the user id).
4. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explicably identified as an authorized purposeOfUse or denied purposeOfuse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Authorization Server is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, Operations, and Break-Glass.

#### XX.4.2.6 Intermediate Consent Contents

The **Intermediate Consent** contents shall be used in conjunction with **Basic Consent** content, and may be used with **Advanced Consent** content. Where as the **Basic Consent** is used to record the fundamental aspects of the Consent ceremony. The **Intermediate Consent** contents can be used independently or together.

**Pre-conditions**:

The controlling Organization has identified various roles and the kinds of purpose of use those roles are authorized to participate in. The Controlling Organization defines the default policy to be used when no consent is found, possibly choosing from the **Implicit Options** policies. The Controlling Organization defines the policy to be used with the explicit basic consent, the policy that will be enforced when the patient has agreed to a consent. The controlling Organization provides for the patient to choose from the intermediate parameters that the controlling organization is willing to enforce, recognizing that some parameters may not be appropriate or allowed. The **Consent Recorder** actor is responsible for assuring that the recorded Consent is enforceable an appropriate.

**Main Flow**:

- Given The Business Access Control prevents inappropriate users, applications, purposes, and activities
  - And an appropriate user / application requests access for an appropriate purpose and activity
  - And the data are tagged with appropriate sensitivity and confidentiality vocabulary
- **Consent Authorization Server**
  - when a consent is found to apply to the user / application and purpose of use (given patient, organization, and policy)
    - And that consent has not expired
      - The Consent identified overall policy will be recognized relative to the overall Permit/Deny
      - The provisions will be recognized for any applicability to the requested access
  - decision of either Deny authorization, or return a Permit with appropriate scope restrictions. The scope restrictions may match the requested scope, or may have been impacted by the Consent parameters.

**Post-conditions:**

- **Consent Enforcement Point** assures only appropriate use is allowed, inappropriate use is denied

##### XX.4.2.6.1 Intermediate Data Timeframe Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a timeframe within which data authored or last updated.

The use-case would be where a patient knows that there was a period of time where they received care, and for which the patient indicates they want to segment out that data for permit or deny. The user interface is not defined here or constrained.

##### XX.4.2.6.2 Intermediate Data by id Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a FHIR Resources by `.id` value.

The use-case would be where a patient knows specific data artifacts for which the patient indicates they want to segment those data for permit or deny. The user interface is not defined here or constrained.

##### XX.4.2.6.3 Intermediate Data Author Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of an indicated author. This option is useful when the consent provision is limiting access to data that was authorized by a given doctor.

The use-case would be where a patient knows that there is an author (organization or practitioner), and for which the patient indicates they want to segment out that data for permit or deny. Note that this capability is dependent on the data be properly attributed to the author. The user interface is not defined here or constrained.

##### XX.4.2.6.4 Intermediate Data Relationship Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of that data being related in a given way to a given identified data object. This option is useful for indicating a consent provision that is limiting/authorizing access to data that was created as part of an encounter, care plan, or episode of care.

The use-case would be where a patient knows that there is an encounter, care plan, or episode of care that can be used to identify data for which the patient indicates they want to segment out that data for permit or deny. Note that this capability is dependent on the data be properly attributed to the encounter, care plan, or episode of care. The user interface is not defined here or constrained.

##### XX.4.2.6.5 Intermediate Additional PurposeOfUse Content

This option provides for the Consent to have one or more permit/deny parameter that indicates a purposeOfUse that is not listed in the **Basic Consent** vocabulary. This would tend to be used with Clinical Research projects, where the purposeOfUse is a code assigned to a specific Clinical Research Project. This may be used for other purposeOfUse codes. Where **Basic Consent** has some well-known purposeOfUse codes, this option is used for other codes.

The use-case would be where a patient is authorizing purposeOfUse beyond those defined in the **Basic Consent**. An example would be a Privacy Consent to allow an identified clinical research project to have access to the patient data.

#### XX.4.2.7 Advanced Consent Content

The **Advanced Consent** contents shall be used in conjunction with **Basic Consent** content, and may be used with **Intermediate Consent** content.  Where as the **Basic Consent** is used to record the fundamental aspects of the Consent ceremony. The **Advanced Consent** Content provides for parameters in a Consent that provide rules around data that are classified by sensitivity and confidentiality.

Support for the Advanced Consent relies on the data being tagged with sensitivity codes and confidentiality codes. This data tagging is not defined in PCF. There are a few established ways to get the data tagged including using a [Security labeling Service](ch-P.html#SLS), which has a few established architectures. The implementation of security tagging is a systems design requirement on the **Consent Enforcement Point** actor.

**Pre-conditions**:

The controlling Organization has identified various roles and the kinds of purpose of use those roles are authorized to participate in. The Controlling Organization defines the default policy to be used when no consent is found, possibly choosing from the **Implicit Options** policies. The Controlling Organization defines the policy to be used with the explicit basic consent, the policy that will be enforced when the patient has agreed to a consent. The controlling Organization provides for the patient to choose from the intermediate parameters that the controlling organization is willing to enforce, recognizing that some parameters may not be appropriate or allowed. The **Consent Recorder** actor is responsible for assuring that the recorded Consent is enforceable an appropriate.

**Main Flow**:

- Given The Business Access Control prevents inappropriate users, applications, purposes, and activities
  - And an appropriate user / application requests access for an appropriate purpose and activity
  - And the data are tagged with appropriate sensitivity and confidentiality vocabulary
- **Consent Authorization Server**
  - when a consent is found to apply to the user / application and purpose of use (given patient, organization, and policy)
    - And that consent has not expired
      - The Consent identified overall policy will be recognized relative to the overall Permit/Deny
      - The provisions will be recognized for any applicability to the requested access
  - decision of either Deny authorization, or return a Permit with appropriate scope restrictions. The scope restrictions may match the requested scope, or may have been impacted by the Consent parameters.

**Post-conditions:**

- **Consent Enforcement Point** assures only appropriate use is allowed, inappropriate use is denied

**Content:**

The **Advanced Consent** content utilizes sensitivity codes and confidentiality codes. The Consent would include parameters that would indicate for a given sensitivity/confidentiality code the conditions on Permit or Deny. 

The typical use-case would be where the patient will allow normal confidentiality data to be used for some purpose such as Treatment, but indicates that data that is tagged as restricted confidentiality not be used.

At a minimum the following stigmatizing [Sensitivity](https://terminology.hl7.org/ValueSet-v3-InformationSensitivityPolicy.html) classifications shall be implemented as parameters:

- `ETH` -- Substance Abuse including Alcohol
  - `ETHUD` -- Alcohol substance abuse
  - `OPIOIDUD` -- Opioid drug abuse
- `PSY` -- Psychiatry Disorder
- `SEX` -- Sexual Assault, Abuse, or Domestic Violence
- `HIV` -- HIV/AIDS

At a minimum the following [ConfidentialityCodes](https://terminology.hl7.org/ValueSet-v3-Confidentiality.html) shall be implemented as parameters:

- `N` Normal and
- `R` Restricted

The ConfidentialityCode may be assigned to data by various ways. Where data have a sensitivity classification that is stigmatizing then the ConfidentialityCode shall be Restricted, otherwise the data are Normal. Other methods of determining the ConfidentialityCode for data are allowed.

<a name="security-considerations"> </a>

## XX.5 PCF Security Considerations

**TODO** usually filled out after whole profile is written

See ITI TF-2x: [Appendix Z.8 “Mobile Security Considerations”](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations)

A change to Overarching policy need to be carefully managed. A change to Overarching policy may have no impact on the Consent, or may foundationally invalidate all Consents. The Overarching Policy identification is a foundational element of a Consent, and thus when the Overarching policy terms change, one can identify all Consents that were based on the prior Patient Privacy Policy Identifier. In some cases, such as jurisdictional rules backed by laws, the overarching policy may change, effectively changing the effect of the rules of a Consent based on that Overarching policy.

Security office should monitor the audit log for uses of break-glass, and follow up to confirm it was a legitimate use of break-glass per policy.

Security office should monitor audit log for access denied, and follow up to confirm that it was a legitimate denial of an access request. Possibly further investigating why the request was initiated.

<a name="other-grouping"> </a>

## XX.6 PCF Cross-Profile Considerations

**TODO Possibilities**

* MHDS - would explain how this is used vs the Consent method in MHDS
* QEDm / IPA 
  


The **Privacy Consent on FHIR (PCF)** builds upon a basic Identity and Authorization model of [Internet User Authorization (IUA)](https://profiles.ihe.net/ITI/IUA/index.html) to provide consent based access control. The Privacy Consent on FHIR is thus focused only on Access Control decisions regarding the parameters of the data subject (patient) privacy consent. The Privacy Consent on FHIR leverages these basic Identity and Authorization decisions as context setting for the authorization decision and enforcement. For example a user that would never be allowed access would be been denied access at the IUA level without invoking PCF, where as an authorized request then must be mediated by the PCF authorization server.

This is to say that PCF does not define:

- how one identifies the patient, this is the role of other Implementation Guides like PDQm, PIXm, PIMR, etc;
- how the patient experiences the ceremony of the consent act, this is systems design, user interface design, and policy language;
- how one asks for data or communicates data, this is the role of other Implementation Guides like MHD, QEDm, MHDS, etc;
- how one tags data with security/privacy sensitivity labels, this is the role of a systems design that might utilize a [Security labeling Service](ch-P.html#SLS); and
- how users or applications are identified and foundationally authorized, this is the role of other Implementation Guides like IUA, and OpenID-Connect.

But PCF enhances and relies upon these other Implementation Guides.

TODO: Likely need a diagram that is more human workflow focused?

<a name="actors-and-transactions"> </a>

## 53.1 PCF Actors, Transactions, and Content Modules

This section defines the actors and transactions in this implementation guide.

Figure below shows the actors directly
involved in the PCF
Profile and the relevant transactions between them.
Internet User Authorization ([IUA](https://profiles.ihe.net/ITI/IUA/index.html)) is shown as the PCF specific actors are reliant on IUA actors.

<figure>
{%include ActorsAndTransactions.svg%}
<figcaption><b>Figure 53.1-1: PCF Actor Diagram</b></figcaption>
</figure>
<br clear="all">

The actors participate in the following Transactions.

**Table 53.1-1: PCF Profile - Actors and Transactions**

| Actors                       | Transactions                      | Direction | Optionality | Reference      |
|------------------------------|-----------------------------------|-----------|-------------|----------------|
| [Consent Recorder](#consentRecorder)  | Access Consent                    | Initiator | R           | [ITI TF-2: 3.108](ITI-108.html) |
| [Consent Registry](#consentRegistry)  | Access Consent                    | Responder | R           | [ITI TF-2: 3.108](ITI-108.html) |
| [Consent Authorization Server](#consentAuthorizationServer) | Access Consent                    | Initiator | R           | [ITI TF-2: 3.108](ITI-108.html) |
| [Consent Enforcement Point](#consentEnforcementPoint) | none |  |  |  |
{: .grid}

The following is a repeat of the IUA Actors and Transactions for clarity. The PCF Implementation Guide places grouping requirements and behavior upon the IUA Actors relative to the grouped PCF Actors.

**Table 53.1-2: IUA Profile - Actors and Transactions**

| Actors                       | Transactions                      | Direction | Optionality | Reference      |
|------------------------------|-----------------------------------|-----------|-------------|----------------|
| [IUA: Authorization Client](https://profiles.ihe.net/ITI/IUA/index.html#34111-authorization-client)         | Get Access Token                  | Initiator | R           | [ITI TF-2: 3.71](other.html#updates-to-iti-71) |
|                              | Incorporate Access Token          | Initiator | R           | [ITI TF-2: 3.72](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) |
|                              | Get Authorization Server metadata | Initiator | R           | [ITI TF-2: 3.103](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) |
| [IUA: Authorization Server](https://profiles.ihe.net/ITI/IUA/index.html#34112-authorization-server)  | Get Access Token                  | Responder | R           | [ITI TF-2: 3.71](other.html#updates-to-iti-71) |
|                              | Introspect Token                  | Responder | R           | [ITI TF-2: 3.102](https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102) |
|                              | Get Authorization Server metadata | Responder | R           | [ITI TF-2: 3.103](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) |
| [IUA: Resource Server](https://profiles.ihe.net/ITI/IUA/index.html#34113-resource-server)    | Introspect Token                  | Initiator | R           | [ITI TF-2: 3.102](https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102) |
|                              | Incorporate Access Token          | Responder | R           | [ITI TF-2: 3.72](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) |
|                              | Get Authorization Server metadata | Initiator | R           | [ITI TF-2: 3.103](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) |
{: .grid}

### 53.1.1 Actors

The actors in this profile are described in more detail in the sections below.

<a name="consentRecorder"> </a>

#### 53.1.1.1 Consent Recorder

The **Consent Recorder** actor is responsible for the capturing of consent from the Patient given policies available. This actor is responsible for assuring that the Patient fully understood the terms of the Consent, and also assures that the Consent terms agreed to are acceptable to the organization responsible and the abilities of the **Consent Authorization Server** and **Consent Enforcement Point** Actors.

The **Consent Recorder** may utilize other resources to interact with the Patient, and to capture the evidence of the Consent ceremony. The interaction with the Patient can be a very complex system that utilizes applications, web user interface, and forms; but may also be a paper process that results in ink signatures on paperwork. The workflow leading up to the **Consent Recorder** may also use FHIR Resources such as a FHIR Questionnaire or a DocumentReference / Binary. Where a DocumentReference and Binary are used to capture the Consent ceremony, the preservation should utilize the [MHD](https://profiles.ihe.net/ITI/MHD) implementation guide.

FHIR Capability Statement for [Consent Recorder](CapabilityStatement-IHE.PCF.consentRecorder.html)

<a name="consentRegistry"> </a>

#### 53.1.1.2 Consent Registry

The **Consent Registry** actor holds Consent resources. This includes active, inactive, and expired Consents. The **Consent Registry** does not have special understanding of the Consent other than as a FHIR `Consent` Resource. It thus is not responsible for assuring that the Consent terms are acceptable or enforceable, this is the responsibility of the **Consent Recorder** Actor.

FHIR Capability Statement for [Consent Registry](CapabilityStatement-IHE.PCF.consentRegistry.html)

<a name="consentAuthorizationServer"> </a>

#### 53.1.1.3 Consent Authorization Server

The **Consent Authorization Server** actor makes authorization decisions based on a given access requested context (e.g. oAuth, query/operation parameters), organizational policies, and current active `Consent` resources. The **Consent Authorization Server** is often implemented utilizing other authorization services, taking input from the user identity (e.g. Open-ID-Connect), and application identity and authorization (e.g. IUA). These predicate authorizations provide the security context upon which the Privacy `Consent` constraints are applied. The result is an authorization token used to request access resources, and is used by the **Consent Enforcement Point** actor.

<a name="consentEnforcementPoint"> </a>

#### 53.1.1.4 Consent Enforcement Point

The **Consent Enforcement Point** actor enforces consent decisions made by the **Consent Authorization Server** actor. This includes deny, permit, and permit with filtering of results. The **Consent Enforcement Point** must be grouped with an **IUA Resource Server** and is invoked when the authorization token includes consent based rules to be enforced.

### 53.1.2 Transaction Descriptions

The transactions in this profile are summarized in the sections below.

#### 53.1.2.1 ITI-108 Access Consent transaction

This transaction is used to Create, Read, Update, Delete, and Search on Consent resources.

For more details see the detailed [Access Consent](ITI-108.html)

#### 53.1.2.2 implied enforcement

The **Consent Enforcement Point** is invoked by the **IUA Resource Server** when there is consent rules to be enforced. There is no externally defined transaction, however the **Consent Enforcement Point** indirectly gets the consent rules to be enforced from the **IUA Resource Server** implicitly learning the details of the token. How this is done, and how the enforcement is achieved is a Systems Design concern outside the scope of an Interoperability specification such as PCF.

<a name="actor-options"> </a>

## 53.2 PCF Actor Options

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

### 53.2.1 Implicit Option

The Implicit Policy Option indicates that there is a default policy that is used when there is no Consent found on file for a given patient. This Implicit Policy shall support the following "overarching" policies:

| canonical URI | Definition |
|---------------|----------- |
`https://profiles.ihe.net/ITI/PCF/Policy-basic-normal` | Permit for clinicians that have authorization for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users.
`https://profiles.ihe.net/ITI/PCF/Policy-all-normal` | Permit for all authorized uses. This presumes that basic user access control will only allow authorized users and purpose of use.
`https://profiles.ihe.net/ITI/PCF/Policy-break-glass-only` | Deny for all use, except when the user is a clinician with authorization to declare a medical patient-safety override (aka Break-Glass).
`https://profiles.ihe.net/ITI/PCF/Policy-deny` |  Deny all.
{: .grid}

Other overarching policies may also be implemented, but their behavior is not defined in PCF.

The operational environment chooses which of these policies they will use, so in operational use only one of these is in effect as the "implicit policy".

The definition of permitted use nor how break-glass is declared is defined here, but is a policy expectation of the environment and is expected to be configured into the IUA authorization decisions and enforcement.

Implicit Option has no ability to have Patient specific parameters. When Patient specific parameters are needed, then Explicit options are required.

When the Implicit Option is not declared to be implemented, then PCF expects "Deny all" overarching policy.

### 53.2.2 Explicit Basic Option

The Explicit Basic Option allows for patient specific consent to be recorded, and changed. This option sets the foundation for consents that expire, and consents that change based on organization and patient agreements. The lack of a consent for a given patient would be covered by the Implicit Option in place. 

Typically the Implicit Option is either a Deny All or a Permit all authorized uses. The Deny All sets the groundwork for an environment where Consent is required for any activity to happen (often called OPT-IN). The permit all authorized uses sets the groundwork for an environment where Consent can be used to refine or dissent (often called OPT-OUT). In all cases, once a Consent is recorded then the terms of the Consent override any Implicit policy.

The Explicit Basic Option indicates that there is support for a basic set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. The overarching policy that the patient and organization have agreed upon. An environment can use the overarching policies defined above, or define policies specific to your local needs. For example in an Implicit Deny All, the Explicit Consents might be based on the permit all authorized users policy.
2. The timeframe for which the consent applies. Enabling consents that have a time limit.
3. Who is permitted/denied: This may be a device, relatedPerson, Practitioner, or Organization. This parameter enables the naming of agents that should be allowed access or denied access. This presumes that the identified agent is appropriately identified (provisioned) and authorized to make the request; typically through some application authorization and role-based-access-control. The user identity is mapped to a FHIR agent type Resource using the agent type Resource `.identifier` element (e.g. Practitioner.identifier would hold the user id).
4. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explicably identified as an authorized purposeOfUse or denied purposeOfUse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Authorization Server is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, or Operations.

See [Basic Consent](content.html#basic) Content Profile

### 53.2.3 Explicit Intermediate options

The following Options shall be used in conjunction with **Explicit Basic Option**, and may be used with **Explicit Advanced Option**. The Intermediate Options can be implemented and/or used individually or combined. When combined within one parameter the logic provided by each option is combined. The data scoping intermediate options are not expected to be found combined on one parameter, but may be combined within a Consent providing different data scoping capability. For example: A consent that indicates that a data timeframe is used to deny insurance access, with a different parameter indicting that a data relationship is allowed access to a research project.

See [Intermediate Consent](content.html#intermediate) Content Profile

#### 53.2.3.1 Explicit Intermediate Data Timeframe Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a timeframe within which data authored or last updated.

#### 53.2.3.2 Explicit Intermediate Data by id Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a FHIR Resources by `.id` value.

#### 53.2.3.3 Explicit Intermediate Data Author Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of an indicated author. This option is useful when the consent provision is limiting access to data that was authorized by a given doctor.

#### 53.2.3.4 Explicit Intermediate Data Relationship Option

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of that data being related in a given way to a given identified data object. This option is useful for indicating a consent provision that is limiting/authorizing access to data that was created as part of an encounter, care plan, or episode of care.

#### 53.2.3.5 Explicit Intermediate Additional PurposeOfUse Option

This option provides for the Consent to have one or more permit/deny parameter that indicates a purposeOfUse that is not listed in the **Explicit Basic Option** vocabulary. This would tend to be used with Clinical Research projects, where the purposeOfUse is a code assigned to a specific Clinical Research Project. This may be used for other purposeOfUse codes. Where **Explicit Basic Option** has some well-known purposeOfUse codes, this option is used for other codes.

One specific use of this Option is to enable Break-Glass. Where the Consent can have a permission explicitly allowing the PurposeOfUse of Break-Glass (#BTG). In this case the Consent would have restrictions, that can be overridden by an authorized Break-Glass. The logic that determines that the given user is authorized, and has declared Break-Glass is out-of-scope of this implementation guide as it is very user-interface and policy specific. The encoding in the Consent, and the encoding in the Access Token is defined here.

### 53.2.4 Explicit Advanced Option

The Explicit Advanced Option indicates that there is support for an advanced set of patient specific parameters. The Advanced policies allow for Patient specific permit/deny parameters on sensitive health topics and requires the use of security tagged data. The security tagged data might be implemented using a [Security labeling Service](ch-P.html#SLS) that is not defined here; or other systems design. This option is required to support sensitive health topic segmentation such as substance abuse, mental health, sexuality and reproductive health, etc.

See [Advanced Consent](content.html#advanced) Content Profile

<a name="required-groupings"> </a>

## 53.3 PCF Required Actor Groupings

PCF leverages other IHE Profiles for critical functionality they provide. This includes [Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/index.html) to provide audit logging of these privacy and security sensitive access control activities, and [Internet User Authorization (IUA)](https://profiles.ihe.net/ITI/IUA/index.html) to provide the oAuth interaction pattern between clients that want to access protected resources and the needs to protect those resources.

### 53.3.1 Consent Recorder

The **Consent Recorder** shall be grouped with a BALP [Audit Creator](https://profiles.ihe.net/ITI/BALP/volume-1.html#152111-audit-creator), and shall record the [BALP RESTful activities](https://profiles.ihe.net/ITI/BALP/content.html#3573-restful-activities). Note that the BALP Audit Creator has details on required grouping with ATNA.

### 53.3.1 Consent Registry

The **Consent Registry** shall be grouped with a BALP [Audit Creator](https://profiles.ihe.net/ITI/BALP/volume-1.html#152111-audit-creator), and shall record the [Consent Authorization Decision Audit Message](https://profiles.ihe.net/ITI/BALP/content.html#3576-consent-authorized-decision-audit-message).  Note that the BALP Audit Creator has details on required grouping with ATNA.

### 53.3.1 Consent Authorization Server

The **Consent Authorization Server** shall be grouped with an IUA: **Authorization Server**. The IUA **Authorization Server** takes care of the IUA transactions and invokes the **Consent Authorization Server** when a request for a token, that would be impacted by a Patient Privacy Consent, is requested.

The IUA Authorization Server shall implement the **JWT Token**, **Token Introspection** and **Authorization Server Metadata** options. There is no use of the IUA Authorization Server **SAML Token** option.

Note that PCF [adds requirements to the ITI-71](other.html#updates-to-iti-71) transaction to carry in the token extensions informed from the consents. These oAuth extensions affect JWT encoding and response from use of the Introspect Token Transaction.

The **Consent Authorization Server** shall be grouped with a BALP [Audit Creator](https://profiles.ihe.net/ITI/BALP/volume-1.html#152111-audit-creator), and shall record the [BALP RESTful activities](https://profiles.ihe.net/ITI/BALP/content.html#3573-restful-activities). Note that the BALP Audit Creator has details on required grouping with ATNA.

### 53.3.2 Consent Enforcement Point

The **Consent Enforcement Point** shall be grouped with an IUA: **Resource Server**.  The IUA **Resource Server** takes care of the IUA transactions and invokes the **Consent Enforcement Point** when a token includes enforcement rules informed by Patient Privacy Consent. 

The IUA Resouce Server shall implement the **JWT Token**, **Token Introspection** and **Authorization Server Metadata** options. There is no use of the IUA Authorization Server **SAML Token** option.

Note that PCF [adds requirements to the ITI-71](other.html#updates-to-iti-71) transaction to carry in the token extensions informed from the consents. These oAuth extensions affect JWT encoding and response from use of the Introspect Token Transaction.

The **Consent Enforcement Point** shall be grouped with a BALP [Audit Creator](https://profiles.ihe.net/ITI/BALP/volume-1.html#152111-audit-creator), and shall record the [BALP RESTful activities](https://profiles.ihe.net/ITI/BALP/content.html#3573-restful-activities). Note that the BALP Audit Creator has details on required grouping with ATNA. Only one BALP RESTful activity AuditEvent needs to be recorded within the Grouped Server.

<a name="overview"> </a>

## 53.4 PCF Overview

The PCF Profile enables authorized access to data according to terms agreed by the Patient and the Organization protecting the data. These terms represent Privacy controls on the use of the data. The Privacy controls augment an overarching policy upon which these Privacy controls build. The writing of overarching policies, and the act of informing the patient and capturing their agreement is a predicate to the use-cases of the PCF.

### 53.4.1 Concepts

Consent is is a patient specific set of parameters that work within an overarching policy. For a discussion of policy, consent policy, and other concepts see [Appendix P: Privacy Access Policies](ch-P.html). The concepts outlined in [Appendix P: Privacy Access Policies](ch-P.html) are critical to understanding this implementation guide.

### 53.4.2 Use Cases

PCF defines some transactions and some content. The content specifications define the variations on Consent that are used to enable consent parameters. The transactions utilize these content and carry out the privacy protection defined within a patient specific consent.

#### 53.4.2.1 Use Case \#1: Capture new consent

When a patient does not have a consent on file, and there is a need to capture consent, the Capture New Consent usecase is used to record the details of the Consent ceremony.

##### 53.4.2.1.1 Capture New Consent Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is no consent on file for a given Patient
When they present their Patient Privacy Policies to a given Patient
And the Patient either agrees, disagrees, or adds acceptable parameters
Then a Consent is captured by the **Consent Recorder** actor and stored in the **Consent Registry**

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.

##### 53.4.2.1.2 Capture New Consent Process Flow

The following flow shows the activities involved in the Capture new Consent flow.

<figure>
{%include usecase1-processflow.svg%}
<figcaption><b>Figure 53.4.2.1-1: Capture new Consent</b></figcaption>
</figure>
<br clear="all">

The diagrammed steps:

1. Query for existing Consent. This step may not be necessary but is important to establish the Capture New Consent use-case from the Update Existing Consent use-case.
2. None is found. Given that no existing Consent exists, there are no preconditions, just default expectations for the workflow.
3. Consult with the Patient. There is some interaction with the Patient. Within this interaction the patient needs to be appropriately informed of the details of the Patient Privacy Policy and the parameters the patient can control. This user Interface might use a FHIR Questionnaire resulting in a QuestionnaireResult as documentation of the ceremony. This User Interface might use some other technical means, or might be a paper process.  This User Interface is not constrained by the PCF.
4. The results of the ceremony are captured to the satisfaction of the controlling Organization.  This might be a QuestionnaireResponse, or a scanned image of the signed paperwork recorded using a DocumentReference (See [MHD](https://profiles.ihe.net/ITI/MHD/index.html))
5. The Consent resource constrained by the Consent constraints defined in Volume 3 is then saved to the **Consent Registry** actor using Transaction [ITI-108].
6. An [AuditEvent is recorded](https://profiles.ihe.net/ITI/BALP/index.html) by both **Consent Recorder** and **Consent Registry** actors to support [Security and Privacy audit analysis use-cases](https://profiles.ihe.net/ITI/BALP/volume-1.html#1524-basicaudit-overview).

#### 53.4.2.2 Use Case \#2: Update Existing Consent

When a patient has an existing consent on file, and there is a need to capture a new consent. The Update Existing Consent usecase is used to record the details of the new Consent ceremony and assure that the previous consent is no longer used.

##### 53.4.2.2.1 Update Existing Consent Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is a consent on file for a given Patient
When they present their Patient Privacy Policies to a given Patient
And the Patient either agrees, disagrees, or adds acceptable parameters
Then a Consent is captured by the **Consent Recorder** actor and stored in the **Consent Registry**
And the new Consent overwrites or invalidates the previous Consent

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.

##### 53.4.2.2.2 Update Existing Consent Process Flow

The following flow shows the activities involved in the Update Existing Consent flow.

<figure>
{%include usecase2-processflow.svg%}
<figcaption><b>Figure 53.4.2.2-1: Update Existing Consent Flow</b></figcaption>
</figure>
<br clear="all">

The diagrammed steps:

1. Query for existing Consent. This step may not be necessary but is important to establish the Capture New Consent use-case from the Update Existing Consent use-case. This step is also useful to retrieve the current Consent parameters so that the User Interface can start with appropriate settings informed by the past.
2. A Consent is found. More than one Consent may be found, for which the PCF does not address how to address this case. The overarching policy would need to be consulted.
3. Consult with the Patient. There is some interaction with the Patient. Within this interaction the patient needs to be appropriately informed of the details of the Patient Privacy Policy and the parameters the patient can control. This user Interface might use a FHIR Questionnaire resulting in a QuestionnaireResult as documentation of the ceremony. This User Interface might use some other technical means, or might be a paper process.  This User Interface is not constrained by the PCF.
4. The results of the ceremony are captured to the satisfaction of the controlling Organization.  This might be a QuestionnaireResponse, or a scanned image of the signed paperwork recorded using a DocumentReference (See [MHD](https://profiles.ihe.net/ITI/MHD/index.html))
5. The Consent resource constrained by the Consent constraints defined in Volume 3 is then saved to the **Consent Registry** actor using Transaction [ITI-108]. This is typically a FHIR Update action so as to replace the previous Consent. It is also possible to delete the previous and save the Consent as a new instance.
6. An [AuditEvent is recorded](https://profiles.ihe.net/ITI/BALP/index.html) by both **Consent Recorder** and **Consent Registry** actors to support [Security and Privacy audit analysis use-cases](https://profiles.ihe.net/ITI/BALP/volume-1.html#1524-basicaudit-overview).

#### 53.4.2.3 Use Case \#3: Consent Access Control

Given that an application needs access to resources, the following use-case assures that any data made available is authorized by the Consent. Note that this use-case presumes that business rules and security access control are incorporated into either the foundational oAuth flow, or some other process outside of this flow.

##### 53.4.2.3.1 Consent Access Control Use Case Description

Given an Organization controlling some Patient identifiable Data 
And they have written and published Patient Privacy Policies
And there is a consent on file for a given Patient
When a request for patient identifiable data is made
Then the Consents are used by the **Consent Authorization Server** actor as stored in the **Consent Registry** to make Access Control Decisions
And the **Consent Enforcement Point** assures that only data authorized by the Consent Access Control Decision are allowed to be exposed.

The Consent details are specific to the Patient Privacy Policy, the parameters agreed to in the ceremony, and the Consent profile (Basic, Intermediate, Advance) that was used.

##### 53.4.2.3.2 Consent Access Control Process Flow

The following flow shows the activities involved in the Consent Access Control flow.

<figure>
{%include usecase3-processflow.svg%}
<figcaption><b>Figure 53.4.2.3-1: Consent Access Control Flow</b></figcaption>
</figure>
<br clear="all">

The diagrammed steps:

1. a **IUA Authorization Client** actor, an abstraction of an app and possibly a user, requests an Access Token of the **IUA Authorization Server** actor with some defined patient, user, app, and data parameters. This is the access request context that the **Consent Authorization Server** will make Consent Access Control Decisions upon.
2. The **IUA Authorization Server** gets user identity information, if available. Such using one or more Open-ID Connect authority. Adding any details to the access request context --> Note that failure to identify a user may be a failure-mode.
3. The **IUA Authorization Server** invokes the **Consent Authorization Server** passing any predicate access token, if available. Adding any details to the access request context --> Note that failure to get an authorization token may be a failure-mode.
4. The **Consent Authorization Server** looks for Patient Consents at the **Consent Registry** actor(s). The access request context may be used to limit the Consent resources returned.
5. The **Consent Authorization Server** receives the available consents. --> Note that failure to get a consent means that the default Implicit policy that is active is enforced.
6. The **Consent Authorization Server** determines the best match or matches of Consents returned to the access control request context (patient, user, app, purposeOfUse, data parameters, etc).
7. The **Consent Authorization Server** makes the Access Control Decision based on the Consents
8. The **Consent Authorization Server** provides the consent decisions to the **IUA Authorization Server**
9. The **IUA Authorization Server** combines the Consent Access Control Decision with the decisions returned in step 2 and 3
10. The **IUA Authorization Server** encodes the combined Access Control Decision into an oAuth token. This is typically just associating the conditions of the Access Control Decision with the opaque oAuth token returned such that later in step 13 the ITI-102 transaction can be used to get the details. This combined Access Control decision indicates what is permitted, denied and any obligations or refrains that must be applied.
11. The **IUA Authorization Server** returns this combined token to the **IUA Authorization Client**. --> Note that failure-modes will not return a success token but rather an access denied.
12. The **IUA Authorization Client** encapsulates the given oAuth token, using ITI-72, to indicate the authorization given where the grouped transaction is as defined by the data access implementation guide that is grouped. Meaning the transaction is otherwise as defined elsewhere. The **IUA Resource Server** receives the ITI-72 and extracts the oAuth token.
13. The **IUA Resource Server** may request introspection using [ITI-102].
14. The **IUA Authorization Server** includes details from the **Consent Authorization Server** decision.
15. The **IUA Authorization Server** returns the token details. ITI-102 is augmented here to communicates the Consent Access Control decision details.
16. The **IUA Resource Server** calls upon the **Consent Enforcement Point** to enforce the token. The **Consent Enforcement Point** may be able to enforce some of the Consent Access Control prior to retrieving the data requested. Such as where the Consent Access Control decision would forbid a kind of FHIR Resource.
17. The **Consent Enforcement Point** would use undefined means to retrieve the requested data from the FHIR Server. This may be by executing the grouped transaction with privileged access.
18. The **Consent Enforcement Point** would inspect the results and further enforce the Consent Access Control decision. This might be to filter out specific resources that could not have been filtered out other ways.
19. The **IUA Resource Server** returns the authorized data to the **IUA Authorization Client** actor.

Not shown, for simplicity of the diagram, is the recording [AuditEvent](https://profiles.ihe.net/ITI/BALP/index.html) by all actors to support [Security and Privacy audit analysis use-cases](https://profiles.ihe.net/ITI/BALP/volume-1.html#1524-basicaudit-overview).

#### 53.4.2.4 Implicit Content

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

##### 53.4.2.4.1 Permit Clinical Treatment

Permit for clinicians that have authorization for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users and legitimate clinical purpose.

**Pre-conditions**:

The controlling Organization has identified Clinical roles that would have access for Treatment, and has mechanisms in place to prevent any inappropriate use.

**Main Flow**:

- Business Access Control prevents inappropriate users, applications, purposes, and activities. Allowing only Clinical users access under Treatment purpose.
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access, thus clinical users get access for clinical treatment need.

##### 53.4.2.4.2 Permit all Authorized

Permit for all authorized users. This presumes that basic user access control will only allow authorized users and for authorized purpose of use.

**Pre-conditions**:

The controlling Organization has identified various roles that would have access for given purpose, and has mechanisms in place to prevent any in appropriate use. This is distinct from the previous use-case in that the roles and purpose are not limited to Clinical and Treatment.

**Main Flow**:

- Business Access Control prevents inappropriate users, applications, purposes, and activities.
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access.

##### 53.4.2.4.3 Deny All

Deny for all uses without exceptions. This is an unusual setting for a purely Implicit consent environment, but is intended to be paired with an Explicit consent. When paired with an Explicit consent, the **Deny All** functions as the default policy when no explicit consent is on record. This might also be used on a system that is designed simply to record data with no access to that data (e.g., an Audit log repository).

**Pre-conditions**:

The controlling Organization has controls in place to prevent all access.

**Main Flow**:

- Business Access Control prevents all access by any users, applications, purposes, and activities.
- There is no Access Control use of the Consent resource

**Post-conditions**:

Business Access Controls control appropriate access.

#### 53.4.2.5 Basic Consent Content

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
4. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explicably identified as an authorized purposeOfUse or denied purposeOfuse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Authorization Server is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, and Operations.

#### 53.4.2.6 Intermediate Consent Contents

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

##### 53.4.2.6.1 Intermediate Data Timeframe Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a timeframe within which data authored or last updated.

The use-case would be where a patient knows that there was a period of time where they received care, and for which the patient indicates they want to segment out that data for permit or deny. The user interface is not defined here or constrained.

##### 53.4.2.6.2 Intermediate Data by id Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates a FHIR Resources by `.id` value.

The use-case would be where a patient knows specific data artifacts for which the patient indicates they want to segment those data for permit or deny. The user interface is not defined here or constrained.

##### 53.4.2.6.3 Intermediate Data Author Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of an indicated author. This option is useful when the consent provision is limiting access to data that was authorized by a given doctor.

The use-case would be where a patient knows that there is an author (organization or practitioner), and for which the patient indicates they want to segment out that data for permit or deny. Note that this capability is dependent on the data be properly attributed to the author. The user interface is not defined here or constrained.

##### 53.4.2.6.4 Intermediate Data Relationship Content

This data scoping option provides for the Consent to have one or more permit/deny parameter that indicates data subject to the rule by way of that data being related in a given way to a given identified data object. This option is useful for indicating a consent provision that is limiting/authorizing access to data that was created as part of an encounter, care plan, or episode of care.

The use-case would be where a patient knows that there is an encounter, care plan, or episode of care that can be used to identify data for which the patient indicates they want to segment out that data for permit or deny. Note that this capability is dependent on the data be properly attributed to the encounter, care plan, or episode of care. The user interface is not defined here or constrained.

##### 53.4.2.6.5 Intermediate Additional PurposeOfUse Content

This option provides for the Consent to have one or more permit/deny parameter that indicates a purposeOfUse that is not listed in the **Basic Consent** vocabulary. This would tend to be used with Clinical Research projects, where the purposeOfUse is a code assigned to a specific Clinical Research Project. This may be used for other purposeOfUse codes. Where **Basic Consent** has some well-known purposeOfUse codes, this option is used for other codes.

The use-case would be where a patient is authorizing purposeOfUse beyond those defined in the **Basic Consent**. An example would be a Privacy Consent to allow an identified clinical research project to have access to the patient data.

This would also be used to indicate that the Consent has provisions enabling Break-Glass using the PurposeOfUse for Break-Glass (BTG). The Consent and Access Token encodings are defined, but the rules of who is authorized and how they declare Break-Glass are not defined as they are dependent on User-Interface, User-Experience, and Policy.

#### 53.4.2.7 Advanced Consent Content

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

## 53.5 PCF Security Considerations

See ITI TF-2x: [Appendix Z.8 “Mobile Security Considerations”](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations)

A change to [any policy](ch-P.html) need to be carefully managed, especially the [Domain Privacy Policy / Overarching Policy](ch-P.html). A change to Overarching Policy may have no impact on the Consent, or may invalidate all Consents. The Overarching Policy identification is a foundational element of a Consent, and thus when the Overarching policy terms change, one can identify all Consents that were based on the prior **Patient Privacy Policy Identifier**. In some cases, such as jurisdictional rules backed by laws, the Overarching Policy may change, effectively changing the effect of the rules of a Consent based on that Overarching Policy.

Security and Privacy office should use the [BALP profiled AuditEvent](https://profiles.ihe.net/ITI/BALP/index.html) to track changes and uses of the Consent resources. The AuditEvent is required of [PCF when grouped with ATNA](ITI-108.html#2310851-security-audit-considerations). The Provenance resource recording is not required of PCF as the use-case need would be satisfied by the AuditEvent record. However an implementation may choose to use Provenance on Create/Update/Delete in addition to AuditEvent. Examples of [a Provenance of create](Provenance-ex-provenance-consent-basic-treat.html) and [a Provenance of update](Provenance-ex-provenance2-consent-basic-treat.html) are provided. The use of Provenance is discussed in [Appendix P.4.3](ch-P.html#p43-change-to-deny-sharing)

Security office should monitor the audit log for uses of break-glass, and follow up to confirm it was a legitimate use of break-glass per policy.

Security office should monitor audit log for access denied, and follow up to confirm that it was a legitimate denial of an access request. Possibly further investigating why the request was initiated.

<a name="other-grouping"> </a>

## 53.6 PCF Cross-Profile Considerations

This implementation guide is expected to be used in conjunction with other implementation guide (Profiles) that provide access to Patient specific data such as [Mobile Health Document Sharing (MHDS)](https://profiles.ihe.net/ITI/MHDS/index.html) or the [PCC](https://profiles.ihe.net/PCC/index.html) Query for Existing Data for Mobile (QEDm). These other implementation guides would have their [appropriate Actors grouped such as is shown in Figure 53.1-1](volume-1.html#531-pcf-actors-transactions-and-content-modules) as "Grouped Client" and "Grouped Server".

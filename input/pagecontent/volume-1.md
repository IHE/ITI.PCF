
Supports Patient Privacy Consents in HIE scope. The Privacy Consent on FHIR builds upon a basic Identity and Authorization model such as IUA or SMART-on-FHIR to provide basic access control. The Privacy Consents on FHIR is thus focused only on Access Control decisions regarding the parameters of the data subject (patient) privacy consent. The Privacy Consents on FHIR leverages these basic Identity and Authorization decisions as context setting for the request, using a cascading authorization model. For example a user that would never be allowed access, would have been denied access at this level.

TODO: Need help explaining cascading oauth. I seem to recall that to the client this looks just like normal oAuth, but at the Authorization Service it may call out to predicate authorization decisions like Open-ID-Connect. Thus there might be the Consent Authorization -> RBAC Authorization -> Open-ID-Connect. But I am not sure...

TODO: Overall parameters: timeframe of the consent, delegate, etc...

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

Actors and transactions are used to achieve these use-cases...

<div>
{%include usecase1-processflow.svg%}
</div>
<br clear="all">

**Figure: Use Case 1 Create New Consent Flow**

<div>
{%include usecase2-processflow.svg%}
</div>
<br clear="all">

**Figure: Use Case 2 Update Consent Flow**

<div>
{%include usecase3-processflow.svg%}
</div>
<br clear="all">

**Figure: Use Case 3 Enforce Consent Flow**

TODO: not sure how to model the Consent Decider / Consent Enforcement


**Table XX.1-1: PCF Profile - Actors and Transactions**

| Actors              | Transactions     | Direction | Optionality | Reference      |
|---------------------|------------------|-----------|-------------|----------------|
| Consent Capture     | Access Consent   | Initiator | R           | ITI TF-2: 3.Y1 |
| Consent Registry    | Access Consent   | Responder | R           | ITI TF-2: 3.Y1 |
| Consent Decider     | Access Consent   | Initiator | R           | ITI TF-2: 3.Y1 |
|                     | Authorize Access | Responder | R           | ITI TF-2: 3.Y2 |
| Consent Enforcement | Authorize Access | Responder | R           | ITI TF-2: 3.Y2 |
{: .grid}


### XX.1.1 Actors
The actors in this profile are described in more detail in the sections below.

#### XX.1.1.1 Consent Capture <a name="consentcapture"> </a>

The **Consent Capture** actor is responsible for the capturing of consent from the Patient given policies available. This actor is responsible for assuring that the Patient fully understood the terms of the Consent, and also assures that the Consent terms agreed to are acceptable to the organization responsible and the abilities of the **Consent Authorization Server** and **Consent Enforcement Resource Server** Actors.

The **Consent Capture** may utalize other resources to interact with the Patient, and to capture the evidence of the Consent ceremony. Such as use of a FHIR Questionnaire or a DocumentReference / Binary. Where a DocumentReference and Binary are used to capture the Consent ceremony, the preservation should utalize the [MHD](https://profiles.ihe.net/ITI/MHD) implementation guide.

FHIR Capability Statement for [Consent Capture](CapabilityStatement-IHE.PCF.capture.html)

#### XX.1.1.2 Consent Registry <a name="consentregistry"> </a>

The **Consent Registry** actor holds Consent resources. This includes active, inactive, and expired Consents. The **Consent Registry** does not have special understanding of the Consent other than as a FHIR `Consent` Resource. It thus is not responsible for assuring that the Consent terms are acceptable or enforceable, this is the responsibility of the **Consent Capture** Actor.

FHIR Capability Statement for [Consent Registry](CapabilityStatement-IHE.PCF.registry.html)

#### XX.1.1.3 Consent Authorization Client <a name="consentclient"> </a>

The **Consent Authorization Client** actor makes use of the **Consent Authorization Server** to get authorization token to use with FHIR REST and Operation requests made to a Resource Server by way of the **Consent Enforcement Resource Server**.

#### XX.1.1.4 Consent Authorization Server <a name="consentdecision"> </a>

The **Consent Authorization Server** actor makes authorization decisions based on a given access requested context (e.g. oAuth), organizational policies, and current active `Consent` resources. The Consent Decider is often implemented utalizing other authorization services, taking input from the user identity (e.g. Open-ID-Connect), and application identity and authorization (e.g. IUA). These predicate authorizations provide the security context upon which the Privacy `Consent` constraints are applied. The result is an authorization token used to request access resources, and is used by the **Consent Enforcement Resource Server** actor.

FHIR Capability Statement for [Consent Authorization Server](CapabilityStatement-IHE.PCF.decider.html)

#### XX.1.1.5 Consent Enforcement Resource Server <a name="consentenforce"> </a>

The **Consent Enforcement Resource Server** actor enforces consent decisions made by the **Consent Authorizatino Server** actor. This includes deny, permit, and permit with filtering of results.

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

| Actor               | Option Name |
|---------------------|-------------|
| Consent Capture     | Implicit  |
| Consent Capture     | Explicit Basic |
| Consent Capture     | Explicit Intermediate |
| Consent Capture     | Explicit Advanced |
| Consent Registry    | none |
| Consent Decider     | Implicit  |
| Consent Decider     | Explicit Basic |
| Consent Decider     | Explicit Intermediate |
| Consent Decider     | Explicit Advanced |
| Consent Enforcement | Implicit  |
| Consent Enforcement | Explicit Basic |
| Consent Enforcement | Explicit Intermediate |
| Consent Enforcement | Explicit Advanced |
{: .grid}

There are three levels of maturity in incrementally more difficult to implement defined:
Support for these Basic, Intermediate, and Advanced policies is support for the ability to provide these capabilties. The actual policy provided to the Patient would be some subset of this support that the data custodian is willing to enforce.

The Privacy Consent on FHIR builds upon a basic Identity and Authorization model such as IUA or SMART-on-FHIR to provide basic access control. The Privacy Consents on FHIR is thus focused only on Access Control decisions regarding the parameters of the data subject (patient) privacy consent.

### XX.2.1 Implicit Option

The Implicit Policy Option indicates that there is a default policy that is used when there is no Consent found on file. This Implicit Policy shall support the following policies:

1. Permit for authorized clinicians to have access for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users.
2. Permit for all authorized users. This presumes that basic user access control will only allow authorized users and purpose of use.
3. Deny for all authorized users, except when the user is a clinician with authorization to declare a medical patient-safety override (aka Break-Glass).
4. Deny all.

Implicit Option has no ability to have Patient specific parameters. When Patient specific parameters are needed, then Explicit options are required.

Note that the patient accessing their own records is not a Consent consideration, but Explicit Basic Option may be useful to enable use-cases where the patient themselves should be denied access, or where a delegate are to be permitted some access.

When the Implicit Option is not declared to be implemented, then default Deny all requests is presumed.

### XX.2.2 Explicit Basic Option

The Explicit Basic Option indicates that there is support for a basic set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. Who is permitted/denied: This may be a device, relatedPerson, Practitioner, or Organization. This parameter enables the naming of agents that should be allowed access or denied access. This presumes that the identified agent is appropriately identified (provisioned) and authorized to make the request; typically through some application authorization and role-based-access-control (see cascased oAuth). The user identity is mapped to a FHIR agent type Resource using the agent type Resource `.identifier` element (e.g. Practitioner.identifier would hold the user id).
2. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explitally identified as an authorized purposeOfUse or denied purposeOfuse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Decider is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, Operations, and Break-Glass
3. Timeframe within which data authored or last updated.
4. Explicit FHIR Resources can be identified using their `.id` value.

See [Basic Consent](ITI-Z1.html) Content Profile

### XX.2.3 Explicit Intermediate Option

The Explicit Intermediate Option indicates that there is support for an intermediate set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. Named Research projects
2. Specific author of data 
3. data relationship to explicit data object permitted/denied (e.g. data involved in a given Encounter, or CarePlan)

See [Intermediate Consent](ITI-Z2.html) Content Profile

### XX.2.4 Explicit Advanced Option

The Explicit Advanced Option indicates that there is support for an advanced set of patient specific parameters. The Advanced policies allow for Patient specific permit/deny parameters on sensitive health topics and requires the use of a **Security Labeling Service** that is not defined here. This is required to support sensitive health topic segmentation such as substance abuse, mental health, sexuality and reproductive health, etc.

See [Advanced Consent](ITI-Z3.html) Content Profile

## XX.3 PCF Required Actor Groupings <a name="required-groupings"> </a>

**TODO Describe any requirements for actors in this profile to be grouped
with other actors. Possibilities**
* ATNA because Audit Logging is so critical to Privacy
* IUA or SMART? or is this not manditory, so would be later in XX.6?

## XX.4 PCF Overview <a name="overview"> </a>

**TODO: Move the use-cases here**

This section shows how the transactions/content modules of the profile
are combined to address the use cases.

Use cases are informative, not normative, and “SHALL” language is
not allowed in use cases.

### XX.4.1 Concepts

If needed, this section provides an overview of the concepts that
provide necessary background for understanding the profile. If not
needed, state “Not applicable.” For an example of why/how this section
may be needed, please see ITI Cross Enterprise Workflow (XDW).

It may be useful in this section but is not necessary, to provide a
short list of the use cases described below and explain why they are
different.

### XX.4.2 Use Cases

#### XX.4.2.1 Use Case \#1: simple name

One or two sentence simple description of this particular use
case.

Note that Section XX.4.2.1 repeats in its entirety for additional use
cases (replicate as Section XX.4.2.2, XX.4.2.3, etc.).

##### XX.4.2.1.1 simple name Use Case Description

Describe the key use cases addressed by the profile. Limit to a
maximum of one page of text or consider an appendix.

##### XX.4.2.1.2 simple name Process Flow

Diagram and describe the process flow(s) covered by this profile in
order to satisfy the use cases. Demonstrate how the profile transactions
are combined/sequenced. To provide context and demonstrate how the
profile interacts with other profiles, feel free to include transactions
and events that are “external” to this profile (using appropriate
notation.)

The set of process flows will typically be exemplary, not exhaustive
(i.e., it will address all the use cases, but will not show all possible
combinations of actors, or all possible sequencing of transactions).

If there are detailed behavioral rules that apply to a specific process
flow or multiple process flows, an appendix may be added as needed.

The roles at the top of the swimlane diagram should correspond to
actor names, include the profile acronym:actor name if referencing an
actor from a different profile.

Modify the following “Swimlane Diagram”.

<div>
{%include usecase1-processflow.svg%}
</div>
<br clear="all">

Figure XX.4.2.2-1: Basic Process Flow in Profile Acronym Profile

If process flow “swimlane” diagrams require additional explanation
to clarify conditional flows, or flow variations need to be described
where alternate systems may be playing different actor roles, document
those conditional flows here.

Delete the material below if this is a workflow or transport
profile. Delete the material above if this profile is a content module
only profile.

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

**TODO**

See ITI TF-2x: [Appendix Z.8 “Mobile Security Considerations”](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations)


## XX.6 PCF Cross-Profile Considerations <a name="other-grouping"> </a>

**TODO Possibilities**
* MHDS - would explain how this is used vs the Consent method in MHDS
* QEDm / IPA 
  

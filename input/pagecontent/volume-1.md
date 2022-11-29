
Supports Patient Privacy Consents in HIE scope. The Privacy Consent on FHIR builds upon a basic Identity and Authorization model such as IUA or SMART-on-FHIR to provide basic access control. The Privacy Consents on FHIR is thus focused only on Access Control decisions regarding the parameters of the data subject (patient) privacy consent. The Privacy Consents on FHIR leverages these basic Identity and Authorization decisions as context setting for the request, using a cascading authorization model. For example a user that would never be allowed access, would have been denied access at this level.

TODO: Need help explaining cascading oauth. I seem to recall that to the client this looks just like normal oAuth, but at the Authorization Service it may call out to predicate authorization decisions like Open-ID-Connect. Thus there might be the Consent Authorization -> RBAC Authorization -> Open-ID-Connect. But I am not sure...

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

The Consent Capture actor is responsible for the capturing of consent from the Patient given policies available. This actor is responsible for assuring that the Patient fully understood the terms of the Consent, and also assures that the Consent terms agreed to are acceptable to the organization responsible and the abilities of the Consent Decider and Consent Enforcement Actors.

The Consent Capture may utalize other resources to interact with the Patient, and to capture the evidence of the Consent ceremony. Such as use of a FHIR Questionnaire or a DocumentReference / Binary. Where a DocumentReference and Binary are used to capture the Consent ceremony, the preservation should utalize the [MHD](https://profiles.ihe.net/ITI/MHD) implementation guide.

FHIR Capability Statement for [Consent Capture]{CapabilityStatement-IHE.PCF.capture.html}

#### XX.1.1.2 Consent Registry <a name="consentregistry"> </a>

The Consent Registry actor holds Consent resources. This includes active, inactive, and expired Consents. The Consent Registry does not have special understanding of the Consent other than as a FHIR Consent Resource. It thus is not responsible for assuring that the Consent terms are acceptable or enforceable, this is the responsibility of the Consent Capture Actor.

FHIR Capability Statement for [Consent Registry](CapabilityStatement-IHE.PCF.registry.html)

#### XX.1.1.2 Consent Decider <a name="consentdecider"> </a>

The Consent Decider actor makes authorization decisions based on a given access requested context (e.g. oAuth), organizational policies, and current active Consent resources. The Consent Decider is often implemented as a cascaded oAuth, taking input from the user identity (e.g. Open-ID-Connect), and application identity and authorization (e.g. client token). These cascaded oAuth provide the security context upon which the Privacy Consent constraints are applied. The result of the cascade oAuth is a token used to request access resources, and is used by the Consent Enforcement actor.

FHIR Capability Statement for [Consent Decider](CapabilityStatement-IHE.PCF.decider.html)

#### XX.1.1.2 Consent Enforcement <a name="consentenforce"> </a>

The Consent Enforcement actor enforces consent decisions made by the Consent Decider actor. This includes deny, permit, and permit with filtering of results.

FHIR Capability Statement for [Consent Enforce](CapabilityStatement-IHE.PCF.enforce.html)

### XX.1.2 Transaction Descriptions
The transactions in this profile are summarized in the sections below.

#### XX.1.2.1 ITI-Y1 Access Consent transaction

This transaction is used to Create, Read, Update, Delete, and Search on Consent resources.

For more details see the detailed [Access Consent](ITI-Y1.html)

#### XX.1.2.2 ITI-Y2 Request for Consent Authorization transaction

This transaction is used to request an authorization decision based on Consents.

For more details see the detailed [Request for Consent Authorization](ITI-Y2.html)

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

#### XX.2.1 Implicit Option

The Implicit Policy Option indicates that there is a default policy that is used when there is no Consent found on file. This Implicit Policy shall support the following policies:

1. Permit for authorized clinicians to have access for Treatment use, but does not authorize other access. This presumes that basic user access control can differentiate legitimate clinical users.
2. Permit for all authorized users. This presumes that basic user access control will only allow authorized users and purpose of use.
3. Deny for all authorized users, except when the user is a clinician with authorization to declare a medical patient-safety override (aka Break-Glass).
4. Deny all.

Implicit Option has no ability to have Patient specific parameters. When Patient specific parameters are needed, then Explicit options are required.

Note that the patient accessing their own records is not a Consent consideration, but Explicit Basic Option may be useful to enable use-cases where the patient themselves should be denied access, or where a delegate are to be permitted some access.

When the Implicit Option is not declared to be implemented, then default Deny all requests is presumed.

#### XX.2.2 Explicit Basic Option

The Explicit Basic Option indicates that there is support for a basic set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. Who is permitted/denied: This may be a device, relatedPerson, Practitioner, or Organization. This parameter enables the naming of agents that should be allowed access or denied access. This presumes that the identified agent is appropriately identified (provisioned) and authorized to make the request; typically through some application authorization and role-based-access-control (see cascased oAuth). The user identity is mapped to a FHIR agent type Resource using the agent type Resource `.identifier` element (e.g. Practitioner.identifier would hold the user id).
2. Purpose of use permitted/denied: There are a number of PurposeOfUse that are available to be explitally identified as an authorized purposeOfUse or denied purposeOfuse. This presumes that the requesting user has the authorization to request for the requested purposeOfUse. That is to say that the Consent Decider is not determining if the user/client is authorized to make the purposeOfUse declaration, this must be previously decided by the security context (see cascaded oAuth) --  Treatment, Payment, Operations, and Break-Glass
3. Timeframe within which data authored or last updated.
4. Explicit FHIR Resources can be identified using their `.id` value.

#### XX.2.3 Explicit Intermediate Option

The Explicit Intermediate Option indicates that there is support for an intermediate set of patient specific parameters. The following set of patient specific parameters may be used to permit or deny:

1. Named Research projects
2. Specific author of data 
3. data relationship to explicit data object permitted/denied (e.g. data involved in a given Encounter, or CarePlan)

#### XX.2.4 Explicit Advanced Option

The Explicit Advanced Option indicates that there is support for an advanced set of patient specific parameters. The Advanced policies allow for Patient specific permit/deny parameters on sensitive health topics and requires the use of a **Security Labeling Service** that is not defined here. This is required to support sensitive health topic segmentation such as substance abuse, mental health, sexuality and reproductive health, etc.

## XX.3 FooBar Required Actor Groupings <a name="required-groupings"> </a>

TODO

*Describe any requirements for actors in this profile to be grouped
with other actors.*

*This section specifies all REQUIRED Actor Groupings (although
“required” sometimes allows for a selection of one of several). To
SUGGEST other profile groupings or helpful references for other profiles
to consider, use Section XX.6 Cross Profile Considerations. Use Section
X.5 for security profile recommendations.*

An actor from this profile (Column 1) shall implement all of the
required transactions and/or content modules in this profile ***in
addition to*** ***<u>all</u>*** of the requirements for the grouped
actor (Column 2) (Column 3 in alternative 2).

If this is a content profile, and actors from this profile are grouped
with actors from a workflow or transport profile, the Reference column
references any specifications for mapping data from the content module
into data elements from the workflow or transport transactions.

In some cases, required groupings are defined as at least one of an
enumerated set of possible actors; this is designated by merging column
one into a single cell spanning multiple potential grouped actors. Notes
are used to highlight this situation.

Section XX.5 describes some optional groupings that may be of interest
for security considerations and Section XX.6 describes some optional
groupings in other related profiles.

Two alternatives for Table XX.3-1 are presented below.

-   If there are no required groupings for any actor in this profile,
    use alternative 1 as a template.

-   If an actor in this profile (with no option), has a required
    grouping, use alternative 1.

-   If any required grouping is associated with an actor/option
    combination in this profile, use alternative 2.

alternative 1 Table XX.3-1: Profile Name - Required Actor
Groupings

All actors from this profile should be listed in Column 1, even if
none of the actors has a required groupings. If no required grouping
exists, “None” should be indicated in Column 2. If an actor in a content
profile is required to be grouped with an actor in a transport or
workflow profile, it will be listed **with at least one** required
grouping. Do not use “XD\*” as an actor name.

In some cases, required groupings are defined as at least one of an
enumerated set of possible actors; to designate this, create a row for
each potential actor grouping and merge column one to form a single cell
containing the profile actor which should be grouped with at least one
of the actors in the spanned rows. In addition, a note should be
included to explain the enumerated set. See example below showing
Document Consumer needing to be grouped with at least one of XDS.b
Document Consumer, XDR Document Recipient or XDM Portable Media
Importer

The author should pay special consideration to security profiles in
this grouping section. Consideration should be given to Consistent Time
(CT) Client, ATNA Secure Node or Secure Application, as well as other
profiles. For the sake of clarity and completeness, even if this table
begins to become long, a line should be added for each actor for each of
the required grouping for security. Also see the ITI document titled
‘Cookbook: Preparing the IHE Profile Security Section’ at
<http://ihe.net/Technical_Frameworks/#IT> for a list of suggested IT and
security groupings.

<table border="1" borderspacing="0" style='border: 1px solid black; border-collapse: collapse'>
<thead>
<tr class="header">
<th>this Profile Acronym Actor</th>
<th>Actor(s) to be grouped with</th>
<th>Reference</th>
<th>Content Bindings Reference</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Actor A</td>
<td><p><em>external Domain Acronym or blank</em></p>
<p><em>profile acronym/Actor</em></p>
<p><em>e.g., ITI CT / Time Client</em></p></td>
<td><p><em>TF Reference; typically from Vol 1</em></p>
<p><em>e.g., ITI-TF-1: 7.1</em></p></td>
<td>--</td>
</tr>
<tr class="even">
<td>Actor B</td>
<td>None</td>
<td>--</td>
<td>--</td>
</tr>
<tr class="odd">
<td><p>Actor C</p>
<p><em>In this example, Actor C shall be grouped with all three actors listed in column 2</em></p></td>
<td><p><em>external Domain Acronym or blank</em></p>
<p><em>profile acronym/Actor</em></p></td>
<td>--</td>
<td>See Note 1</td>
</tr>
<tr class="even">
<td></td>
<td><em>external Domain Acronym or blank profile acronym/Actor</em></td>
<td>--</td>
<td>See Note 1</td>
</tr>
<tr class="odd">
<td></td>
<td><p><em>external Domain Acronym or blank</em></p>
<p><em>profile acronym/Actor</em></p></td>
<td>--</td>
<td>See Note 1</td>
</tr>
<tr class="even">
<td><p>Actor D <em>(See note 1)</em></p>
<p><em>In this example, the note is used to indicate that the Actor D shall be grouped with one or more of the two actors of the two actors in column 2.</em></p></td>
<td><p><em>external Domain Acronym or blank</em></p>
<p><em>profile acronym/Actor</em></p></td>
<td>--</td>
<td>See Note 1</td>
</tr>
<tr class="odd">
<td></td>
<td><p><em>external Domain Acronym or blank</em></p>
<p><em>profile acronym/Actor</em></p></td>
<td>--</td>
<td>See Note 1</td>
</tr>
<tr class="even">
<td><p>Actor E</p>
<p><em>In rare cases, the actor to be grouped with must implement an option. An example is in column 2.)</em></p></td>
<td><p><em>external Domain Acronym or blank</em></p>
<p><em>profile acronym Actor</em></p>
<p><em>e.g., ITI RFD Form Filler with the Archive Form Option</em></p></td>
<td><p><em>TF Reference to the Option definition; typically from Vol 1</em></p>
<p><em>(e.g., ITI TF-1: 17.3.11)</em></p></td>
<td></td>
</tr>
<tr class="odd">
<td><em>e.g., Content Consumer (See Note 1)</em></td>
<td><em>ITI XDS.b / Document Consumer</em></td>
<td><em>ITI TF-1: 10.1</em></td>
<td><em>PCC TF-2:4.1 (See Note 2)</em></td>
</tr>
<tr class="even">
<td></td>
<td><em>ITI XDR / Document Recipient</em></td>
<td><em>ITI TF-1: 15.1</em></td>
<td><em>PCC TF-2:4.1 (See Note 2)</em></td>
</tr>
<tr class="odd">
<td></td>
<td><em>ITI XDM / Portable Media Importer</em></td>
<td><em>ITI TF-1: 16.1</em></td>
<td><em>PCC TF-2:4.1 (See Note 2)</em></td>
</tr>
<tr class="even">
<td><em>e.g., Content Consumer</em></td>
<td><em>ITI CT / Time Client</em></td>
<td><em>ITI TF-1: 7.1</em></td>
<td>--</td>
</tr>
</tbody>
</table>

Note 1: *This is a short note. It may be used to describe situations
where an actor from this profile may be grouped with one of several
other profiles/actors.*

Note 2: *A note could also be used to explain why the grouping is
required, if that is still not clear from the text above.*

alternative 2 Table XX.3-1: this Profile Acronym Profile
- Required Actor Groupings

All actors from this profile should be listed in Column 1. If no
required grouping exists, “None” should be indicated in Column 3. 

Guidance on using the “Grouping Condition” column:

-   If an actor has no required grouping, Column 2 should contain “--“.
    See Actor A below.

-   If an actor has a required grouping that is not associated with a
    profile option (i.e., it has no condition), column 2 should contain
    “Required”. See Actor B below.

-   Sometimes an option requires that an actor in this profile be
    grouped with an actor in another profile. That condition is
    specified in Column 2. See Actor C below.

<table border="1" borderspacing="0" style='border: 1px solid black; border-collapse: collapse'>
<tbody>
<tr class="odd">
<td>this Profile Acronym Actor</td>
<td>Grouping Condition</td>
<td>Actor(s) to be grouped with</td>
<td>Reference</td>
</tr>
<tr class="even">
<td>Actor A</td>
<td>--</td>
<td>None</td>
<td>--</td>
</tr>
<tr class="odd">
<td>Actor B</td>
<td>Required</td>
<td><p><em>external Domain Acronym or blank profile acronym/Actor</em></p>
<p><em>e.g., ITI CT / Time Client</em></p></td>
<td><p><em>TF Reference; typically from Vol 1</em></p>
<p><em>(e.g., ITI TF-1: 7.1)</em></p></td>
</tr>
<tr class="even">
<td>Actor C</td>
<td>With the <em>Option name in this profile</em> Option</td>
<td><em>external Domain Acronym or blank profile acronym/Actor</em></td>
<td><em>Where the Option is defined in this profile Section XX.3 z</em></td>
</tr>
<tr class="odd">
<td><p>Actor D</p>
<p><em>if an actor has both required and conditional groupings, list the Required grouping first</em></p></td>
<td>Required</td>
<td><em>external Domain Acronym or blank profile acronym/Actor</em></td>
<td><em>TF Reference; typically from Vol 1</em></td>
</tr>
<tr class="even">
<td></td>
<td>If the <em>Option name in this profile</em> Option is supported.</td>
<td><em>external Domain Acronym or blank profile acronym/Actor</em></td>
<td><em>TF Reference; typically from Vol 1</em></td>
</tr>
<tr class="odd">
<td></td>
<td>If the <em>other Option name in this profile</em> Option is supported.</td>
<td><em>external Domain Acronym or blank profile acronym/Actor</em></td>
<td><em>TF Reference; typically from Vol 1</em></td>
</tr>
<tr class="even">
<td><p>Actor E</p>
<p><em>(In rare cases, the actor to be grouped with must implement an option, an example is in column 3)</em></p></td>
<td>Required</td>
<td><p><em>external Domain Acronym or blank profile acronym/Actor</em> with the <em>option name</em></p>
<p><em>e.g. ITI RFD Form Filler with the Archive Form Option</em></p></td>
<td><p><em>TF Reference to the Option definition; typically from Vol 1</em></p>
<p><em>(eg ITI TF-1:17.3.11)</em></p></td>
</tr>
</tbody>
</table>


## XX.4 FooBar Overview <a name="overview"> </a>

TODO: Move the use-cases here

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

## XX.5 FooBar Security Considerations <a name="security-considerations"> </a>

TODO

See ITI TF-2x: [Appendix Z.8 “Mobile Security Considerations”](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations)

The following is instructions to the editor and this text is not to be included in a publication. 
The material initially from [RFC 3552 "Security Considerations Guidelines" July 2003](https://tools.ietf.org/html/rfc3552).

This section should address downstream design considerations, specifically for: Privacy, Security, and Safety. These might need to be individual header sections if they are significant or need to be referenced.

The editor needs to understand Security and Privacy fundamentals. 
General [Security and Privacy guidance](http://hl7.org/fhir/secpriv-module.html) is provided in the FHIR Specification. 
The FHIR core specification should be leveraged where possible to inform the reader of your specification.

IHE FHIR based profiles should reference the [ITI Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html) section 8 Mobile Security and Privacy Considerations base when appropriate.

IHE Document Content profiles can reference the security and privacy provided by the Document Sharing infrastructure as directly grouped or possibly to be grouped.

   While it is not a requirement that any given specification or system be
   immune to all forms of attack, it is still necessary for authors of specifications to
   consider as many forms as possible.  Part of the purpose of the
   Security and Privacy Considerations section is to explain what attacks have been 
   considered and what countermeasures can be applied to defend against them.
   
   There should be a clear description of the kinds of threats on the
   described specification.  This should be approached as an
   effort to perform "due diligence" in describing all known or
   foreseeable risks and threats to potential implementers and users.

Authors MUST describe:
* which attacks have been considered and addressed in the specification
* which attacks have been considered but not addressed in the specification
* what could be done in system design, system deployment, or user training


   At least the following forms of attack MUST be considered:
   eavesdropping, replay, message insertion, deletion, modification, and
   man-in-the-middle.  Potential denial of service attacks MUST be
   identified as well.  If the specification incorporates cryptographic
   protection mechanisms, it should be clearly indicated which portions
   of the data are protected and what the protections are (i.e.,
   integrity only, confidentiality, and/or endpoint authentication,
   etc.).  Some indication should also be given to what sorts of attacks
   the cryptographic protection is susceptible.  Data which should be
   held secret (keying material, random seeds, etc.) should be clearly
   labeled.

   If the specification involves authentication, particularly user-host
   authentication, the security of the authentication method MUST be
   clearly specified.  That is, authors MUST document the assumptions
   that the security of this authentication method is predicated upon.

   The threat environment addressed by the Security and Privacy Considerations
   section MUST at a minimum include deployment across the global
   Internet across multiple administrative boundaries without assuming
   that firewalls are in place, even if only to provide justification
   for why such consideration is out of scope for the protocol.  It is
   not acceptable to only discuss threats applicable to LANs and ignore
   the broader threat environment.  In
   some cases, there might be an Applicability Statement discouraging
   use of a technology or protocol in a particular environment.
   Nonetheless, the security issues of broader deployment should be
   discussed in the document.

   There should be a clear description of the residual risk to the user
   or operator of that specification after threat mitigation has been
   deployed.  Such risks might arise from compromise in a related
   specification (e.g., IPsec is useless if key management has been
   compromised), from incorrect implementation, compromise of the
   security technology used for risk reduction (e.g., a cipher with a
   40-bit key), or there might be risks that are not addressed by the
   specification (e.g., denial of service attacks on an
   underlying link protocol).  Particular care should be taken in
   situations where the compromise of a single system would compromise
   an entire protocol.  For instance, in general specification designers
   assume that end-systems are inviolate and don't worry about physical
   attack.  However, in cases (such as a certificate authority) where
   compromise of a single system could lead to widespread compromises,
   it is appropriate to consider systems and physical security as well.

   There should also be some discussion of potential security risks
   arising from potential misapplications of the specification or technology
   described in the specification.  
  
This section also include specific considerations regarding Digital Signatures, Provenance, Audit Logging, and De-Identification.

Where audit logging is specified, a StructureDefinition profile(s) should be included, and Examples of those logs might be included.

## XX.6 FooBar Cross-Profile Considerations <a name="other-grouping"> </a>

TODO

This section is informative, not normative. It is intended to put
this profile in context with other profiles. Any required groupings
should have already been described above. Brief descriptions can go
directly into this section; lengthy descriptions should go into an
appendix. Examples of this material include ITI Cross Community Access
(XCA) Grouping Rules (Section 18.2.3), the Radiology associated profiles
listed at wiki.ihe.net, or ITI Volume 1 Appendix E “Cross Profile
Considerations”, and the “See Also” sections Radiology Profile
descriptions on the wiki such as
<http://wiki.ihe.net/index.php/Scheduled_Workflow#See_Also>. If this
section is left blank, add “Not applicable.”

Consider using a format such as the following:

other profile acronym - other profile name

A other profile actor name in other profile name might
be grouped with a this profile actor name to describe
benefit/what is accomplished by grouping.



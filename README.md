# Proposed Scope

Much like BPPC + APPC does for XDS community. This Implementation Guide (IG) would do for FHIR community. This IG could be used with MHDS, which already has some of the framework for more specific Consents, but BPPCm would be more complete than what is [indicated in MHDS](https://profiles.ihe.net/ITI/MHDS/volume-1.html#1504-mhds-overview). This IG could also be used for organization use or community use beyond MHD/XDS, which would include use-cases like QEDm, and IPA. This would leverage BasicAudit to record access control decisions and recording of consents.

This IG would

1. Define a set of privacy policies with canonical URI and/or code.
1. Define a set of Consent patterns that are foundational.
1. Define actors for creation/update of Consent: ???? 
   - Consent Creator/Reader/Updater/Deleter actor,
   - Consent Registry actor, 
   - Consent Decision actor, and 
   - Consent Enforcement actor.

Much of the details are already fleshed out in these two articles: 
- [FHIR core Consent Examples explained](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html)
and 
- [FHIR Consent mapped to BPPC -- matched to STU3](https://healthcaresecprivacy.blogspot.com/2019/11/fhir-consent-mapped-with-bppc.html)

# IG Name

Chosen Name - **Privacy Consent on FHIR (PCF)**

**Discussed but not chosen:**
* Basic Mobile Consent (BMC)
* Privacy Mobile Consent (PMC)
* Mobile Privacy Consent (MPC)
* Privacy Consent (PC)
* Privacy Consent for Mobile (PCM)
* Privacy Consent for REST (PCR)
* Privacy Consent on FHIR (PCoF)
* Basic Advanced Privacy Consent (BAPC)
* FHIR Privacy Consent (FPC)

# Use-cases

This section includes explanation of some example scenarios and points at example 
Consent resources for them. 
These example scenarios are provided for educational use only, they are not an 
endorsement of these scenarios. 

## Consent Policy 

some policy URI could be defined for common consent terms. Not clear that these will be detailed enough to use in practice, but would be useful categorization of policy types.

- Explicit Permit (patient elects to have some information shared) is required which enables document sharing
- Explicit Deny (patient elects to not have information shared) stops all document sharing
- Implicit Permit allows for document sharing
- Explicit Deny of sharing outside of use in local care events, but does allow emergency override (aka break-glass)
- Explicit Deny of sharing outside of use in local care events, but without emergency override (aka break-glass)
- Explicit Permit authorization captured that allows specific research project
- Change the consent policy (e.g.,  change from Permit to Deny)

In each of these cases the provisions of the instance of Consent could further constrain.

## Notice of Privacy Policy

Some realms only require that the patient be given access to the organizations privacy policy. 
In these realms the patient is not given the choice to accept, reject, or change the terms of privacy policy. 
The expectation is that the patient can stop the engagement with the healthcare provider if they don't like the privacy policy (yes, we know this is a fallacy in many situations). 

Likely constraints (back of the envelop):
* status 1..1 - would indicate active
* scope 1..1 - #patient-privacy
* category 1..1 - would indicate patient consent, specifically a delegation of authority
* patient 1..1 - would indicate the Patient resource reference for the given patient
* dateTime 1..1 - would indicate when the privacy policy was presented
* performer 1..1 - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
* organization 1..1 - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
* source 1..1 - would point at the specific signed consent by the patient
* policy.uri 1..1 - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
* provision.type 1..1 - permit - given there is no way to deny, this would be fixed at permit.
* provision.agent 0..* - would indicate the those being authorized resource, if empty then all in the community
* provision.agent.role - would indicate this agent is delegated authority
* provision.purpose - would indicate some set of authorized purposeOfUse
* provision.period MS - would indicate a sunset for the consent if applicable, empty means no expiration

## Basic signed acknowledgement

This section covers the most basic of privacy consents, that simply records an acknowledgement to a given privacy policy permitting data sharing. 
This is only slightly different than the Notice of Privacy Policy, in that with this example, there is some evidence captured from the ceremony. 
Such as a patient initialing or signing a form indicating they have received the Privacy Policy. 
Similar to the Notice of Privacy Policy, the Patient is not given a choice to reject or change the terms of the privacy policy.
The specific version of privacy policy recorded can also be helpful to know when a given patient needs to be presented with the new version of the privacy policy.

## Change to deny sharing

This section covers the case where a basic permit has been used, but for some reason the authorization is revoked or rejected. 
An example might be where the organization does allow the patient to reject a previously permitted action, and the patient has expressed they want to deny sharing now. 
Another example might be where legal action has happened compelling an organization to revoke the consent.

* Should Version management on Consent resources be required?
* Should AuditEvent be required?

## Some patient specific provisions

Authorizing or Denying access to:
* who by a given Practitioner, CareTeam, RelatedPerson
* why by a given Purpose Of Event codes 
  * why by a given named Research projects
* data by Confidentiality class (Normal, but not Restricted) -- presumes a mature SLS
  * data by sensitivity class -- presumes a mature SLS
* data by authored timeframe
* data by authorship (authored by someone in organization XYZ)
* data by identifier (explicit reference)
* when specific period of time data can be accessed

what others are needed in real-life (vs theory)?

# Not likely to be in scope

These seem to be possible with Consent resource in R4, but not clear they are priority or even possible.

* Use of Consent besides Privacy (consent to treat, advanced directives)
* .action -- this is not well enough defined in Consent 
* applied obligations or refrains -- no clear place where these go in Consent
* .class -- this is not well enough defined in Consent
* data related to an identified data resource (e.g. all data related to this Encounter)
* use of types of Resources -- not clear how this is useful (e.g. all Observations but not other types of Resources)
* Consent enforcement within an organization. We focus on Cross-Enterprise/Community access.
* Use of FHIR Consent for XDS/XCA environments

## should these be in scope?

* Patient Privacy Preferences -- which might bring along with it a need for another actor which is in the control of the Patient and not associated with the HIE community
* Do we need to cover policies that would constrain Document Source based on a Consent rule? This was included in XDS/BPPC, but there is no evidence that it was used.
* Should a [Security Labeling Service](https://healthcaresecprivacy.blogspot.com/2022/09/security-labeling-service.html) be formally defined? should it be abstractly defined? It is possible to define the concept, pointing to the HL7 stuff including the soon to be published FHIR ds4p, and indicate that this is  functionality expected to apply security labels to all objects being controlled. It might apply security labels to more fine-grain (e.g. portions within a document) but the critical aspect seems to be the size of the object being controlled.

## Multi-Generation Plan?

I suspect that everyone sees a different scope to this general problem. Consent is often very complex as one digs deeper. So I present a plan of attack that starts with a well defined "Community", the MHDS community; and a well defined object-to-be-controlled, the document. 

1. MHDS -- The Central MHDS Document Registry enforcing Consents, just controlling Document Consumer actor. I think this will need to call upon the new SeR to provide tokens that a distributed repository would be expected to enforce. Note that Consent would be recorded in the central FHIR server (adding a Consent Registry actor), there would not be a distributed Consent Registry. Likely one Consent per patient with rules for the whole Community.
2. MHDS + mXDE/QEDm -- adding access rules around resources derived from Documents
3. MHDS + XCA -- given that XCA is used to connect a MHDS community to broader network of community; then this use-case would add Consent terms for requests coming in from the outside.
4. QEDm standalone -- this is later in the generation plan as there is no pre-defined community or terms of connection defined. However this likely is not unlike the previous, just needing the previous to be worked out fully before this is added.  This use-case bring switch it FHIR Resource based object control (prior the object to be controlled is a document)
5. Residual Obligations/Refrains - same as above but there would be 'permit' provisions that require some refrain or obligation
  
# Research

## Other IGs that have constrained Consent for Privacy purposes
Note that there are many IGs that have profiled Consent for Advanced Directives / Living Wills; and for Consent to treat.

Data pulled from the new [FHIR Guides Stats page](http://fhir.org/guides/stats/all-profile-res-consent.html) - which is constantly being updated. (24 indications of profile on FHIR Consent)

Privacy Consent:
- [DaVinci Health Record Exchange (HRex)](https://build.fhir.org/ig/HL7/davinci-ehrx/)
  - [HRex Consent Profile](https://build.fhir.org/ig/HL7/davinci-ehrx/StructureDefinition-hrex-consent.html)
- [SDOH Clinical Care](https://build.fhir.org/ig/HL7/fhir-sdoh-clinicalcare/)
  - [SDOHCC Consent](https://build.fhir.org/ig/HL7/fhir-sdoh-clinicalcare/StructureDefinition-SDOHCC-Consent.html) release authorization
- Specialty Medication Enrollment](https://build.fhir.org/ig/HL7/fhir-specialty-rx/)
  - [Specialty Rx Consent](https://build.fhir.org/ig/HL7/fhir-specialty-rx/StructureDefinition-specialty-rx-consent.html)
- [UK INTEROPen Care Connect FHIR Profiles](https://fhir.hl7.org.uk/)
  - [CareConnect Consent 1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Consent-1)

## Other research to note
- HL7 FHIR DS4P
  - [FHIR Data Segmentation for Privacy - CI build](http://build.fhir.org/ig/HL7/fhir-security-label-ds4p/branches/master/index.html)
- John Moehrke blog
  - [RelatedPerson Consent](https://healthcaresecprivacy.blogspot.com/2022/06/relatedperson-consent-how-to-record.html)
  - [Explaining FHIR Consent examples](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html)
  - [FHIR Consent mapped to BPPC](https://healthcaresecprivacy.blogspot.com/2019/11/fhir-consent-mapped-with-bppc.html)
  - [Security Labeling Service](https://healthcaresecprivacy.blogspot.com/2022/09/security-labeling-service.html)
  
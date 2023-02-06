# Privacy Consent on FHIR (PCF)

Note where decisions are made and a concept is put into the IG, it is generally removed from the README. Thus the readme is not comprehensive, it is focused mostly on open-issues, questions, and parking lot.

## CI Build

http://build.fhir.org/ig/IHE/ITI.PCF/branches/master/index.html

## Questions

questions to the ITI committee to aid with the development of the IG.

1. The Deny except for Break-Glass seems to be beyond foundational. Seems these use-cases are out-of-scope? The use-case as written is a possible base policy, but would not be a common one in healthcare and especially not in treatment.  I think we thus need to remove Break-Glass
1. is Volume 1 getting too long? Could split on H2 (actors, options, grouping, overview, security, xProfile) like what is done in MHD.
1. do we define deployment models that have the Privacy-Preferences external to a custodian, and/or the Consent Management outside the custodian. The initial round might be limited to cases where there is some overriding organization that encompasses all actors formally defined in PCF. Thus coordinating between possibly divergent or conflicting policies can be left to the Consent Creator actor.
1. There is partial documentation of Privacy-Preferences, which uses the FHIR Consent without a binding to a custodian. These Privacy-Preferences are statements by the Patient of their desired rules. These desired rules can be used during the consent interaction (ceremony) to pre-adjust the rules that the custodian is willing to support. Thus enabling a more friendly experience by the Patient. This is most useful when the Patient has complex desired rules that may be hard to capture during the consent ceremony.
1. the XX.4.2 section seems awkward given the pattern IHE has for content profiling. The detail is there, but it seems not as useful as it could be. would cucumber be more understandable? have I written this wrong? I have written these more from the access control logic, but possibly they should only be from the perspective of the content definition. The access control logic is in the option text above?
1. Are we going to support just one level of sub-provisions? 2 levels of sub-provisions? not limited? Seems one level of exceptions should be sufficient for most cases. Unclear what realistic use-cases need 2 levels. Recommend only one level of sub-provisions (This enables Permit with exceptions, and Deny with exceptions; but does not support exceptions to the exceptions). Given no combining rules, and concern to make implementable.
  - I have written this as exhaustive search through sub-provisions. is this right?
1. Do we profile Questionnaire/QuestionnaireResponse? (What generation?) For now I informatively indicate that the capture event could be enabled using Questionnaire.
1. Do we profile Consent Policy retrieval (the text of the policy)? For now I presume NPFS can be used for this, should it be required / recommended / encouraged? Should that happen in MHDS, not here?
1. Should auditEvent be required? There will certainly be AuditEvent profiling and examples built off of BALP.
1. Should FHIR resource version support be required? (e.g. version of Consent to show history)
1. Should FHIR Provenance be required / recommended / encouraged?
1. How to approach the overall solution which will be very complex? The thinking is that there will be both options within the IG of increasing complexity and building on the previous; but also that the initial version may be scope limited to make it achievable and measurable. One specific extension beyond what I have defined would be refinement on use of security tags, security labeling service, and other ABAC concepts. Initial proposal is focused on some high value sensitive topics.
1. The NOT likely in scope is open for discussion. I put some things here because of maturity of that concept, maturity of that element in the FHIR Consent, complexity, or unclear priority. Thus any feedback is welcome.
1. Do we need to cover policies that would constrain Document Source based on a Consent rule? As in a Consent that would prevent Create/Update/Delete actions. This was included in XDS/BPPC, but there is no evidence that it was used.
1. I expect that we could define some explicitly coded policies for MHDS environments that would have defined behavior. These would be definable in behaviors, but not in human language that would be used with the patient. Given that the Consent Capture is defined as not including the patient engagement on the consent terms, this may not be a problem that we can't provide human language. we could provide boilerplate human language, but we should be careful to not express legal terms.
1. I defined a subset of ConfidentialityCodes (N, R), and Sensitivity codes (ETH, ETHUD, OPIOIDUD, PSY, SEX, and HIV). Is this enough? Is this too many? There is details on these in the [SLS sample](http://build.fhir.org/ig/JohnMoehrke/ConsentWithSegmentation/branches/main/sls.html)
2. Profile number, transaction numbers, and content profile numbers

### Decided

1. Is Explicit Basic too advanced? If so, what should be moved to Intermediate?  I think that timeframe and resource by id should be in an option that is between basic and intermediate. They are more powerful than one would expect basic, but they are easy to implement without deep inspection (using fundamental Base Resource elements of .id and .meta.lastUpdated). Intermediate requires that the authorization enforcement do deeper (aka Resource type specific) inspection. Do we have four levels rather than the current three (basic, intermediate, advanced, expert)?
   1. Each incremental parameter should be its own option. So we end up with Implicit, Explicit, and Advanced; mostly as they were. The following are incrementally built upon Basic: Data Timeframe, Data by id, Named research project, data author, and data relationship.
   2. I simply made the intermediate a set of options with these 5. So there is still use of 'intermediate'. The volume three profiling of Consent would then include the profiling for these 5 in one chapter.
1. I did bring in SLS to Appendix P
2. HIV is still important internationally
3. Female Health may be a sensitve topic (menstration cycle) - TODO
4. SLS valueset management, might explain some modern terms as examplars of the continual maintenance. - TODO
   
## Proposed Scope

Much like BPPC + APPC does for XDS community, this Implementation Guide (IG) would do for FHIR community. This IG could be used with MHDS, which already has some of the framework for more specific Consents, but PCF would be more complete than what is [indicated in MHDS](https://profiles.ihe.net/ITI/MHDS/volume-1.html#1504-mhds-overview). This IG could also be used for organization use or community use beyond MHD/XDS, which would include use-cases like QEDm, and IPA. This would leverage BasicAudit to record access control decisions and recording of consents.

This IG would

1. Define a set of privacy policies with canonical URI and/or code. These codes might be used in real-implementations, but would also aid with understanding of the concept. Much like most of the PurposeOfUse codes are usable, while others are too abstract in real-implementations.
1. Define a set of Consent patterns that are foundational. These would be options of increasing complexity, building upon the previous. As IHE Profile options they indicate an ability to support the use-case. Real-Implementations would pick which actual policy(s) are used. So the ability to support an option does not mandate that that option is used in all settings.
1. Define actors for creation/update of Consent: 

## Use-cases

This section includes explanation of some example scenarios and points at example
Consent resources for them.
These example scenarios are provided for educational use only, they are not an
endorsement of these scenarios.

### basic

Likely constraints (back of the envelop):

- status 1..1 - would indicate active
- scope 1..1 - #patient-privacy
- category 1..1 - would indicate patient consent, specifically a delegation of authority
- patient 1..1 - would indicate the Patient resource reference for the given patient
- dateTime 1..1 - would indicate when the privacy policy was presented
- performer 1..1 - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization 1..1 - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
- source 1..1 - would point at the specific signed consent by the patient
- policy.uri 1..1 - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
- provision.type 1..1 - permit - given there is no way to deny, this would be fixed at permit.
- provision.agent 0..* - would indicate the those being authorized resource, if empty then all in the community
- provision.agent.role - would indicate this agent is delegated authority
- provision.purpose - would indicate some set of authorized purposeOfUse
- provision.period MS - would indicate a sunset for the consent if applicable, empty means no expiration

### Some patient specific provisions

Authorizing or Denying access to:

- who by a given Practitioner, CareTeam, RelatedPerson
- why by a given Purpose Of Event codes 
  - why by a given named Research projects
- data by Confidentiality class (Normal, but not Restricted) -- presumes a mature SLS
  - data by sensitivity class -- presumes a mature SLS
- data by authored timeframe
- data by authorship (authored by someone in organization XYZ)
- data by identifier (explicit reference)
- when specific period of time the consent is valid

what others are needed in real-life (vs theory)?

### Not likely to be in scope

These seem to be possible with Consent resource in R4, but not clear they are priority or even possible.

- Use of Consent besides Privacy (consent to treat, advanced directives)
- .action -- this is not well enough defined in Consent 
- applied obligations or refrains -- no clear place where these go in Consent
- .class -- this is not well enough defined in Consent
- data related to an identified data resource (e.g. all data related to this Encounter)
- use of types of Resources -- not clear how this is useful (e.g. all Observations but not other types of Resources)
- Consent enforcement within an organization. We focus on Cross-Enterprise/Community access.
- Use of FHIR Consent for XDS/XCA environments
- Use-case where the patient revoking authorized access is expected to also stop all downstream disclosures that were originally authorized. Thus only supporting authorization decisions at the time the data request is made with no ramifications placed upon the data released and no ability to recind what was authorized. see [Consents Revocation and Redisclosure](https://jafarim.net/revocation-and-redisclosure/)
- Use-case that authorizes patient delegates. This could be done with Consent, but is considered a more advanced than supported in first generation of PCF. See [RelatedPerson Consent](https://healthcaresecprivacy.blogspot.com/2022/06/relatedperson-consent-how-to-record.html)

## Multi-Generation Plan?

I suspect that everyone sees a different scope to this general problem. Consent is often very complex as one digs deeper. So I present a plan of attack that starts with a well defined "Community", the MHDS community; and a well defined object-to-be-controlled, the document.

1. MHDS -- The Central MHDS Document Registry enforcing Consents, just controlling Document Consumer actor. I think this will need to call upon the new SeR to provide tokens that a distributed repository would be expected to enforce. Note that Consent would be recorded in the central FHIR server (adding a Consent Registry actor), there would not be a distributed Consent Registry. Likely one Consent per patient with rules for the whole Community.
2. MHDS + mXDE/QEDm -- adding access rules around resources derived from Documents
3. MHDS + XCA -- given that XCA is used to connect a MHDS community to broader network of community; then this use-case would add Consent terms for requests coming in from the outside.
4. QEDm standalone -- this is later in the generation plan as there is no pre-defined community or terms of connection defined. However this likely is not unlike the previous, just needing the previous to be worked out fully before this is added.  This use-case bring switch it FHIR Resource based object control (prior the object to be controlled is a document)
5. Residual Obligations/Refrains - same as above but there would be 'permit' provisions that require some refrain or obligation
6. other things beyond scope
7. use of FHIR R5 Consent
  
## Research

### Other IGs that have constrained Consent for Privacy purposes

Note that there are many IGs that have profiled Consent for Advanced Directives / Living Wills; and for Consent to treat.

Data pulled from the new [FHIR Guides Stats page](http://fhir.org/guides/stats/all-profile-res-consent.html) - which is constantly being updated. (24 indications of profile on FHIR Consent)

Privacy Consent:

- [DaVinci Health Record Exchange (HRex)](https://build.fhir.org/ig/HL7/davinci-ehrx/)
  - [HRex Consent Profile](https://build.fhir.org/ig/HL7/davinci-ehrx/StructureDefinition-hrex-consent.html)
- [SDOH Clinical Care](https://build.fhir.org/ig/HL7/fhir-sdoh-clinicalcare/)
  - [SDOHCC Consent](https://build.fhir.org/ig/HL7/fhir-sdoh-clinicalcare/StructureDefinition-SDOHCC-Consent.html) release authorization
- [Specialty Medication Enrollment](https://build.fhir.org/ig/HL7/fhir-specialty-rx)
  - [Specialty Rx Consent](https://build.fhir.org/ig/HL7/fhir-specialty-rx/StructureDefinition-specialty-rx-consent.html)
- [UK INTEROPen Care Connect FHIR Profiles](https://fhir.hl7.org.uk/)
  - [CareConnect Consent 1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Consent-1)

### Other research to note

- HL7 FHIR DS4P
  - [FHIR Data Segmentation for Privacy - CI build](http://build.fhir.org/ig/HL7/fhir-security-label-ds4p/branches/master/index.html)
- [John Moehrke blog](https://healthcaresecprivacy.blogspot.com)
  - [RelatedPerson Consent](https://healthcaresecprivacy.blogspot.com/2022/06/relatedperson-consent-how-to-record.html)
  - [Explaining FHIR Consent examples](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html)
  - [FHIR Consent mapped to BPPC](https://healthcaresecprivacy.blogspot.com/2019/11/fhir-consent-mapped-with-bppc.html)
  - [Security Labeling Service](https://healthcaresecprivacy.blogspot.com/2022/09/security-labeling-service.html)
  - [Consent with Segmented Data](http://build.fhir.org/ig/JohnMoehrke/ConsentWithSegmentation/branches/main/index.html)
- [Mohammad Jafari blog](https://jafarim.net/blog/)
  - [Consents Revocation and Redisclosure](https://jafarim.net/revocation-and-redisclosure/)
  - [Consent Overarching Policy](https://jafarim.net/consent-overarching-policy)
- ONC LEAP Computable Consent Project 
  - [High-Level Architecture](https://sdhealthconnect.github.io/leap/blog/2021/09/30/architecture.html)
  - [Scalability in Consent Management](https://sdhealthconnect.github.io/leap/blog/2021/12/23/scalability.html)
  - [Future Directions for the LEAP Consent Project](https://sdhealthconnect.github.io/leap/blog/2021/10/04/leap-future.html)

### IG Name

Chosen Name - **Privacy Consent on FHIR (PCF)**

**IG names that were discussed but not chosen:**

- Basic Mobile Consent (BMC)
- Privacy Mobile Consent (PMC)
- Mobile Privacy Consent (MPC)
- Privacy Consent (PC)
- Privacy Consent for Mobile (PCM)
- Privacy Consent for REST (PCR)
- Privacy Consent on FHIR (PCoF)
- Basic Advanced Privacy Consent (BAPC)
- FHIR Privacy Consent (FPC)


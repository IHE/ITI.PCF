# Privacy Consent on FHIR (PCF)

Note where decisions are made and a concept is put into the IG, it is generally removed from the README. Thus the readme is not comprehensive, it is focused mostly on open-issues, questions, and parking lot.

## CI Build

http://build.fhir.org/ig/IHE/ITI.PCF/branches/master/index.html

## Questions

questions to the ITI committee to aid with the development of the IG.

1. Should we explain in Appendix P about overall policies that Privacy Policies fit within, such as hiring policy, code of conduct, internet usage policy, health and safety policy, travel policies, etc?
1. is Volume 1 getting too long? Could split on H2 (actors, options, grouping, overview, security, xProfile) like what is done in MHD.
1. the 53.4.2 section seems awkward given the pattern IHE has for content profiling. The detail is there, but it seems not as useful as it could be. would cucumber be more understandable? have I written this wrong? I have written these more from the access control logic, but possibly they should only be from the perspective of the content definition. The access control logic is in the option text above?
1. Are we going to support just one level of sub-provisions? 2 levels of sub-provisions? not limited? Seems one level of exceptions should be sufficient for most cases. Unclear what realistic use-cases need 2 levels. Recommend only one level of sub-provisions (This enables Permit with exceptions, and Deny with exceptions; but does not support exceptions to the exceptions). Given no combining rules, and concern to make implementable. I have written this as exhaustive search through sub-provisions. is this right?
1. How to approach the overall solution which will be very complex? The thinking is that there will be both options within the IG of increasing complexity and building on the previous; but also that the initial version may be scope limited to make it achievable and measurable. One specific extension beyond what I have defined would be refinement on use of security tags, security labeling service, and other ABAC concepts. Initial proposal is focused on some high value sensitive topics.
1. The NOT likely in scope is open for discussion. I put some things here because of maturity of that concept, maturity of that element in the FHIR Consent, complexity, or unclear priority. Thus any feedback is welcome.
1. I expect that we could define some explicitly coded policies for MHDS environments that would have defined behavior. These would be definable in behaviors, but not in human language that would be used with the patient. Given that the Consent Recorder is defined as not including the patient engagement on the consent terms, this may not be a problem that we can't provide human language. we could provide boilerplate human language, but we should be careful to not express legal terms.
1. I defined a subset of ConfidentialityCodes (N, R), and Sensitivity codes (ETH, ETHUD, OPIOIDUD, PSY, SEX, and HIV). Is this enough? Is this too many?
2. Added a base policy that forbids redisclosure. This is the only policy that places restrictions upon the recipient.

### In development

- adding examples to Volume 3
- defining the profiles for those examples
- 
### Decided

1. Is Explicit Basic too advanced? If so, what should be moved to Intermediate?  I think that timeframe and resource by id should be in an option that is between basic and intermediate. They are more powerful than one would expect basic, but they are easy to implement without deep inspection (using fundamental Base Resource elements of .id and .meta.lastUpdated). Intermediate requires that the authorization enforcement do deeper (aka Resource type specific) inspection. Do we have four levels rather than the current three (basic, intermediate, advanced, expert)?
   1. Each incremental parameter should be its own option. So we end up with Implicit, Explicit, and Advanced; mostly as they were. The following are incrementally built upon Basic: Data Timeframe, Data by id, Named research project, data author, and data relationship.
   2. I simply made the intermediate a set of options with these 5. So there is still use of 'intermediate'. The volume three profiling of Consent would then include the profiling for these 5 in one chapter.
1. I did bring in SLS to Appendix P
2. HIV is still important internationally
3. Female Health may be a sensitive topic (menstruation cycle) - possible Open-Issue
4. SLS valueset management, Explained ICD11 as some modern terms as exemplars of the continual maintenance.
5. break-glass -- could support Deny All with break-glass. Thus all requests for treatment get Deny, but the deny is indicated as break-glass qualifying. Thus purposeOfUse break-glass is used.   harder to support that some data is returned, but not all. -- Open-Issue, request solutions
6. Include Privacy Preference flow in Appendix P, but not within the normative text.
7. We are not going to provide details on Questionnaire / QuestionnaireResponse use. There are mentions of the possibility, but no more is to be said. A future revision of this or a new IG could address this.
8. We are not going to profile how the Patient Privacy Policy could be retrieved other than the mention about use of MHD.
9. Discussed the possibility of needing to do continued maintenance, including proving that historic access would have enforced the consent at that time, and thus the need for Consent versions, Provenance, and/or AuditEvent. -- Possible Open-Issue
10. PCF is not addressing the use-case where a Consent (dissent) would forbid the data capture or recording. This was available in BPPC, but was not found to be used.

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


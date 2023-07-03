# Privacy Consent on FHIR (PCF)

Note where decisions are made and a concept is put into the IG, it is generally removed from the README. Thus the readme is not comprehensive, it is focused mostly on open-issues, questions, and parking lot.

## CI Build

http://build.fhir.org/ig/IHE/ITI.PCF/branches/master/index.html

## ITI bi-weekly development call

ITI meets for one hour every other week to develop this work toward Public-Comment, toward Trial-Implementation publication. Target for Public-Comment is spring/summer 2023, thus first Trial-Implementation publication in Fall 2023. 

- bi-weekly - Fridays @ 10amCT/11amET/1700CET
- Starting March 3, 2023
- [teams meeting](https://teams.microsoft.com/l/meetup-join/19%3ameeting_YTI4NWQ5MjItNzQ0Ny00ZDJmLTg3MzAtMTliZDYxNzFlMjNm%40thread.v2/0?context=%7b%22Tid%22%3a%2202a9376b-a4f9-4a63-a240-52c43ebf9a89%22%2c%22Oid%22%3a%226459fea4-110a-4d17-85f0-00587211a0c0%22%7d)

Best to [join the ITI-Technical committee](https://www.ihe.net/ihe_domains/it_infrastructure/), but I am interested in diverse perspectives from anyone.

## Questions

questions to the ITI committee to aid with the development of the IG.

- given that all comments have been addressed, the current version (ci-build) is ready for approval for publication.
  - Once published, we should have the discussion on when we start on next generation of the multi-generation plan.
- still interested in resolving any of the open-issues.
  - [PCF_18](https://github.com/IHE/ITI.PCF/issues/18) What sensitivity categories should be mandatory? There is a list of them today, but is this too many? Why is too many a problem? Should we define our own fake sensitivity that is required purely for connectathon purposes? Could we do the same with one of the current categories?
  - [PCF_19](https://github.com/IHE/ITI.PCF/issues/19) Seems identifying an agent in a consent is more of an Intermediate than Basic. It is listed as Basic today as it was in BPPC.
  - [PCF_20](https://github.com/IHE/ITI.PCF/issues/20) Break-glass without a specific way to declare break-glass? Could we leave in what we have defined, just move it to Intermediate? Must we remove all break-glass until the full flow can be addressed?
  - [PCF_21](https://github.com/IHE/ITI.PCF/issues/21) No compelling use to drive mandate for Provenance, so it likely will stay just examples, and this open-issue gets closed.

## Multi-Generation Plan?

I suspect that everyone sees a different scope to this general problem. Consent is often very complex as one digs deeper. So I present a plan of attack that starts with a well defined "Community", the MHDS community; and a well defined object-to-be-controlled, the document.

1. MHDS -- The Central MHDS Document Registry enforcing Consents, just controlling Document Consumer actor. I think this will need to call upon the new SeR to provide tokens that a distributed repository would be expected to enforce. Note that Consent would be recorded in the central FHIR server (adding a Consent Registry actor), there would not be a distributed Consent Registry. Likely one Consent per patient with rules for the whole Community.
2. MHDS + mXDE/QEDm -- adding access rules around resources derived from Documents
3. MHDS + XCA -- given that XCA is used to connect a MHDS community to broader network of community; then this use-case would add Consent terms for requests coming in from the outside.
4. QEDm standalone -- this is later in the generation plan as there is no pre-defined community or terms of connection defined. However this likely is not unlike the previous, just needing the previous to be worked out fully before this is added.  This use-case bring switch it FHIR Resource based object control (prior the object to be controlled is a document)
5. Residual Obligations/Refrains - same as above but there would be 'permit' provisions that require some refrain or obligation
6. support for tagging at an element level, rather than just Resource. An example is within the Patient resource there are various addresses and phone numbers that might need to be tagged with specific sensitivities that might have release rules indicated in either overall policy or Consent instance. Other examples are needed to fully justify this added overhead.
7. Defined full workflow for break-glass
8. use of FHIR R5 Consent
  
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
- [Switzerland Core](http://fhir.ch/ig/ch-core/index.html)
  - [CH Core EPR-Consent](http://fhir.ch/ig/ch-core/StructureDefinition-ch-core-epr-consent.html)

### Other research to note

- HL7 FHIR DS4P
  - [STU Publication of HL7 FHIR® Implementation Guide: Data Segmentation for Privacy (DS4P), Release 1](http://hl7.org/fhir/uv/security-label-ds4p/STU1)
  - [FHIR Data Segmentation for Privacy - CI build](http://build.fhir.org/ig/HL7/fhir-security-label-ds4p/branches/master/index.html)
- [John Moehrke blog](https://healthcaresecprivacy.blogspot.com)
  - [RelatedPerson Consent](https://healthcaresecprivacy.blogspot.com/2022/06/relatedperson-consent-how-to-record.html)
  - [Explaining FHIR Consent examples](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html)
  - [FHIR Consent mapped to BPPC](https://healthcaresecprivacy.blogspot.com/2019/11/fhir-consent-mapped-with-bppc.html)
  - [Security Labeling Service](https://healthcaresecprivacy.blogspot.com/2022/09/security-labeling-service.html)
  - [Consent with Segmented Data](http://build.fhir.org/ig/JohnMoehrke/ConsentWithSegmentation/branches/main/index.html)
- [Mohammad Jafari blog](https://jafarim.net/blog/)
  - [A Developer's Guide to Security labeling in FHIR](https://jafarim.net/labeling-developer-guide/)
  - [Consents Revocation and Redisclosure](https://jafarim.net/revocation-and-redisclosure/)
  - [Consent Overarching Policy](https://jafarim.net/consent-overarching-policy)
- ONC LEAP Computable Consent Project
  - [High-Level Architecture](https://sdhealthconnect.github.io/leap/blog/2021/09/30/architecture.html)
  - [Scalability in Consent Management](https://sdhealthconnect.github.io/leap/blog/2021/12/23/scalability.html)
  - [Future Directions for the LEAP Consent Project](https://sdhealthconnect.github.io/leap/blog/2021/10/04/leap-future.html)

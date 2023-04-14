
This Implementation Guide, Privacy Consent on FHIR (PCF), provides support for patient privacy consents for Health Information Exchanges using FHIR.

This includes refinement of the consent handling defined in [MHDS](https://profiles.ihe.net/ITI/MHDS). The scope does not intend to cover all consent use-cases, such as the consent use-cases for within an orgaization, or more advanced consents that may be addressed in future versions of PCF.

<div markdown="1" class="stu-note">

| [Significant Changes, Open, and Closed Issues](issues.html) |
{: .grid}

</div>

### Organization of This Guide

This guide is organized into the following sections:

1. Volume 1:
   1. [53 Introduction](volume-1.html)
   1. [53.1 Actors, Transactions, and Content](volume-1.html#actors-and-transactions)
   1. [53.2 Actor Options](volume-1.html#actor-options)
   1. [53.3 Actor Required Groupings](volume-1.html#required-groupings)
   1. [53.4 Overview](volume-1.html#overview)
   1. [53.5 Security Considerations](volume-1.html#security-considerations)
   1. [53.6 Cross Profile Considerations](volume-1.html#other-grouping)
   1. [Appendix P: Privacy Access Policies](ch-P.html)
2. Volume 2: Transaction Detail
   1. _[3.71 Get Access Token \[ITI-71\]](other.html#updates-to-iti-71)_
   1. [3.72 Incorporate Access Token \[ITI-71\]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
   1. [3.102 Introspect Token \[ITI-102\]](https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102)
   1. [3.103 Get Authorization Server Metadata \[ITI-103\]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103)
   1. [3.110 Access Consent \[ITI-110\]](ITI-110.html)
3. Volume 3: Metadata and Content
   1. [5.8 Privacy Consent Patterns](content.html)
4. Other
   1. [Changes to Other Profiles](other.html)
   1. [Updates to ITI-71](other.html#updates-to-iti-71)
   1. [Download and analysis](download.html)
   1. [Test Plan](testplan.html)

See also the [Table of Contents](toc.html) and
the index of [Artifacts](artifacts.html) defined as part of this implementation guide.

### Conformance Expectations

IHE uses the normative words: Shall, Should, and May according to [standards conventions](https://profiles.ihe.net/GeneralIntro/ch-E.html).

#### Must Support

The use of ```mustSupport``` in StructureDefinition profiles equivalent to the IHE use of **R2** as defined in [Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.10-profiling-conventions-for-constraints-on-fhir).

mustSupport of true - only has a meaning on items that are minimal cardinality of zero (0), and applies only to the source actor populating the data. The source actor shall populate the elements marked with MustSupport, if the concept is supported by the actor, a value exists, and security and consent rules permit.
The consuming actors should handle these elements being populated or being absent/empty.
Note that sometimes mustSupport will appear on elements with a minimal cardinality greater than zero (0), this is due to inheritance from a less constrained profile.

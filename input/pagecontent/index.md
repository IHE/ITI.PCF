
This Implementation Guide, Privacy Consent on FHIR (PCF), provides support for patient privacy consents for Health Information Exchanges using FHIR.

This includes refinement of the consent handling defined in [MHDS](https://profiles.ihe.net/ITI/MHDS). The scope does not intend to cover all consent use-cases, such as the consent use-cases for within an orgaization, or more advanced consents that may be addressed in future versions of PCF.

<div markdown="1" class="stu-note">

| [Significant Changes, Open, and Closed Issues](issues.html) |
{: .grid}

</div>

### Organization of This Guide

This guide is organized into the following sections:

1. Volume 1:
   1. [Introduction](volume-1.html)
   1. [Actors, Transactions, and Content](volume-1.html#actors-and-transactions)
   1. [Actor Options](volume-1.html#actor-options)
   1. [Actor Required Groupings](volume-1.html#required-groupings)
   1. [Overview](volume-1.html#overview)
   1. [Security Considerations](volume-1.html#security-considerations)
   1. [Cross Profile Considerations](volume-1.html#other-grouping)
   1. [Appendix P: Privacy Access Policies](ch-P.html)

2. Volume 2: Transaction Detail
   1. [Get Consent Access Token \[ITI-108\]](ITI-108.html)
   1. [Introspect Consent Token \[ITI-109\]](ITI-109.html)
   1. [Access Consent \[ITI-110\]](ITI-110.html)

3. Volume 3: Metadata and Content
   1. [Privacy Consent Patterns](content.html)

4. Other
   1. [Changes to Other Profiles](other.html)
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

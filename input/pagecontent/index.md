
The Privacy Consent on FHIR (PCF) Profile provides support for patient privacy consents and access control where a FHIR API is used to access Document Sharing Health Information Exchanges.

This includes refinement of the consent handling defined in [MHDS](https://profiles.ihe.net/ITI/MHDS). The scope does not intend to cover all consent use cases, such as the consent use cases for within an organization, or more advanced consents that may be addressed in future versions of PCF.

<div markdown="1" class="stu-note">

| [Significant Changes, Open and Closed Issues](issues.html) |
{: .grid}

</div>

### Organization of This Guide

This guide is organized into the following sections:

- Volume 1: Profiles
  - [Introduction](volume-1.html)
  - [Actors, Transactions, and Content](volume-1.html#actors-and-transactions)
  - [Actor Options](volume-1.html#actor-options)
  - [Actor Required Groupings](volume-1.html#required-groupings)
  - [Overview](volume-1.html#overview)
  - [Security Considerations](volume-1.html#security-considerations)
  - [Cross Profile Considerations](volume-1.html#other-grouping)
  - [Appendix P: Privacy Access Policies](ch-P.html)
- Volume 2: Transaction Detail
  - [Get Access Token \[ITI-71\]](other.html#updates-to-iti-71)
  - [Incorporate Access Token \[ITI-72\]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)
  - [Introspect Token \[ITI-102\]](https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102)
  - [Get Authorization Server Metadata \[ITI-103\]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103)
  - [Access Consent \[ITI-108\]](ITI-108.html)
- Volume 3: Metadata and Content
  - [Privacy Consent Patterns](content.html)
- Other
  - [Changes to Other IHE Specification](other.html)
  - [Updates to ITI-71](other.html#updates-to-iti-71)
  - [Test Plan](testplan.html)
  - [Download and Analysis](download.html)

See also the [Table of Contents](toc.html) and
the index of [Artifacts](artifacts.html) defined as part of this implementation guide.

### Conformance Expectations

IHE uses the normative words: Shall, Should, and May according to [standards conventions](https://profiles.ihe.net/GeneralIntro/ch-E.html).

#### Must Support

The use of ```mustSupport``` in StructureDefinition profiles equivalent to the IHE use of **R2** as defined in [Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.10-profiling-conventions-for-constraints-on-fhir).

mustSupport of true - only has a meaning on items that are minimal cardinality of zero (0), and applies only to the source actor populating the data. The source actor shall populate the elements marked with MustSupport, if the concept is supported by the actor, a value exists, and security and consent rules permit.
The consuming actors should handle these elements being populated or being absent/empty.
Note that sometimes mustSupport will appear on elements with a minimal cardinality greater than zero (0), this is due to inheritance from a less constrained profile.

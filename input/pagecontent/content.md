The following are the FHIR Consent profiling for the PCF profile. The FHIR Consent fundamentals are [explained in Appendix P](ch-P.html#FHIR-Explainer).

### 3:5.8.1 Foundation Policies

The [Foundation Consent](StructureDefinition-IHE.PCF.consentBasic.html) Content Profile indicates the common constraints for all of PCF. There are no examples of this as there is no intended use of this profile.

<a name="basic"> </a>

### 3:5.8.2 Basic

Using [Basic Consent](StructureDefinition-IHE.PCF.consentBasic.html) Content Profile

Examples for this Resource Profile:

- [Basic Consent to sharing for Treatment policy](Consent-ex-consent-basic-treat.html)
- [Basic Consent with an Ink signature](Consent-ex-consent-basic-ink.html)
- [Basic Consent that Rejects the base policy given](Consent-ex-consent-basic-reject.html)
  - This could also be a representation of a situation when the patient has changed to rejection of a prior agreement
- [Consent that has expired](Consent-ex-consent-expired-treat.html)

<a name="intermediate"> </a>

### 3:5.8.3 Intermediate

Using [Intermediate Consent](StructureDefinition-IHE.PCF.consentIntermediate.html) Content Profile

Examples for this Resource Profile:

- restricted Consent to data [authored in a timeframe](Consent-ex-consent-intermediate-timeframe.html)
  - restricted **exception** to data [authored in a timeframe](Consent-ex-consent-intermediate-not-timeframe.html)
- restricted consent to a [named set of data](Consent-ex-consent-intermediate-data.html)
  - restricted **exception** to a [named set of data](Consent-ex-consent-intermediate-not-data.html)
- restricted consent to [data authored by a Practitioner](Consent-ex-consent-intermediate-authoredby.html)
  - restricted **exception** to [data authored by a Practitioner](Consent-ex-consent-intermediate-not-authoredby.html)
- restricted consent to data [related to an encounter](Consent-ex-consent-intermediate-encounter.html)
  - restricted **exception** to data [related to an encounter](Consent-ex-consent-intermediate-not-encounter.html)
- restricted consent to specific [intermediate purpose of use](Consent-ex-consent-intermediate-purpose.html)
  - restricted **exception** to specific intermediate purpose of use. TODO: Not clear to me what an example like this would be. Seems the root use of purpose of use is sufficient?

<a name="advanced"> </a>

### 3:5.8.4 Advanced

Using [Advanced Consent](StructureDefinition-IHE.PCF.consentAdvanced.html) Content Profile

Examples for this Resource Profile:

- Consent to [allow NORMAL data access](Consent-ex-consent-advanced-normal.html)
- Consent to [allow NORMAL and RESTRICTED data access](Consent-ex-consent-advanced-normal-restricted.html)
- Consent to [allow NORMAL data access but not RESTRICTED](Consent-ex-consent-advanced-normal-not-restricted.html) -- This adds the not restricted which should not be needed as the root only authorizes NORMAL.
- Consent to [allow NORMAL data access, and some access to RESTRICTED](Consent-ex-consent-advanced-normal-focused-restricted.html)
- Consent to [allow NORMAL data access, and some access to Mental Health](Consent-ex-consent-advanced-normal-focused-psy.html)
- Consent to [allow NORMAL data access, and some access to Mental Health and Sexual Health](Consent-ex-consent-advanced-normal-focused-psy-or-sex.html)

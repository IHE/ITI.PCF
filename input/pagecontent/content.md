
## 3:5.8 Patient Consent Patterns

The following are the FHIR Consent profiling for the PCF profile.


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

- restricted Consent to data authored in a timeframe
  - restricted **exception** to data authored in a timeframe
- restricted consent to a named set of data
  - restricted **exception** to data authored in a timeframe
- restricted consent to data authored by a Practitioner
  - restricted **exception** to data authored by a Practitioner
- restricted consent to data related to an encounter
  - restricted **exception** to data related to an encounter
- restricted consent to specific purpose of use
  - restricted **exception** to specific purpose of use

<a name="advanced"> </a>

### 3:5.8.4 Advanced

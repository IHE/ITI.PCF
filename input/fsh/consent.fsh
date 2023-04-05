
RuleSet:        FoundationConsent
/*
Using a RuleSet so that the foundational constraints are consistent and show up in the profiles

- status 1..1 - would indicate active
- scope 1..1 - #patient-privacy
- category 1..1 - would indicate patient consent, specifically a delegation of authority
- identifier 0..1 - no defined use in PCF. This could carry business identifiers assigned to the consent instance
- patient 1..1 - would indicate the Patient resource reference for the given patient
- dateTime 1..1 - would indicate when the privacy policy was presented
- performer 1.. - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization 1.. - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
- source 1..1 - would point at the specific signed consent by the patient
- policy.uri 1..1 - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
- provision.type 1..1 - permit indicates agreement with the policy, deny would indicate rejection.
- provision.actor 0..* - would indicate those being granted permit / denied access, if empty then all in the community
- provision.actor.role - fixed value IRCP to indicate information recipient.
- provision.purpose - would indicate some set of authorized purposeOfUse
- provision.period MS - would indicate a sunset for the consent if applicable, empty means no expiration
- provision.provisions are allowed

Not allowed in PCF
- provision.provision.provisions - **NOT allowed**, no clear use-case need and would add complexity
- policy.authority - **not used** in PCF, unclear the use-case need
- policyRule - **not used** in PCF, unclear the use-case need
- verification - **not used** in PCF, unclear the use-case need
- provision.action - **not used** in PCF. The purpose is sufficient.
- provision.class - **not used** in PCF, unclear the use-case need
- provision.code - **not used** in PCF, unclear the use-case need

Not constrained here as constrained by derived profiles (basic, intermediate, advanced)
- securityLabel
*/
* status 1..1
* scope 1..1
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category 1..
// TODO should we define a category for basic vs intermediary vs advanced
* patient 1..1
* dateTime 1..1
* performer 1..
* organization 1..
* source[x] 1..1
* policy.uri 1..1
* policy.authority 0..0
* policyRule 0..0
* verification 0..0
* provision.type 1..1
* provision.period MS
* provision.purpose MS
* provision.actor MS
* provision.actor.role = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP
* provision.action 0..0
* provision.class 0..0
* provision.code 0..0
* provision.provision.provision 0..0



Profile:        BasicConsent
Parent:         Consent
Id:             IHE.PCF.consentBasic
Title:          "IHE PCF Explicit Basic Consent"
Description:    """
Explicit Basic Consent 

- status 1..1 - would indicate active
- scope 1..1 - #patient-privacy
- category 1..1 - would indicate patient consent, specifically a delegation of authority
- identifier 0..1 - no defined use in PCF. This could carry business identifiers assigned to the consent instance
- patient 1..1 - would indicate the Patient resource reference for the given patient
- dateTime 1..1 - would indicate when the privacy policy was presented
- performer 1.. - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization 1.. - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
- source 1..1 - would point at the specific signed consent by the patient
- policy.uri 1..1 - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
- provision.type 1..1 - permit indicates agreement with the policy, deny would indicate rejection.
- provision.actor 0..* - would indicate those being granted permit / denied access, if empty then all in the community
- provision.actor.role - fixed value IRCP to indicate information recipient.
- provision.purpose - would indicate some set of authorized purposeOfUse
- provision.period MS - would indicate a sunset for the consent if applicable, empty means no expiration
- provision.provisions are allowed

Not allowed in PCF
- provision.provision.provisions - **NOT allowed**, no clear use-case need and would add complexity
- policy.authority - **not used** in PCF, unclear the use-case need
- policyRule - **not used** in PCF, unclear the use-case need
- verification - **not used** in PCF, unclear the use-case need
- provision.action - **not used** in PCF. The purpose is sufficient.
- provision.class - **not used** in PCF, unclear the use-case need
- provision.code - **not used** in PCF, unclear the use-case need

Specifics of Basic:
- provision.purpose - would indicate some set of authorized purposeOfUse only Treatment, Payment, Operations, or Break-Glass, see Intermediate
- provision.securityLabel is not allowed, see Intermediate
- provision.dataPeriod is not allowed, see Intermediate
- provision.data is nto allowed, see Intermediate
- provision.provision are NOT allowed, see Intermediate
"""
* insert FoundationConsent
* provision.securityLabel 0..0
* provision.purpose from BasicPurposeVS (required)
* provision.dataPeriod 0..0
* provision.data 0..0
* provision.provision 0..0

ValueSet: BasicPurposeVS
Title: "Basic Purpose ValueSet"
Description: "ValueSet of the PurposeOfUse minimally required by Basic Option"
* ^experimental = false
* http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* http://terminology.hl7.org/CodeSystem/v3-ActReason#BTG

Profile:        IntermediateConsent
Parent:         Consent
Id:             IHE.PCF.consentIntermediate
Title:          "IHE PCF Explicit Intermediate Consent"
Description:    """
Explicit Intermediate Consent 

- all elements allowed by Basic are allowed here, plus the following
- restriction at the root `.provision` apply to the whole Consent
  - restrictions at the `.provision.provision` are exceptions to the base consent
  - no `.provision.provision.provisions` are allowed
- data authored in a timeframe is specified in the `.dataPeriod` element
- explicit data objects are indicated in the `.data` element with `.meaning` of `#instance`
- data with relationship to an object are indicated in a `.data` element with `.meaning` of `#related`
- data authored by a given actor is indicated in the `.data` element with `.meaning` of `#authoredby`
- purposes of use activities are indicated in the `.purpose` element
- `securityLabel` is not allowed, see Advanced
"""
* insert FoundationConsent
* provision.provision MS
* provision.securityLabel 0..0
* provision.dataPeriod MS
* provision.provision.dataPeriod MS
* provision.data MS
* provision.data ^slicing.discriminator.type = #value
* provision.data ^slicing.discriminator.path = "meaning"
* provision.data ^slicing.rules = #closed
* provision.data contains 
  iData 0..* and
  rData 0..* and 
  aData 0..*
* provision.data[iData].meaning = #instance
* provision.data[rData].meaning = #related
* provision.data[rData].reference only Reference(Encounter or CarePlan or EpisodeOfCare)
* provision.data[aData].meaning = #authoredby
* provision.data[aData].reference only Reference(Practitioner or PractitionerRole or Organization or Device or Group or CareTeam or Patient or RelatedPerson)
* provision.provision.data MS
* provision.provision.data ^slicing.discriminator.type = #value
* provision.provision.data ^slicing.discriminator.path = "meaning"
* provision.provision.data ^slicing.rules = #closed
* provision.provision.data contains 
  iDataP 0..1 and
  rDataP 0..1 and 
  aDataP 0..1
* provision.provision.data[iDataP].meaning = #instance
* provision.provision.data[rDataP].meaning = #related
* provision.provision.data[rDataP].reference only Reference(Encounter or CarePlan or EpisodeOfCare)
* provision.provision.data[aDataP].meaning = #authoredby
* provision.provision.data[aDataP].reference only Reference(Practitioner or PractitionerRole or Organization or Device or Group or CareTeam or Patient or RelatedPerson)
* provision.purpose MS 
* provision.provision.purpose MS


Profile:        AdvancedConsent
Parent:         Consent
Id:             IHE.PCF.consentAdvanced
Title:          "IHE PCF Explicit Advanced Consent"
Description:    """
Explicit Advanced Consent 

- all elements allowed by Basic and Intermediate are allowed here, plus the following
- `securityLabel` indicates sensitivity or confidentiality tags on data
  - Only codes from [Avanced Security Tag ValueSet](ValueSet-AdvancedSecurityTagVS.html)
"""
* insert FoundationConsent
* provision.provision MS
* provision.securityLabel  from AdvancedSecurityTagVS (required)
* provision.provision.securityLabel  from AdvancedSecurityTagVS (required)

ValueSet: AdvancedSecurityTagVS
Title: "Advanced Security Tag ValueSet"
Description: """
ValueSet of the security tags allowed in Advanced Consent Option

At a minimum the following stigmatizing [Sensitivity](https://terminology.hl7.org/ValueSet-v3-InformationSensitivityPolicy.html) classifications shall be implemented as parameters:

- `ETH` -- Substance Abuse including Alcohol
  - `ETHUD` -- Alcohol substance abuse
  - `OPIOIDUD` -- Opioid drug abuse
- `PSY` -- Psychiatry Disorder / Mental Health
- `SEX` -- Sexual Assault, Abuse, or Domestic Violence
- `HIV` -- HIV/AIDS

At a minimum the following [ConfidentialityCodes](https://terminology.hl7.org/ValueSet-v3-Confidentiality.html) shall be implemented as parameters:

- `N` Normal and
- `R` Restricted
"""
* ^experimental = false
* http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R
* http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* http://terminology.hl7.org/CodeSystem/v3-ActCode#ETH
* http://terminology.hl7.org/CodeSystem/v3-ActCode#ETHUD
* http://terminology.hl7.org/CodeSystem/v3-ActCode#OPIOIDUD
* http://terminology.hl7.org/CodeSystem/v3-ActCode#PSY
* http://terminology.hl7.org/CodeSystem/v3-ActCode#SEX
* http://terminology.hl7.org/CodeSystem/v3-ActCode#HIV
 




Instance: ex-documentreference
InstanceOf: DocumentReference
Title: "DocumentReference Consent Paperwork example"
Description: """
DocumentReference example of the paperwork of the Consent

This is showing an example of a document that is purely text.
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #current
* type = http://loinc.org#64292-6 "Release of information consent"
* subject = Reference(Patient/ex-patient)
* author = Reference(Organization/ex-organization)
* description = "The captured signed document"
* content.attachment.title = "Hello World"
* content.attachment.contentType = #text/plain
* content.attachment.data = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdCwgc2VkIGRvIGVpdXNtb2QgdGVtcG9yIGluY2lkaWR1bnQgdXQgbGFib3JlIGV0IGRvbG9yZSBtYWduYSBhbGlxdWEuIFV0IGVuaW0gYWQgbWluaW0gdmVuaWFtLCBxdWlzIG5vc3RydWQgZXhlcmNpdGF0aW9uIHVsbGFtY28gbGFib3JpcyBuaXNpIHV0IGFsaXF1aXAgZXggZWEgY29tbW9kbyBjb25zZXF1YXQuIER1aXMgYXV0ZSBpcnVyZSBkb2xvciBpbiByZXByZWhlbmRlcml0IGluIHZvbHVwdGF0ZSB2ZWxpdCBlc3NlIGNpbGx1bSBkb2xvcmUgZXUgZnVnaWF0IG51bGxhIHBhcmlhdHVyLiBFeGNlcHRldXIgc2ludCBvY2NhZWNhdCBjdXBpZGF0YXQgbm9uIHByb2lkZW50LCBzdW50IGluIGN1bHBhIHF1aSBvZmZpY2lhIGRlc2VydW50IG1vbGxpdCBhbmltIGlkIGVzdCBsYWJvcnVtLg=="
// Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.




Instance: ex-consent-basic-treat
InstanceOf: BasicConsent
Title: "Consent for treatment example"
Description: """
Consent for purposes of use involved in treatment: Treatment/Payment/Operations

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT


Instance: ex-consent-basic-ink
InstanceOf: BasicConsent
Title: "Consent for treatment example with ink signature"
Description: """
Consent for purposes of use involved in treatment: Treatment/Payment/Operations

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference -- Ink signature on paper
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-consent-ink)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT


Instance: ex-consent-expired-treat
InstanceOf: BasicConsent
Title: "Consent for treatment example"
Description: """
Consent for purposes of use involved in treatment: Treatment/Payment/Operations

This is a BasicConsent, that has expired, example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO
- **provision period end was at December 31, 2022 -- thus this Consent has expired.**
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.period.end = "2022-12-31"

Instance: ex-consent-basic-reject
InstanceOf: BasicConsent
Title: "Dissent for treatment example"
Description: """
Dissent for purposes of use involved in treatment: Treatment/Payment/Operations

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- **base provision is #deny -- rejecting the indicated policy**
- base provision includes TPO so as to be clear this is a consent about TPO
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #deny
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT




Instance: ex-consent-ink
InstanceOf: DocumentReference
Title: "Binary example using DocumentReference"
Description: "Example of a scanned image of an ink signature in binary using DocumentReference."
* status = #current
* content.attachment.url = "Binary/B-ink"
* content.attachment.contentType = #image/png


// binary throws a File Type error that DocumentReference does not
// likely needs a IG extension - implementationguide-resource-format
Instance: B-ink
InstanceOf: Binary
Title: "Binary example using Binary"
Description: "Example of a binary ink signed document."
* contentType = #image/png
* data = "ig-loader-ink.png"


// TODO -- might bring in a BPPC DocumentReference and possibly show a derived Consent off of that. Might this be a grouping behavior when PCF+MHD+BPPC?




Instance: ex-consent-intermediate-timeframe
InstanceOf: IntermediateConsent
Title: "Consent allowing data authored within a timeframe"
Description: """
Consent allowing data authored within a timeframe

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- access only data authored within 2022
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.dataPeriod.start = 2022-01
* provision.dataPeriod.end = 2022-12


Instance: ex-consent-intermediate-not-timeframe
InstanceOf: IntermediateConsent
Title: "Consent allowing most sharing but NOT data authored within a timeframe"
Description: """
Consent allowing most sharing of data but NOT data authored within a timeframe

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- permit form most uses
- a sub-provision denying access to data authored within 2022
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.provision.type = #deny
* provision.provision.dataPeriod.start = 2022-01
* provision.provision.dataPeriod.end = 2022-12



Instance: ex-consent-intermediate-authoredby
InstanceOf: IntermediateConsent
Title: "Consent allowing data authored by a practitioner"
Description: """
Consent allowing data authored by

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- authored by ex-practitioner
  - [practitioner 1](Practitioner-ex-practitioner.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.data[aData].meaning = #authoredby
* provision.data[aData].reference = Reference(Practitioner/ex-practitioner)


Instance: ex-consent-intermediate-not-authoredby
InstanceOf: IntermediateConsent
Title: "Consent allowing most sharing but NOT data authored by a practitioner"
Description: """
Consent allowing most sharing of data but NOT data authored by a practitioner

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- a sub-provision denying access to data authored by ex-practitioner
  - [practitioner 1](Practitioner-ex-practitioner.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.provision.type = #deny
* provision.provision.data[aDataP].meaning = #authoredby
* provision.provision.data[aDataP].reference = Reference(Practitioner/ex-practitioner)


Instance: ex-consent-intermediate-encounter
InstanceOf: IntermediateConsent
Title: "Consent allowing data authored related to a encounter"
Description: """
Consent allowing data authored related to a encounter

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- authored within an encounter
  - [encounter 1](Encounter-ex-encounter.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.data[rData].meaning = #related
* provision.data[rData].reference = Reference(Encounter/ex-encounter)


Instance: ex-consent-intermediate-not-encounter
InstanceOf: IntermediateConsent
Title: "Consent allowing most sharing but NOT data authored by a practitioner"
Description: """
Consent allowing most sharing of data but NOT data authored by a practitioner

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- a sub-provision denying access to data authored within an encounter
  - [encounter 1](Encounter-ex-encounter.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.provision.type = #deny
* provision.provision.data[rDataP].meaning = #related
* provision.provision.data[rDataP].reference = Reference(Encounter/ex-encounter)




Instance: ex-consent-intermediate-data
InstanceOf: IntermediateConsent
Title: "Consent allowing specific data"
Description: """
Consent allowing specific data

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- with specific data itemized.
  - [alcohol use 1](Observation-ex-alcoholUse.html)
  - [blood sugar 1](Observation-ex-bloodSugar.html)
  - [blood pressure 1](Observation-ex-bloodPressure.html)
  - [weight 1](Observation-ex-weight.html)
  - [weight 2](Observation-ex-weight-stone.html)
  - [encounter 1](Encounter-ex-encounter.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.data[iData][+].meaning = #instance
* provision.data[iData][=].reference = Reference(Encounter/ex-encounter)
* provision.data[iData][+].meaning = #instance
* provision.data[iData][=].reference = Reference(Observation/ex-weight-stone)
* provision.data[iData][+].meaning = #instance
* provision.data[iData][=].reference = Reference(Observation/ex-weight)
* provision.data[iData][+].meaning = #instance
* provision.data[iData][=].reference = Reference(Observation/ex-bloodPressure)
* provision.data[iData][+].meaning = #instance
* provision.data[iData][=].reference = Reference(Observation/ex-bloodSugar)
* provision.data[iData][+].meaning = #instance
* provision.data[iData][=].reference = Reference(Observation/ex-alcoholUse)


Instance: ex-consent-intermediate-not-data
InstanceOf: IntermediateConsent
Title: "Consent allowing most sharing but NOT data authored by a practitioner"
Description: """
Consent allowing most sharing of data but NOT data authored by a practitioner

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Intermediate part:
- a sub-provision denying access to a specific data instance
  - [alcohol use 1](Observation-ex-alcoholUse.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.provision.type = #deny
* provision.provision.data[iDataP][+].meaning = #instance
* provision.provision.data[iDataP][=].reference = Reference(Observation/ex-alcoholUse)



Instance: ex-org-researcher
InstanceOf: Organization
Title: "Example Organization doing the FooBar Research"
Description: "The Organization that is allowed access for FooBar research project"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* name = "research house org"


Instance: ex-consent-intermediate-purpose
InstanceOf: IntermediateConsent
Title: "Consent allowing data access for a given intermediate purpose"
Description: """
Consent allowing data access for a given intermediate purpose

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- base provision is #permit -- accepting the policy

This is the Intermediate part:
- Intermediate PurposeOfUse are those that fall outside the basic purposeOfUse valueset
- In this case the PurposeOfUse will be for a Clinical Research Project -- FooBar
- given that the intermediate purpose is a Clinical Research project, then the policy URI will also be different
- allowing a given purpose beyond the basic purpose valueSet
- Given this is a research project, also have included the research organization as actor
  - [research org](Organization-ex-org-researcher.html)
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/researchFooBar.txt"
* provision.type = #permit
* provision.purpose[+] = http://example.org/policies/purposeOfUse#FooBar
* provision.actor.reference = Reference(Organization/ex-org-researcher)
* provision.actor.role = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP


Instance: ex-consent-advanced-normal
InstanceOf: AdvancedConsent
Title: "Consent allowing NORMAL data access"
Description: """
Consent allowing NORMAL data access 

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Advanced part:
- Normal data only
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N


Instance: ex-consent-advanced-normal-restricted
InstanceOf: AdvancedConsent
Title: "Consent allowing NORMAL and RESTRICTED data access"
Description: """
Consent allowing NORMAL and RESTRICTED data access 

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Advanced part:
- Normal and Restricted data only
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R


Instance: ex-consent-advanced-normal-not-restricted
InstanceOf: AdvancedConsent
Title: "Consent allowing NORMAL and RESTRICTED data access"
Description: """
Consent allowing NORMAL data access but NOT RESTRICTED. The exclusion of RESTRICTED should not be needed, given permit is only Normal

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Advanced part:
- Normal data only
- Not Restricted data only
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* provision.provision.type = #deny
* provision.provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R



Instance: ex-consent-advanced-normal-focused-restricted
InstanceOf: AdvancedConsent
Title: "Consent allowing NORMAL and focused RESTRICTED data access"
Description: """
Consent allowing NORMAL data access but only focused RESTRICTED.

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Advanced part:
- Normal data only
- only Practitioner gets Restricted data only
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* provision.provision.type = #permit
* provision.provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R
* provision.actor.reference = Reference(Practitioner/ex-practitioner)
* provision.actor.role = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP



Instance: ex-consent-advanced-normal-focused-psy
InstanceOf: AdvancedConsent
Title: "Consent allowing NORMAL and focused Mental Health data access"
Description: """
Consent allowing NORMAL data access but only focused Mental Health Abuse.

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Advanced part:
- Normal data only
- only Practitioner gets Mental Health data only
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* provision.provision.type = #permit
* provision.provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-ActCode#PSY
* provision.actor.reference = Reference(Practitioner/ex-practitioner)
* provision.actor.role = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP




Instance: ex-consent-advanced-normal-focused-psy-or-sex
InstanceOf: AdvancedConsent
Title: "Consent allowing NORMAL and focused access to Mental Health or Sexual Health data"
Description: """
Consent allowing NORMAL and focused access to Mental Health or Sexual Health data.

This is a BasicConsent example:
- status is active - so it should be enforced
- scope is privacy 
- category is LOINC 59284-0 Consent
- date indicated when the consent is recorded
- patient is identified
- performer is the patient
- organization is identified
- source indicate a DocumentReference (with included text of the policy)
- policy url is to a base policy -- TODO likely should define some canonical URI for the base policies in PCF?
- base provision is #permit -- accepting the policy
- base provision includes TPO so as to be clear this is a consent about TPO

This is the Advanced part:
- Normal data only
- only Practitioner gets Mental Health or Sexual Health data
"""
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[+] = http://loinc.org#59284-0 "Consent"
* patient = Reference(Patient/ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/basePrivacyConsentPolicy.txt"
* provision.type = #permit
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#TREAT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HPAYMT
* provision.purpose[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HOPERAT
* provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* provision.provision.type = #permit
* provision.provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-ActCode#PSY
* provision.provision.securityLabel[+] = http://terminology.hl7.org/CodeSystem/v3-ActCode#SEX
* provision.actor.reference = Reference(Practitioner/ex-practitioner)
* provision.actor.role = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP



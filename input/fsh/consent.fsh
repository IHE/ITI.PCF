Profile:        BasicConsent
Parent:         Consent
Id:             IHE.PCF.consentBasic
Title:          "IHE PCF Basic Consent"
Description:    """
Basic Consent 

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
- provision.provisions are allowed
- provision.provision.provisions are NOT allowed
"""
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
* policyRule 0..0
* verification 0..0
* provision.type 1..1
* provision.period MS
* provision.actor 0..*
* provision.action 0..0
* provision.securityLabel 0..0
* provision.purpose 0..*
// TODO valueSet for purpose of use of TPOB
* provision.class 0..0
* provision.code 0..0
* provision.dataPeriod MS
* provision.data 0..0
* provision.provision 0..0




Instance: ex-organization
InstanceOf: Organization
Title: "Example Organization holding the data"
Description: "The Organization that holds the data, and enforcing any Consents"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* name = "somewhere org"

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


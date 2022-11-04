Profile:        BasicConsent
Parent:         Consent
Id:             IHE.PCF.consentBasic
Title:          "IHE PCF Basic Consent"
Description:    """
* status 1..1 - would indicate active
* scope 1..1 - #patient-privacy
* category 1..1 - would indicate patient consent, specifically a delegation of authority
* patient 1..1 - would indicate the Patient resource reference for the given patient
* dateTime 1..1 - would indicate when the privacy policy was presented
* performer 1..1 - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
* organization 1..1 - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
* source 1..1 - would point at the specific signed consent by the patient
* policy.uri 1..1 - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
* provision.type 1..1 - permit - given there is no way to deny, this would be fixed at permit.
* provision.agent 0..* - would indicate the those being authorized resource, if empty then all in the community
* provision.agent.role - would indicate this agent is delegated authority
* provision.purpose - would indicate some set of authorized purposeOfUse
* provision.period MS - would indicate a sunset for the consent if applicable, empty means no expiration
* provision.provisions are allowed
* provision.provision.provisions are NOT allowed
"""
* status 1..1
* scope 1..1
* category 1..1
* patient 1..1
* dateTime 1..1
* performer 1..1
* organization 1..1
* source[x] 1..1
* policy.uri 1..1
* provision.type 1..1
* provision.actor 0..*
* provision.purpose 0..*
* provision.dataPeriod MS
* provision.provision 0..*
* provision.provision.provision 0..0





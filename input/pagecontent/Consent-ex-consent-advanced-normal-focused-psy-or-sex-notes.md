#### IUA Access Token

Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

 Given that the token will express the permit portion, the `residual` would need to express the refinement. This case allows treatment access to normal data, and carves out mental health data and sexual health data as accessible only to [Practitioner](Practitioner-ex-practitioner.html). The oAuth token would be expressing a general permit for most users to the given patient data. Possibly with scope restrictions based on other business rules, such as a subset of actions (CRUDE) and resources.

The token would need to include an `ihe_pcf` extension to point at this consent, and that would include a `residual` to express the refinement. Shown as followed:

For Users that are not [Practitioner](Practitioner-ex-practitioner.html), the token **result** will be no different than consent to [allow NORMAL data access](Consent-ex-consent-advanced-normal.html)
  - ITI-71 [access token](Consent-ex-consent-advanced-normal.html#notes)

For the User [Practitioner](Practitioner-ex-practitioner.html), the token **result** will be:

- The restriction to the given purpose (Treatment, Payment, and Operations) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below.
- The restriction to just normal data would need to be expressed:
  - First as a forbid everything
  - Second as a permit normal data
- Third is to permit Mental Health data and Sexual Health Data

```json
"extensions" : {
  "ihe_iua" : {
    ...
    "purpose_of_use" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
        "code" : "TREAT"
      },{
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
        "code" : "HPAYMT"
      },{
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
        "code" : "HOPERAT"
    }]
  }
  "ihe_pcf" : {
    "patient_id" : "http://example.org/fhir/Patient/ex-patient",
    "doc_id" : "http://example.org/fhir/Consent/ex-consent-intermediate-authoredby",
    "residual" : [
      {
        "type" : "forbid",
      },{
        "type" : "permit",
        "securityLabel" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-Confidentiality",
            "code" : "N"
        }]
      },{
        "type" : "permit",
        "securityLabel" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
            "code" : "PSY"
          },{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
            "code" : "SEX"
        }]
      }
    ]
  }
}
```

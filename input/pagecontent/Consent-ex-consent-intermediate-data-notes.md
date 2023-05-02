#### IUA Access Token

Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

Given that the token will express the permit portion, the `residual` would need to express the refinement. In this case, given that the data filter is at the root, it means that nothing BUT the data is allowed. The oAuth token would be expressing a general permit for the given user to the given patient data. Possibly with scope restrictions based on other business rules, such as a subset of actions (CRUDE) and resources.

The token would need to include an `ihe_pcf` extension to point at this consent, and that would include a `residual` to express the refinement. Shown as followed:

- The restriction to the given purpose (Treatment, Payment, and Operations) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below
- The restriction to the given set of data would need to be expressed:
  - First as a forbid everything
  - Second as a permit that specific data

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
    "doc_id" : ["http://example.org/fhir/Consent/ex-consent-intermediate-data"],
    "residual" : [
      {
        "type" : "forbid",
      },{
        "type" : "permit",
        "data" : [{
            "meaning" : "instance",
            "reference" : {
            "reference" : "http://example.org/fhir/Encounter/ex-encounter"
            }
        },{
            "meaning" : "instance",
            "reference" : {
            "reference" : "http://example.org/fhir/Observation/ex-weight-stone"
            }
        },{
            "meaning" : "instance",
            "reference" : {
            "reference" : "http://example.org/fhir/Observation/ex-weight"
            }
        },{
            "meaning" : "instance",
            "reference" : {
            "reference" : "http://example.org/fhir/Observation/ex-bloodPressure"
            }
        },{
            "meaning" : "instance",
            "reference" : {
            "reference" : "http://example.org/fhir/Observation/ex-bloodSugar"
            }
        },{
            "meaning" : "instance",
            "reference" : {
            "reference" : "http://example.org/fhir/Observation/ex-alcoholUse"
            }
        }]
      }
    ]
  }
}
```

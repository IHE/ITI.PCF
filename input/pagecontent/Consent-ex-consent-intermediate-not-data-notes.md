#### IUA Access Token

Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

 Given that the token will express the permit portion, the `residual` would need to express the refinement. In this case one resource should be forbidden. The oAuth token would be expressing a general permit for the given user to the given patient data. Possibly with scope restrictions based on other business rules, such as a subset of actions (CRUDE) and resources.

The token would need to include an `ihe_pcf` extension to point at this consent, and that would include a `residual` to express the refinement. Shown as followed:

- The restriction to the given purpose (Treatment, Payment, and Operations) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below.
- The restriction to the given one data resource would need to be expressed:

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
    "doc_id" : "http://example.org/fhir/Consent/ex-consent-intermediate-not-data",
    "residual" : [
      {
        "type" : "forbid",
        "data" : [{
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

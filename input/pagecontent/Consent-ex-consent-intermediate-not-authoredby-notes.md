Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

 Given that the token will express the permit portion, the `residual` would need to express the refinement. In this case the oAuth token and scope will address a general permit, and thus the `residual` need only express the forbid to information authored by the given practitioner.

The token would need to include an `ihe_pcf` extension to point at this consent, and that would include a `residual` to express the refinement. Shown as followed:

- The restriction to the given purpose (Treatment, Payment, and Operations) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below.
- The restriction to forbid data authored by the given practitioner would be expressed

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
    "doc_id" : "http://example.org/fhir/Consent/ex-consent-intermediate-not-authoredby",
    "residual" : [
      {
        "type" : "permit",
        "data" : [{
            "meaning" : "authoredby",
            "reference" : {
            "reference" : "http://example.org/fhir/Practitioner/ex-practitioner"
            }
        }]
      }
    ]
  }
}
```

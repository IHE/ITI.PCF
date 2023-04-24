Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

 Given that the token will express the permit portion, the `residual` would need to express the refinement. In this case, given that the timeframe filter is at the root, it means that nothing BUT the information authored in that timeframe is allowed. The oAuth token would be expressing a general permit for the given user to the given patient data. Possibly with scope restrictions based on other business rules, such as a subset of actions (CRUDE) and resources.

The token would need to include an `ihe_pcf` extension to point at this consent, and that would include a `residual` to express the refinement. Shown as followed:

- The restriction to the given purpose (Treatment, Payment, and Operations) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below.
- The restriction to data timeframe would need to be expressed:
  - first `forbid` all data
  - second `permit` data authored in the given timeframe

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
    "patient_id" : "Patient/ex-patient",
    "doc_id" : "Consent/ex-consent-intermediate-timeframe",
    "residual" : [
      {
        "type" : "forbid",
      }, {
        "type" : "permit",
        "dataPeriod" : {
          "start" : "2022-01-01",
          "end" : "2022-12-31"
        }
      }
    ]
  }
}
```

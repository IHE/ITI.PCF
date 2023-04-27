#### IUA Access Token

Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following PCF specific element to inform the **Consent Enforcement Point**. 

 In this case there is no residual, as the Consent expresses that authorization be given for a given purpose of use. Possibly with scope restrictions based on other business rules, such as a subset of actions (CRUDE) and resources. No token would be issued by ITI-71 for users not authorized, or requests beyond the set of purpose of use.

- The restriction to the given purpose (FooBar) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below.
- The consent is indicated in the `ihe_pcf`.
  - no `residual` element is provided, indicating that no residual rules need be enforced.

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
    "doc_id" : ["http://example.org/fhir/Consent/ex-consent-basic-treat"]
  }
}
```

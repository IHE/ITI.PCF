This Consent denies all access except for break-glass; thus any access request that has not declared break-glass purposeOfUse (BTG), or for which the user is not authorized to declare break-glass; would be rejected and not given any access token. This rejection would be recognized by users that know that they are authorized to break-glass that they might choose to declare a break-glass safety concern. There might be more refined user-interface or user-experience than this, but specification of that user-interface is out of the scope of PCF.

Provided an [ITI-71](other.html#updates-to-iti-71) is requested by an authorized user with PurposeOfUse indicating break-glass, then this would result in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

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
        "code" : "BTG"
    }]
  }
  "ihe_pcf" : {
    "patient_id" : "http://example.org/fhir/Patient/ex-patient",
    "doc_id" : "http://example.org/fhir/Consent/ex-consent-intermediate-dissent-break-glass",
  }
}
```

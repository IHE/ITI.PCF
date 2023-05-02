#### IUA Access Token

Provided an [ITI-71](other.html#updates-to-iti-71) results in a PERMIT access token issued. That token would have the following residual element to inform the **Consent Enforcement Point** that it needs to restrict the results.

In this case there is no residual, as the Consent expresses that authorization be given only to a given Research organization for a given purpose of use. Possibly with scope restrictions based on other business rules, such as a subset of actions (CRUDE) and resources. No token would be issued by ITI-71 for users not a part of the Research organization, or requests by that organization that are not purpose FooBar.

- The restriction to the given purpose (FooBar) would be expressed in the `ihe_iua` extension
  - The other `ihe_iua` extension parameters are not shown below
- The consent is indicated in the `ihe_pcf`
  - no `residual` element is provided, indicating that no residual rules need be enforced

```json
"extensions" : {
  "ihe_iua" : {
    ...
    "purpose_of_use" : [{
        "system" : "http://example.org/policies/purposeOfUse",
        "code" : "FooBar"
    }]
  }
  "ihe_pcf" : {
    "patient_id" : "http://example.org/fhir/Patient/ex-patient",
    "doc_id" : ["http://example.org/fhir/Consent/ex-consent-intermediate-purpose"]
  }
}
```

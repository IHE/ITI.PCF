<div markdown="1" class="stu-note">
This section modifies other IHE profiles or the General Introduction appendices and is not a part of the xxx Profile. The content here will be incorporated into the target narrative at a future time, usually when xxx Profile goes normative.
</div>

## IHE Technical Frameworks General Introduction Appendix A: Actors

|------------------------------------------------|
| Editor, add the following new or modified actors to the [IHE Technical Frameworks General Introduction Appendix A](https://profiles.ihe.net/GeneralIntro/ch-A.html): |
{:.grid .bg-info}

| Actor                         | Definition                                                                                |
| ----------------------------- | ------------------------------------------------------------------------------------------|
| none |  |
{:.grid .table-striped}



## IHE Technical Frameworks General Introduction Appendix B: Transactions

|------------------------------------------------|
| Editor, add the following new or modified transactions to the [IHE Technical Frameworks General Introduction Appendix B](https://profiles.ihe.net/GeneralIntro/ch-B.html): |
{:.grid .bg-info}


| Transaction                    | Definition                                                                              |
| ------------------------------ | --------------------------------------------------------------------------------------- |
| none |  |
{:.grid .table-striped}

## IHE Technical Frameworks General Introduction Appendix D: Glossary

|------------------------------------------------|
| Editor, add the following new or modified terms to the [IHE Technical Frameworks General Introduction Appendix D](https://profiles.ihe.net/GeneralIntro/ch-D.html): |
{:.grid .bg-info}

| Term                         | Definition                                                    | Acronyms/Abbreviations | Synonyms    |
| ---------------------------- | --------------------------------------------------------------| -----------------------| ------------|
| none |  |
{:.grid .table-striped}

## Updates to ITI-71

|------------------------------------------------|
| Editor, Update the IUA [Transaction ITI-71](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) as follows, adding section 3.71.4.2.2.1.4 |
{:.grid .bg-info}

###### 3.71.4.2.2.1.4 Privacy Consent on FHIR grouping

When grouped with the PCF Consent Authorization Server, and where the Access Decision includes consideration of Privacy Consent, the following oAuth extension shall be included.

The Authorization Server and Resource Server shall support the following `extensions` parameter:

- `patient_id`: Patient identifier related to the Patient Privacy Policy Identifier. Its value should be the patient identifier in CX syntax or as a FHIR full URL.
- `doc_id`: Patient Privacy Policy Acknowledgment Document. Its value should  be an URN or as a FHIR full URL.
- `acp`: Patient Privacy Policy Identifier. This is usually a URL to either a coded form and/or a human readable form. The URL would follow http negotiate to return the appropriate format given the mime-type negotiation.
- `residual`: Carries data that would be forbidden from being returned. Given that scope identifies what is overall allowed.

If present, the claims shall be wrapped in an `extensions` object with key `ihe_pcf` and a JSON value object containing the claims. Shown as a JSON Template:

```
"extensions" : {  
  "ihe_pcf" : {  
    "patient_id": { Reference(Patient)}, // who the consent subject is
    "doc_id": { Reference(Consent)}, // what the consent is
    "acp": "<uri>", // basis policy this is built upon
    "residual" : [{
      "type" : "<code>", // forbid | permit
      "securityLabel" : [{ Coding }], // Security Labels that define affected resources
      "dataPeriod" : { Period }, // Timeframe for data controlled by this rule
      "data" : [{ // Data controlled by this rule
        "meaning" : "<code>", // R!  instance | related | dependents | authoredby
        "reference" : { Reference(Any) } // R!  The actual data reference
      }],
    }]
  }
}
```

Given that the token is authorizing access to the defined Scope, then the `residual` is focused on results that would be forbidden to be returned (forbid). Note that `forbid` is not identical to `Consent.provision.type` of `deny` but is related:

- the oAuth scope indicates the gross data that is permitted
- residual `forbid` indicates data that is forbidden to be returned
- residual `permit` overrides an explicit residual `forbid`
- If no `forbid` applies, then the data is allowed to flow back to the requester

Example: Given [Consent allowing data authored within a timeframe](Consent-ex-consent-intermediate-timeframe.html), which limits access to only data authored within 2022. This is a root `.provision` restriction. Note that the purpose restriction is handled in in the [ITI-71](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) `purpose_of_use`, so the `residual` need only address the `dataPeriod`.

```json
  "provision" : {
    "type" : "permit",
    "dataPeriod" : {
      "start" : "2022-01-01",
      "end" : "2022-12-31"
    }
  }
```

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
      },
      {
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

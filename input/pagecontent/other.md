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
| Editor, Update the IUA Transaction ITI-71 as follows, adding section 3.71.4.2.2.1.4 |
{:.grid .bg-info}

####### 3.71.4.2.2.1.4 Privacy Consent on FHIR grouping

When grouped with the PCF Consent Authorization Server, and where the Access Decision includes consideration of Privacy Consent, the following oAuth extension shall be included.

The Authorization Server and Resource Server shall support the following extension parameter:

- `patient_id`: Patient identifier related to the Patient Privacy Policy Identifier. Its value should  be the patient identifier in CX syntax or as a FHIR full URL.
- `doc_id`: Patient Privacy Policy Acknowledgment Document. Its value should  be an URN or as a FHIR full URL.
- `acp`: Patient Privacy Policy Identifier. This is usually a URL to either a coded form and/or a human readable form. The URL would follow http negotiate to return the appropriate format given the mime-type negotiation.
- TODO: `other_values` will evolve as we include various rules to be enforced.

If present, the claims shall be wrapped in an "extensions" object with key 'ihe_pcf' and a JSON value object containing the claims, e.g.,

```json
"extensions" : {  
  "ihe_pcf" : {  
    "patient_id": "http://example.org/fhir/Patient/1",
    "doc_id": "http://example.org/fhir/Consent/1",
    "acp": "http://example.org/policies/privacyPolicy1",
    "other_value": "..."    
  }  
}
```

<div markdown="1" class="stu-note">
This section modifies other IHE profiles or the General Introduction appendices and is not a part of the PCF Profile. The content here will be incorporated into the target narrative at a future time, usually when PCF Profile goes normative.
</div>

## IHE Technical Frameworks General Introduction Appendix A: Actors

|------------------------------------------------|
| Editor, add the following new or modified actors to the [IHE Technical Frameworks General Introduction Appendix A](https://profiles.ihe.net/GeneralIntro/ch-A.html): |
{:.grid .bg-info}

| Actor                         | Definition                                                                                |
| ----------------------------- | ------------------------------------------------------------------------------------------|
| Consent Recorder | responsible for the capturing of consent from the Patient given policies available |
| Consent Registry | holds Consent resources |
| Consent Authorization Server | makes authorization decisions based on a given access requested context |
| Consent Enforcement Point | enforces consent decisions made by the **Consent Authorization Server** Actor |
{:.grid .table-striped}


## IHE Technical Frameworks General Introduction Appendix B: Transactions

|------------------------------------------------|
| Editor, add the following new or modified transactions to the [IHE Technical Frameworks General Introduction Appendix B](https://profiles.ihe.net/GeneralIntro/ch-B.html): |
{:.grid .bg-info}


| Transaction                    | Definition                                                                              |
| ------------------------------ | --------------------------------------------------------------------------------------- |
| [Access Consent] (ITI-108.html) \[ITI-71\]] |  used to Create, Read, Update, Delete, and Search on Consent resources |
{:.grid .table-striped}

## IHE Technical Frameworks General Introduction Appendix D: Glossary

|------------------------------------------------|
| Editor, add the following new or modified terms to the [IHE Technical Frameworks General Introduction Appendix D](https://profiles.ihe.net/GeneralIntro/ch-D.html): |
{:.grid .bg-info}

| Term                         | Definition                                                    | Acronyms/Abbreviations | Synonyms    |
| ---------------------------- | --------------------------------------------------------------| -----------------------| ------------|
**Trust Domain** | Systems and entities that are trusted due to membership in a domain, where this membership includes agreement with the policies of the trust domain. A Trust Domain often spans multiple domains, such as a Health Information Exchange or a Federation of Health Information Domains. An example is the [XDS Affinity Domain](https://profiles.ihe.net/ITI/TF/Volume1/ch-10.html), or the [XCA Community](https://profiles.ihe.net/ITI/TF/Volume1/ch-18.html).
**Patient Privacy Policy Domain** | The domain (Trust Domain) for which a Patient Privacy Policy applies. The Patient Privacy Policy Domain may cover an Organization, Health Information Exchange, or a defined set of Communities. The Patient Privacy Policy Domain is a Trust Domain.
**Domain Privacy Policy** / **Overarching Policy** | Defines acceptable use of private data within the domain. The overarching policy are defined and enforced in the broader context of a law, regulation, or organizational policy that defines the scope, authority, and limitations. Within the Domain Privacy Policy will be a set of Patient Privacy Policies, that are used at the Privacy Consent level. The Domain Privacy Policy is responsible for defining users, roles, classifications, and the possible parameters the patient will be offered during the Privacy Consent Ceremony. The Domain Privacy Policy must address the appropriate use of data when no Consent has been captured, how conflicting policies are to be resolved, and when a restriction may cause a patient or operator safety concern (e.g., Break-Glass).
**Patient Privacy Policy** | A Patient Privacy Policy explains appropriate use of data/documents in a way that provides choices to the patient. The Patient Privacy Policy sits within the Domain Privacy Policy. A Patient Privacy Policy will identify who has access to information, and what information is governed by the policy (e.g., under what conditions will **data** be marked as containing that type of information). The Patient Privacy Policy may be a consent policy, dissent policy, authorization policy, etc.
**Patient Privacy Consent Resource** | (a.k.a., Privacy Consent) A record resource that follows the BPPC profile or the PCF profile and captures the act of the consent ceremony and the details. The Consent references the basis Patient Privacy Policy. The Consent may be agreement with the policy, dissent with the policy, or may contain further constraints and authorizations based on the Patient Privacy Policy.
**Patient Privacy Policy Identifier** | A Patient Privacy Policy Domain-assigned globally unique identifier that identifies the Patient Privacy Policy.
**Patient Identified Data** |  Are data about an identified Patient. This may be health information, but for the purposes of this Appendix it is any personally identifiable information (PII).
**Data Holder** / **Custodian** | A controlling entity of some set of Patient Identifiable Data.
**Patient** / **Subject of data** / **Consumer** | The patient is the human-subject of health-related data. The use of the term patient is not to imply only subjects under current treatment.
**Privacy Consent** | (a.k.a., Consent) Binding agreement between the Patient / Subject of the data and the Data Holder as to the appropriate use of data. The consent may include constraints and obligations. The agreement may be executed by delegates, and the agreement may include other parties that are held to the terms. Consent term is used here in broad definition not limited by the definition of consent in regulation or laws.
**Privacy Consent Ceremony** | All the steps leading up to and including the acceptance by the Patient and Custodian of the terms of a Privacy Consent. The ceremony is responsible for assuring the patient is well informed and understands the terms. The ceremony may include many people and tools.
**Privacy Parameters** | Rules that are allowed to be specified by the patient as deviations from the Patient Privacy Policy. Such as limiting access to data published in a date range, data published by a given author, or data with a specific kind of restricted health sensitivity.
**Privacy Preferences** | Published by the Patient as desired privacy conditions. These preferences may be used during a Consent ceremony to inform the privacy conditions.
**Data Access Requests** | Defined interactions in which data are shared within a Trust Domain in keeping with the Patient Privacy Consent terms. Requests for data to leave the control of the Data Holder. Most requests will be from within a broader Trust Domain, but some requests may be to parties outside a Trust Domain.
**Authentic Requests** | Requests that can be proven to be from within the trust domain. Authentic Requests carry well-defined parameters of the request including identity of data recipient, purpose of use the data will be used, and the data characteristics scope.
**Data Classification** |  Patient identifiable data is considered health information and is subject to a set of constraints as given to normal health information.
**Security Labeling Service** | A service that classifies data into a defined set of sensitivity classifications.
**Normal Health Data** | The majority of Patient Identified Data are health information and is considered more sensitive than non-health information, this data would be classified as Normal Health Data. Normal Health Data is sensitive.
**Restricted Health Data** | Some Patient Identifiable Data are considered more sensitive and is classified as Restricted Health Data. Data may be considered Restricted by regulation or laws, or may be deemed by the patient to be more sensitive. Some examples of restricted health data are data that describes a stigmatizing sensitive health topic such as mental health, drug abuse, sexual health, or other.
**Users** | An identifiable agent, usually human, that has some defined role within the Organization within which they operate. A User may be the Patient herself, a patient related party, clinician, researcher, billing clerk, etc. These different functional roles will have different needs to access data. For example, registration clerks may need to be able to access patient demographics, billing, and contacts but would not need access to clinical content.
{:.grid .table-striped}

## Updates to \[ITI-71\]

|------------------------------------------------|
| Editor, Update the IUA [Transaction \[ITI-71\]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) as follows, adding section 3.71.4.2.2.1.4 |
{:.grid .bg-info}

###### 3.71.4.2.2.1.4 Privacy Consent on FHIR grouping

When grouped with the PCF Consent Authorization Server, and where the Access Decision includes consideration of Privacy Consent, the following `ihe_pcf` oAuth extension shall be included.

The Authorization Server and Resource Server shall support the following `extensions` parameter:

- `patient_id`: 1..1 Patient identifier related to the Patient Privacy Policy Identifier. Its value should be the patient identifier in CX syntax or as a FHIR full URL.
- `doc_id`: 1..* Patient Privacy Policy Acknowledgment Document. Its value should  be an URN or as a FHIR full URL.
- `acp`: 0..* Patient Privacy Policy Identifier. This is usually the URL from the `Consent.policy.uri` which is either a coded form and/or a human readable form. The URL would follow http negotiate to return the appropriate format given the mime-type negotiation.
- `residual`: 0..* Given that the oAuth token and scope identifies what is overall allowed, the `residual` carries residual rules from the PCF Consent Authorization Server to be enforced by the PCF Consent Enforcement Point.
  - `type` : 1..1 type of this rule, either forbid or permit
  - `securityLabel` : 0..* Security Labels that define affected resources
  - `dataPeriod` : 0..* Timeframe for data controlled by this rule
  - `data` : 0..* Data controlled by this rule
    - `meaning` : 1..1 Data controlled by this rule relationship to reference
    - `reference` : 1..1 Referenced data

If present, the claims shall be wrapped in an `extensions` object with key `ihe_pcf` and a JSON value object containing the claims. Shown as a JSON Template:

```
"extensions" : {  
  "ihe_pcf" : {  
    "patient_id": { Reference(Patient)}, // who the consent subject is
    "doc_id": [{ Reference(Consent)}], // what the consent(s) were used
    "acp": ["<uri>"], // basis policy the consent(s) are built upon
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
- residual `forbid` indicates data that is forbidden, and shall not be returned
- residual `permit` overrides an explicit residual `forbid`
- if no `forbid` applies, then the data is allowed to flow back to the requester

Example: Given [Consent allowing data authored within a timeframe](Consent-ex-consent-intermediate-timeframe.html), which limits access to only data authored within 2022. This is a root `.provision` restriction. Note that the purpose restriction is handled in the \[ITI-71\](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) `purpose_of_use`, so the `residual` need only address the `dataPeriod`.

```json
  "provision" : {
    "type" : "permit",
    "dataPeriod" : {
      "start" : "2022-01-01",
      "end" : "2022-12-31"
    }
  }
```

- The restriction to the given purpose (Treatment, Payment, and Operations) would be expressed in the `ihe_iua` extension.
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
    "doc_id" : ["Consent/ex-consent-intermediate-timeframe"],
    "residual" : [{
        "type" : "forbid",
      },{
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

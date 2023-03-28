Instance: IHE.PCF.consentRecorder
InstanceOf: CapabilityStatement
Title: "PCF Consent Recorder Actor"
Usage: #definition
* description = """
CapabilityStatement for the Consent Recorder Actor 

Explain
- uses [Access Consent \[ITI-110\]](ITI-110.html) to record new or updated Consent Resources
"""
* url = "https://profiles.ihe.net/ITI/PCF/CapabilityStatement/IHE.PCF.consentRecorder"
* name = "IHE_PCF_consentRecorder"
* title = "IHE PCF Consent Recorder"
* status = #active
* experimental = false
* date = "2023-02-14"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #client
  * documentation = "PCF Consent Recorder provides capability to record a Privacy Consent."
  * security
    * description = "Recommend [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html), encouraged [IHE-IUA](https://profiles.ihe.net/ITI/IUA/index.html) or [SMART-app-launch](http://www.hl7.org/fhir/smart-app-launch/)"
  * resource[+]
    * type = #Consent
    * documentation = """
PCF transaction [Access Consent \[ITI-110\]](ITI-110.html)
"""
    * interaction[+].code = #create
    * interaction[+].code = #read
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * interaction[+].code = #search-type
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "When the resource version last changed"
    * searchParam[+]
      * name = "_id"
      * type = #token
      * documentation = "Logical id of this artifact"
    * searchParam[+]
      * name = "status"
      * type = #token
      * documentation = "Whether the Consent record is active"
    * searchParam[+]
      * name = "patient"
      * type = #reference
      * documentation = "The Patient"
  * interaction.code = #search-system


Instance: IHE.PCF.consentRegistry
InstanceOf: CapabilityStatement
Title: "PCF Consent Registry Actor"
Usage: #definition
* description = """
CapabilityStatement for Consent Registry Actor.

Explain
- provides [Access Consent \[ITI-110\]](ITI-110.html) to store and support access to Privacy Consent Resources
"""
* url = "https://profiles.ihe.net/ITI/PCF/CapabilityStatement/IHE.PCF.consentRegistry"
* name = "IHE_PCF_consentRegistry"
* title = "IHE PCF Consent Registry"
* status = #active
* experimental = false
* date = "2023-02-14"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #server
  * documentation = "PCF Consent Registry actor provides capability to record, search, and manage Consents."
  * security
    * description = "Recommend [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html), encouraged [IHE-IUA](https://profiles.ihe.net/ITI/IUA/index.html) or [SMART-app-launch](http://www.hl7.org/fhir/smart-app-launch/)"
  * resource[+]
    * type = #Consent
    * documentation = """
PCF transaction [Access Consent \[ITI-110\]](ITI-110.html)
"""
    * interaction[+].code = #create
    * interaction[+].code = #read
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * interaction[+].code = #search-type
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "When the resource version last changed"
    * searchParam[+]
      * name = "_id"
      * type = #token
      * documentation = "Logical id of this artifact"
    * searchParam[+]
      * name = "status"
      * type = #token
      * documentation = "Whether the Consent record is active"
    * searchParam[+]
      * name = "patient"
      * type = #reference
      * documentation = "The Patient"
  * interaction.code = #search-system

Instance: IHE.PCF.consentAuthorizationServer
InstanceOf: CapabilityStatement
Title: "PCF Consent Authorization Server Actor"
Usage: #definition
* description = """
CapabilityStatement for the Consent Authorization Server Actor 

Explain
- is a Client that uses [Access Consent \[ITI-110\]](ITI-110.html) to retrieve current Privacy Consent and make access control decisions based upon them
"""
* url = "https://profiles.ihe.net/ITI/PCF/CapabilityStatement/IHE.PCF.consentAuthorizationServer"
* name = "IHE_PCF_consentAuthorizationServer"
* title = "IHE PCF Consent Authorization Server"
* status = #active
* experimental = false
* date = "2023-02-14"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #client
  * documentation = "PCF Consent Authorization Server makes authorization decisions based on the existing Privacy Consent."
  * security
    * description = "Recommend [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html), encouraged [IHE-IUA](https://profiles.ihe.net/ITI/IUA/index.html) or [SMART-app-launch](http://www.hl7.org/fhir/smart-app-launch/)"
  * resource[+]
    * type = #Consent
    * documentation = """
PCF transaction [Access Consent \[ITI-110\]](ITI-110.html)
"""
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "When the resource version last changed"
    * searchParam[+]
      * name = "_id"
      * type = #token
      * documentation = "Logical id of this artifact"
    * searchParam[+]
      * name = "status"
      * type = #token
      * documentation = "Whether the Consent record is active"
    * searchParam[+]
      * name = "patient"
      * type = #reference
      * documentation = "The Patient"
  * interaction.code = #search-system


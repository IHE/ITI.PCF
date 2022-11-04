Instance: IHE.PCF.capture
InstanceOf: CapabilityStatement
Title: "PCF Actor"
Usage: #definition
* description = """
CapabilityStatement for capture Actor 

Explain
- blah
- blah
"""
* url = "https://profiles.ihe.net/ITI/PCF/CapabilityStatement/IHE.PCF.capture"
* name = "IHE_PCF_capture"
* title = "IHE PCF capture"
* status = #active
* experimental = false
* date = "2022-10-27"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #client
  * documentation = "PCF capture provides capability to blah blah."
  * security
    * description = "Recommend [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html), encouraged [IHE-IUA](https://profiles.ihe.net/ITI/IUA/index.html) or [SMART-app-launch](http://www.hl7.org/fhir/smart-app-launch/)"
  * resource[+]
    * type = #Consent
    * documentation = """
PCF transaction [ITI-Y1]
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
      * name = "active"
      * type = #token
      * documentation = "Whether the Consent record is active"
    * searchParam[+]
      * name = "patient"
      * type = #reference
      * documentation = "The Patient"
  * interaction.code = #search-system


Instance: IHE.PCF.registry
InstanceOf: CapabilityStatement
Title: "PCF registry Actor"
Usage: #definition
* description = """
CapabilityStatement for registry Actor.

Explain
- blah
- blah
"""
* url = "https://profiles.ihe.net/ITI/PCF/CapabilityStatement/IHE.PCF.registry"
* name = "IHE_PCF_supplier"
* title = "IHE PCF registry"
* status = #active
* experimental = false
* date = "2022-10-27"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * mode = #server
  * documentation = "PCF capture provides capability to blah blah."
  * security
    * description = "Recommend [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html), encouraged [IHE-IUA](https://profiles.ihe.net/ITI/IUA/index.html) or [SMART-app-launch](http://www.hl7.org/fhir/smart-app-launch/)"
  * resource[+]
    * type = #Consent
    * documentation = """
PCF transaction [ITI-Y1]
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
      * name = "active"
      * type = #token
      * documentation = "Whether the Consent record is active"
    * searchParam[+]
      * name = "patient"
      * type = #reference
      * documentation = "The Patient"
  * interaction.code = #search-system


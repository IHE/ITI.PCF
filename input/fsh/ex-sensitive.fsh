


Instance: ex-ObservationAlcoholUse
InstanceOf: Observation
Title: "Observation - SH: Alcohol Use"
Description: """
This example Observation resource to represent alcohol use assessment in a patient summary.

- SLS assessed this as ETHUD
- SLS added Restricted due to the ETHUD assessment
"""
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActCode#ETHUD
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R
* status = #final
* code = http://loinc.org#74013-4
* subject = Reference(Patient/ex-patient)
* effectiveDateTime = "2022-06-13"
* valueQuantity = 5 '{wine glasses}/d' 

Instance:   ex-bloodSugarB-0
InstanceOf: Observation
Title: "Example of an MHV blood sugar R4 observation"
Description: """
holding typical health values

- SLS assessed this as not sensitvie
- SLS added Normal due to not sensitive
"""
//* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = http://loinc.org#2339-0 "Glucose [Mass/volume] in Blood"
* subject = Reference(Patient/ex-patient)
* effectiveDateTime = 2020-12-04T23:50:50-05:00
* valueQuantity = 99 'mg/dL' 
// no comments in this one as comments is only in DSTU2
* note.text = "a bit low, no indicated method, no indicated eating"


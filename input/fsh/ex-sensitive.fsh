


Instance: ex-alcoholUse
InstanceOf: Observation
Title: "Observation - SH: Alcohol Use"
Description: """
This example Observation resource to represent alcohol use assessment in a patient summary.

- SLS assessed this as ETHUD
- SLS added Restricted due to the ETHUD assessment
"""
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActCode#ETHUD
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#R
* status = #final
* code = http://loinc.org#74013-4
* subject = Reference(Patient/ex-patient)
* performer = Reference(Practitioner/ex-author)
* effectiveDateTime = 2022-06-13
* valueQuantity = 5 '{wine glasses}/d' "glasses of wine"
* encounter = Reference(Encounter/ex-encounter)



Instance:   ex-bloodSugar
InstanceOf: Observation
Title: "Example of an MHV blood sugar R4 observation"
Description: """
holding typical health values

- SLS assessed this as not sensitvie
- SLS added Normal due to not sensitive
"""
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = http://loinc.org#2339-0 "Glucose [Mass/volume] in Blood"
* subject = Reference(Patient/ex-patient)
* performer = Reference(Practitioner/ex-author)
* effectiveDateTime = 2020-12-04T23:50:50-05:00
* valueQuantity = 99 'mg/dL' "mg/dL"
// no comments in this one as comments is only in DSTU2
* note.text = "a bit low, no indicated method, no indicated eating"
* encounter = Reference(Encounter/ex-encounter)



Instance:   ex-bloodPressure
InstanceOf: http://hl7.org/fhir/StructureDefinition/bp
Title: "Example of a blood pressure R4 observation, minimal"
Description:      "holding typical values"
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* status = #final
* category[VSCat] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs "Vital Signs"
* code.coding[BPCode] = LOINC#85354-9 
* subject = Reference(Patient/ex-patient)
* performer = Reference(Practitioner/ex-author)
* effectiveDateTime = 2004-12-25T23:50:50-05:00
* component[SystolicBP].code.coding[SBPCode] = LOINC#8480-6 "Systolic blood pressure"
* component[SystolicBP].valueQuantity = 140.0 'mm[Hg]' "mm[Hg]"
* component[DiastolicBP].code.coding[DBPCode] = LOINC#8462-4 "Diastolic blood pressure"
* component[DiastolicBP].valueQuantity = 90.0 'mm[Hg]' "mm[Hg]"
* note.text = "a minimal blood pressure"
* encounter = Reference(Encounter/ex-encounter)



Instance:   ex-weight
InstanceOf: http://hl7.org/fhir/StructureDefinition/bodyweight
Title: "Example of a bodyWeight R4 observation"
Description: """
Sample for demonstration purposes of a common weight Observation
- marked as compliant with IHE.ToDo.bodyWeight profile
- marked as test data
- status of final
- category vital-signs
- code of loinc body weight
- subject of the example patient
- effective time of December 25th, 2004
- weight 185 pounds
- note: a bit heavy
"""
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* status = #final
* category[VSCat] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code = http://loinc.org#29463-7
* subject = Reference(Patient/ex-patient)
* performer = Reference(Practitioner/ex-author)
* effectiveDateTime = 2004-12-25T23:50:50-05:00
* valueQuantity = 185 '[lb_av]' "pounds"
* note.text = "a bit heavy"
* encounter = Reference(Encounter/ex-encounter)



Instance:   ex-weight-2
InstanceOf: http://hl7.org/fhir/StructureDefinition/bodyweight
Title: "Example of an valid FHIR bodyWeight R4 observation, but not compliant with the profile"
Description: """
Sample for demonstration purposes of a common weight Observation.
- Given that this is not compliant, it is thus not declaring that it is compliant, it is just an Observation
- marked as test data
- status of final
- category of vital-signs
- code of loinc 29463-7 and 3141-9
- also code of snomed 27113001
- subject of the example patient
- linked to an encounter
- effectiveDateTime = March 28, 2016
- weight 280 lbs
- note: a bit heavy, about 280 lbs
"""
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* status = #final
* category[VSCat] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code.text = "body weight"
* code.coding[BodyWeightCode] = LOINC#29463-7
* subject = Reference(Patient/ex-patient)
* performer = Reference(Practitioner/ex-author)
* encounter = Reference(Encounter/example)
* effectiveDateTime = 2016-03-28
* valueQuantity = 280 '[lb_av]' "pounds"
* note.text = "a bit heavy, about 280 lbs"
* encounter = Reference(Encounter/ex-encounter)


Instance:   ex-encounter
InstanceOf: Encounter
Title: "Example Encounter"
Description:      "holding typical values"
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* subject = Reference(Patient/ex-patient)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#HH

Instance: ex-practitioner
InstanceOf: Practitioner
Title: "Dummy Practitioner example"
Description: "Dummy Practitioner example for completeness sake. No actual use of this resource other than an example target"
Usage: #example
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* telecom.system = #email
* telecom.value = "Practitioner@example.com"

Instance: ex-author
InstanceOf: Practitioner
Title: "Dummy Authoring Practitioner example"
Description: "Dummy Practitioner example for completeness sake. No actual use of this resource other than an example target"
Usage: #example
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* telecom.system = #email
* telecom.value = "Author@example.com"


Instance: ex-clerk
InstanceOf: Practitioner
Title: "Clerk Practitioner example"
Description: "Clerk Practitioner example used as an example Clerk managing Consents"
Usage: #example
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* telecom.system = #email
* telecom.value = "Clerk@example.org"




Instance: ex-organization
InstanceOf: Organization
Title: "Example Organization holding the data"
Description: "The Organization that holds the data, and enforcing any Consents"
Usage: #example
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* meta.security[+] = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* active = true
* name = "somewhere org"


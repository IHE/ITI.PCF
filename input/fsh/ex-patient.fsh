Instance:   ex-patient
InstanceOf: Patient
Title: "Example Patient"
Description: "The patient from which all the example relate"
// history - http://playgroundjungle.com/2018/02/origins-of-john-jacob-jingleheimer-schmidt.html
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Smith"
* name[=].given = "Jack"
* name[+].use = #old
* name[=].family = "Schnidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingle"
* name[=].given[+] = "Heimer"
* name[=].period.end = "1960"
* name[+].use = #official
* name[=].family = "Smith"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
* name[=].period.start = "1960-01-01"
* gender = #male
* birthDate = "1923-07-25"
* address.state = "WI"
* address.country = "USA"

Instance: ex-mother
InstanceOf: Patient
Title: "Mother of John"
Description: "The patient resource describing the mother"
// history - https://www.reddit.com/r/CasualConversation/comments/acw803/who_exactly_is_john_jacob_jingleheimer_schmidt/
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Schmidt"
* name[=].given[+] = "Katie"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "Katherine"
* name[=].given[+] = "Irene"
* gender = #female
* address.country = "IR"

## Significant Changes
NA, this is the initial public comment release.

## Issues
During development, the [readme in the github repo carries development and questions](https://github.com/IHE/ITI.PCF/blob/master/README.md)

### Submit an Issue

IHE welcomes [New Issues](https://github.com/IHE/ITI.PCF/issues/new/choose)
from the GitHub community. For those without GitHub access, issues may be
submitted at [ITI Public Comments](https://www.ihe.net/ITI_Public_Comments/).

As issues are submitted they will be managed on the
[PCF GitHub Issues](https://github.com/IHE/ITI.PCF/issues), where discussion and
workarounds will be found. These issues, when critical, will be processed using the normal
[IHE Change Proposal](https://wiki.ihe.net/index.php/Category:CPs) management and balloting.
It is important to note that as soon as a Change Proposal is approved, it carries the same
weight as a published Implementation Guide (i.e., it is testable at an
[IHE Connectathon](https://www.ihe.net/participate/connectathon/) from the time
it is approved, even if it will not be integrated until several months later).

### Open Issues and Questions

- [PCF_18: Advanced required sensitivity codes](https://github.com/IHE/ITI.PCF/issues/18)
  - In the Advanced is a required subset of ConfidentialityCodes (N, R), and Sensitivity codes (ETH, ETHUD, OPIOIDUD, PSY, SEX, and HIV). Is this enough? Is this too many? What should be required of the PCF? Note that required in the PCF does not mean that a deployment implementation must use all of these codes.
  - There is likely no minimal set that is universally globally required. After public comment the current list of Sensitivity Codes that are mandatory is likely to be trimmed.  Should the sensitivity classifications that are moved out of the mandatory requirement still listed as a useful mention?
- [PCF_19: Should Basic include agent authored by the Consent](https://github.com/IHE/ITI.PCF/issues/19)
  - The Basic Explicit Option includes the ability for the Consent to identify a list of agents (device, relatedPerson, Practitioner, or Organization) that would be authorized by the Consent. This was supported by BPPC, so was considered Basic. However this has been identified as an unusual need today and thus would be more appropriate to be in the Intermediate group. Please comment on if you find this needed and agree that it should be in Basic, or if this support should be in Intermediate.
- [PCF_20: Should PCF include break-glass when there is no clear way to declare break-glass](https://github.com/IHE/ITI.PCF/issues/20)
  - There is support in a Consent for provisions when break-glass is declared, and there are support for conveying break-glass between the decision and enforcement. However, there is no clear way to declare break-glass, or to inform a client that the user is authorized to declare break-glass and would get access to more data.
  - There are many ways envisioned to declare break-glass:
    - oAuth access token request (ITI-71) includes the purposeOfUse of BTG, in addition to normal purposeOfUse (e.g., Treatment, Payment, Operations).
    - oAuth access token request (ITI-71) has a user-interface that would ask the user to declare break-glass. Unclear when this user-interface would engage, as it clearly can't engage every request.
    - some non-security method such as the http Category, as outlined in a [dragon note on the FHIR specification](http://hl7.org/fhir/R4B/security-labels.html#break-the-glass).
    - Indication given in FHIR OperationOutcome that some data was filtered that would not need to be filtered if break-glass was declared.
    - Other non standard method.
- [PCF_21: Should Provenance be recommended or required?](https://github.com/IHE/ITI.PCF/issues/21)
  - ITI-108 includes requirements to record AuditEvents, using BALP pattern. This is considered sufficient to track inappropriate changes, and is referenced in the Security Considerations. Should there also be requirements to record Provenance on Create, Update, and Delete in addition to AuditEvent?

### Closed Issues

None 
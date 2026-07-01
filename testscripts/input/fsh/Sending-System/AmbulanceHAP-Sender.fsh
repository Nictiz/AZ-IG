// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Sender content-validation TestScript (Conformancelab, FHIR R5). The sending
// system (ambulance / RAV) is the system under test (a client that pushes the
// message); Conformancelab plays the receiving server and asserts on the
// request. Aliases and RuleSets are shared (../Alias.fsh, ../RuleSet.fsh).
//
// PROVISIONAL: the exchange paradigm is not yet chosen (Open Items #14), so the
// transport operation is modelled as a plain create/POST. The content assertions
// are paradigm-independent.
// ---------------------------------------------------------------------------

Instance: hg-TestScript-AmbulanceHAP-Sender
InstanceOf: $CL-TestScript
Usage: #definition
Title: "Acute Zorg - Ambulanceverwijzing - Sender (content validation)"
Description: "Validates that the ambulance-to-HAP referral message produced by a sending system (the system under test) is a conformant AMB-naar-HAP message."
* insert Metadata(hg-TestScript-AmbulanceHAP-Sender)
* title = "Acute Zorg - Ambulanceverwijzing - Sender (content validation)"
* description = "Validates that the referral message a sending system pushes is a conformant AMB-naar-HAP message (message Bundle, event 145, a referral ServiceRequest conforming to its profile, the mandatory reason section)."
* insert ClientTesting
* profile[+] = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralBundle-AmbulanceHAP"
* profile[=].id = "referral-bundle"
* test
  * name = "Validate the pushed AMB-naar-HAP message"
  * description = "The sending system pushes the referral message; the engine validates its structure and conformance."
  * action[0].operation
    * type = $interaction#create
    * resource = #Bundle
    * description = "The sending system (SUT) pushes the ambulance-to-HAP referral message Bundle. PROVISIONAL: modelled as a create/POST pending the exchange-paradigm choice (#14)."
    * origin = 1
    * destination = 1
    * encodeRequestUrl = true
  * insert ReferralMessageContentAsserts
  * action[+].assert
    * description = "The receiving server accepts the message."
    * direction = #response
    * operator = #in
    * responseCode = "200,201"
    * warningOnly = false
    * stopTestOnFail = true

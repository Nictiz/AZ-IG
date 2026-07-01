// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Phase-A Conformancelab TestScripts (FHIR R5) for the Ambulanceverwijzing
// (AMB naar HAP) use case. Content-validation tests: they check that the message
// a Sender produces - and that a Receiver accepts - is a conformant AMB-naar-HAP
// message, independent of most transport details.
//
// Authored against the Interoplab CL-TestScript-core profile, using the reusable
// RuleSets in RuleSet.fsh (Metadata, ClientTesting/ServerTesting, and the message
// content asserts) - modelled on the IKNL PZP test materials. Roles mirror the
// IG's hg-ActorSender / hg-ActorReceiver actors.
//
// PROVISIONAL: the exchange paradigm is not yet chosen (Open Items #14), so the
// transport operation is modelled as a plain create/POST. The content assertions
// are paradigm-independent; the operation.type is the part to revisit.
// ---------------------------------------------------------------------------

// =============================================================================
// Sender (ambulance / RAV is the system under test = client): validate the
// message it pushes. Conformancelab plays the receiving server.
// =============================================================================
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

// =============================================================================
// Receiver (HAP is the system under test = server): the engine (client) sends a
// known conformant message and asserts the receiver accepts it.
// =============================================================================
Instance: hg-TestScript-AmbulanceHAP-Receiver
InstanceOf: $CL-TestScript
Usage: #definition
Title: "Acute Zorg - Ambulanceverwijzing - Receiver (accept message)"
Description: "Sends a conformant ambulance-to-HAP referral message to a receiving system (the system under test) and confirms it is accepted. The message sent is the worked scenario-5b example from the IG."
* insert Metadata(hg-TestScript-AmbulanceHAP-Receiver)
* title = "Acute Zorg - Ambulanceverwijzing - Receiver (accept message)"
* description = "Sends a conformant ambulance-to-HAP referral message to a receiving system (the system under test) and confirms it is accepted."
* insert ServerTesting
// The message Bundle sent to the receiver. The fixture file (an R4 example from
// the IG) is supplied by Conformancelab from the loaded R4 package / _reference
// resources; here it is referenced by id (the packaging wires up the file).
* fixture[0]
  * id = "referral"
  * autocreate = false
  * autodelete = false
  * resource.reference = "Bundle/hg-ReferralBundle-AmbulanceHAP-referral"
* test
  * name = "Send the AMB-naar-HAP message to the receiver"
  * description = "The engine pushes a conformant referral message; the receiving system (SUT) must accept it."
  * action[0].operation
    * type = $interaction#create
    * resource = #Bundle
    * description = "Send the ambulance-to-HAP referral message Bundle to the receiver. PROVISIONAL: modelled as a create/POST pending the exchange-paradigm choice (#14)."
    * sourceId = "referral"
    * origin = 1
    * destination = 1
    * encodeRequestUrl = true
  * action[+].assert
    * description = "The receiving system accepts the message."
    * direction = #response
    * operator = #in
    * responseCode = "200,201"
    * warningOnly = false
    * stopTestOnFail = true

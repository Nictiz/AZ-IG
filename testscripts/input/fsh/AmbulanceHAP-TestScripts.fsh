// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Phase-A ConformanceLab TestScripts (FHIR R5) for the Ambulanceverwijzing
// (AMB naar HAP) use case. These are content-validation tests: they check that
// the message a Sender produces - and that a Receiver accepts - is a conformant
// AMB-naar-HAP message, independent of most transport details.
//
// Authored against the Interoplab CL-TestScript-core profile so the
// ConformanceLab conventions (SUT markers on origin/destination, mandatory
// descriptions) are enforced. Roles mirror the IG's hg-ActorSender / hg-Actor-
// Receiver actors.
//
// PROVISIONAL: the exchange paradigm is not yet chosen (Open Items #14), so the
// transport operation is modelled as a plain create/POST of the message Bundle.
// The *assertions* on the message content are paradigm-independent and stable;
// the operation.type is the part to revisit once the paradigm is fixed.
// ---------------------------------------------------------------------------

Alias: $CL-TestScript = http://fhir.interoplab.eu/fhir/StructureDefinition/Interoplab-CL-TestScript-core
Alias: $CL-SUT = http://fhir.interoplab.eu/fhir/StructureDefinition/Interoplab-CL-ext-SUT
Alias: $interaction = http://hl7.org/fhir/restful-interaction
Alias: $origin-types = http://terminology.hl7.org/CodeSystem/testscript-profile-origin-types
Alias: $destination-types = http://terminology.hl7.org/CodeSystem/testscript-profile-destination-types
Alias: $sr-profile = http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP

// =============================================================================
// Sender (ambulance / RAV is the system under test): validate the message it
// pushes. ConformanceLab plays the receiving server and asserts on the request.
// =============================================================================
Instance: hg-TestScript-AmbulanceHAP-Sender
InstanceOf: $CL-TestScript
Usage: #definition
Title: "Acute Zorg - Ambulanceverwijzing - Sender (content validation)"
Description: "Validates that the ambulance-to-HAP referral message produced by a sending system (the system under test) is a conformant AMB-naar-HAP message: a message Bundle with the correct event, a referral ServiceRequest conforming to the use case profile, and the mandatory Composition reason section."
* url = "http://nictiz.nl/fhir/TestScript/hg-TestScript-AmbulanceHAP-Sender"
* version = "0.1.0-alpha.1"
* name = "AZ_AmbulanceHAP_Sender"
* title = "Acute Zorg - Ambulanceverwijzing - Sender (content validation)"
* status = #draft
* experimental = true
* publisher = "Nictiz"
* description = "Content-validation test for the sending system in the Ambulanceverwijzing naar HAP use case."
* origin
  * extension[$CL-SUT].valueBoolean = true
  * index = 1
  * profile = $origin-types#FHIR-Client
* destination
  * extension[$CL-SUT].valueBoolean = false
  * index = 1
  * profile = $destination-types#FHIR-Server
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
  * action[+].assert
    * description = "The pushed resource is a Bundle."
    * direction = #request
    * resource = #Bundle
    * warningOnly = false
    * stopTestOnFail = true
  * action[+].assert
    * description = "The Bundle is a message Bundle (Bundle.type = message)."
    * direction = #request
    * expression = "Bundle.type = 'message'"
    * warningOnly = false
    * stopTestOnFail = true
  * action[+].assert
    * description = "The MessageHeader carries the AMB-naar-HAP transaction event (145)."
    * direction = #request
    * expression = "Bundle.entry.resource.ofType(MessageHeader).event.ofType(Coding).code = '145'"
    * warningOnly = false
    * stopTestOnFail = true
  * action[+].assert
    * description = "The MessageHeader focuses a resource (the referral ServiceRequest)."
    * direction = #request
    * expression = "Bundle.entry.resource.ofType(MessageHeader).focus.exists()"
    * warningOnly = false
    * stopTestOnFail = false
  * action[+].assert
    * description = "The message contains a referral ServiceRequest conforming to hg-ReferralServiceRequest-AmbulanceHAP."
    * direction = #request
    * expression = "Bundle.entry.resource.ofType(ServiceRequest).conformsTo('http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP')"
    * warningOnly = false
    * stopTestOnFail = false
  * action[+].assert
    * description = "The Composition carries the mandatory 'reason for referral' section (SNOMED 440378000)."
    * direction = #request
    * expression = "Bundle.entry.resource.ofType(Composition).section.code.coding.where(system = 'http://snomed.info/sct' and code = '440378000').exists()"
    * warningOnly = false
    * stopTestOnFail = false
  * action[+].assert
    * description = "The receiving server accepts the message."
    * direction = #response
    * operator = #in
    * responseCode = "200,201"
    * warningOnly = false
    * stopTestOnFail = true

// =============================================================================
// Receiver (HAP is the system under test): the engine (client) sends a known
// conformant message and asserts the receiver accepts it.
// =============================================================================
Instance: hg-TestScript-AmbulanceHAP-Receiver
InstanceOf: $CL-TestScript
Usage: #definition
Title: "Acute Zorg - Ambulanceverwijzing - Receiver (accept message)"
Description: "Sends a conformant ambulance-to-HAP referral message to a receiving system (the system under test) and confirms it is accepted. The message sent is the worked scenario-5b example from the IG."
* url = "http://nictiz.nl/fhir/TestScript/hg-TestScript-AmbulanceHAP-Receiver"
* version = "0.1.0-alpha.1"
* name = "AZ_AmbulanceHAP_Receiver"
* title = "Acute Zorg - Ambulanceverwijzing - Receiver (accept message)"
* status = #draft
* experimental = true
* publisher = "Nictiz"
* description = "Acceptance test for the receiving system in the Ambulanceverwijzing naar HAP use case."
* origin
  * extension[$CL-SUT].valueBoolean = false
  * index = 1
  * profile = $origin-types#FHIR-Client
* destination
  * extension[$CL-SUT].valueBoolean = true
  * index = 1
  * profile = $destination-types#FHIR-Server
// The message Bundle sent to the receiver. The fixture file (an R4 example from
// the IG) is supplied by ConformanceLab from the loaded R4 package / _reference
// resources; here it is referenced by id (Phase-B packaging wires up the file).
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

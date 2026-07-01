// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Receiver acceptance TestScript (Conformancelab, FHIR R5). The receiving system
// (HAP) is the system under test (a server); the engine (client) sends a known
// conformant message and asserts the receiver accepts it. Aliases and RuleSets
// are shared (../Alias.fsh, ../RuleSet.fsh).
//
// The message Bundle sent to the receiver is the worked scenario-5b example from
// the IG (an R4 resource); generate.py copies it into this role's
// _reference/resources folder so Conformancelab can send it.
//
// PROVISIONAL: the exchange paradigm is not yet chosen (Open Items #14), so the
// transport operation is modelled as a plain create/POST.
// ---------------------------------------------------------------------------

Instance: hg-TestScript-AmbulanceHAP-Receiver
InstanceOf: $CL-TestScript
Usage: #definition
Title: "Acute Zorg - Ambulanceverwijzing - Receiver (accept message)"
Description: "Sends a conformant ambulance-to-HAP referral message to a receiving system (the system under test) and confirms it is accepted. The message sent is the worked scenario-5b example from the IG."
* insert Metadata(hg-TestScript-AmbulanceHAP-Receiver)
* title = "Acute Zorg - Ambulanceverwijzing - Receiver (accept message)"
* description = "Sends a conformant ambulance-to-HAP referral message to a receiving system (the system under test) and confirms it is accepted."
* insert ServerTesting
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

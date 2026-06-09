// =============================================================================
// Actors and obligations.
//
// Following the FHIR Obligations framework (and the IKNL PZP / AU-Core pattern),
// support expectations are expressed as obligations bound to actors rather than
// the single mustSupport boolean. The PUSH defines two system actors:
//
//   - Sender   (the ambulance / RAV system that produces and pushes the message)
//   - Receiver (the GP / HAP system that consumes the message)
//
// The Sender SHALL populate an obligation-marked element if it knows a value for
// it (SHALL:populate-if-known). The Receiver SHALL accept such an element without
// raising an error (SHALL:no-error). This is the producer/consumer pairing from
// the FHIR obligation code system (http://hl7.org/fhir/CodeSystem/obligation).
// =============================================================================

Instance: hg-ActorSender
InstanceOf: ActorDefinition
Usage: #definition
Title: "HG Referral Sender (ambulance)"
Description: "The sending system in the ambulance referral PUSH: the ambulance / Regionale Ambulancevoorziening (RAV) system that produces and transmits the referral message."
* url = "http://nictiz.nl/fhir/ActorDefinition/hg-ActorSender"
* name = "HgActorSender"
* status = #active
* type = #system

Instance: hg-ActorReceiver
InstanceOf: ActorDefinition
Usage: #definition
Title: "HG Referral Receiver (GP/HAP)"
Description: "The receiving system in the ambulance referral PUSH: the GP out-of-hours post (HAP) system that consumes the referral message."
* url = "http://nictiz.nl/fhir/ActorDefinition/hg-ActorReceiver"
* name = "HgActorReceiver"
* status = #active
* type = #system

// Combined obligation: Sender SHALL populate if known; Receiver SHALL not error.
// Insert onto an element with: * <element> insert Obligation
RuleSet: Obligation
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:populate-if-known
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorSender
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:no-error
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorReceiver

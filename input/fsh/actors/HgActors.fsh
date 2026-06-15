// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Obligation RuleSet - reusable across all referral use case profiles.
//
// Following the FHIR Obligations framework,
// support expectations are expressed as obligations bound to actors rather than
// the single mustSupport boolean.
//
// The Sender SHALL populate an obligation-marked element if it knows a value for
// it (SHALL:populate-if-known). The Receiver SHALL accept such an element without
// raising an error (SHALL:no-error). This is the producer/consumer pairing from
// the FHIR obligation code system (http://hl7.org/fhir/CodeSystem/obligation).
//
// Actor instances are defined per use case (see HgActorsAmbulanceHAP.fsh).
// =============================================================================

// Combined obligation: Sender SHALL populate if known; Receiver SHALL not error.
// Insert onto an element with: * <element> insert Obligation
RuleSet: Obligation
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:populate-if-known
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorSender
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:no-error
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorReceiver

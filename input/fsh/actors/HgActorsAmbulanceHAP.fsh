// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Use case actors for Ambulance referral (Ambulanceverwijzing) (AMB -> HAP, message 24).
//
// These actors correspond to the Systeemrollen defined in the Ontwerp Acute Zorg functional design (section 2.16): AZP-AVS  Acute Zorg Proces - Ambulanceverwijzing Sturend   (AMBS) AZP-AVO  Acute Zorg Proces - Ambulanceverwijzing Ontvangend (HIS / HAPIS)
// =============================================================================

Instance: hg-ActorSender-AmbulanceHAP
InstanceOf: ActorDefinition
Usage: #definition
Title: "hg referral Sender - Ambulance referral (AMBS, AZP-AVS)"
Description: "Ambulance management system (AMBS) that produces and transmits the Ambulance referral to the HIS/HAPIS."
* url = "http://ig.nictiz.nl/az/ActorDefinition/hg-ActorSender-AmbulanceHAP"
* name = "HgActorSenderAmbulanceHAP"
* status = #draft
* type = #system
* documentation = """The HG Referral Sender is the system role fulfilled by an ambulance management system (AMBS). It is responsible for the transaction Sturen Ambulanceverwijzing.

In the [functional design](functional-design.html), this role is identified as Acute Zorg Proces - Ambulanceverwijzing Sturend with system role code AZP-AVS.

An HG Referral Sender **SHALL** populate obligation-marked elements when it has a value for them (SHALL:populate-if-known)."""
* capabilities = "http://ig.nictiz.nl/az/CapabilityStatement/hg-CapabilityStatement-Sender"

Instance: hg-ActorReceiver-AmbulanceHAP
InstanceOf: ActorDefinition
Usage: #definition
Title: "hg referral Receiver - Ambulance referral (HIS/HAPIS, AZP-AVO)"
Description: "GP information system (HIS) or GP out-of-hours service information system (HAPIS) that accepts the Ambulance referral from the AMBS."
* url = "http://ig.nictiz.nl/az/ActorDefinition/hg-ActorReceiver-AmbulanceHAP"
* name = "HgActorReceiverAmbulanceHAP"
* status = #draft
* type = #system
* documentation = """The HG Referral Receiver is the system role fulfilled by a GP information system (HIS) or a GP out-of-hours service information system (HAPIS). It is responsible for the transaction Ontvangen Ambulanceverwijzing.

In the [functional design](functional-design.html), this role is identified as Acute Zorg Proces - Ambulanceverwijzing Ontvangend with system role code AZP-AVO.

An HG Referral Receiver **SHALL** accept obligation-marked elements without raising an error (SHALL:no-error)."""
* capabilities = "http://ig.nictiz.nl/az/CapabilityStatement/hg-CapabilityStatement-Receiver"

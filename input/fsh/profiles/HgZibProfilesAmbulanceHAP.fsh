// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Transaction-specific zib profiles (Ambulanceverwijzing, AMB -> HAP).
//
// Per the Nictiz profiling guidelines, cardinalities and conformance for the participating zibs are applied at the use case (information standard specific) layer, derived from the nl-core profiles. These carry the cardinalities the ART-DECOR transaction puts on the building blocks (Patient, HealthProfessional, HealthcareProvider), plus obligations for sender/receiver.
//
// Cardinalities follow the published AMB-HAP transaction (4.145, 2025-06-10) where tightened (gender 1..1). The patient identifier is kept 0..* (optional and repeatable - see the element comment) rather than hard-required; name and birthDate are left at nl-core cardinality with obligations.
// =============================================================================

Profile: HgPatientAmbulanceHAP
Parent: $nlcore-Patient
Id: hg-Patient-AmbulanceHAP
Title: "hg Patient - Ambulance to HAP"
Description: "Patient in the ambulance to GP out-of-hours post (HAP) referral. Derived from nl-core-Patient; identifiers (e.g. BSN or a local hospital identifier) should be sent when known so the HAP can match the referral to a person."
* identifier 0..*
  * ^comment = "0..*: a patient may carry more than one identifier (for example a BSN and a local hospital identifier), so the element is repeatable. It is optional (min 0) because an ambulance patient is not always identified yet; the populate-if-known obligation carries the expectation to send an identifier when one is known."
* identifier insert Obligation
* name insert Obligation
* name.text ^comment = "This element can be used to represent the full name as plain text when the name is not registered in a structured manner (i.e. without the structured `family`/`given` parts). The corresponding dataset alignment is still open (see the Open Items page)."
* gender 1..1
* gender insert ObligationMandatory
* birthDate insert Obligation

Profile: HgHealthcareProviderOrganizationAmbulanceHAP
Parent: $nlcore-Organization
Id: hg-HealthcareProvider-Organization-AmbulanceHAP
Title: "hg HealthcareProvider Organization - Ambulance to HAP"
Description: "Sending (RAV) and receiving (HAP) organization in the ambulance referral. Derived from nl-core-HealthcareProvider-Organization; an identifier (e.g. URA) is required so the organization is unambiguously addressable."
* identifier 1..*
* identifier insert ObligationMandatory
* name 1..1
* name insert ObligationMandatory

Profile: HgHealthProfessionalPractitionerRoleAmbulanceHAP
Parent: $nlcore-PractitionerRole
Id: hg-HealthProfessional-PractitionerRole-AmbulanceHAP
Title: "hg HealthProfessional PractitionerRole - Ambulance to HAP"
Description: "Role of the sending ambulance professional in the referral. Derived from nl-core-HealthProfessional-PractitionerRole."
* practitioner insert Obligation
* organization insert Obligation

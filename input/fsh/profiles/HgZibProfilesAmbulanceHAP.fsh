// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Transaction-specific zib profiles (Ambulanceverwijzing, AMB -> HAP).
//
// Per the Nictiz profiling guidelines, cardinalities and conformance for the
// participating zibs are applied at the use case (information standard specific)
// layer, derived from the nl-core profiles. These carry the cardinalities the
// ART-DECOR transaction puts on the building blocks (Patient, HealthProfessional,
// HealthcareProvider), plus obligations for sender/receiver.
//
// Cardinalities follow the published AMB-HAP transaction (4.145, 2025-06-10):
// identifier 1..1 (BSN required; 1..* here to allow additional FHIR identifiers),
// name 0..1, gender 1..1, birthDate 0..1.
// =============================================================================

Profile: HgPatientAmbulanceHAP
Parent: $nlcore-Patient
Id: hg-Patient-AmbulanceHAP
Title: "hg Patient - Ambulance to HAP"
Description: "Patient in the ambulance to GP out-of-hours post (HAP) referral. Derived from nl-core-Patient; the patient SHALL be identifiable so the HAP can match the referral to a person."
* identifier 1..*
* identifier insert Obligation
* name insert Obligation
* gender 1..1
* gender insert Obligation
* birthDate insert Obligation

Profile: HgHealthcareProviderOrganizationAmbulanceHAP
Parent: $nlcore-Organization
Id: hg-HealthcareProvider-Organization-AmbulanceHAP
Title: "hg HealthcareProvider Organization - Ambulance to HAP"
Description: "Sending (RAV) and receiving (HAP) organisation in the ambulance referral. Derived from nl-core-HealthcareProvider-Organization; an identifier (e.g. URA) is required so the organisation is unambiguously addressable."
* identifier 1..*
* identifier insert Obligation
* name 1..1
* name insert Obligation

Profile: HgHealthProfessionalPractitionerRoleAmbulanceHAP
Parent: $nlcore-PractitionerRole
Id: hg-HealthProfessional-PractitionerRole-AmbulanceHAP
Title: "hg HealthProfessional PractitionerRole - Ambulance to HAP"
Description: "Role of the sending ambulance professional in the referral. Derived from nl-core-HealthProfessional-PractitionerRole."
* practitioner insert Obligation
* organization insert Obligation

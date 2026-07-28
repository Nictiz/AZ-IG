// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Transaction-specific zib profiles (Ambulanceverwijzing, AMB -> HAP).
//
// Per the Nictiz profiling guidelines, cardinalities and conformance for the participating zibs are applied at the use case (information standard specific) layer, derived from the nl-core profiles. These carry the cardinalities the ART-DECOR transaction puts on the building blocks (Patient, HealthProfessional, HealthcareProvider), plus obligations for sender/receiver.
//
// Cardinalities follow the published AMB-HAP transaction (4.145, 2025-06-10) where tightened (gender 1..1). The patient identifier is kept 0..* (optional and repeatable - see the element comment) rather than hard-required; name and birthDate are left at nl-core cardinality with obligations.
// =============================================================================

// Resource-local invariants. Severity is #warning for now (legitimate edge cases exist: a not-yet-
// identified ambulance patient; an organization addressed other than by URA). They can be raised to
// #error once the ART-DECOR conformance mapping confirms the requirement (see the Open Items page).
Invariant: hg-pat-1
Description: "The patient should be identifiable so the receiver can match the referral: an identifier or a name is present."
Severity: #warning
Expression: "identifier.exists() or name.exists()"

Invariant: hg-org-1
Description: "The organization should be unambiguously addressable: a URA identifier is present."
Severity: #warning
Expression: "identifier.where(system = 'http://fhir.nl/fhir/NamingSystem/ura').exists()"

Profile: HgPatientAmbulanceHAP
Parent: $nlcore-Patient
Id: hg-Patient-AmbulanceHAP
Title: "hg Patient - Ambulance to HAP"
Description: "Patient in the ambulance to GP out-of-hours post (HAP) referral. Derived from nl-core-Patient; identifiers (e.g. BSN or a local hospital identifier) should be sent when known so the HAP can match the referral to a person."
* obeys hg-pat-1
* identifier 0..*
  * ^comment = "0..*: a patient may carry more than one identifier (for example a BSN and a local hospital identifier), so the element is repeatable. It is optional (min 0) because an ambulance patient is not always identified yet; the populate-if-known obligation carries the expectation to send an identifier when one is known."
* identifier insert Obligation
* identifier[bsn] 0..1
* name insert Obligation
* name.text ^comment = "This element can be used to represent the full name as plain text when the name is not registered in a structured manner (i.e. without the structured `family`/`given` parts)."
* gender 1..1
* gender insert ObligationMandatory
* birthDate insert Obligation
* contact.extension[contactPerson].value[x] only Reference(RelatedPerson or HgContactPersonAmbulanceHAP)

Profile: HgHealthcareProviderOrganizationAmbulanceHAP
Parent: $nlcore-Organization
Id: hg-HealthcareProvider-Organization-AmbulanceHAP
Title: "hg HealthcareProvider Organization - Ambulance to HAP"
Description: "Sending (RAV) and receiving (HAP) organization in the ambulance referral. Derived from nl-core-HealthcareProvider-Organization; an identifier (e.g. URA) is required so the organization is unambiguously addressable."
* obeys hg-org-1
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

Profile: HgEncounterAmbulanceHAP
Parent: $nlcore-Encounter
Id: hg-Encounter-AmbulanceHAP
Title: "hg Encounter - Ambulance to HAP"
Description: "An interaction between a patient and ambulance professionals. Derived from nl-core-Encounter."
* ^purpose = "A derived profile from [nl-core-Encounter](http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter) to provide a version better suited for ambulance to HAP use case. This profile augments the nl-core profile to support the exchange of the ambulance trip number."
* identifier ^slicing.discriminator[0].type = #pattern
* identifier ^slicing.discriminator[0].path = "$this"
* identifier ^slicing.rules = #open
* identifier contains tripNumber 1..1
* identifier[tripNumber] ^patternIdentifier.system = "urn:oid:2.16.840.1.113883.2.4.3.32.5"
* identifier[tripNumber] ^short = "Trip number"
* identifier[tripNumber] ^alias[0] = "Ritnummer"
* identifier[tripNumber] ^definition = "Identificerend nummer van een specifieke ambulance-inzet of rit, waarmee de inzet binnen de administratie van de ambulancedienst kan worden getraceerd."
* identifier[tripNumber] ^comment = """
Het ritnummer bestaat uit een aantal onderdelen die worden gescheiden door een koppelteken "-". De structuur is [ambulancevoorziening-jaartal-ritvolgnummer-patiëntvolgnummer]

* ambulancevoorziening N1..2 - Identificatienummer van de ambulancevoorziening
* jaartal N4
* ritvolgnummer N1..14 - Volgnummer van de rit, uniek binnen de ambulancevoorziening en het jaartal
* patiëntvolgnummer N1..2 - Volgnummer van de patiënt binnen de rit. Dit is alleen hoger dan 1 als er meerdere patiënten vervoerd worden of als de rit is geannuleerd en vervolgens wordt de patiënt opnieuw ingestuurd (zie toelichting).

**Toelichting**

Indien een patiënt wordt ingestuurd naar een ziekenhuis met een verkeerd BSN, dan wordt deze rit geannuleerd. Het ritnummer heeft voor de extensie patiëntvolgnummer 1. Vanuit de ambulance wordt een nieuw bericht gestuurd met patiëntvolgnummer 2 en het nieuwe BSN, dus een “andere” patiënt. De annulering van de rit is wel belangrijk, want anders lijkt het alsof er 2 patiënten komen, wat in principe ook kan. Bij een annulering van de rit moet er een nieuw ritnummer komen waarbij het patiëntvolgnummer opgehoogd wordt met 1. Voorbeeld; Na 09-2023-1234567-1 komt 09-2023-1234567-2."""
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#EMER "emergency"

Profile: HgContactPersonAmbulanceHAP
Parent: $nlcore-ContactPerson
Id: hg-ContactPerson-AmbulanceHAP
Title: "hg ContactPerson - Ambulance to HAP"
Description: "Derived from nl-core-ContactPerson."
* ^purpose = "A derived profile from [nl-core-Encounter](http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter) to provide a version better suited for ambulance to HAP use case. This profile augments the nl-core profile with a reference to HgNameInformationAmbulanceHAP."
* name[nameInformation] only HgNameInformationAmbulanceHAP

Profile: HgNameInformationAmbulanceHAP
Parent: $nlcore-NameInformation
Id: hg-NameInformation-AmbulanceHAP
Title: "hg NameInformation - Ambulance to HAP"
Description: "Derived from nl-core-NameInformation."
* ^purpose = "A derived profile from [nl-core-Encounter](http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter) to provide a version better suited for ambulance to HAP use case. This profile augments the nl-core profile with a mapping of the dataelement 'VolledigeNaam'."

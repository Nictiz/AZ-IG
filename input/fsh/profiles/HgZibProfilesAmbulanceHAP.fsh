// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Transaction-specific zib profiles (Ambulanceverwijzing, AMB -> HAP).
//
// Per the Nictiz profiling guidelines, cardinalities and conformance for the participating zibs are applied at the use case (information standard specific) layer, derived from the nl-core profiles. These carry the cardinalities the ART-DECOR transaction puts on the building blocks (Patient, HealthProfessional, HealthcareProvider), plus obligations for sender/receiver.
//
// Cardinalities follow the published AMB-HAP transaction (4.145, 2025-06-10) where tightened: the organization carries identifier 1..* and name 1..1 so both parties are unambiguously addressable. The patient identifier is 1..* (repeatable, with the BSN slice 0..1 - see the element comment); gender, name and birthDate are left at nl-core cardinality with obligations.
// =============================================================================

// Resource-local invariant. Severity is #warning for now (legitimate edge case: an organization
// addressed other than by URA). It can be raised to #error once the ART-DECOR conformance mapping
// confirms the requirement (see the Open Items page).
Invariant: hg-org-1
Description: "The organization should be unambiguously addressable: a URA identifier is present."
Severity: #warning
Expression: "identifier.where(system = 'http://fhir.nl/fhir/NamingSystem/ura').exists()"

Profile: HgPatientAmbulanceHAP
Parent: $nlcore-Patient
Id: hg-Patient-AmbulanceHAP
Title: "hg Patient - Ambulance to HAP"
Description: "Patient in the ambulance to GP out-of-hours service (HAP) referral. Derived from nl-core-Patient; identifiers (e.g. BSN or a local hospital identifier) should be sent when known so the HAP can match the referral to a person."
* ^purpose = "A derived profile from [nl-core-Patient](http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient) to provide a version better suited for the Ambulance to HAP use case. This profile carries the cardinalities of the transaction and the obligations for sender and receiver, and requires at least one identifier for the patient."
* insert NictizMetadata
* identifier 1..*
* identifier ^comment = "1..*: a patient may carry more than one identifier (for example a BSN and a local hospital identifier), so the element is repeatable. The BSN is optional (min 0) because an ambulance patient is not always identified yet. An alternative (temporary) identifier must be present when the patient identification has not yet been verified."
* identifier insert ObligationMandatory
* identifier[bsn] 0..1
* name insert Obligation
* name.text ^comment = "This element can be used to represent the full name as plain text when the name is not registered in a structured manner (i.e. without the structured `family`/`given` parts)."
* gender insert Obligation
* birthDate insert Obligation
* contact.name only HgNameInformationAmbulanceHAP

Profile: HgHealthcareProviderOrganizationAmbulanceHAP
Parent: $nlcore-Organization
Id: hg-HealthcareProvider-Organization-AmbulanceHAP
Title: "hg HealthcareProvider Organization - Ambulance to HAP"
Description: "Sending (RAV) and receiving (HAP) organization in the ambulance referral. Derived from nl-core-HealthcareProvider-Organization; an identifier (e.g. URA) is required so the organization is unambiguously addressable."
* ^purpose = "A derived profile from [nl-core-HealthcareProvider-Organization](http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization) to provide a version better suited for the Ambulance to HAP use case. This profile requires an identifier so that both the sending and the receiving organization are unambiguously addressable."
* insert NictizMetadata
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
* ^purpose = "A derived profile from [nl-core-HealthProfessional-PractitionerRole](http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole) to provide a version better suited for the Ambulance to HAP use case. This profile adds the obligations for sender and receiver on the professional and the organization they act for."
* insert NictizMetadata
* practitioner only Reference(Practitioner or $nlcore-Practitioner or HgHealthProfessionalPractitionerAmbulanceHAP)
* practitioner insert Obligation
* organization insert Obligation

Profile: HgHealthProfessionalPractitionerAmbulanceHAP
Parent: $nlcore-Practitioner
Id: hg-HealthProfessional-Practitioner-AmbulanceHAP
Title: "hg HealthProfessional Practitioner - Ambulance to HAP"
Description: "Sending ambulance professional in the referral. Derived from nl-core-HealthProfessional-Practitioner; the transaction requires at least one ZorgverlenerIdentificatienummer, so identifier is 1..*."
* ^purpose = "A derived profile from [nl-core-HealthProfessional-Practitioner](http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner) to provide a version better suited for the Ambulance to HAP use case. This profile requires an identifier for the sending professional, as the transaction does, and adds the obligations for sender and receiver."
* insert NictizMetadata
* identifier 1..*
* identifier insert ObligationMandatory

Profile: HgEncounterAmbulanceHAP
Parent: $nlcore-Encounter
Id: hg-Encounter-AmbulanceHAP
Title: "hg Encounter - Ambulance to HAP"
Description: "An interaction between a patient and ambulance professionals. Derived from nl-core-Encounter."
* ^purpose = "A derived profile from [nl-core-Encounter](http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter) to provide a version better suited for the Ambulance to HAP use case. This profile carries the mapping of the data element 'Ritnummer'."
* insert NictizMetadata
* identifier ^slicing.discriminator[0].type = #pattern
* identifier ^slicing.discriminator[0].path = "$this"
* identifier ^slicing.rules = #open
* identifier contains tripNumber 1..1
* identifier[tripNumber] ^patternIdentifier.system = "urn:oid:2.16.840.1.113883.2.4.3.32.5"
* identifier[tripNumber] ^short = "Trip number"
* identifier[tripNumber] ^alias[0] = "Ritnummer"
* identifier[tripNumber] ^definition = "Identificerend nummer van een specifieke ambulance-inzet of rit, waarmee de inzet binnen de administratie van de ambulancedienst kan worden getraceerd."
* identifier[tripNumber] ^comment = """Het ritnummer bestaat uit een aantal onderdelen die worden gescheiden door een koppelteken "-". De structuur is [ambulancevoorziening-jaartal-ritvolgnummer-patiëntvolgnummer]"""
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#EMER "emergency"

Profile: HgNameInformationAmbulanceHAP
Parent: $nlcore-NameInformation
Id: hg-NameInformation-AmbulanceHAP
Title: "hg NameInformation - Ambulance to HAP"
Description: "Derived from nl-core-NameInformation."
* ^purpose = "A derived profile from [nl-core-NameInformation](http://nictiz.nl/fhir/StructureDefinition/nl-core-NameInformation) to provide a version better suited for the Ambulance to HAP use case. This profile carries the mapping of the data element 'VolledigeNaam'."
* insert NictizMetadata
// The comment is taken over from nl-core-NameInformation (0.12.0-beta.4), with the heading
// "## Zib compatibility" written as bold text. As a heading it gives the definitions page a
// second top level heading, which the IG Publisher reports as a WCAG error. Remove this rule
// once nl-core has fixed the heading.
* given ^comment = """This element can be used to represent full given names or initials. `extension:givenOrInitial` SHALL be used on each repretition to specifiy if it's a full name (_BR_) or an initial (_IN_).

**Zib compatibility**

Tthis element is used to represent the FirstNames and Initials concepts of zib NameInformation, but the FHIR implementation deviates from the zib model. The zib defines these concepts as a list of official first names (as a single string) and a list of initials (as a single string), both optional. They both represent the official name(s) of a person and thus represent the same concept. In FHIR however, each first name is either a complete name or an initial, but not both. In addition, each name may be defined separately.

Therefore, the zib concepts are implemented here in the following way:

* Systems SHOULD use a `.given` element for each official first name that they know of (either as a full name or an initial), in order of appearance (as specified by FHIR).
* Each of these elements:
  * SHOULD be populated with the complete name if it is known, or with the initial if no more information is available.
  * As noted, it SHALL be augmented with `extension:givenOrInitial`.

Initials should thus not be communicated for each complete first name that is known, in contrast to what is specified by the zib. Receiving systems can recreate initials from the full names if needed.

If a system _does_ however only have a list of official first names and a separate list of official initials, without knowing the relationship between these two, only the full names SHOULD be communicated, while an additional `.name` instance MAY be used to communicate the initials. It is expected that the second instance just contains the initials and no other information from the zib. Receiving systems MAY ignore the second instance.

**Note 1:** The GivenName concept should not be included here but in a separate `.name` instance where `.use` = _usual_.

**Note 2**: As specified by FHIR, multiple official first names MAY be combined in a single `.given` element (separated by spaces), as long as the `.given` elements can be concatenated to form the full first name representation, and the 'extension:givenOrInitial` is used to mark the element as containing either full names or the initials. This pattern is strongly discouraged as it is hard to determine if the value pertains multiple names or a single combined name containing spaces."""

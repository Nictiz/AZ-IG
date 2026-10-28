### Overview

This page describes the data model for the Ambulanceverwijzing (AMB → HAP) referral: the resources, how they fit together, the profiles that constrain them, and how to declare conformance and validate. For element-by-element detail, open each profile under [Artifacts](artifacts.html).

### Message structure

A referral carries the following clinical core (see [Data Exchange](data-exchange.html) for how it travels):

- *hg-ReferralServiceRequest-AmbulanceHAP* is the focal resource. It references the patient (*subject*), the sending ambulance (*requester*) and the receiving HAP (*performer*), and carries the clinical content through `supportingInfo`.
- *supportingInfo* points to a *hg-ReferralComposition-AmbulanceHAP* for the transfer summary note (reason, instituted treatment, diagnosis or conclusion) and, when documents are attached, to one or more *hg-ReferralDocumentReference-AmbulanceHAP* resources.
- The dataset's CommunicationItem wrapper is folded into *DocumentReference* (its sender on *author*); the recipient is the *performer* of the referral.

One wrapper sits on top of this core: *hg-ReferralBundle-AmbulanceHAP*, the `transaction` Bundle the sender POSTs. It carries the resources above as `POST` entries with a `urn:uuid` `fullUrl` each, so the references between them resolve within the transaction and no entry claims an identity on the receiving server.

The example message under [Artifacts](artifacts.html) illustrates the model: a message based on the *Richtlijn Gegevensuitwisseling Acute Zorg*, generated from an ADA instance in ART-DECOR. The [Testing](testing.html) page describes it.

### Profiles in this use case

The diagram shows the use case profiles in the transaction Bundle and the references between them. Each arrow is labeled with the referencing element. The table below links each profile and the profile it is derived from.

<div>{% include data-model.svg %}</div>
<br clear="all"/>

| Resource | Use case profile | Derived from | Role in the referral |
|---|---|---|---|
| ServiceRequest | [`hg-ReferralServiceRequest-AmbulanceHAP`](StructureDefinition-hg-ReferralServiceRequest-AmbulanceHAP.html) | [`hg-ServiceRequest`](StructureDefinition-hg-ServiceRequest.html) | Focal resource: the referral request |
| Composition | [`hg-ReferralComposition-AmbulanceHAP`](StructureDefinition-hg-ReferralComposition-AmbulanceHAP.html) | [`hg-Composition`](StructureDefinition-hg-Composition.html) | Transfer summary note (treatment given, diagnosis/conclusion) |
| DocumentReference | [`hg-ReferralDocumentReference-AmbulanceHAP`](StructureDefinition-hg-ReferralDocumentReference-AmbulanceHAP.html) | [`hg-DocumentReference`](StructureDefinition-hg-DocumentReference.html) | Attached document(s), e.g. a report (0..\*) |
| Patient | [`hg-Patient-AmbulanceHAP`](StructureDefinition-hg-Patient-AmbulanceHAP.html) | [`nl-core-Patient`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-Patient) | The patient being referred |
|       Encounter       |                                                                [`hg-Encounter-AmbulanceHAP`](StructureDefinition-hg-Encounter-AmbulanceHAP.html)                                                               |                                                                                                  [`nl-core-Encounter`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-Encounter)                                                                                                  |                         The interaction between a patient and the ambulance professionals (trip number)                         |
| Organization | [`hg-HealthcareProvider-Organization-AmbulanceHAP`](StructureDefinition-hg-HealthcareProvider-Organization-AmbulanceHAP.html) | [`nl-core-HealthcareProvider-Organization`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-HealthcareProvider-Organization) | Sending (RAV) and receiving (HAP) organizations |
| PractitionerRole | [`hg-HealthProfessional-PractitionerRole-AmbulanceHAP`](StructureDefinition-hg-HealthProfessional-PractitionerRole-AmbulanceHAP.html) | [`nl-core-HealthProfessional-PractitionerRole`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-HealthProfessional-PractitionerRole) | Role of the sending ambulance professional |
| Practitioner | [`hg-HealthProfessional-Practitioner-AmbulanceHAP`](StructureDefinition-hg-HealthProfessional-Practitioner-AmbulanceHAP.html) | [`nl-core-HealthProfessional-Practitioner`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-HealthProfessional-Practitioner) | The ambulance professional |
| Bundle | [`hg-ReferralBundle-AmbulanceHAP`](StructureDefinition-hg-ReferralBundle-AmbulanceHAP.html) | [`hg-Bundle`](StructureDefinition-hg-Bundle.html) | The transaction that is POSTed |

 The free text of each *Composition* section is carried in the section's own narrative (*Composition.section.text*, whose *.div* holds plain text or the limited xhtml allowed for a Narrative).

The R4 resources *Encounter* and *ServiceRequest* both contain the mandatory element `status`. In the current use case, the patient is present at the time the data is exchanged, and the transaction is performed only once. Therefore, the status values are fixed for this use case:

- `Encounter.status` SHALL be `finished`.
- `ServiceRequest.status` SHALL be `completed`.

These fixed values reflect the current, one-time nature of the transaction. In future use cases involving ongoing or repeatable service requests, other `ServiceRequest.status` values may be applicable.

### Reading obligations

This IG expresses support expectations with the FHIR Obligations framework. Each obligation-marked element carries `mustSupport = true` plus two actor-scoped expectations:

- Sender (*hg-ActorSender-AmbulanceHAP*): for a mandatory element (min >= 1) it **SHALL** always populate it (`SHALL:populate`); for an optional element it **SHALL** populate it when it knows a value (`SHALL:populate-if-known`).
- Receiver (*hg-ActorReceiver-AmbulanceHAP*): **SHALL** accept the element without raising an error (`SHALL:no-error`).

Obligations are shown per element on each profile's page. The rationale for this approach is on the [Design Decisions](design-decisions.html#conformance-via-obligations) page.

### Declaring conformance and validating

- Validation. Validate instances with the official HL7 FHIR validator against the package `nictiz.nl.az` together with its dependencies (nl-core, zib2020). A resource is conformant when it passes validation against the relevant profile.
- Declaring conformance. In exchange, the nl-core profiles remain the normative basis. A sender that meets the tighter use case cardinalities **MAY** declare this by listing the use case profile canonical in *meta.profile*; a resource that conforms to a use case profile also satisfies nl-core.
- Actor perspective. Validate from the relevant actor's perspective: a sending system against the Sender obligations, a receiving system against the Receiver obligations. Validating the `Bundle` checks the transaction as a whole; validating an individual resource checks that resource on its own.

### Dutch-English element name mapping

The ART-DECOR dataset is Dutch-only. Each profile element carries three language-related descriptors sourced differently:

- `alias` carries the Dutch dataset element name verbatim from ART-DECOR, preserving direct traceability to the source.
- `definition` carries the Dutch *omschrijving* from ART-DECOR.
- `short` carries an English translation authored in this IG. Where an equivalent element existed in the archived ELZ FHIR profiles (`nictiz.fhir.nl.r4.elz`), the same English term is used; elements specific to the AMB-HAP transaction are translated independently.

The Dutch-to-English correspondence per element is therefore visible directly on each profile: the `alias` (Dutch dataset name) and the `short` (English term) are shown for every element on the profile pages under [Artifacts](artifacts.html).

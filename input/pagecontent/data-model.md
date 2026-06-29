### Overview

This page describes the data model for the Ambulanceverwijzing (AMB naar HAP) referral: the resources that make up a referral, how they fit together, the profiles that constrain them, how to read the support obligations, and how to declare conformance and validate. For element-by-element detail, open each profile under [Artifacts](artifacts.html).

### Message structure

A referral always carries the same clinical core, regardless of the exchange paradigm (see [Data Exchange](data-exchange.html)):

- `hg-ReferralServiceRequest-AmbulanceHAP` is the focal resource. It references the patient (`subject`), the sending ambulance (`requester`) and the receiving HAP (`performer`), and carries the clinical content through `supportingInfo`.
- `supportingInfo` points to a `hg-ReferralComposition-AmbulanceHAP` for the transfer summary note (reason, instituted treatment, diagnosis or conclusion) and, when documents are attached, to one or more `hg-ReferralDocumentReference-AmbulanceHAP` resources.
- The dataset's CommunicatieItem wrapper is folded into `DocumentReference` (its category on `category`, its sender on `author`); the recipient is the referral's `performer`.

Under the FHIR Messaging paradigm, two wrapper resources are added on top of this core: `hg-ReferralMessageHeader-AmbulanceHAP` (which identifies the event and focuses the ServiceRequest) and `hg-ReferralBundle-AmbulanceHAP` (the message bundle). Under the RESTful or FHIR Document paradigms these wrappers are replaced by a transaction bundle or a document bundle respectively.

The worked example (scenario 5b) under [Artifacts](artifacts.html) shows a complete referral message with all participating resources.

### Profiles in this use case

| Resource | Use case profile | Derived from | Role in the referral |
|---|---|---|---|
| ServiceRequest | `hg-ReferralServiceRequest-AmbulanceHAP` | `hg-ReferralServiceRequest` | Focal resource: the referral request |
| Composition | `hg-ReferralComposition-AmbulanceHAP` | `hg-ReferralComposition` | Transfer summary note (treatment given, diagnosis/conclusion) |
| DocumentReference | `hg-ReferralDocumentReference-AmbulanceHAP` | `hg-ReferralDocumentReference` | Attached document(s), e.g. a report (0..\*) |
| Patient | `hg-Patient-AmbulanceHAP` | nl-core-Patient | The patient being referred |
| Organization | `hg-HealthcareProvider-Organization-AmbulanceHAP` | nl-core-HealthcareProvider-Organization | Sending (RAV) and receiving (HAP) organizations |
| PractitionerRole | `hg-HealthProfessional-PractitionerRole-AmbulanceHAP` | nl-core-HealthProfessional-PractitionerRole | Role of the sending ambulance professional |
| Practitioner | (none - nl-core directly) | nl-core-HealthProfessional-Practitioner | The ambulance professional |
| MessageHeader | `hg-ReferralMessageHeader-AmbulanceHAP` | `hg-ReferralMessageHeader` | Messaging wrapper: event and focus |
| Bundle | `hg-ReferralBundle-AmbulanceHAP` | `hg-ReferralBundle` | Messaging wrapper: the message bundle |

`Practitioner` has no dedicated use case profile; the nl-core profile is used directly. The free text of each Composition section is carried in the section's own narrative (`Composition.section.text`, whose `.div` holds plain text or the limited xhtml allowed for a Narrative).

### Reading obligations

This IG uses the FHIR Obligations framework instead of `mustSupport`. Each obligation-marked element carries two actor-scoped expectations:

- Sender (`hg-ActorSender-AmbulanceHAP`): for a mandatory element (min >= 1) it **SHALL** always populate it (`SHALL:populate`); for an optional element it **SHALL** populate it when it knows a value (`SHALL:populate-if-known`).
- Receiver (`hg-ActorReceiver-AmbulanceHAP`): **SHALL** accept the element without raising an error (`SHALL:no-error`).

Obligations are shown per element on each profile's page. The rationale for this approach is on the [Design Decisions](design-decisions.html#conformance-via-obligations) page.

### Declaring conformance and validating

- Validation. Validate instances with the official HL7 FHIR validator against the package `nictiz.fhir.nl.r4.acutezorg` together with its dependencies (nl-core, zib2020). A resource is conformant when it passes validation against the relevant profile.
- Declaring conformance. In exchange, the nl-core profiles remain the normative basis. A sender that meets the tighter use case cardinalities **MAY** declare this by listing the use case profile canonical in `meta.profile`; a resource that conforms to a use case profile also satisfies nl-core and, by extension, FHIR core.
- Actor perspective. Validate from the relevant actor's perspective: a sending system against the Sender obligations, a receiving system against the Receiver obligations. Wrapper resources (`MessageHeader`, `Bundle`) are only required under the FHIR Messaging paradigm.

### Dutch-English element name mapping

The ART-DECOR dataset is Dutch-only. Each profile element carries three language-related descriptors sourced differently:

- `alias` carries the Dutch dataset element name verbatim from ART-DECOR, preserving direct traceability to the source.
- `definition` carries the Dutch *omschrijving* from ART-DECOR.
- `short` carries an English translation authored in this IG. Where an equivalent element exists in the ELZ FHIR profiles (`nictiz.fhir.nl.r4.elz`), the same English term is used; elements specific to the AMB-HAP transaction are translated independently.

| Dutch dataset name | English `short` |
|---|---|
| Envelop | Envelope |
| Bestemmingsstatus | DestinationStatus |
| Patient | Patient |
| Datum en tijd | SendDateTime |
| Verzender | Sender |
| Ontvanger | Recipient |
| RedenBericht | MessageReason |
| Context | Context |
| Kern | Core |
| IngesteldeBehandeling | SetTreatment |
| Diagnose/Conclusie | DiagnosisConclusion |
| AfgesprokenMetPatient | AgreedWithPatient |
| CommunicatieItem | CommunicationItem |
| CommunicatieAfzender | CommunicationSender |
| Document | (folded into DocumentReference root) |
| DocumentIdentificatie | DocumentIdentification |
| DocumentSetIdentificatie | DocumentSetIdentification |
| DocumentType | DocumentType |
| DocumentBestandtype | DocumentMediaType |
| DocumentInhoud | DocumentContent |
| DocumentNaam | DocumentName |
| DocumentCreatieDatumTijd | DocumentCreationDateTime |

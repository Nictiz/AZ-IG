## Design decisions

This page documents the key modeling and conformance choices made in this IG. It is intended for
profile authors, reviewers, and implementers who want to understand the rationale behind the
structure, not just the rules.

### Base profiles

All participating resources build on nl-core (zib2020, R4). Identifiers,
name and address structures, and organisation and practitioner modelling follow nl-core, which
keeps the IG aligned with the wider Dutch FHIR ecosystem.

### Workflow request resource

The referral is modelled as a `ServiceRequest` on FHIR core, with
`intent` fixed to `order`. The ambulance is the `requester` and the HAP is the `performer`.
This follows the FHIR workflow request pattern.

### No Task, for now

We deliberately omit `Task` and follow the ad-hoc workflow pattern. See the
[Workflow](workflow.html) page for the rationale and a description of how `Task` could be
introduced in a future version without reworking the referral content profiles.

### Exchange paradigm

The exchange paradigm has not yet been decided. Three options are under
consideration: FHIR Messaging (a Bundle of type `message` with a `MessageHeader`), RESTful
(individual resources POSTed to a FHIR server), and FHIR Document (a Bundle of type
`document`). The profiles in this IG are designed to remain valid under all three options.
See the [Data Exchange](data-exchange.html) page for a full description of each option and
the server and client requirements.

### Terminology

Bindings use zib and nl-core value sets where available.

### Profile layering and naming

Following the [Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4), profiles are organised in two layers. A generic,
open-world layer on FHIR core carries the reusable referral structure with no cardinality
tightening and no obligations: `hg-ReferralServiceRequest`, `hg-ReferralComposition`,
`hg-ReferralDocumentReference`, `hg-ReferralMessageHeader` and `hg-ReferralBundle`. A use case
layer derives from these for this transaction and adds cardinalities, obligations (see below),
the fixed message event and the dataset mappings: `hg-ReferralServiceRequest-AmbulanceHAP` and its
siblings. Names use the `hg-` project prefix with the use case appended; other referral
transactions can reuse the generic layer and add their own use case profiles.

Alongside these, three transaction-specific zib profiles carry the dataset's cardinalities on the
participating building blocks, each derived from the corresponding nl-core profile:
`hg-Patient-AmbulanceHAP` (from nl-core-Patient), `hg-HealthcareProvider-Organization-AmbulanceHAP`
(from nl-core-HealthcareProvider-Organization) and `hg-HealthProfessional-PractitionerRole-AmbulanceHAP`
(from nl-core-HealthProfessional-PractitionerRole). These hold the minima needed to identify the
patient and the sending/receiving organisations and should be reconciled against the published
dataset's exact multiplicities.

These transaction-specific profiles are primarily intended for **validation**, not for constraining
data exchange. In exchange, the corresponding nl-core profiles remain the normative basis.
Implementers may however declare conformance to the tighter use case profiles via
`meta.profile` in the resource if they wish to signal that the stricter cardinalities are met.

From a vendor perspective, this layering is a **design and governance pattern**, not an
implementation requirement. Vendors that already support nl-core do not need to rebuild their
FHIR infrastructure for this transaction: the use case layer only adds a named validation profile
on top of what is already there. Note that different use cases may still require different
functional approaches or workflow adaptations beyond the FHIR layer.

### Conformance via obligations

Instead of `mustSupport`, support expectations are expressed with the FHIR Obligations framework,
following the IKNL PZP and HL7 AU Core pattern. Two system actors are defined as
`ActorDefinition` resources: `hg-ActorSender` (the ambulance/RAV system that produces and pushes
the message) and `hg-ActorReceiver` (the HAP system that consumes it). Obligation-marked
elements carry, via the `obligation` extension, a `SHALL:populate-if-known` obligation for the
Sender (it must populate the element when it knows a value) and a `SHALL:no-error` obligation for
the Receiver (it must accept the element without error). This makes the producer and consumer
expectations explicit and machine-readable, where `mustSupport` would only carry a single,
direction-less flag.

### Reference modelling (open world)

References are kept open. Where the dataset binds a reference to an nl-core building block, the
transaction-specific zib profile is added *next to* the base FHIR resource type rather than
replacing it: for example `ServiceRequest.subject` is `Reference(Patient or hg-Patient-AmbulanceHAP)`
and `requester`/`performer` allow `PractitionerRole`/`Organization` next to their hg- profiles.
This follows the [Nictiz profiling guideline](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4) of adding the target profile beside the core type, so a sender
that holds only a plain core resource still conforms, while a sender that can produce the richer
nl-core-based profile is recognised. We deliberately do not slice references by `targetProfile`
here: there are no per-target cardinalities or mappings that would require it, and a single slice
with multiple `targetProfile`s has known tooling limitations. Slicing can be added later if a
future transaction needs to constrain individual targets separately.

### Resource map

The `hg-ReferralMessageHeader-AmbulanceHAP` focuses the `hg-ReferralServiceRequest-AmbulanceHAP`. The ServiceRequest references the
patient (`subject`), the ambulance (`requester`) and the HAP (`performer`), and carries the
clinical content through `supportingInfo`: a `hg-ReferralComposition-AmbulanceHAP` for the referral note
(reason, instituted treatment, diagnosis or conclusion) and, when documents are attached, one or
more `hg-ReferralDocumentReference-AmbulanceHAP` resources referenced directly. The dataset's CommunicatieItem wrapper
is folded into `DocumentReference` (its category on `category`, its sender on `author`); the
recipient is the referral's `performer`. The example set under scenario 5b shows a complete
message bundle.

### Dataset traceability

Each use case profile carries `Mapping` entries back to the ART-DECOR dataset Verwijzing ambulance
naar huisartsenpost (OID 2.16.840.1.113883.2.4.3.11.60.103.1.1), under the identity
`hg-dataset-20201019`, following the
[Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4).
FHIR elements point at the dataset data-element ids (`hg-dataelement-NNNN`).

The ART-DECOR dataset is **shared across all acute-zorg use cases**: element IDs are allocated once
and reused across transactions. Not every element appears in every transaction. Some elements -
such as TypeBericht (hg-dataelement-1685) and Urgentie (hg-dataelement-1702) - are defined in the
shared dataset and modeled in the ELZ/primary-care transaction but are not explicitly constrained
in the AMB-HAP transaction 4.145. Where a mapping is included for such an element but no further
cardinality, obligation, or binding tightening is applied, the mapping serves as a traceability
link only. The functional design describes the intended use.

Because the CommunicatieItem wrapper was folded into `DocumentReference`, its sender
(CommunicatieAfzender, hg-dataelement-5464) is mapped onto `DocumentReference.author`. The
DocumentReference is mapped at root level to both the CommunicatieItem (hg-dataelement-5457) and
the Document inside it (hg-dataelement-5472). Two elements have no clean FHIR mapping in the
folded model and are documented as known gaps in the FSH: hg-dataelement-5458 (Identificatienummer
van CommunicatieItem) and hg-dataelement-5475 (DocumentVersienummer), the latter because
`DocumentReference` in R4 has no version number field. MessageHeader and Bundle are transport
resources and map only at envelope level (sender, timestamp). All mappings should be reviewed
against the published dataset version.

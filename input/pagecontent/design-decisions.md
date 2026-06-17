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

Some SNOMED CT codes in this IG (for example `11131000146102` on `ServiceRequest.code`) belong to
the Netherlands edition (module `11000146104`) rather than the International edition. The build
therefore pins the SNOMED edition for validation through an expansion-parameters resource
(`expansion-params.json`, referenced from `sushi-config.yaml` via `path-expansion-params`), so
the terminology server resolves these codes against the Netherlands edition. When a newer NL
edition is adopted, update the version URI in `expansion-params.json`.

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

Instead of `mustSupport`, support expectations are expressed with the FHIR Obligations framework. Two system actors are defined per use case as
`ActorDefinition` resources: for the Ambulanceverwijzing these are `hg-ActorSender-AmbulanceHAP`
(the ambulance/RAV system that produces and pushes the message) and `hg-ActorReceiver-AmbulanceHAP`
(the HAP system that consumes it). The reusable `Obligation` rule set references them through
aliases, so each use case supplies its own sender and receiver actors. Obligation-marked
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
nl-core-based profile is recognised.

[§6.2 of the profiling guideline](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4)
recommends slicing a reference by `targetProfile` (`discriminator.type = profile`,
`discriminator.path = resolve()`) to attach per-target mappings to the functional model. That
mechanism requires the reference to be repeatable (max > 1), because FHIR does not permit slicing
an element with max = 1. In this transaction the references that carry a per-target distinction -
`ServiceRequest.requester` (Verzender) and `ServiceRequest.performer` (Ontvanger), each mapping to
a *zorgverlener* (PractitionerRole) and a *zorgaanbieder* (Organization) dataelement - are
constrained to exactly one sender and one recipient (`1..1`), so they cannot be sliced. Their
per-target dataelements are therefore recorded as element-level mappings (the *zorgaanbieder* is
the Organization reached via the sending PractitionerRole's `.organization`). targetProfile
slicing would be the right tool for a future repeatable reference.

The *zorgaanbieder* is referenced as `nl-core-HealthcareProvider-Organization` **directly**, not
through the `nl-core-HealthcareProvider` (Location) focal resource. nl-core makes Location the
focal resource of the zib HealthcareProvider because, in its words, "most references to this zib
are concerned about the recording of the physical location where the care to patient/client takes
place rather than the organizational information." That rationale does not hold here: the
*zorgaanbieder* on `requester`/`performer` (and on `MessageHeader.sender`) is the organisational
identity of the message sender and recipient (RAV and HAP, addressed by URA), an addressing
concept with no care-location component, and the dataset carries no location data to populate a
Location resource. Routing through the Location focal resource would add an empty Location whose
only content is `managingOrganization`. We therefore reference the Organization profile directly;
a use case that genuinely needs the physical care location should reference `nl-core-HealthcareProvider`
instead.

#### Why nl-core profiles are listed alongside FHIR core types

When a reference constraint lists only an nl-core profile \- for example `Reference(nl-core-Patient)`
\- a FHIR validator will require the referenced resource to declare conformance to that profile
(via `meta.profile` or by passing validation against it). A plain R4 Patient resource without
nl-core constraints would fail, even if all the clinically relevant fields are present. By
writing `Reference(Patient or nl-core-Patient)`, both a bare FHIR R4 Patient and a resource
that additionally satisfies nl-core are accepted, keeping the profile open to senders that do
not (yet) produce nl-core-profiled resources.

This applies at both layers. The generic profiles include the base FHIR R4 type alongside every
nl-core equivalent (`Patient or nl-core-Patient`, `Practitioner or nl-core-Practitioner`,
`PractitionerRole or nl-core-PractitionerRole`, `Organization or nl-core-Organization`) so
the generic layer does not impose a Dutch-specific dependency. The use case profiles further
add the use case-specific zib profiles beside both core and nl-core types. A resource conforming
to a use case-specific profile also satisfies nl-core and by extension FHIR core, so the
hierarchy is consistent: stricter profiles are always offered *in addition to* less strict ones,
never as sole alternatives.

### Resource map

The resource map - which resources participate, how they reference each other, and which
profile constrains each - is on the [Data Model](data-model.html#message-structure) page,
together with a profile table and a worked example.

### Dataset traceability

Each use case profile carries `Mapping` entries back to the ART-DECOR dataset Verwijzing ambulance
naar huisartsenpost (OID 2.16.840.1.113883.2.4.3.11.60.103.1.1), under the identity
`hg-dataset-20201019`, following the
[Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4).
FHIR elements point at the dataset data-element ids (`hg-dataelement-NNNN`).

The ART-DECOR project (`hg-`, ELZ) was originally established for primary care
(Eerstelijnszorg/ELZ) information exchange. Its shared dataset catalogue \- including
the `hg-dataelement-NNNN` identifier series \- reflects that origin. The project scope was later
widened to cover acute care use cases such as ambulance referrals. The AMB-HAP transaction
(4.145) is part of this wider scope; its element IDs come from the same shared catalogue and
therefore carry the same `hg-` prefix. Some elements in the catalogue were defined for primary
care transactions (ELZ) and are not explicitly constrained in AMB-HAP transaction 4.145 - for
example TypeBericht (hg-dataelement-1685) and Urgentie (hg-dataelement-1702). Where a mapping is
included for such an element but no further cardinality, obligation, or binding tightening is
applied, the mapping serves as a traceability link only. The functional design describes the
intended use.

Because the CommunicatieItem wrapper was folded into `DocumentReference`, its sender
(CommunicatieAfzender, hg-dataelement-5464) is mapped onto `DocumentReference.author`. The
DocumentReference is mapped at root level to both the CommunicatieItem (hg-dataelement-5457) and
the Document inside it (hg-dataelement-5472). Two elements have no clean FHIR mapping in the
folded model and are documented as known gaps in the FSH: hg-dataelement-5458 (Identificatienummer
van CommunicatieItem) and hg-dataelement-5475 (DocumentVersienummer), the latter because
`DocumentReference` in R4 has no version number field. MessageHeader and Bundle are transport
resources and map only at envelope level (sender, timestamp). All mappings should be reviewed
against the published dataset version.

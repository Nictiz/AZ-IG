### Background

The information exchange described in this Implementation Guide is defined by two Nictiz documents:

- The Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022) ([PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)) is the policy-level guideline that establishes which data must be exchanged between parties in acute care settings in the Netherlands. It defines the scenarios, parties, and content requirements at a clinical level.

- The Ontwerp Gegevensuitwisseling Acute Zorg ([functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg)) is the Nictiz functional design document that translates the *richtlijn* into structured, implementable information exchange specifications. It defines datasets, message structures, and exchange directions for each use case.

### Position in the Nictiz five-layer model

Interoperability requires agreements on five layers - the Nictiz [vijflagenmodel](https://www.nictiz.nl/wat-we-doen/zorginformatiestelsel/interoperabiliteit/lagenmodel-3/) - with *wet- en regelgeving* (legislation) and *beveiliging* (security) as conditions across all of them. This Implementation Guide mainly specifies the Informatie and Applicatie layers; the layers above and below it are established elsewhere.

| Layer | For this transaction | Where in this IG |
|---|---|---|
| Organisatie | Governance and agreements between the parties (ambulance/RAV, HAP), the *Richtlijn Gegevensuitwisseling Acute Zorg*, and the national release policy. Largely outside this technical IG. | [Home](index.html), Functional design (this page) |
| Zorgproces | The handover itself: an ambulance professional refers a patient to the HAP after on-scene care, one-directional PUSH. | [Use cases](use-cases.html), [Workflow](workflow.html) |
| Informatie | What is exchanged: the ART-DECOR dataset, the zibs and nl-core, and the dataset mappings. | [Data model](data-model.html), this page |
| Applicatie | How systems exchange it: the FHIR R4 profiles, the message structure (MessageHeader/Bundle), CapabilityStatements and ActorDefinitions. | [Artifacts](artifacts.html), [Data model](data-model.html) |
| IT-infrastructuur | The transport: the exchange paradigm (FHIR Messaging, RESTful or FHIR Document), not yet chosen. | [Data exchange](data-exchange.html) |

The two conditional columns, *wet- en regelgeving* and *beveiliging*, apply across every layer and are out of scope of this IG.

### Use case: Ambulanceverwijzing (AMB naar HAP), section 2.16

[Section 2.16 of the functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29) covers the handover of a patient by an ambulance professional to a GP out-of-hours post (HAP, *huisartsenpost*) after on-scene care. This corresponds to message 24 in the *richtlijn* (AMB naar HAP). The exchange is one-directional (PUSH): the ambulance/Regionale Ambulancevoorziening (RAV) sends, the HAP receives.

The information exchanged covers patient identification, the reason for referral, the treatment instituted on scene, the clinical conclusion or working diagnosis, and any supporting documents such as an clinical note or ECG.

### ART-DECOR dataset

The functional design is formalized in a machine-readable dataset in [ART-DECOR](https://decor.nictiz.nl/ad/#/hg-), the standard Dutch platform for defining healthcare information datasets.

Relationship to ELZ.

The [`nictiz.fhir.nl.r4.elz`](https://simplifier.net/packages/nictiz.fhir.nl.r4.elz/) package is the FHIR implementation of the primary care (Eerstelijnszorg/ELZ) transactions in the same ART-DECOR project (`hg-`) that this IG uses for the AMB-HAP transaction. The shared ART-DECOR project was originally established for primary care exchanges (GP referrals, paramedic referrals); it has since been widened to cover acute care use cases including ambulance referrals. Because both IGs draw on the same `hg-` project, they share element IDs (`hg-dataelement-NNNN`), the `hg-` canonical prefix, and - in the current state - overlapping profile IDs (`hg-ReferralServiceRequest`, `hg-ReferralComposition`). These are not the same profiles. The generic layer in this IG was developed independently and intentionally diverges from ELZ in several places:

- `hg-ReferralServiceRequest`: the ELZ profile fixes `status` to `#completed` and defines a `category` slice with a primary-care-specific OID coding. Both are omitted here as they are ELZ specific; use case layers in this IG add their own `category` slice and `status` constraints where needed.
- `hg-ReferralComposition`: the ELZ profile defines a detailed Envelope/Core section hierarchy specific to primary care (CarePath, RequiredConsultationFacilities, MessageReason, etc.). Section structure has proven to be use case specific, so no named sections are defined at the generic layer; each use case adds its own section slices.
- `hg-ReferralTask`: present in ELZ. Not yet defined here; will be added when a use case requires explicit workflow tracking.
- `hg-ReferralMessageHeader`, `hg-ReferralBundle`, `hg-ReferralDocumentReference`: present in this IG, not in ELZ.

Note that `nictiz.fhir.nl.r4.elz` is also not in a final state. The differences described above are therefore not blocking, but they do need to be reconciled before either package reaches a stable release. As part of that reconciliation, ELZ should adopt the same two-layer pattern used here: a generic open-world base profile and a separate use case layer that adds the primary-care- specific constraints (category slice, status, section structure). In a future version, `nictiz.fhir.nl.r4.elz` should depend on this IG for the shared generic profiles rather than maintaining its own copies.

There are two distinct ART-DECOR artefacts relevant to this IG:

Dataset - the shared catalog of data element definitions, originally primary care and now widened to all participating acute care use cases. Element identifiers (`hg-dataelement-NNNN`) are allocated here once and reused across transactions.

OID: `2.16.840.1.113883.2.4.3.11.60.103.1.1`, effective date 2020-10-19 - [view in ART-DECOR](https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39)

Transaction - the AMB-HAP-specific transaction definition (which elements are used, cardinalities, constraints). This is the published view to read when implementing or reviewing the exchange.

OID: `2.16.840.1.113883.2.4.3.11.60.103.4.145`, effective date 2025-06-10 - [view published transaction](https://decor.nictiz.nl/pub/eerstelijnszorg/hg-html-20260317T103425/tr-2.16.840.1.113883.2.4.3.11.60.103.4.145-2025-06-10T000000.html)

Each profile in this IG carries `Mapping` entries that trace FHIR elements back to their corresponding dataset element identifiers (`hg-dataelement-NNNN`). These mappings are visible on the Mappings tab of each profile page. See the [Design Decisions](design-decisions.html#dataset-traceability) page for the mapping conventions used.

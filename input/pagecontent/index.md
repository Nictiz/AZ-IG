### Scope

This Implementation Guide covers the referral from an ambulance professional to a GP
out-of-hours post (HAP), known in the
[Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022)](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)
as the Ambulanceverwijzing (message 24, AMB naar HAP). It corresponds to
[section 2.16 of the Nictiz functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29)
and to scenario 5b of the richtlijn. The exchange is one directional (PUSH):
the ambulance sends, the HAP receives. The intended audience is software developers building
sending or receiving systems.

Message 23 (AMB naar HA, referral to the regular GP) is out of scope for this version. It
follows the same FHIR pattern and can be accommodated later by adding a parallel
`hg-Referral*-AmbulanceHA` use-case layer on the same generic base profiles, together with a
new `ambulance-referral-to-ha` event code in `HgMessageEventCS`. No changes to the existing
HAP profiles would be required.

### Design choices

Base profiles. All participating resources build on nl-core (zib2020, R4). Identifiers,
name and address structures, and organisation and practitioner modelling follow nl-core, which
keeps the IG aligned with the wider Dutch FHIR ecosystem.

Workflow request resource. The referral is modelled as a `ServiceRequest` on FHIR core, with
`intent` fixed to `order`. The ambulance is the `requester` and the HAP is the `performer`.
This follows the FHIR workflow request pattern.

No Task, for now. We deliberately omit `Task` and follow the ad-hoc workflow pattern, in which
the performer acts on the request directly without a separate fulfilment resource. It is
conceivable that a future version, or other referral use cases that need richer workflow and
status tracking, will add a `Task` to mediate request and fulfilment. The current profiles are
designed so that this can be introduced without reworking the referral content.

Exchange paradigm. The referral is exchanged as FHIR Messaging: a `Bundle` of type `message`
with a `MessageHeader` that carries the event and focuses the `ServiceRequest`. This fits the
LSP, which routes messages in a store-and-forward manner, and it matches the event-driven nature
of an ambulance handover. A transaction bundle (REST against the receiver) or a document bundle
(a static, attestable letter) were the alternatives; messaging was chosen as the closest fit to
the target infrastructure.

Terminology. Bindings use zib and nl-core value sets where available. NHG-specific terminology
is not used.

### Profile layering and naming

Following the [Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4), profiles are organised in two layers. A generic,
open-world layer on FHIR core carries the reusable referral structure with no cardinality
tightening and no `mustSupport`: `hg-ReferralServiceRequest`, `hg-ReferralComposition`,
`hg-ReferralDocumentReference`, `hg-ReferralMessageHeader` and `hg-ReferralBundle`. A use-case
layer derives from these for this transaction and adds cardinalities, obligations (see below),
the fixed message event and the dataset mappings: `hg-ReferralServiceRequest-AmbulanceHAP` and its
siblings. Names use the `hg-` project prefix with the use case appended; other referral
transactions can reuse the generic layer and add their own use-case profiles.

Alongside these, three transaction-specific zib profiles carry the dataset's cardinalities on the
participating building blocks, each derived from the corresponding nl-core profile:
`hg-Patient-AmbulanceHAP` (from nl-core-Patient), `hg-HealthcareProvider-Organization-AmbulanceHAP`
(from nl-core-HealthcareProvider-Organization) and `hg-HealthProfessional-PractitionerRole-AmbulanceHAP`
(from nl-core-HealthProfessional-PractitionerRole). These hold the minima needed to identify the
patient and the sending/receiving organisations and should be reconciled against the published
dataset's exact multiplicities.

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

Each profile carries `mapping` entries back to the ART-DECOR dataset Verwijzing ambulance naar
huisartsenpost (OID 2.16.840.1.113883.2.4.3.11.60.103.1.1), under the identity
`hg-dataset-20201019`, mirroring the Nictiz-R4-ELZ AMBU-HAP profiles. FHIR elements point at the
dataset data-element ids (hg-dataelement-NNNN). Because the CommunicatieItem wrapper was folded
into DocumentReference, its category and sender are mapped onto `DocumentReference.category` and
`DocumentReference.author`. MessageHeader and Bundle are transport resources, so they map only at
envelope level (sender, timestamp). These are best-effort and should be reviewed against the
published dataset version.

### Open items

These need confirmation before the profiles are finalised.

- Bestemmingsstatus (Envelop). Modelled provisionally through `ServiceRequest.status`
  (active maps to active, cancelled maps to revoked). The third value, transferred, has no clean
  core equivalent and may need a small extension. To be decided.
- `DocumentReference.category` binding. Left open pending a suitable zib, nl-core, or generic
  value set. The original Nictiz profile bound the CommunicatieItem category to an NHG-derived set,
  which is out of scope here.
- `ServiceRequest.reasonCode`. Currently text only. A coded binding can be added if section 2.16
  specifies one.
- Document specification. Section 3.3 of the Nictiz functional design specifies the document
  inside the Ambulanceverwijzing to the HAP. The `hg-ReferralDocumentReference-AmbulanceHAP` constraints should be
  reconciled with that once published.

### Dependencies

| Package | Version | Purpose |
|---|---|---|
| [nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core) | 0.12.0-beta.4 | nl-core base profiles (Patient, Organization, PractitionerRole, …) |
| [nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020) | 0.12.0-beta.4 | zib2020 profiles; declared explicitly because Sushi does not pull this transitive dependency of nl-core on its own |
| [hl7.fhir.uv.tools.r4](https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2) | 1.1.2 | Required for `ActorDefinition` to resolve in R4 |

### Building this IG

The profiles are authored in FSH and compiled with Sushi, then built with the HL7 IG Publisher.

nl-core profiles derive from zib2020 profiles (for example nl-core-Patient derives from
zib-Patient). To validate a constraint such as `subject only Reference(nl-core-Patient)`, Sushi
walks that ancestry, so the zib2020 package must be loaded. Sushi does not pull this transitive
dependency on its own, so zib2020 is declared explicitly in sushi-config.yaml alongside nl-core,
at the same version. With both declared, the build runs clean. No snapshot generation step is
needed; differential-only packages are sufficient.

### References

1. Nictiz. *Richtlijn Gegevensuitwisseling Acute Zorg versie 4*. 2022. [PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)
2. Nictiz. *Ontwerp Acute Zorg — Functioneel ontwerp*. [https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg)
3. Nictiz. *Ontwerp Acute Zorg — Ambulanceverwijzing (AMB → HA/HAP), section 2.16*. [https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29)
4. Nictiz. *Nictiz FHIR Implementation Guide R4*. [https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4)
5. Nictiz. *FHIR Profiling Guidelines R4*. [https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4)
6. Nictiz. *nl-core FHIR R4 package* (nictiz.fhir.nl.r4.nl-core 0.12.0-beta.4). [https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core)
7. Nictiz. *zib2020 FHIR R4 package* (nictiz.fhir.nl.r4.zib2020 0.12.0-beta.4). [https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020)
8. HL7. *FHIR Tools R4 package* (hl7.fhir.uv.tools.r4 1.1.2). [https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2](https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2)

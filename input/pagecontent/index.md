### Scope

This Implementation Guide provides FHIR R4 profiles and guidance for information exchange in
acute care settings in the Netherlands, following the
[Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022)](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)
and the [Nictiz functional design for Acute Zorg](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg).
All profiles are built on nl-core (zib2020, R4) and follow the
[Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4) and the [Nictiz FHIR R4 Implementation Guide](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4).

The IG is organised in two layers. A generic layer defines open-world profiles that are
reusable across referral use cases. Use-case layers derive from these and add
the cardinalities, obligations, terminology bindings and dataset mappings specific to each
transaction.

The intended audience of this IG is software developers building sending or receiving systems for acute
care information exchange in the Netherlands.

#### Language

This IG is written in English. The underlying functional design and ART-DECOR dataset are in Dutch,
and Dutch terms appear throughout the IG where they originate from those sources:

- `alias` values on profile elements carry the Dutch dataset element name (e.g. `Bestemmingsstatus`,
  `RedenBericht`) taken directly from ART-DECOR, to preserve traceability to the source.
- `definition` texts are taken from the ART-DECOR dataset omschrijving and left in Dutch.
- `short` descriptors are English translations authored in this IG. Where an equivalent element
  exists in the ELZ FHIR profiles (`nictiz.fhir.nl.r4.elz`), the same English term is used for
  consistency. Elements specific to the AMB-HAP transaction have no ELZ equivalent and are
  translated independently.

A full Dutch-English mapping of dataset element names to the `short` values used in this IG is
provided on the [Data Model](data-model.html#dutch-english-element-name-mapping) page.

#### Use cases

| Use case | Message | Status |
|---|---|---|
| [Ambulanceverwijzing naar HAP](functional-design.html) (AMB naar HAP) | Message 24 | Included in this version |
| Ambulanceverwijzing naar HA (AMB naar HA) | Message 23 | Planned - follows the same pattern; will add a parallel `hg-Referral*-AmbulanceHA` layer and a new event code |

**Relationship to nictiz.fhir.nl.r4.elz.**
The [`nictiz.fhir.nl.r4.elz`](https://simplifier.net/packages/nictiz.fhir.nl.r4.elz/) package
is the FHIR implementation of the primary care (Eerstelijnszorg/ELZ) transactions
in the same ART-DECOR project (`hg-`) that this IG uses for the AMB-HAP transaction. The shared
ART-DECOR project was originally established for primary care exchanges (GP referrals, paramedic
referrals); it has since been widened to cover acute care use cases including ambulance referrals.
Because both IGs draw on the same `hg-` project, they share element IDs (`hg-dataelement-NNNN`),
the `hg-` canonical prefix, and - in the current state - overlapping profile IDs
(`hg-ReferralServiceRequest`, `hg-ReferralComposition`). These are not the same profiles. The
generic layer in this IG was developed independently and intentionally diverges from ELZ in
several places:

- `hg-ReferralServiceRequest`: the ELZ profile fixes `status` to `#completed` and defines a
  `category` slice with a primary-care-specific OID coding. Both are omitted here as they are
  ELZ-specific; use case layers in this IG add their own `category` slice and `status`
  constraints where needed.
- `hg-ReferralComposition`: the ELZ profile defines a detailed Envelope/Core section hierarchy
  specific to primary care (CarePath, RequiredConsultationFacilities, MessageReason, etc.).
  Section structure has proven to be use case specific, so no named sections are defined at the
  generic layer; each use case adds its own section slices.
- `hg-ReferralTask`: present in ELZ. Not yet defined here; will be added when a use case
  requires explicit workflow tracking.
- `hg-ReferralMessageHeader`, `hg-ReferralBundle`, `hg-ReferralDocumentReference`: present in
  this IG, not in ELZ.

Note that `nictiz.fhir.nl.r4.elz` is also not in a final state. The differences described above
are therefore not blocking, but they do need to be reconciled before either package reaches a
stable release. As part of that reconciliation, ELZ should adopt the same two-layer pattern used
here: a generic open-world base profile and a separate use case layer that adds the primary-care-
specific constraints (category slice, status, section structure). In a future version,
`nictiz.fhir.nl.r4.elz` should depend on this IG for the shared generic profiles rather than
maintaining its own copies.

### Design decisions

Key modeling and conformance choices - profile layering, the obligations framework, open-world
reference modelling, resource map, and dataset traceability - are documented on the
[Design Decisions](design-decisions.html) page.

### Open items

A number of profile decisions and architectural choices are still pending. See the
[Open Items](open-items.html) page for the full list.

### Dependencies

{% include dependency-table.xhtml %}

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
2. Nictiz. *Ontwerp Acute Zorg - Functioneel ontwerp*. [https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg)
3. Nictiz. *Ontwerp Acute Zorg - Ambulanceverwijzing (AMB → HA/HAP), section 2.16*. [https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29)
4. Nictiz. *Nictiz FHIR Implementation Guide R4*. [https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4)
5. Nictiz. *FHIR Profiling Guidelines R4*. [https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4)
6. Nictiz. *nl-core FHIR R4 package* (nictiz.fhir.nl.r4.nl-core 0.12.0-beta.4). [https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core)
7. Nictiz. *zib2020 FHIR R4 package* (nictiz.fhir.nl.r4.zib2020 0.12.0-beta.4). [https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020)
8. HL7. *FHIR Tools R4 package* (hl7.fhir.uv.tools.r4 1.1.2). [https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2](https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2)

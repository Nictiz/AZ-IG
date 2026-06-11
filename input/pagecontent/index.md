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

The intended audience of thit IG is software developers building sending or receiving systems for acute
care information exchange in the Netherlands.

#### Use cases

| Use case | Message | Status |
|---|---|---|
| [Ambulanceverwijzing naar HAP](functional-design.html) (AMB naar HAP) | Message 24 | Included in this version |
| Ambulanceverwijzing naar HA (AMB naar HA) | Message 23 | Planned - follows the same pattern; will add a parallel `hg-Referral*-AmbulanceHA` layer and a new event code |

> **Note on the generic profile layer.**
> The generic `hg-Referral*` profiles in this IG were originally developed as part of the
> [`nictiz.fhir.nl.r4.elz`](https://simplifier.net/packages/nictiz.fhir.nl.r4.elz/) package and have been copied here to serve as the open-world base
> layer for the Acute Zorg umbrella IG. In a future version, `nictiz.fhir.nl.r4.elz` will be
> updated to depend on this IG for those profiles rather than maintaining its own copy. It is
> also possible that the generic profiles will be extracted into a dedicated package at that
> point, if other IGs outside the Acute Zorg scope need to reuse them.

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

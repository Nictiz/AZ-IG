These pending items affect how the exchange is modeled or implemented; each is tracked as a GitHub issue. The full list, including build, tooling and editorial tasks, is in the [issue tracker](https://github.com/Nictiz/AZ-IG/issues).

| Area | Open item | Issue |
|---|---|---|
| Profiles | `DocumentReference.category` - no value set bound yet | [#2](https://github.com/Nictiz/AZ-IG/issues/2) |
| Profiles | `ServiceRequest.reasonCode` - whether to constrain the ICPC coding | [#3](https://github.com/Nictiz/AZ-IG/issues/3) |
| Profiles | `DocumentReference` identifiers (R5/R6) - confirm the local `type`-code scheme | [#4](https://github.com/Nictiz/AZ-IG/issues/4) |
| Profiles | ART-DECOR to FHIR cardinality/conformance mapping (obligations may still change) | [#5](https://github.com/Nictiz/AZ-IG/issues/5) |
| Profiles | `Composition.section` codes still under review | [#6](https://github.com/Nictiz/AZ-IG/issues/6) |
| Profiles | Patient name as free text (`HumanName.text`) - dataset component needed | [#7](https://github.com/Nictiz/AZ-IG/issues/7) |
| Profiles | ART-DECOR mapping ids to be re-verified (functional-spec changes); mapping target URL pending the new ART-DECOR publication | [#17](https://github.com/Nictiz/AZ-IG/issues/17) |
| Profiles | `DocumentReference` - identifier slice `system`/`value` cardinality, and whether the attachment `contentType` is always PDF | [#18](https://github.com/Nictiz/AZ-IG/issues/18) |
| Profiles | Cross-resource subject consistency (Composition/DocumentReference vs ServiceRequest) - guidance or transaction-level check | [#19](https://github.com/Nictiz/AZ-IG/issues/19) |
| Profiles | Realign with the refreshed ART-DECOR transaction (2026-06): stale mapping ids (sender/receiver party sub-elements), new `Ritnummer` (`ServiceRequest.identifier`), receiver `OrganisatieType`, and `Patient.gender` cardinality | [#27](https://github.com/Nictiz/AZ-IG/issues/27) |
| Architecture | Message 23 (AMB → HA) out of scope for this version | [#15](https://github.com/Nictiz/AZ-IG/issues/15) |
| Architecture | Workflow (`Task`) not supported; the beta.1 test phase uses a single transaction with all resources, how a workflow is implemented is to be determined | [#84](https://github.com/Nictiz/AZ-IG/issues/84) |
| Tooling | Example messages are a hand-authored interpretation of the ART-DECOR ADA test data - regenerate with the ADA-to-FHIR tooling once available | [#21](https://github.com/Nictiz/AZ-IG/issues/21) |
| Conformance | Transport-level conformance to the Nictiz FHIR R4 IG (HTTP, search, error handling, CapabilityStatements) - to be worked out against the RESTful paradigm | [#22](https://github.com/Nictiz/AZ-IG/issues/22) |
| Examples | The example Bundles use `POST` entries whose resources still carry an `id`, because a FSH `Instance` cannot be inlined without one. A real sender uses `urn:uuid` `fullUrl` values and no resource ids | [#21](https://github.com/Nictiz/AZ-IG/issues/21) |
| Versioning | The IG version is provisional - align it with the ART-DECOR data set and functional design versions on publication | [#26](https://github.com/Nictiz/AZ-IG/issues/26) |

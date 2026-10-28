These pending items affect how the exchange is modeled or implemented; each is tracked as a GitHub issue. The full list, including build, tooling and editorial tasks, is in the [issue tracker](https://github.com/Nictiz/AZ-IG/issues).

| Area | Open item | Issue |
|---|---|---|
| Profiles | `ServiceRequest.reasonCode` - whether to constrain the ICPC coding | [#3](https://github.com/Nictiz/AZ-IG/issues/3) |
| Profiles | `DocumentReference` identifiers (R5/R6) - confirm the local `type`-code scheme | [#4](https://github.com/Nictiz/AZ-IG/issues/4) |
| Profiles | ART-DECOR to FHIR cardinality/conformance mapping (obligations may still change) | [#5](https://github.com/Nictiz/AZ-IG/issues/5) |
| Profiles | `DocumentReference` versioning - the identifier of the *CommunicatieItem* and the document version number have no clean R4 mapping yet | [#37](https://github.com/Nictiz/AZ-IG/issues/37) |
| Profiles | `Organization.identifier` - a slice for the RAV identification of the sending organization | [#68](https://github.com/Nictiz/AZ-IG/issues/68) |
| Profiles | `Organization.type` - location/department not specified yet in HealthcareProvider Organization for values from LSDV-list | [#106](https://github.com/Nictiz/AZ-IG/issues/106) |
| Profiles | `PractitionerRole.organization` - 0..1 in the profile, while the data set has *zorgaanbieder* 1..1; to be decided before 1.0.0 | [#116](https://github.com/Nictiz/AZ-IG/issues/116) |
| Profiles | `ServiceRequest.reason` and `ServiceRequest.instruction` - Relationship between ServiceRequest and Composition for 'reason' and 'patientinstruction' | [#133](https://github.com/Nictiz/AZ-IG/issues/133) |
| Architecture | Message 23 (AMB → HA) out of scope for this version | [#15](https://github.com/Nictiz/AZ-IG/issues/15) |
| Architecture | Workflow (`Task`) not supported; the beta.1 test phase uses a single transaction with all resources, how a workflow is implemented is to be determined | [#84](https://github.com/Nictiz/AZ-IG/issues/84) |

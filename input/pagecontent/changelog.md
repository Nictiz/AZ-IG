This page lists the notable changes per version for implementers of this IG. Changes to the functional design and the ART-DECOR transaction are described in the [release notes on the Nictiz wiki](https://informatiestandaarden.nictiz.nl/wiki/az:Release_notes_AmbulanceVerwijzing_V1.0.0). The published versions are listed on the [history page](http://ig.nictiz.nl/az/history.html).

Each change links to the GitHub issue and, where there is one, to the AZ ticket in Nictiz Jira.

### 1.0.0-beta.1

Published 2026-10-21. First published version, for testing with vendors. Not for production.

#### Package and publication

- Package id `nictiz.nl.az` and canonical base `http://ig.nictiz.nl/az`, published on ig.nictiz.nl. Every profile URL has changed since 0.1.0-alpha.1. Profiles from nl-core and zib2020 keep `http://nictiz.nl/fhir` ([#101](https://github.com/Nictiz/AZ-IG/issues/101), [#97](https://github.com/Nictiz/AZ-IG/issues/97), [#13](https://github.com/Nictiz/AZ-IG/issues/13)).
- The generic profiles are renamed to `hg-ServiceRequest`, `hg-Composition`, `hg-DocumentReference` and `hg-Bundle`. The use case profiles keep their names ([#80](https://github.com/Nictiz/AZ-IG/issues/80)).
- The IG uses the shared Nictiz IG template ([#100](https://github.com/Nictiz/AZ-IG/issues/100), [#108](https://github.com/Nictiz/AZ-IG/issues/108)).

#### Exchange

- The referral is sent RESTful: the sender POSTs one `transaction` Bundle with a `urn:uuid` `fullUrl` per entry. FHIR Messaging is dropped, so there is no MessageHeader and no message event code ([#14](https://github.com/Nictiz/AZ-IG/issues/14), [#20](https://github.com/Nictiz/AZ-IG/issues/20)).
- Transport-level conformance follows the Nictiz FHIR R4 Implementation Guide ([#22](https://github.com/Nictiz/AZ-IG/issues/22)).
- No Task resource and no document Bundle ([#42](https://github.com/Nictiz/AZ-IG/issues/42), [#45](https://github.com/Nictiz/AZ-IG/issues/45)).

#### Profiles

- The use case layer is aligned with the updated ART-DECOR transaction ([#27](https://github.com/Nictiz/AZ-IG/issues/27); [AZ-1117](https://nictiz.atlassian.net/browse/AZ-1117), [AZ-1145](https://nictiz.atlassian.net/browse/AZ-1145), [AZ-1152](https://nictiz.atlassian.net/browse/AZ-1152), [AZ-1160](https://nictiz.atlassian.net/browse/AZ-1160)).
- Patient: elements and cardinalities follow the transaction ([AZ-1117](https://nictiz.atlassian.net/browse/AZ-1117)). `identifier` is 1..*, with the BSN slice 0..1, as in the generic building blocks ([#28](https://github.com/Nictiz/AZ-IG/issues/28); [AZ-1121](https://nictiz.atlassian.net/browse/AZ-1121)). `gender` is optional, with a populate-if-known obligation ([AZ-1152](https://nictiz.atlassian.net/browse/AZ-1152)).
- Contact person of the patient: the name is sent as free text, without a RelatedPerson resource ([#49](https://github.com/Nictiz/AZ-IG/issues/49), [#61](https://github.com/Nictiz/AZ-IG/issues/61); [AZ-1152](https://nictiz.atlassian.net/browse/AZ-1152)).
- Encounter stays, to carry the trip number (*ritnummer*) in `Encounter.identifier` ([#76](https://github.com/Nictiz/AZ-IG/issues/76); [AZ-1145](https://nictiz.atlassian.net/browse/AZ-1145)).
- *Bestemmingsstatus* (destination status) is removed ([#38](https://github.com/Nictiz/AZ-IG/issues/38)).
- New use case profile `hg-HealthProfessional-Practitioner-AmbulanceHAP`, with `identifier` 1..* ([#39](https://github.com/Nictiz/AZ-IG/issues/39)).
- Composition: LOINC codes for the document type and the sections, including the section for agreements with the patient ([#6](https://github.com/Nictiz/AZ-IG/issues/6), [#35](https://github.com/Nictiz/AZ-IG/issues/35); [AZ-1160](https://nictiz.atlassian.net/browse/AZ-1160), [AZ-1157](https://nictiz.atlassian.net/browse/AZ-1157)). The section codes for *Ingestelde behandeling* and the agreements with the patient are corrected ([#66](https://github.com/Nictiz/AZ-IG/issues/66)).
- DocumentReference: the mapping of `category` is removed ([#2](https://github.com/Nictiz/AZ-IG/issues/2); [AZ-1144](https://nictiz.atlassian.net/browse/AZ-1144)). On both identifier slices `system` and `value` are 1..1, and `contentType` is no longer limited to PDF ([#18](https://github.com/Nictiz/AZ-IG/issues/18)).
- `mustSupport` is set together with every obligation ([#33](https://github.com/Nictiz/AZ-IG/issues/33); [AZ-1159](https://nictiz.atlassian.net/browse/AZ-1159)).
- Cardinalities that equal those of the parent profile are removed ([#85](https://github.com/Nictiz/AZ-IG/issues/85)).

#### Pages

- New Functional Design page, use cases in English, and a diagram of the use case profiles and their references ([#43](https://github.com/Nictiz/AZ-IG/issues/43), [#44](https://github.com/Nictiz/AZ-IG/issues/44), [#46](https://github.com/Nictiz/AZ-IG/issues/46), [#47](https://github.com/Nictiz/AZ-IG/issues/47)).
- The dataset mappings point to the ART-DECOR publication ([#17](https://github.com/Nictiz/AZ-IG/issues/17)).

### 0.1.0-alpha.1

Not published. This version existed only as a continuous build of the `0.1.0` branch, with package id `nictiz.fhir.nl.r4.acutezorg` and canonical base `http://nictiz.nl/fhir`. It was the first draft of the Ambulanceverwijzing naar HAP (AMB to HAP) use case, for review.

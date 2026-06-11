### Background

The information exchange described in this Implementation Guide is defined by two Nictiz documents:

- The **Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022)** ([PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)) is the policy-level guideline that establishes which data must be exchanged between parties in acute care settings in the Netherlands. It defines the scenarios, parties, and content requirements at a clinical level.

- The **Ontwerp Gegevensuitwisseling Acute Zorg** ([functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg)) is the Nictiz functional design document that translates the richtlijn into structured, implementable information exchange specifications. It defines datasets, message structures, and exchange directions for each use case.

### Use case: Ambulanceverwijzing (AMB → HAP), section 2.16

[Section 2.16 of the functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29)
covers the handover of a patient by an ambulance professional to a GP out-of-hours post (HAP, huisartsenpost) after on-scene care. This corresponds to message 24 in the richtlijn (AMB naar HAP). The exchange is one-directional (PUSH): the ambulance / Regionale Ambulancevoorziening (RAV) sends, the HAP receives.

The information exchanged covers patient identification, the reason for referral, the treatment instituted on scene, the clinical conclusion or working diagnosis, and any supporting documents such as an ECG or photograph. The HAP uses this information to prepare for the patient's arrival and to match the referral to the patient.

### ART-DECOR dataset

The functional design is formalised in a machine-readable dataset in [ART-DECOR](https://decor.nictiz.nl/ad/#/hg-), the standard Dutch platform for defining healthcare information datasets. There are two distinct ART-DECOR artefacts relevant to this IG:

**Dataset** - the shared catalogue of data element definitions across all acute-zorg use cases. Element identifiers (`hg-dataelement-NNNN`) are allocated here and reused across transactions.

OID: `2.16.840.1.113883.2.4.3.11.60.103.1.1`, effective date 2020-10-19 - [view in ART-DECOR](https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39)

**Transaction** - the AMB-HAP-specific transaction definition (which elements are used, cardinalities, constraints). This is the published view to read when implementing or reviewing the exchange.

OID: `2.16.840.1.113883.2.4.3.11.60.103.4.145`, effective date 2025-06-10 - [view published transaction](https://decor.nictiz.nl/pub/eerstelijnszorg/hg-html-20260317T103425/tr-2.16.840.1.113883.2.4.3.11.60.103.4.145-2025-06-10T000000.html)

Each profile in this IG carries `Mapping` entries that trace FHIR elements back to their corresponding dataset element identifiers (`hg-dataelement-NNNN`). These mappings are visible on the Mappings tab of each profile page. See the [Design Decisions](design-decisions.html#dataset-traceability) page for the mapping conventions used.

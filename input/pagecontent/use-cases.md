### Overview

This IG covers referral transactions from the [Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022)](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf). The information exchanged covers patient identification, the reason for referral, the treatment instituted on scene, the clinical conclusion or working diagnosis, and any supporting documents such as an clinical note or ECG. Each use case maps to a specific message in the *richtlijn* and is implemented as a separate use case layer on top of the generic `hg-Referral*` profiles.

| Use case | Message | Status |
|---|---|---|
| [Ambulance referral to a GP out-of-hours service](#ambulance-referral-to-a-gp-out-of-hours-service-amb--hap) (*Ambulanceverwijzing naar HAP*; AMB → HAP) | Message 24 | Included in this version |
| [Ambulance referral to a General Practitioner](#ambulance-referral-to-a-general-practitioner-amb--ha) (*Ambulanceverwijzing naar HA*; AMB → HA) | Message 23 | Planned |

---

### Ambulance referral to a GP out-of-hours service (AMB → HAP)

Handover of a patient by an ambulance professional to a GP out-of-hours service (HAP, *huisartsenpost*) after on-scene care. The exchange is one-directional (PUSH): the ambulance/RAV sends, the HAP receives.

Functional design: [Section 2.16 of the Nictiz functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29) - see also the [Functional Design](functional-design.html) page in this IG.

Actors:

- [hg referral Sender - Ambulanceverwijzing (AMBS, AZP-AVS)](ActorDefinition-hg-ActorSender-AmbulanceHAP.html)
- [hg referral Receiver - Ambulanceverwijzing (HIS/HAPIS, AZP-AVO)](ActorDefinition-hg-ActorReceiver-AmbulanceHAP.html)

CapabilityStatements:

- [hg referral Sender CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Sender.html)
- [hg referral Receiver CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Receiver.html)

Profiles: see [Artifacts](artifacts.html#structures-resource-profiles) for the full list of `hg-Referral*-AmbulanceHAP` profiles, and the [Data Model](data-model.html) page for the message structure, profile table, and conformance guidance.

Examples under [Artifacts](artifacts.html): a worked referral based on scenario 5b of the *Richtlijn Gegevensuitwisseling Acute Zorg*; a maximal message modelled on the ART-DECOR ADA test scenario (a richly populated patient and message, with a document attachment); and a minimal message modelled on the ART-DECOR ADA minimal test scenario.

Data exchange: see [Data Exchange](data-exchange.html) for the exchange paradigm options and sender/receiver requirements for this use case.

---

### Ambulance referral to a General Practitioner (AMB → HA)

Handover of a patient by an ambulance professional to a GP (HA, *huisarts*). Follows the same pattern as AMB naar HAP; will add a parallel `hg-Referral*-AmbulanceHA` use case layer and a new message event code. Not yet defined in this version.

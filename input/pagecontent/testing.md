This page lists the example messages provided for review and testing, and gives a functional mapping from the dataset concepts to the FHIR elements they land on.

### How these examples were produced

The example messages are generated with the Nictiz ADA-to-FHIR tooling from ADA instances in ART-DECOR: the functional test scenarios and an example message based on the *Richtlijn Gegevensuitwisseling Acute Zorg*.

All example resources use fictional test data only.

### Example scenarios

| Example | Source | What it shows | Message |
|---|---|---|---|
| Example message | *Richtlijn Gegevensuitwisseling Acute Zorg* | A structured patient with address, telecom and a contact person; a sending nurse; the four Composition sections; and a PDF attachment. | [Bundle](Bundle-bundle-az-ave-voorbeeldbericht-AMB-HAP.html) |
| Maximal | ART-DECOR ADA test `az-ave-tst-2-maximaal` | A richly populated message: structured patient with address, telecom and a contact person; the four Composition sections; and a plain text attachment. | [Bundle](Bundle-bundle-az-ave-tst-2-maximaal.html) |
| Minimal | ART-DECOR ADA test `az-ave-tst-1-minimaal` | A lean message: a patient with a local identifier only, the *Reden bericht* section and a PDF attachment. | [Bundle](Bundle-bundle-az-ave-tst-1-minimaal.html) |

### Mappings

How the dataset concepts (as seen in the ART-DECOR data set and the ADA scenarios) map to FHIR in this IG. The authoritative, element-level mappings to the `hg-dataelement-NNNN` identifiers are on the Mappings tab of each profile; the table below is a functional summary to help read the examples.

#### Envelope - `ServiceRequest` (and the message wrappers)

| Dataset concept (*Envelop*) | FHIR element |
|---|---|
| Patientgegevens | `ServiceRequest.subject` → `Patient` |
| Verzender - *zorgverlener* | `ServiceRequest.requester` → `PractitionerRole` |
| Verzender - *zorgaanbieder* | `PractitionerRole.organization` to `Organization` or `ServiceRequest.requester` to `Organization`;<br>`Composition.author` |
| Ontvanger - *zorgaanbieder* | `ServiceRequest.performer` → `Organization` |
|  Ritnummer  | `ServiceRequest.encounter` → `Encounter.identifier[tripNumber]`   |
| Datum en tijd | `ServiceRequest.authoredOn` |
| RedenBericht (reason, free text) | `ServiceRequest.reasonCode.text` |
| AfgesprokenMetPatient | `ServiceRequest.patientInstruction` |
| Kern (link to the core) | `ServiceRequest.supportingInfo` → `Composition` |
|   Dossiergegevens (link to the document)   |   `ServiceRequest.supportingInfo` → `DocumentReference`   |
| Transaction | `Bundle.type = transaction`; every entry a `POST` with a `urn:uuid` `fullUrl` |

| Dataset concept (_verzender_ - _zorgverlener_)| FHIR element|
|-|-|
| ZorgverlenerIdentificatienummer|  `PractitionerRole` → `Practitioner.Identifier`  |
| Specialisme|  `PractitionerRole.speciality`  |
| Contactgegevens (tefeloonnummer)|  `PractitionerRole.telecom`  |
| Zorgaanbieder (verzender) |  `PractitionerRole.organization` → `Organization`  |

| Dataset concept (*verzender - zorgaanbieder*)| FHIR element|
|-|-|
| ZorgaanbiederIdentificatienummer|  `Organization.identifier`  |
| OrganisatieNaam|  `Organization.name`  |

| Dataset concept (*ontvanger - zorgaanbieder*)| FHIR element|
|-|-|
| ZorgaanbiederIdentificatienummer|  `Organization.identifier`  |
| OrganisatieNaam|  `Organization.name`  |
| OrganisatieType|  `Organization.type[organizationType]`  |

#### Core - `Composition`

| Dataset concept (*Kern*) | FHIR element |
|---|---|
| RedenBericht | `Composition.section[messageReason]` |
| IngesteldeBehandeling | `Composition.section[treatmentGiven]` |
| Diagnose/Conclusie | `Composition.section[diagnosisConclusion]` |
| AfgesprokenMetPatient | `Composition.section[agreedWithPatient]` |

#### Building blocks - `Patient`

| Data concept (_bouwstenen_)  | FHIR element |
|---|---|
| Patient | `Patient` |
|     - Naamgegevens    |        `Patient.name`        |
|     - Adresgegevens    |               `Patient.address`               |
|     - Contactgegevens (telefoon, e-mail)    |               `Patient.telecom`               |
| - Identificatienummer (BSN) | `Patient.identifier` |
| - Geslacht | `Patient.gender` |
| - Geboortedatum | `Patient.birthDate` |
| Contactpersoon | `Patient.contact`  |
|         - Contactgegevens (telefoon)        |          `Patient.contact.telecom[telephoneNumbers]`         |
|         - Naamgegevens        |                              `Patient.contact.name` → `HumanName`                              |
|                             - VolledigeNaam                             |          `HumanName.text`         |
  
#### Document - `DocumentReference` (folded *CommunicatieItem*)

| Dataset concept (*Dossier*) | FHIR element |
|---|---|
| Document | `DocumentReference` |
| DocumentIdentificatie | `DocumentReference.identifier[documentId]` |
| DocumentSetIdentificatie | `DocumentReference.identifier[documentSetId]` |
| DocumentVersienummer | `DocumentReference.extension[documentVersion]` |
| DocumentBestandtype | `DocumentReference.content.attachment.contentType` |
| DocumentInhoud | `DocumentReference.content.attachment.data` |
| DocumentNaam | `DocumentReference.content.attachment.title` |
| DocumentCreatieDatumTijd | `DocumentReference.content.attachment.creation` |
| DocumentType | `DocumentReference.type` |

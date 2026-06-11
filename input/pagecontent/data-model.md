### Resource map

The diagram below shows how the FHIR resources relate to each other in the
Ambulanceverwijzing naar HAP.

```
Bundle (hg-ReferralBundle-AmbulanceHAP)  [Messaging only]
 └── MessageHeader (hg-ReferralMessageHeader-AmbulanceHAP)
      └── focus ──────────────────────────────────────────────┐
                                                              ▼
                                          ServiceRequest (hg-ReferralServiceRequest-AmbulanceHAP)
                                           ├── subject ──────► Patient (hg-Patient-AmbulanceHAP)
                                           ├── requester ────► PractitionerRole (hg-HealthProfessional-PractitionerRole-AmbulanceHAP)
                                           │                    └── organization ► Organization (hg-HealthcareProvider-Organization-AmbulanceHAP)
                                           ├── performer ────► Organization (hg-HealthcareProvider-Organization-AmbulanceHAP)
                                           └── supportingInfo ► Composition (hg-ReferralComposition-AmbulanceHAP)
                                                            └── DocumentReference (hg-ReferralDocumentReference-AmbulanceHAP) [0..*]
```

---

### ServiceRequest - hg-ReferralServiceRequest-AmbulanceHAP

The focal resource of the referral. Identifies the patient, the sending ambulance professional
and organisation, and the receiving HAP.

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `status` | 1..1 | code | Status of the referral request (`active`, `revoked`) |
| `intent` | 1..1 | code | Fixed to `order` |
| `category` | 0..* | CodeableConcept | Message type (berichttype) |
| `priority` | 0..1 | code | Urgency (urgentie) |
| `subject` | 1..1 | Reference(Patient \| hg-Patient-AmbulanceHAP) | The patient being referred |
| `authoredOn` | 1..1 | dateTime | Date and time the referral was created |
| `requester` | 1..1 | Reference(PractitionerRole \| Organization \| hg-HealthProfessional-PractitionerRole-AmbulanceHAP \| hg-HealthcareProvider-Organization-AmbulanceHAP) | Sending ambulance professional or RAV organisation |
| `performer` | 1..1 | Reference(PractitionerRole \| Organization \| hg-HealthProfessional-PractitionerRole-AmbulanceHAP \| hg-HealthcareProvider-Organization-AmbulanceHAP) | Receiving HAP organisation |
| `reasonCode` | 1..1 | CodeableConcept | Reason for the referral (redenBericht / context) |
| `supportingInfo` | 1..* | Reference(hg-ReferralComposition-AmbulanceHAP \| hg-ReferralDocumentReference-AmbulanceHAP) | Referral note and any attached documents |
| `patientInstruction` | 0..1 | string | Instructions agreed with the patient (afgesprokenMetPatient) |

---

### Composition - hg-ReferralComposition-AmbulanceHAP

The referral note carrying the clinical content as structured sections.

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `status` | 1..1 | code | Composition status (`final`) |
| `type` | 1..1 | CodeableConcept | Fixed to LOINC `57133-1` (Referral note) |
| `subject` | 1..1 | Reference(Patient \| hg-Patient-AmbulanceHAP) | The patient |
| `date` | 1..1 | dateTime | Date and time the composition was authored |
| `author` | 1..1 | Reference(PractitionerRole \| Organization \| ...) | Authoring ambulance professional or RAV organisation |
| `title` | 1..1 | string | Human-readable title of the referral note |
| `section[treatmentGiven]` | 0..1 | BackboneElement | Instituted treatment (ingestelde behandeling); SNOMED `182991002` |
| `section[treatmentGiven].extension[treatmentGivenTextValue]` | 1..1 | string (HgExtTextValue) | Free-text description of the treatment given |
| `section[diagnosisConclusion]` | 0..1 | BackboneElement | Diagnosis or conclusion (diagnose/conclusie); SNOMED `60022001` |
| `section[diagnosisConclusion].extension[diagnosisConclusionTextValue]` | 1..1 | string (HgExtTextValue) | Free-text diagnosis or working conclusion |

---

### DocumentReference - hg-ReferralDocumentReference-AmbulanceHAP

An attached document (e.g. ECG, photograph). Zero or more per referral, referenced from
`ServiceRequest.supportingInfo`. The CommunicatieItem wrapper from the dataset is folded into
this resource: the communication category maps to `category` and the sender maps to `author`.

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `masterIdentifier` | 0..1 | Identifier | Unique document instance identifier (documentIdentificatie) |
| `identifier` | 0..* | Identifier | Document set identifier (documentSetIdentificatie) |
| `status` | 1..1 | code | `current` |
| `type` | 0..1 | CodeableConcept | Document type (documentType) |
| `category` | 0..* | CodeableConcept | Communication category (communicatieCategorie) |
| `author` | 0..* | Reference(PractitionerRole \| Organization \| ...) | Sender of the communication item (communicatieAfzender) |
| `content.attachment.contentType` | 1..1 | code | MIME type of the document (documentBestandtype) |
| `content.attachment.data` | 1..1 | base64Binary | Base64-encoded document content (documentInhoud) |
| `content.attachment.title` | 0..1 | string | Document name (documentNaam) |
| `content.attachment.creation` | 0..1 | dateTime | Document creation date/time (documentCreatieDatumTijd) |

---

### MessageHeader - hg-ReferralMessageHeader-AmbulanceHAP

Wraps the referral as a FHIR message. Only relevant under Option 1 (FHIR Messaging).

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `eventCoding` | 1..1 | Coding | Fixed to `HgMessageEventCS#ambulance-referral-to-hap` |
| `focus` | 1..1 | Reference(hg-ReferralServiceRequest-AmbulanceHAP) | The focal ServiceRequest |
| `sender` | 1..1 | Reference(Organization \| hg-HealthcareProvider-Organization-AmbulanceHAP) | Sending RAV organisation |
| `source.endpoint` | 1..1 | url | Technical endpoint of the sending system |
| `destination.endpoint` | 0..1 | url | Technical endpoint of the receiving system |

---

### Patient - hg-Patient-AmbulanceHAP

Derived from nl-core-Patient. Carries the minimum identification needed for the HAP to match
the referral to a person.

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `identifier` | 1..* | Identifier | Patient identifier, e.g. BSN (`http://fhir.nl/fhir/NamingSystem/bsn`) |
| `name` | 1..* | HumanName | Patient name |
| `birthDate` | 0..1 | date | Date of birth |
| `gender` | 0..1 | code | Administrative gender |

---

### Organization - hg-HealthcareProvider-Organization-AmbulanceHAP

Used for both the sending RAV and the receiving HAP. Derived from
nl-core-HealthcareProvider-Organization.

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `identifier` | 1..* | Identifier | Organisation identifier, e.g. URA (`http://fhir.nl/fhir/NamingSystem/ura`) |
| `name` | 0..1 | string | Organisation name |

---

### PractitionerRole - hg-HealthProfessional-PractitionerRole-AmbulanceHAP

The role of the sending ambulance professional. Derived from
nl-core-HealthProfessional-PractitionerRole.

| Element | Cardinality | Type | Description |
|---|---|---|---|
| `practitioner` | 0..1 | Reference(Practitioner) | The individual ambulance professional |
| `organization` | 0..1 | Reference(Organization \| hg-HealthcareProvider-Organization-AmbulanceHAP) | The RAV organisation |
| `code` | 0..* | CodeableConcept | Professional role (e.g. ambulanceverpleegkundige) |

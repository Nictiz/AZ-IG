### Overview

This page describes the data exchange architecture for acute-zorg referrals. The exchange is
always one-directional (PUSH): the sending system produces and transmits a referral; the
receiving system accepts and processes it. The sender is the ambulance / Regionale
Ambulancevoorziening (RAV) system; the receiver is the GP out-of-hours post (HAP) system.

The specific exchange paradigm - how the FHIR resources are packaged and transmitted - has not
yet been decided. Three options are described below. The conformance resources and profiles in
this IG are designed to remain valid under any of the three options; the choice of paradigm
determines which wrapper resources (Bundle, MessageHeader) are required and how the HTTP
interaction is structured.

### System context and broker

In practice, the ambulance system does not produce native FHIR resources. A broker component
- operated separately from both the RAV and the HAP - converts the native ambulance message
format (e.g. an HL7 v2 or proprietary format) to FHIR and forwards it to the receiver. This
broker is transparent from a conformance perspective: this IG defines what the FHIR message
must look like and what the HAP system must be able to receive, regardless of whether the FHIR
content was produced directly by the RAV system or by an intermediary broker. The broker is
not a formal actor in this IG.

---

### Option 1: FHIR Messaging

The referral is wrapped in a `Bundle` of type `message`. The first entry is a `MessageHeader`
that identifies the event (`ambulance-referral-to-hap`) and focuses the `ServiceRequest`. All
referenced resources are included in the same bundle. The sender transmits the bundle to the
receiver's `$process-message` endpoint or via a store-and-forward intermediary (e.g. the LSP).

**Profiles used:** `hg-ReferralBundle-AmbulanceHAP`, `hg-ReferralMessageHeader-AmbulanceHAP`,
and the use-case profiles for the enclosed resources.

**Fits well when:** the infrastructure is event-driven or store-and-forward (e.g. LSP/XDS);
the receiver does not expose a FHIR REST endpoint; the transaction must be atomic and
self-contained.

**Limitations:** requires the sender to produce a complete, valid bundle at the moment of
transmission; less suited for incremental updates or queries.

**Example interaction:**

```http
POST /fhir/$process-message HTTP/1.1
Content-Type: application/fhir+json

{
  "resourceType": "Bundle",
  "type": "message",
  "timestamp": "2026-06-11T10:00:00+02:00",
  "entry": [
    {
      "fullUrl": "urn:uuid:header-1",
      "resource": {
        "resourceType": "MessageHeader",
        "eventCoding": {
          "system": "http://nictiz.nl/fhir/CodeSystem/hg-message-event",
          "code": "ambulance-referral-to-hap"
        },
        "focus": [{ "reference": "urn:uuid:sr-1" }],
        "sender": { "reference": "urn:uuid:org-rav" },
        "source": { "endpoint": "https://ambulance.example.nl/fhir" }
      }
    },
    {
      "fullUrl": "urn:uuid:sr-1",
      "resource": {
        "resourceType": "ServiceRequest",
        "meta": { "profile": ["http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP"] },
        "status": "active",
        "intent": "order",
        "subject": { "reference": "urn:uuid:patient-1" },
        "requester": { "reference": "urn:uuid:prole-1" },
        "performer": [{ "reference": "urn:uuid:org-hap" }],
        "reasonCode": [{ "text": "Controleconsult na ambulancezorg" }]
      }
    }
    // ... Composition, Patient, Organization, PractitionerRole entries
  ]
}
```

---

### Option 2: RESTful (FHIR REST API)

The sender POSTs individual resources to the receiver's FHIR server using standard REST
operations. The `ServiceRequest` is the focal resource; `Composition`, `DocumentReference`,
`Patient`, `Organization`, and `PractitionerRole` are either bundled in a transaction bundle
or posted separately. The receiver exposes a FHIR server.

**Profiles used:** the use-case profiles for all individual resources; no MessageHeader or
message Bundle.

**Fits well when:** the receiver already hosts a FHIR server; query and update patterns are
needed alongside the initial push; integration with standard FHIR tooling is a priority.

**Limitations:** requires the receiver to expose and maintain a FHIR REST API; managing
referential integrity across separate POSTs requires a transaction bundle or careful ordering.

**Example interaction (transaction bundle):**

```http
POST /fhir HTTP/1.1
Content-Type: application/fhir+json

{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "fullUrl": "urn:uuid:sr-1",
      "resource": {
        "resourceType": "ServiceRequest",
        "meta": { "profile": ["http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP"] },
        "status": "active",
        "intent": "order",
        "subject": { "reference": "urn:uuid:patient-1" },
        "requester": { "reference": "urn:uuid:prole-1" },
        "performer": [{ "reference": "urn:uuid:org-hap" }],
        "reasonCode": [{ "text": "Controleconsult na ambulancezorg" }]
      },
      "request": { "method": "POST", "url": "ServiceRequest" }
    },
    {
      "fullUrl": "urn:uuid:patient-1",
      "resource": {
        "resourceType": "Patient",
        "meta": { "profile": ["http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"] }
        // ...
      },
      "request": { "method": "POST", "url": "Patient" }
    }
    // ... Composition, Organization, PractitionerRole entries
  ]
}
```

---

### Option 3: FHIR Document

The referral is wrapped in a `Bundle` of type `document`. The first entry is a `Composition`
that organises the clinical content. The bundle is an immutable, attestable clinical document
that can be stored and exchanged as a unit.

**Profiles used:** `hg-ReferralComposition-AmbulanceHAP` as the document anchor; a document
`Bundle` (not the messaging `hg-ReferralBundle-AmbulanceHAP`); the use-case profiles for
enclosed resources.

**Fits well when:** the referral needs to be stored as a legal or attestable document;
integration with document-sharing infrastructure (IHE XDS/MHD) is required.

**Limitations:** a document bundle is immutable - corrections require a new document;
less suited for workflow tracking or status updates.

**Example interaction:**

```http
POST /fhir/Bundle HTTP/1.1
Content-Type: application/fhir+json

{
  "resourceType": "Bundle",
  "type": "document",
  "timestamp": "2026-06-11T10:00:00+02:00",
  "entry": [
    {
      "fullUrl": "urn:uuid:comp-1",
      "resource": {
        "resourceType": "Composition",
        "meta": { "profile": ["http://nictiz.nl/fhir/StructureDefinition/hg-ReferralComposition-AmbulanceHAP"] },
        "status": "final",
        "type": { "coding": [{ "system": "http://loinc.org", "code": "57133-1" }] },
        "subject": { "reference": "urn:uuid:patient-1" },
        "date": "2026-06-11T10:00:00+02:00",
        "author": [{ "reference": "urn:uuid:prole-1" }],
        "title": "Ambulanceverwijzing naar huisartsenpost",
        "section": [
          {
            "code": { "coding": [{ "system": "http://snomed.info/sct", "code": "182991002" }] },
            "extension": [{ "url": "...", "valueString": "Antacidum toegediend." }]
          }
        ]
      }
    }
    // ... ServiceRequest, Patient, Organization, PractitionerRole entries
  ]
}
```

---

### Decision status

The exchange paradigm has not yet been selected. The decision will be driven by the target
infrastructure (LSP, direct FHIR connectivity, document repository) and by alignment with
other acute-zorg use cases in this IG. This page will be updated once a paradigm is chosen.

The CapabilityStatements (`hg-CapabilityStatement-Sender` and `hg-CapabilityStatement-Receiver`)
currently reflect paradigm-neutral requirements and will be refined once the paradigm is fixed.

---

### What the sender must support

Regardless of paradigm, the sending system (ambulance / RAV) must be able to:

- Produce a conformant `hg-ReferralServiceRequest-AmbulanceHAP` as the focal resource
- Populate all obligation-marked elements it has a value for (`SHALL:populate-if-known`)
- Produce a conformant `hg-ReferralComposition-AmbulanceHAP` carrying the referral note sections
- Attach supporting documents as `hg-ReferralDocumentReference-AmbulanceHAP` instances when available
- Populate patient, organisation, and professional resources conformant to the use-case zib profiles

Under **Option 1 (Messaging):** additionally produce a conformant `hg-ReferralBundle-AmbulanceHAP`
and `hg-ReferralMessageHeader-AmbulanceHAP`, and transmit the bundle to the receiver's endpoint.

Under **Option 2 (REST):** additionally POST resources to the receiver's FHIR server, using a
transaction bundle to ensure atomicity.

Under **Option 3 (Document):** additionally produce a document bundle with
`hg-ReferralComposition-AmbulanceHAP` as the first entry.

---

### What the receiver must support

The receiving system (HAP) must be able to:

- Accept and process a referral push without raising an error on any obligation-marked element
  (`SHALL:no-error`)
- Store or route the referral for clinical review
- Handle all resource types included in the referral: `ServiceRequest`, `Composition`,
  `DocumentReference`, `Patient`, `Organization`, `PractitionerRole`, `Practitioner`

Under **Option 1 (Messaging):** additionally expose a `$process-message` endpoint or receive
messages via an intermediary; process the `Bundle` of type `message`.

Under **Option 2 (REST):** additionally expose a FHIR REST server supporting at minimum
`create` interactions on the relevant resource types, and support transaction bundles.

Under **Option 3 (Document):** additionally accept a `Bundle` of type `document` and store or
index it via the applicable document-sharing infrastructure.

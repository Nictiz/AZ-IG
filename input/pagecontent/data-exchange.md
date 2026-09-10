### Overview

This page currently covers the data exchange architecture for the Ambulanceverwijzing (AMB to HAP) use case. As additional use cases are added to this IG, their exchange architecture will be described here or on separate pages. See [Use cases](use-cases.html) for an overview of all use cases and their status.

The exchange is one-directional (PUSH): the sending system produces and transmits a referral; the receiving system accepts and processes it.

The exchange paradigm is RESTful: the sender POSTs the referral to the receiver's FHIR endpoint as a `transaction` Bundle. That is what this IG models, and it is described under Option 2 below. The two alternatives that were weighed, FHIR Messaging and FHIR Document, remain described for the reader who needs to know why they were not taken, but no profiles are provided for them.

### System context and broker

In practice, ambulance/RAV systems do not produce native FHIR resources. A broker component - operated separately from both the RAV and the HAP - converts the native message format (e.g. an HL7 v2 or proprietary format) to FHIR and forwards it to the receiver. This broker is transparent from a conformance perspective: this IG defines what the FHIR content must look like and what the receiving system must be able to accept, regardless of whether the FHIR content was produced directly by the sending system or by an intermediary. The broker is not a formal actor in this IG.

---

### Option 1: FHIR Messaging (not chosen)

The referral is wrapped in a `Bundle` of `type` `message`. The first entry is a `MessageHeader` that identifies the event and references the `ServiceRequest` via `focus`. All referenced resources are included in the same Bundle. The sender transmits the Bundle to the receiver's `$process-message` endpoint or via a store-and-forward intermediary.

Profiles that would be needed: a message Bundle profile and a MessageHeader profile, next to the use case profiles for the enclosed resources. Neither is provided in this IG.

Fits well when: the infrastructure is event-driven or store-and-forward; the receiver does not expose a FHIR REST endpoint; the transaction must be atomic and self-contained.

Limitations: requires the sender to produce a complete, valid Bundle at the moment of transmission; less suited for incremental updates or queries.

---

### Option 2: RESTful (FHIR REST API) - the chosen paradigm

The sender POSTs resources to the receiver's FHIR server using a transaction Bundle. The `ServiceRequest` is the focal resource; `Composition`, `DocumentReference`, `Patient`, `Organization`, and `PractitionerRole` are included in the same `transaction`. The receiver exposes a FHIR server.

Profiles used: `hg-ReferralBundle-AmbulanceHAP` for the transaction, and the use case profiles for the resources it carries. No MessageHeader and no message Bundle.

Fits well when: the receiver already hosts a FHIR server; query and update patterns are needed alongside the initial push; integration with standard FHIR tooling is a priority.

Limitations: requires the receiver to expose and maintain a FHIR REST API; managing referential integrity across separate POSTs requires a transaction Bundle or careful ordering.

---

### Option 3: FHIR Document (not chosen)

The referral is wrapped in a `Bundle` of `type` document. The first entry is a `Composition` that organises the clinical content. The Bundle is an immutable, attestable clinical document that can be stored and exchanged as a unit.

Profiles that would be needed: a document Bundle profile with the use case Composition as its anchor, next to the use case profiles for the enclosed resources. No document Bundle profile is provided in this IG.

Fits well when: the referral needs to be stored as a legal or attestable document; integration with document-sharing infrastructure (IHE XDS/MHD) is required.

Limitations: a document Bundle is immutable - corrections require a new document; less suited for workflow tracking or status updates.

---

### Decision status

RESTful is the paradigm this IG designs against. The decision is recorded in [GitHub issue #14](https://github.com/Nictiz/AZ-IG/issues/14) and is not final until the agreement with the vendors and the infrastructure parties is in place for the beta release; until then it is the direction, not a commitment that binds those parties.

What follows from it is already applied: the referral is a `transaction` Bundle, the MessageHeader profile and the message event code system have been removed, and the CapabilityStatements state the system-level `transaction` interaction next to `create` per resource type.

The concrete transaction definitions a reader may expect from other Nictiz FHIR IGs - search parameters, HTTP headers, and the `Bundle.entry.fullUrl` conventions of the overarching [Nictiz FHIR R4 IG](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4) - still have to be worked out against this paradigm; see the [Open Items](open-items.html) page.

---

### Sender requirements

The formal sender requirements are defined in:

- [hg referral Sender - Ambulanceverwijzing (AMBS, AZP-AVS)](ActorDefinition-hg-ActorSender-AmbulanceHAP.html)
- [hg referral Sender CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Sender.html)

In summary, the sender **SHALL**:

- Produce a conformant use case ServiceRequest as the focal resource
- Populate every mandatory obligation-marked element (`SHALL:populate`) and every optional one it has a value for (`SHALL:populate-if-known`)
- Produce a conformant use case Composition carrying the transfer summary note sections
- Attach supporting documents as use case DocumentReference instances when available
- Populate patient, organization, and professional resources conformant to the use case profiles
- Package the referral as a `transaction` Bundle conforming to `hg-ReferralBundle-AmbulanceHAP` and POST it to the receiver's base URL, with a `urn:uuid` `fullUrl` per entry so the references between the resources resolve within the transaction.

---

### Receiver requirements

The formal receiver requirements are defined in:

- [hg referral Receiver - Ambulanceverwijzing (HIS/HAPIS, AZP-AVO)](ActorDefinition-hg-ActorReceiver-AmbulanceHAP.html)
- [hg referral Receiver CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Receiver.html)

In summary, the receiver **SHALL**:

- Accept and process a referral push without raising an error on any obligation-marked element (`SHALL:no-error`)
- Store or route the referral for clinical review
- Handle all resource types included in the referral: `ServiceRequest`, `Composition`, `DocumentReference`, `Patient`, `Encounter`, `Organization`, `PractitionerRole`, `Practitioner`
- Expose a FHIR endpoint that accepts a `transaction` Bundle, resolve the `urn:uuid` references between its entries, and answer with a `transaction-response` Bundle in which every entry was created.


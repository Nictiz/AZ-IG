// =============================================================================
// Generic referral layer (open world, FHIR core based, no mustSupport).
// Reusable across the acute-zorg referral use cases. Use-case profiles derive
// from these and add cardinalities, mustSupport and dataset mappings.
// =============================================================================

Profile: HgReferralServiceRequest
Parent: ServiceRequest
Id: hg-ReferralServiceRequest
Title: "HG Referral ServiceRequest"
Description: "Generic referral request (workflow 'request' on FHIR core ServiceRequest) for acute-zorg referrals. Open-world: nl-core targets are added next to the base resources; cardinalities and mustSupport are left to the use-case layer."
* intent = #order
* subject only Reference(Patient or $nlcore-Patient)
* requester only Reference(PractitionerRole or Organization or $nlcore-PractitionerRole or $nlcore-Organization)
* performer only Reference(PractitionerRole or Organization or $nlcore-PractitionerRole or $nlcore-Organization)
* supportingInfo only Reference(Resource or HgReferralComposition or HgReferralDocumentReference)

Profile: HgReferralComposition
Parent: Composition
Id: hg-ReferralComposition
Title: "HG Referral Composition"
Description: "Generic referral note carrying the textual rubrieken as Composition sections. Open-world base for the use-case layer."
// Fixed here assuming all acute-zorg referral compositions are referral notes.
// If a future use case requires a different document type, move this to the use-case layer.
* type = $loinc#57133-1 "Referral note"
* subject only Reference(Patient or $nlcore-Patient)
* author only Reference(PractitionerRole or Organization or $nlcore-PractitionerRole or $nlcore-Organization)
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open

Profile: HgReferralDocumentReference
Parent: DocumentReference
Id: hg-ReferralDocumentReference
Title: "HG Referral DocumentReference"
Description: "Generic attached document for a referral (for example an ECG or photo). Open-world base for the use-case layer."
* author only Reference(PractitionerRole or Organization or $nlcore-PractitionerRole or $nlcore-Organization)

Profile: HgReferralMessageHeader
Parent: MessageHeader
Id: hg-ReferralMessageHeader
Title: "HG Referral MessageHeader"
Description: "Generic MessageHeader for a referral PUSH. Focuses the referral ServiceRequest; the event is fixed at the use-case layer."
* event[x] only Coding
* focus only Reference(HgReferralServiceRequest)
* sender only Reference(Organization or $nlcore-Organization)

Profile: HgReferralBundle
Parent: Bundle
Id: hg-ReferralBundle
Title: "HG Referral Bundle"
Description: "Generic message bundle for a referral PUSH. The first entry SHALL be the MessageHeader."
* type = #message

// =============================================================================
// Use-case layer: Ambulanceverwijzing (AMB -> HAP, message 24). Derives from the generic
// hg-Referral profiles, tightens cardinalities, applies obligations (in place of
// mustSupport) and fixes the message event. Dataset mappings live here (see
// DatasetMappings.fsh). Reference targets keep the core resource type alongside
// the transaction-specific zib profile, so the model stays open-world.
// =============================================================================

Profile: HgReferralServiceRequestAmbulanceHAP
Parent: HgReferralServiceRequest
Id: hg-ReferralServiceRequest-AmbulanceHAP
Title: "HG Referral ServiceRequest - Ambulance to HAP"
Description: "Ambulance to GP out-of-hours post (HAP) referral request (Ambulanceverwijzing, AMB naar HAP, message 24)."
* status 1..1
* status insert Obligation
* intent 1..1
* intent insert Obligation
* category insert Obligation
* priority 0..1
* priority insert Obligation
* subject 1..1
* subject only Reference(Patient or HgPatientAmbulanceHAP)
* subject insert Obligation
* authoredOn 1..1
* authoredOn insert Obligation
* requester 1..1
* requester only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* requester insert Obligation
* performer 1..1
* performer only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* performer insert Obligation
* reasonCode 1..1
* reasonCode insert Obligation
* supportingInfo 1..*
* supportingInfo insert Obligation
* patientInstruction 0..1
* patientInstruction insert Obligation

Profile: HgReferralCompositionAmbulanceHAP
Parent: HgReferralComposition
Id: hg-ReferralComposition-AmbulanceHAP
Title: "HG Referral Composition - Ambulance to HAP"
Description: "Referral note for the ambulance to GP out-of-hours post (HAP) referral."
* status 1..1
* status insert Obligation
* subject 1..1
* subject only Reference(Patient or HgPatientAmbulanceHAP)
* subject insert Obligation
* author 1..1
* author only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* author insert Obligation
* date 1..1
* date insert Obligation
* title 1..1
* title insert Obligation
* section[treatmentGiven] insert Obligation
* section[treatmentGiven].extension[treatmentGivenTextValue] 1..1
* section[treatmentGiven].extension[treatmentGivenTextValue] insert Obligation
* section[diagnosisConclusion] insert Obligation
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue] 1..1
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue] insert Obligation

Profile: HgReferralDocumentReferenceAmbulanceHAP
Parent: HgReferralDocumentReference
Id: hg-ReferralDocumentReference-AmbulanceHAP
Title: "HG Referral DocumentReference - Ambulance to HAP"
Description: "Attached document for the ambulance to GP out-of-hours post (HAP) referral. The folded CommunicatieItem category and sender are carried on `category` and `author`."
* masterIdentifier insert Obligation
* identifier insert Obligation
* type insert Obligation
* category insert Obligation
* author only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* author insert Obligation
* content.attachment.contentType 1..1
* content.attachment.contentType insert Obligation
* content.attachment.data 1..1
* content.attachment.data insert Obligation
* content.attachment.title insert Obligation
* content.attachment.creation insert Obligation

Profile: HgReferralMessageHeaderAmbulanceHAP
Parent: HgReferralMessageHeader
Id: hg-ReferralMessageHeader-AmbulanceHAP
Title: "HG Referral MessageHeader - Ambulance to HAP"
Description: "MessageHeader for the ambulance to GP out-of-hours post (HAP) referral PUSH."
* eventCoding = HgMessageEventCS#ambulance-referral-to-hap
* focus 1..1
* focus insert Obligation
* sender 1..1
* sender only Reference(Organization or HgHealthcareProviderOrganizationAmbulanceHAP)
* sender insert Obligation
* source 1..1

Profile: HgReferralBundleAmbulanceHAP
Parent: HgReferralBundle
Id: hg-ReferralBundle-AmbulanceHAP
Title: "HG Referral Bundle - Ambulance to HAP"
Description: "Message bundle for the ambulance to GP out-of-hours post (HAP) referral PUSH."
* type = #message
* timestamp 1..1
* entry 1..*
* entry.fullUrl 1..1
* entry.resource 1..1

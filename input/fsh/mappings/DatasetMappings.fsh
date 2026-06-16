// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// Mappings to the ART-DECOR dataset "Verwijzing ambulance naar huisartsenpost"
// (id 2.16.840.1.113883.2.4.3.11.60.103.1.1, effectiveDate 2020-10-19).
// Per Nictiz profiling guidelines, mappings live on the use case layer.
//
// The underlying ART-DECOR dataset is shared across multiple use cases: element
// IDs (hg-dataelement-NNNN) are allocated once and reused across transactions. Not every
// element appears in every transaction. Where a mapping below covers an element that is
// defined in the shared dataset but not explicitly constrained in AMB-HAP transaction
// 4.145 (e.g. TypeBericht, Urgentie), it is included as a traceability link only.
// No further tightening is applied; the functional design describes the intended use.

Mapping: HgReferralServiceRequestAmbulanceHAPDataset
Source: HgReferralServiceRequestAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-1673" "Envelop"
* status -> "hg-dataelement-5556" "Bestemmingsstatus"
// TypeBericht (1685): defined in the shared dataset; not explicitly modeled in AMB-HAP
// transaction 4.145 (message type is implicit). Traceability link only.
* category -> "hg-dataelement-1685" "TypeBericht"
// Urgentie (1702): defined in the shared dataset; not explicitly modeled in AMB-HAP
// transaction 4.145. Traceability link only.
* priority -> "hg-dataelement-1702" "Urgentie"
* subject -> "hg-dataelement-1676" "Patient"
* authoredOn -> "hg-dataelement-1684" "Datum en tijd"
// Verzender/Ontvanger map to multiple dataelements (generic + zorgverlener + zorgaanbieder).
// These references are max-1 (one sender, one recipient), which FHIR does not allow to be
// sliced, so the per-target dataelements are recorded as element-level mappings rather than on
// targetProfile slices. zorgverlener = the PractitionerRole target; zorgaanbieder = the
// Organization it belongs to (reached via PractitionerRole.organization).
* requester -> "hg-dataelement-5089" "Verzender"
* requester -> "hg-dataelement-5398" "Verzender (zorgverlener)"
* requester -> "hg-dataelement-5391" "Verzender (zorgaanbieder)"
* performer -> "hg-dataelement-1680" "Ontvanger"
* performer -> "hg-dataelement-5399" "Ontvanger (zorgverlener)"
* performer -> "hg-dataelement-5400" "Ontvanger (zorgaanbieder)"
// RedenBericht and Context sit inside Kern in the dataset hierarchy. In FHIR, the reason
// for referral is placed on ServiceRequest.reasonCode rather than inside the Composition
// (Kern). This is a deliberate placement over strict dataset hierarchy.
* reasonCode -> "hg-dataelement-1872" "RedenBericht"
* reasonCode -> "hg-dataelement-1710" "Context"
* supportingInfo -> "hg-dataelement-1709" "Kern"
* supportingInfo -> "hg-dataelement-5457" "CommunicatieItem (gerealiseerd via DocumentReference)"
* patientInstruction -> "hg-dataelement-1752" "AfgesprokenMetPatient"

Mapping: HgReferralCompositionAmbulanceHAPDataset
Source: HgReferralCompositionAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-1709" "Kern"
* subject -> "hg-dataelement-1676" "Patient"
* author -> "hg-dataelement-5089" "Verzender"
* section[treatmentGiven].extension[treatmentGivenTextValue] -> "hg-dataelement-1711" "IngesteldeBehandeling"
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue] -> "hg-dataelement-1749" "Diagnose/Conclusie"

Mapping: HgReferralDocumentReferenceAmbulanceHAPDataset
Source: HgReferralDocumentReferenceAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
// DocumentReference represents the folded CommunicatieItem wrapper (5457) and the
// Document it contains (5472). Both are mapped at root level.
* -> "hg-dataelement-5457" "CommunicatieItem"
* -> "hg-dataelement-5472" "Document"
* masterIdentifier -> "hg-dataelement-5473" "DocumentIdentificatie"
* identifier -> "hg-dataelement-5474" "DocumentSetIdentificatie"
* type -> "hg-dataelement-5554" "DocumentType"
* category -> "hg-dataelement-5463" "CommunicatieCategorie"
// CommunicatieAfzender (5464) is folded onto author.
// CommunicatieGeadresseerde (5468) has no direct FHIR field; the referral performer covers
// that role implicitly.
* author -> "hg-dataelement-5464" "CommunicatieAfzender"
* content.attachment.contentType -> "hg-dataelement-5476" "DocumentBestandtype"
* content.attachment.data -> "hg-dataelement-5477" "DocumentInhoud"
* content.attachment.title -> "hg-dataelement-5552" "DocumentNaam"
* content.attachment.creation -> "hg-dataelement-5553" "DocumentCreatieDatumTijd"
// Known gaps - no clean FHIR mapping available in R4:
// hg-dataelement-5458 (Identificatienummer van CommunicatieItem): masterIdentifier is
//   used for the Document identity (5473); the CommunicatieItem-level ID has no home
//   in the folded model.
// hg-dataelement-5475 (DocumentVersienummer): DocumentReference R4 has no version number
//   field; an extension would be needed to carry this element.

Mapping: HgReferralMessageHeaderAmbulanceHAPDataset
Source: HgReferralMessageHeaderAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* sender -> "hg-dataelement-5089" "Verzender (transportniveau)"

Mapping: HgReferralBundleAmbulanceHAPDataset
Source: HgReferralBundleAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* timestamp -> "hg-dataelement-1684" "Datum en tijd (transportniveau)"

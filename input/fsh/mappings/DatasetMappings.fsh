// Mappings to the ART-DECOR dataset "Verwijzing ambulance naar huisartsenpost"
// (id 2.16.840.1.113883.2.4.3.11.60.103.1.1, effectiveDate 2020-10-19).
// Per Nictiz profiling guidelines, mappings live on the use-case layer.

Mapping: HgReferralServiceRequestAmbulanceHAPDataset
Source: HgReferralServiceRequestAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-1673" "Envelop"
* status -> "hg-dataelement-5556" "Bestemmingsstatus"
* category -> "hg-dataelement-1685" "MessageType / berichttype"
* priority -> "hg-dataelement-1702" "Urgentie"
* subject -> "hg-dataelement-1676" "Patient"
* authoredOn -> "hg-dataelement-1684" "Datum en tijd"
* requester -> "hg-dataelement-5089" "Verzender"
* requester -> "hg-dataelement-5398" "Verzender (zorgverlener)"
* requester -> "hg-dataelement-5391" "Verzender (zorgaanbieder)"
* performer -> "hg-dataelement-1680" "Ontvanger"
* performer -> "hg-dataelement-5399" "Ontvanger (zorgaanbieder)"
* performer -> "hg-dataelement-5400" "Ontvanger (zorgaanbieder)"
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
* -> "hg-dataelement-1725" "Dossiergegevens"
* subject -> "hg-dataelement-1676" "Patient"
* author -> "hg-dataelement-5089" "Verzender"
* section[treatmentGiven].extension[treatmentGivenTextValue] -> "hg-dataelement-1711" "IngesteldeBehandeling"
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue] -> "hg-dataelement-1749" "Diagnose / Conclusie"

Mapping: HgReferralDocumentReferenceAmbulanceHAPDataset
Source: HgReferralDocumentReferenceAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-5472" "Document"
* masterIdentifier -> "hg-dataelement-5473" "DocumentIdentificatie"
* identifier -> "hg-dataelement-5474" "DocumentSetIdentificatie"
* type -> "hg-dataelement-5554" "DocumentType"
* category -> "hg-dataelement-5463" "CommunicatieCategorie (gevouwen)"
* author -> "hg-dataelement-5464" "CommunicatieAfzender (gevouwen)"
* content.attachment.contentType -> "hg-dataelement-5476" "DocumentBestandtype"
* content.attachment.data -> "hg-dataelement-5477" "DocumentInhoud"
* content.attachment.title -> "hg-dataelement-5552" "DocumentNaam"
* content.attachment.creation -> "hg-dataelement-5553" "DocumentCreatieDatumTijd"

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

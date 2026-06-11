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
* . ^short = "Referral"
* . ^alias[0] = "Envelop"
* . ^definition = "Geeft alle relevante gegevens in de envelop conform de richtlijn."
* status 1..1
* status ^short = "DestinationStatus"
* status ^alias[0] = "Bestemmingsstatus"
* status ^definition = "Geeft de status van de ambulance naar deze bestemming. De waarden zijn: Actief = patiënt is onderweg naar de bestemming. Geannuleerd = patiënt gaat niet meer naar de bestemming. Dit is het laatste bericht van de ambulance naar de bestemming. Overgedragen = patiënt is overgedragen aan de bestemming. Dit is het laatste bericht van de ambulance naar de bestemming."
* status insert Obligation
* intent 1..1
* intent insert Obligation
* category ^short = "MessageType"
* category ^alias[0] = "TypeBericht"
* category ^definition = "Geeft het type bericht dat verstuurd wordt door de verzender."
* category insert Obligation
* priority 0..1
* priority ^short = "Urgency"
* priority ^alias[0] = "Urgentie"
* priority ^definition = "Geeft de inhoud van de urgentie."
* priority insert Obligation
* subject 1..1
* subject ^short = "Patient"
* subject ^alias[0] = "Patient"
* subject ^definition = "Geeft de gegevens van de patiënt en de eventuele gegevens over de contactpersonen van de patiënt."
* subject only Reference(Patient or HgPatientAmbulanceHAP)
* subject insert Obligation
* authoredOn 1..1
* authoredOn ^short = "SendDateTime"
* authoredOn ^alias[0] = "Datum en tijd"
* authoredOn ^definition = "Geeft het tijdstip waarop de verzender het bericht afrondt en aanbiedt voor verzending."
* authoredOn insert Obligation
* requester 1..1
* requester ^short = "Sender"
* requester ^alias[0] = "Verzender"
* requester ^alias[1] = "Zorgverlener"
* requester ^alias[2] = "Zorgaanbieder"
* requester ^definition = "Geeft de volledige identificatie- en contactgegevens van de verzender van het bericht."
* requester only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* requester insert Obligation
* performer 1..1
* performer ^short = "Recipient"
* performer ^alias[0] = "Ontvanger"
* performer ^alias[1] = "Zorgverlener"
* performer ^alias[2] = "Zorgaanbieder"
* performer ^definition = "Geeft de volledige identificatie- en contactgegevens van de ontvanger van het bericht."
* performer only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* performer insert Obligation
* reasonCode 1..1
* reasonCode ^short = "MessageReason"
* reasonCode ^alias[0] = "RedenBericht"
* reasonCode ^alias[1] = "Context"
* reasonCode ^definition = "Geeft de reden van de verwijzing of de update. Hierbij is de beschrijving als vrije tekst op aangeven van het NHG verplicht. Daarnaast kan er ook een ICPC-code van de episode worden meegestuurd, al dan niet aangevuld met meer details over de vastlegging van de ICPC."
* reasonCode insert Obligation
* supportingInfo 1..*
* supportingInfo ^short = "ClinicalContent"
* supportingInfo ^alias[0] = "Kern"
* supportingInfo ^alias[1] = "CommunicatieItem"
* supportingInfo ^definition = "Geeft de zorginhoudelijke kerngegevens van de berichten die worden uitgewisseld."
* supportingInfo insert Obligation
* patientInstruction 0..1
* patientInstruction ^short = "AgreedWithPatient"
* patientInstruction ^alias[0] = "AfgesprokenMetPatient"
* patientInstruction ^definition = "In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op het veld 'Afspraken met patiënt'."
* patientInstruction insert Obligation

Profile: HgReferralCompositionAmbulanceHAP
Parent: HgReferralComposition
Id: hg-ReferralComposition-AmbulanceHAP
Title: "HG Referral Composition - Ambulance to HAP"
Description: "Referral note for the ambulance to GP out-of-hours post (HAP) referral."
* . ^short = "ClinicalContent"
* . ^alias[0] = "Kern"
* . ^definition = "Geeft de zorginhoudelijke kerngegevens van de berichten die worden uitgewisseld."
* status 1..1
* status insert Obligation
* subject 1..1
* subject ^short = "Patient"
* subject ^alias[0] = "Patient"
* subject ^definition = "Geeft de gegevens van de patiënt en de eventuele gegevens over de contactpersonen van de patiënt."
* subject only Reference(Patient or HgPatientAmbulanceHAP)
* subject insert Obligation
* author 1..1
* author ^short = "Sender"
* author ^alias[0] = "Verzender"
* author ^definition = "Geeft de volledige identificatie- en contactgegevens van de verzender van het bericht."
* author only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* author insert Obligation
* date 1..1
* date insert Obligation
* title 1..1
* title insert Obligation
* section contains treatmentGiven 0..1 and diagnosisConclusion 0..1
* section[treatmentGiven] ^short = "TreatmentGiven"
* section[treatmentGiven] ^alias[0] = "IngesteldeBehandeling"
* section[treatmentGiven] ^definition = "Geeft de ingestelde behandeling in het verwijsbericht, de update en het DT-bericht."
* section[treatmentGiven].code = $sct#182991002
* section[treatmentGiven].extension contains HgExtTextValue named treatmentGivenTextValue 0..1
* section[treatmentGiven] insert Obligation
* section[treatmentGiven].extension[treatmentGivenTextValue] 1..1
* section[treatmentGiven].extension[treatmentGivenTextValue] insert Obligation
* section[diagnosisConclusion] ^short = "DiagnosisConclusion"
* section[diagnosisConclusion] ^alias[0] = "Diagnose / Conclusie"
* section[diagnosisConclusion] ^definition = "Geeft de diagnose en/of conclusie."
* section[diagnosisConclusion].code = $sct#60022001
* section[diagnosisConclusion].extension contains HgExtTextValue named diagnosisConclusionTextValue 0..1
* section[diagnosisConclusion] insert Obligation
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue] 1..1
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue] insert Obligation

Profile: HgReferralDocumentReferenceAmbulanceHAP
Parent: HgReferralDocumentReference
Id: hg-ReferralDocumentReference-AmbulanceHAP
Title: "HG Referral DocumentReference - Ambulance to HAP"
Description: "Attached document for the ambulance to GP out-of-hours post (HAP) referral. The folded CommunicatieItem category and sender are carried on `category` and `author`."
* . ^short = "CommunicationItem"
* . ^alias[0] = "CommunicatieItem"
* masterIdentifier ^short = "DocumentIdentification"
* masterIdentifier ^alias[0] = "DocumentIdentificatie"
* masterIdentifier ^definition = "Het identificatienummer van het document."
* masterIdentifier insert Obligation
* identifier ^short = "DocumentSetIdentification"
* identifier ^alias[0] = "DocumentSetIdentificatie"
* identifier ^definition = "Identificatienummer van de set waar het document toe behoort."
* identifier insert Obligation
* type ^short = "DocumentType"
* type ^alias[0] = "DocumentType"
* type ^definition = "Geeft aan welk type document is toegevoegd. Op dit moment is de BSA lijst gekoppeld vanuit de Ambulance."
* type insert Obligation
* category insert Obligation
* author ^short = "CommunicationSender"
* author ^alias[0] = "CommunicatieAfzender"
* author only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* author insert Obligation
* content.attachment.contentType 1..1
* content.attachment.contentType ^short = "DocumentMediaType"
* content.attachment.contentType ^alias[0] = "DocumentBestandtype"
* content.attachment.contentType ^definition = "Het bestandtype als mimetype, bijvoorbeeld \"application/pdf\" of \"text/plain\". Voor de verwijzing vanuit de Ambulance naar de Huisarts of Huisartsenpost is dit een pdf."
* content.attachment.contentType insert Obligation
* content.attachment.data 1..1
* content.attachment.data ^short = "DocumentContent"
* content.attachment.data ^alias[0] = "DocumentInhoud"
* content.attachment.data ^definition = "Geeft de inhoud van de bijlage (blob)."
* content.attachment.data insert Obligation
* content.attachment.title ^short = "DocumentName"
* content.attachment.title ^alias[0] = "DocumentNaam"
* content.attachment.title ^definition = "De bestandsnaam die het document heeft bij de verzender."
* content.attachment.title insert Obligation
* content.attachment.creation ^short = "DocumentCreationDateTime"
* content.attachment.creation ^alias[0] = "DocumentCreatieDatumTijd"
* content.attachment.creation ^definition = "Datum van het aanmaken van het document."
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

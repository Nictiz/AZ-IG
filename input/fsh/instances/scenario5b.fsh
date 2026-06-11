// ---------------------------------------------------------------------------
// Example set for scenario 5b (Richtlijn): ambulance professional refers
// patient Patrick to the GP out-of-hours post (HAP) after on-scene care.
// ---------------------------------------------------------------------------

Instance: patient-patrick
InstanceOf: HgPatientAmbulanceHAP
Usage: #example
Title: "Patient - Patrick (scenario 5b)"
* identifier.system = $bsn
* identifier.value = "999999990"
* name.use = #official
* name.family = "de Vries"
* name.given = "Patrick"
* gender = #male
* birthDate = "1944-03-10"

Instance: practitioner-ambu
InstanceOf: Practitioner
Usage: #example
Title: "Practitioner - ambulance nurse"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.text = "A. Ambulance"

Instance: prole-ambulance
InstanceOf: HgHealthProfessionalPractitionerRoleAmbulanceHAP
Usage: #example
Title: "PractitionerRole - ambulance nurse"
* practitioner = Reference(practitioner-ambu)
* organization = Reference(org-rav)
* code.text = "Ambulanceverpleegkundige"

Instance: org-rav
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - Regionale Ambulancevoorziening"
* identifier.system = $ura
* identifier.value = "00000001"
* name = "RAV Utrecht"

Instance: org-hap
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - Huisartsenpost"
* identifier.system = $ura
* identifier.value = "00000002"
* name = "Huisartsenpost Utrecht"

Instance: servicerequest-referral
InstanceOf: HgReferralServiceRequestAmbulanceHAP
Usage: #example
Title: "ServiceRequest - ambulance referral to HAP"
* status = #active
* intent = #order
* code = $sct#11131000146102
* category[referralType] = $sct#3457005
* subject = Reference(patient-patrick)
* authoredOn = "2026-06-08T11:15:00+02:00"
* requester = Reference(prole-ambulance)
* performer = Reference(org-hap)
* reasonCode.text = "Controleconsult gevraagd na ambulancezorg (maagklachten)."
* patientInstruction = "Maak een afspraak op de huisartsenpost voor een controleconsult."
* supportingInfo = Reference(composition-referral)
* supportingInfo[+] = Reference(documentreference-ecg)

Instance: composition-referral
InstanceOf: HgReferralCompositionAmbulanceHAP
Usage: #example
Title: "Composition - ambulance referral note"
* status = #final
* type = $loinc#57133-1 "Referral note"
* subject = Reference(patient-patrick)
* date = "2026-06-08T11:15:00+02:00"
* author = Reference(prole-ambulance)
* title = "Ambulanceverwijzing naar huisartsenpost"
* section[treatmentGiven].title = "Ingestelde behandeling"
* section[treatmentGiven].code = $sct#182991002
* section[treatmentGiven].text.status = #generated
* section[treatmentGiven].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Antacidum toegediend, klachten verminderd.</div>"
* section[treatmentGiven].extension[treatmentGivenTextValue].valueString = "Antacidum toegediend, klachten verminderd."
* section[diagnosisConclusion].title = "Diagnose / conclusie"
* section[diagnosisConclusion].code = $sct#60022001
* section[diagnosisConclusion].text.status = #generated
* section[diagnosisConclusion].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Waarschijnlijk maagklachten. Controle door huisarts gewenst.</div>"
* section[diagnosisConclusion].extension[diagnosisConclusionTextValue].valueString = "Waarschijnlijk maagklachten. Controle door huisarts gewenst."

Instance: documentreference-ecg
InstanceOf: HgReferralDocumentReferenceAmbulanceHAP
Usage: #example
Title: "DocumentReference - ECG attachment"
* status = #current
* masterIdentifier.system = "urn:ietf:rfc:3986"
* masterIdentifier.value = "urn:uuid:1b1f4f9e-0000-4000-8000-000000000001"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:1b1f4f9e-0000-4000-8000-000000000002"
* type.text = "ECG"
* category.text = "Bijlage"
* author = Reference(prole-ambulance)
* content.attachment.contentType = #application/pdf
* content.attachment.data = "JVBERi0xLjQK"
* content.attachment.title = "12-afleidingen ECG"
* content.attachment.creation = "2026-06-08T11:05:00+02:00"

Instance: messageheader-referral
InstanceOf: HgReferralMessageHeaderAmbulanceHAP
Usage: #example
Title: "MessageHeader - ambulance referral"
* eventCoding = HgMessageEventCS#ambulance-referral-to-hap
* focus = Reference(servicerequest-referral)
* sender = Reference(org-rav)
* source.endpoint = "https://ambulance.example.nl/fhir"
* destination.endpoint = "https://hap.example.nl/fhir"

Instance: bundle-referral
InstanceOf: HgReferralBundleAmbulanceHAP
Usage: #example
Title: "Bundle - ambulance referral message (scenario 5b)"
* type = #message
* timestamp = "2026-06-08T11:15:05+02:00"
* entry[+].fullUrl = "http://nictiz.nl/fhir/MessageHeader/messageheader-referral"
* entry[=].resource = messageheader-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/ServiceRequest/servicerequest-referral"
* entry[=].resource = servicerequest-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/Composition/composition-referral"
* entry[=].resource = composition-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/Patient/patient-patrick"
* entry[=].resource = patient-patrick
* entry[+].fullUrl = "http://nictiz.nl/fhir/Practitioner/practitioner-ambu"
* entry[=].resource = practitioner-ambu
* entry[+].fullUrl = "http://nictiz.nl/fhir/PractitionerRole/prole-ambulance"
* entry[=].resource = prole-ambulance
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/org-rav"
* entry[=].resource = org-rav
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/org-hap"
* entry[=].resource = org-hap
* entry[+].fullUrl = "http://nictiz.nl/fhir/DocumentReference/documentreference-ecg"
* entry[=].resource = documentreference-ecg

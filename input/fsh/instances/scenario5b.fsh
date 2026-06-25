// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Example set for scenario 5b (Richtlijn): ambulance professional refers
// patient Patrick to the GP out-of-hours post (HAP) after on-scene care.
// ---------------------------------------------------------------------------

Instance: hg-Patient-AmbulanceHAP-patrick
InstanceOf: HgPatientAmbulanceHAP
Usage: #example
Title: "Patient - Patrick (scenario 5b)"
Description: "Example patient (Patrick de Vries) referred from the ambulance to the GP out-of-hours post in scenario 5b."
* identifier.system = $bsn
* identifier.value = "999999990"
* name.use = #official
* name.family = "de Vries"
* name.given = "Patrick"
// nl-core-NameInformation requires the iso21090-EN-qualifier (givenOrInitial) on each given name
* name.given[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[0].extension[0].valueCode = #BR
* gender = #male
* birthDate = "1944-03-10"

Instance: Practitioner-hg-ambu
InstanceOf: Practitioner
Usage: #example
Title: "Practitioner - ambulance nurse"
Description: "Example ambulance nurse (the sending professional) for scenario 5b."
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.text = "A. Ambulance"

Instance: hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu
InstanceOf: HgHealthProfessionalPractitionerRoleAmbulanceHAP
Usage: #example
Title: "PractitionerRole - ambulance nurse"
Description: "Example PractitionerRole linking the ambulance nurse to the sending RAV organization for scenario 5b."
* practitioner = Reference(Practitioner-hg-ambu)
* organization = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-rav)
* code.text = "Ambulanceverpleegkundige"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-rav
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - Regionale Ambulancevoorziening"
Description: "Example sending organization (Regionale Ambulancevoorziening, RAV) for scenario 5b."
* identifier.system = $ura
* identifier.value = "00000001"
* name = "RAV Utrecht"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-hap
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - Huisartsenpost"
Description: "Example receiving organization (GP out-of-hours post, HAP) for scenario 5b."
* identifier.system = $ura
* identifier.value = "00000002"
* name = "Huisartsenpost Utrecht"

Instance: hg-ReferralServiceRequest-AmbulanceHAP-referral
InstanceOf: HgReferralServiceRequestAmbulanceHAP
Usage: #example
Title: "ServiceRequest - ambulance referral to HAP"
Description: "Example ambulance-to-HAP referral request (the focal resource) for scenario 5b."
* status = #completed
* intent = #order
* code = $sct#11131000146102 "overdracht van zorg vanuit ambulance"
* category[referralType] = $sct#308292007 "overdracht van zorg (verrichting)"
* subject = Reference(hg-Patient-AmbulanceHAP-patrick)
* authoredOn = "2026-06-08T11:15:00+02:00"
* requester = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu)
* performer = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-hap)
* reasonCode.text = "Controleconsult gevraagd na ambulancezorg (maagklachten)."
* patientInstruction = "Maak een afspraak op de huisartsenpost voor een controleconsult."
* supportingInfo = Reference(hg-ReferralComposition-AmbulanceHAP-referral)
* supportingInfo[+] = Reference(hg-ReferralDocumentReference-AmbulanceHAP-ecg)

Instance: hg-ReferralComposition-AmbulanceHAP-referral
InstanceOf: HgReferralCompositionAmbulanceHAP
Usage: #example
Title: "Composition - ambulance referral note"
Description: "Example referral note carrying the instituted treatment and the diagnosis/conclusion for scenario 5b."
* status = #final
* type = $loinc#57133-1 "Referral note"
* subject = Reference(hg-Patient-AmbulanceHAP-patrick)
* date = "2026-06-08T11:15:00+02:00"
* author = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu)
* title = "Ambulanceverwijzing naar huisartsenpost"
* section[treatmentGiven]
  * title = "Ingestelde behandeling"
  * code = $loinc#18776-5
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Antacidum toegediend, klachten verminderd.</div>"
* section[diagnosisConclusion]
  * title = "Diagnose/conclusie"
  * code = $loinc#55110-1
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Waarschijnlijk maagklachten. Controle door huisarts gewenst.</div>"

Instance: hg-ReferralDocumentReference-AmbulanceHAP-ecg
InstanceOf: HgReferralDocumentReferenceAmbulanceHAP
Usage: #example
Title: "DocumentReference - ECG attachment"
Description: "Example attached document (an ECG) accompanying the referral in scenario 5b."
* status = #current
* masterIdentifier
  * system = "urn:ietf:rfc:3986"
  * value = "urn:uuid:1b1f4f9e-0000-4000-8000-000000000001"
* identifier
  * system = "urn:ietf:rfc:3986"
  * value = "urn:uuid:1b1f4f9e-0000-4000-8000-000000000002"
* type = $acutezorg-cs16#001 "12 afleidingen ECG"
* category.text = "Bijlage"
* author = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu)
* content.attachment
  * contentType = #application/pdf
  * data = "JVBERi0xLjQK"
  * title = "12-afleidingen ECG"
  * creation = "2026-06-08T11:05:00+02:00"

Instance: hg-ReferralMessageHeader-AmbulanceHAP-referral
InstanceOf: HgReferralMessageHeaderAmbulanceHAP
Usage: #example
Title: "MessageHeader - ambulance referral"
Description: "Example MessageHeader focusing the referral ServiceRequest for the scenario 5b message."
* eventCoding = HgMessageEvent#ambulance-referral-to-hap
* focus = Reference(hg-ReferralServiceRequest-AmbulanceHAP-referral)
* sender = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-rav)
* source.endpoint = "https://ambulance.example.nl/fhir"
* destination.endpoint = "https://hap.example.nl/fhir"

Instance: hg-ReferralBundle-AmbulanceHAP-referral
InstanceOf: HgReferralBundleAmbulanceHAP
Usage: #example
Title: "Bundle - ambulance referral message (scenario 5b)"
Description: "Example message Bundle containing the complete ambulance-to-HAP referral for scenario 5b."
* type = #message
* timestamp = "2026-06-08T11:15:05+02:00"
* entry[+].fullUrl = "http://nictiz.nl/fhir/MessageHeader/hg-ReferralMessageHeader-AmbulanceHAP-referral"
* entry[=].resource = hg-ReferralMessageHeader-AmbulanceHAP-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/ServiceRequest/hg-ReferralServiceRequest-AmbulanceHAP-referral"
* entry[=].resource = hg-ReferralServiceRequest-AmbulanceHAP-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/Composition/hg-ReferralComposition-AmbulanceHAP-referral"
* entry[=].resource = hg-ReferralComposition-AmbulanceHAP-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/Patient/hg-Patient-AmbulanceHAP-patrick"
* entry[=].resource = hg-Patient-AmbulanceHAP-patrick
* entry[+].fullUrl = "http://nictiz.nl/fhir/Practitioner/Practitioner-hg-ambu"
* entry[=].resource = Practitioner-hg-ambu
* entry[+].fullUrl = "http://nictiz.nl/fhir/PractitionerRole/hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu"
* entry[=].resource = hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-rav"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-rav
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-hap"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-hap
* entry[+].fullUrl = "http://nictiz.nl/fhir/DocumentReference/hg-ReferralDocumentReference-AmbulanceHAP-ecg"
* entry[=].resource = hg-ReferralDocumentReference-AmbulanceHAP-ecg

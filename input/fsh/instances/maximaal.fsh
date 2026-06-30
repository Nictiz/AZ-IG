// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Maximal example, modelled on the ART-DECOR ADA test instance
// "az-ave-tst-2-maximaal" (Ambulanceverwijzing, app hg-1.0.0): a richly
// populated ambulance-to-HAP referral that exercises the optional elements the
// minimal example omits - a structured patient with address, telecom and a
// contact person, a sending nurse (PractitionerRole), all four Composition
// sections, the patient instruction, and a PDF document attachment.
// Identifiers and content follow the ADA test data (test values only).
//
// Note: this is a hand-authored interpretation of the ADA instance, not output
// of the usual ADA-to-FHIR tooling (not yet available for this transaction).
// See the Testing page; the examples are provisional pending that tooling.
// ---------------------------------------------------------------------------

Instance: hg-Patient-AmbulanceHAP-max
InstanceOf: HgPatientAmbulanceHAP
Usage: #example
Title: "Patient - J.H.M. van Baatenburg (maximal example)"
Description: "Example patient for the maximal ambulance-to-HAP referral (ART-DECOR ADA test az-ave-tst-2-maximaal): BSN, structured name, gender, birth date, address, telecom and a contact person."
* identifier.system = $bsn
* identifier.value = "999910589"
* name.use = #official
* name.text = "J.H.M. van Baatenburg"
* name.family = "van Baatenburg"
* name.given = "J.H.M."
* name.given[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[0].extension[0].valueCode = #IN
* gender = #female
* birthDate = "1954-08-06"
* telecom[0].system = #phone
* telecom[0].value = "0611234567"
* telecom[+].system = #email
* telecom[=].value = "giesput@myweb.nl"
* address.use = #home
* address.line = "Knolweg 1003"
* address.city = "Stitswerd"
* address.postalCode = "9999ZA"
* address.country = "Nederland"
* contact.relationship.text = "Familielid"
* contact.name.text = "Putten"
* contact.telecom.system = #phone
* contact.telecom.value = "0611234567"

Instance: hg-HealthProfessional-Practitioner-AmbulanceHAP-max
InstanceOf: Practitioner
Usage: #example
Title: "Practitioner - ambulance nurse (maximal example)"
Description: "Example sending ambulance professional (nurse) for the maximal ambulance-to-HAP referral, identified by a UZI number."
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/uzi-nr-pers"
* identifier.value = "123456789"

Instance: hg-HealthProfessional-PractitionerRole-AmbulanceHAP-max
InstanceOf: HgHealthProfessionalPractitionerRoleAmbulanceHAP
Usage: #example
Title: "PractitionerRole - ambulance nurse (maximal example)"
Description: "Example PractitionerRole linking the ambulance nurse to the sending RAV organization for the maximal ambulance-to-HAP referral."
* practitioner = Reference(hg-HealthProfessional-Practitioner-AmbulanceHAP-max)
* organization = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-max-rav)
* code.text = "Verpleegkundige"
* telecom.system = #phone
* telecom.value = "0612345678"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-max-rav
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - RAV (maximal example)"
Description: "Example sending organization (Regionale Ambulancevoorziening) for the maximal ambulance-to-HAP referral."
* identifier.system = "urn:oid:2.16.840.1.113883.2.4.3.11.60.55.15.1"
* identifier.value = "25"
* name = "RAV"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-max-hap
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - HAP (maximal example)"
Description: "Example receiving organization (huisartsenpost) for the maximal ambulance-to-HAP referral, identified by an AGB code."
* identifier.system = "http://fhir.nl/fhir/NamingSystem/agb-z"
* identifier.value = "6010860"
* name = "HAP"
* type.text = "Huisartsenpost"

Instance: hg-ReferralServiceRequest-AmbulanceHAP-max
InstanceOf: HgReferralServiceRequestAmbulanceHAP
Usage: #example
Title: "ServiceRequest - maximal ambulance referral"
Description: "Maximal example ambulance-to-HAP referral request (ART-DECOR ADA test az-ave-tst-2-maximaal): the focal resource with sender, recipient, reason, patient instruction and links to the Composition core and the document attachment."
* status = #completed
* intent = #order
* code = $sct#11131000146102 "overdracht van zorg vanuit ambulance"
* category[referralType] = $sct#308292007 "overdracht van zorg (verrichting)"
* subject = Reference(hg-Patient-AmbulanceHAP-max)
* authoredOn = "2026-06-20T14:00:00+02:00"
* requester = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-max)
* performer = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-max-hap)
* reasonCode.text = "Patiënt is vanuit acute ambulancezorg voor verdere zorg doorverwezen naar de huisartsenspoedpost."
* patientInstruction = "Huisarts nog inlichten."
* supportingInfo[0] = Reference(hg-ReferralComposition-AmbulanceHAP-max)
* supportingInfo[+] = Reference(hg-ReferralDocumentReference-AmbulanceHAP-max)

Instance: hg-ReferralComposition-AmbulanceHAP-max
InstanceOf: HgReferralCompositionAmbulanceHAP
Usage: #example
Title: "Composition - maximal transfer summary note"
Description: "Maximal example transfer summary note: reason, the instituted treatment, the diagnosis/conclusion and the agreement with the patient, for the maximal ambulance-to-HAP referral."
* status = #final
* type = $loinc#18761-7 "Samenvatting van overdracht [bevinding] in {instelling} d.m.v. {rol} (document)"
* subject = Reference(hg-Patient-AmbulanceHAP-max)
* date = "2026-06-20T14:00:00+02:00"
* author = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-max)
* title = "Ambulanceverwijzing naar huisartsenpost"
* section[messageReason]
  * title = "Reden van verwijzing"
  * code = $sct#440378000 "verwijzing voor (waarneembare entiteit)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Patiënt is vanuit acute ambulancezorg voor verdere zorg doorverwezen naar de huisartsenspoedpost.</div>"
* section[treatmentGiven]
  * title = "Ingestelde behandeling"
  * code = $loinc#18776-5 "Behandelplan [bevinding] in {instelling} d.m.v. {rol} (document)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>Luchtweg: intubatie van de trachea (moeizame intubatie).</p><p>Oxygenatie en ventilatie: kunstmatige beademing (machine FiO2 0.50, AMV 6 L/min, frequentie 10/min, PEEP 3 cmH2O), handmatige beademing, zuurstof 3 L/min.</p><p>Circulatie: cardioversie (2x, max 600 J); ROSC nee; AED aangesloten voor aankomst (5 schokken); transthoracale cardiale pacing (60/min, 5 mA, fixed rate); defibrillatie met gelijkstroom (3x, 200 J).</p><p>Traumatologie: koelen van patiënt (10 minuten). Obstetrie: afklemmen van de navelstreng. Isolatie: contactisolatie.</p><p>Medicatie: Acetylsalicylzuur 2 stuks, oraal toegediend.</p><p>Extra informatie behandeling: normale behandeling.</p></div>"
* section[diagnosisConclusion]
  * title = "Diagnose/conclusie"
  * code = $loinc#55110-1 "Conclusies [interpretatie] (document)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Letsel van het aangezicht. Moeilijk te observeren door de weersomstandigheden.</div>"
* section[agreedWithPatient]
  * title = "Afspraken met patiënt"
  * code = $loinc#69730-0 "Instructions"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Huisarts nog inlichten.</div>"

Instance: hg-ReferralDocumentReference-AmbulanceHAP-max
InstanceOf: HgReferralDocumentReferenceAmbulanceHAP
Usage: #example
Title: "DocumentReference - ambulance report attachment (maximal example)"
Description: "Example attached document (the ambulance report PDF) accompanying the maximal ambulance-to-HAP referral."
* status = #current
* identifier[documentId]
  * type = HgDocumentIdentifierType#document-id
  * system = "urn:oid:2.16.840.1.113883.2.4.3.11.999.103.3"
  * value = "9068"
* identifier[documentSetId]
  * type = HgDocumentIdentifierType#document-set-id
  * system = "urn:oid:2.16.840.1.113883.2.4.3.11.999.103.3"
  * value = "12"
* extension[documentVersion].valueString = "1"
* type = $acutezorg-cs16#006 "intern rapport/overdracht"
* category.text = "Bijlage"
* author = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-max)
* content.attachment
  * contentType = #application/pdf
  * data = "JVBERi0xLjQK"
  * title = "ambulance verslag"
  * creation = "2026-06-20T13:50:00+02:00"

Instance: hg-ReferralMessageHeader-AmbulanceHAP-max
InstanceOf: HgReferralMessageHeaderAmbulanceHAP
Usage: #example
Title: "MessageHeader - maximal ambulance referral"
Description: "Example MessageHeader focusing the referral ServiceRequest for the maximal ambulance-to-HAP referral message."
* eventCoding = HgMessageEvent#145 "Verwijzing ambulance naar huisartsenpost"
* focus = Reference(hg-ReferralServiceRequest-AmbulanceHAP-max)
* sender = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-max-rav)
* source.endpoint = "https://ambulance.example.nl/fhir"
* destination.endpoint = "https://hap.example.nl/fhir"

Instance: hg-ReferralBundle-AmbulanceHAP-max
InstanceOf: HgReferralBundleAmbulanceHAP
Usage: #example
Title: "Bundle - maximal ambulance referral message"
Description: "Maximal example message Bundle for an ambulance-to-HAP referral (ART-DECOR ADA test az-ave-tst-2-maximaal), containing the complete referral with the document attachment."
* type = #message
* timestamp = "2026-06-20T14:00:05+02:00"
* entry[+].fullUrl = "http://nictiz.nl/fhir/MessageHeader/hg-ReferralMessageHeader-AmbulanceHAP-max"
* entry[=].resource = hg-ReferralMessageHeader-AmbulanceHAP-max
* entry[+].fullUrl = "http://nictiz.nl/fhir/ServiceRequest/hg-ReferralServiceRequest-AmbulanceHAP-max"
* entry[=].resource = hg-ReferralServiceRequest-AmbulanceHAP-max
* entry[+].fullUrl = "http://nictiz.nl/fhir/Composition/hg-ReferralComposition-AmbulanceHAP-max"
* entry[=].resource = hg-ReferralComposition-AmbulanceHAP-max
* entry[+].fullUrl = "http://nictiz.nl/fhir/Patient/hg-Patient-AmbulanceHAP-max"
* entry[=].resource = hg-Patient-AmbulanceHAP-max
* entry[+].fullUrl = "http://nictiz.nl/fhir/Practitioner/hg-HealthProfessional-Practitioner-AmbulanceHAP-max"
* entry[=].resource = hg-HealthProfessional-Practitioner-AmbulanceHAP-max
* entry[+].fullUrl = "http://nictiz.nl/fhir/PractitionerRole/hg-HealthProfessional-PractitionerRole-AmbulanceHAP-max"
* entry[=].resource = hg-HealthProfessional-PractitionerRole-AmbulanceHAP-max
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-max-rav"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-max-rav
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-max-hap"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-max-hap
* entry[+].fullUrl = "http://nictiz.nl/fhir/DocumentReference/hg-ReferralDocumentReference-AmbulanceHAP-max"
* entry[=].resource = hg-ReferralDocumentReference-AmbulanceHAP-max

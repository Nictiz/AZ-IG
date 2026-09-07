// -------------------------------------------------------------------------------
// Logical Model Verwijzing ambulance naar huisartsenpost 
// derived from ART-DECOR Transaction 2.16.840.1.113883.2.4.3.11.60.103.4.145 as of 2025-06-10T00:00:00
// Filename DS_verwijzing_ambulance_naar_huisartsenpost_(download_2026-09-02T09:24:02).fsh
// -------------------------------------------------------------------------------
Logical:     Verwijzing_ambulance_naar_huisartsenpost
Parent:      Element
Id:          verwijzing-ambulance-naar-huisartsenpost // ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.4.145--20250610000000
Title:       "Verwijzing ambulance naar huisartsenpost"
Description: """Verwijzing ambulance naar huisartsenpost"""

* ^language = #en-US
* ^status = #draft
* ^version = "2025-06-10T00:00:00"
* ^extension.url = "http://hl7.org/fhir/StructureDefinition/resource-effectivePeriod"
* ^extension.valuePeriod.start = "2020-10-19T17:52:39Z"

* ^identifier.use = #official
* ^identifier.system = "urn:ietf:rfc:3986"
* ^identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.103.4.145"

* Bouwstenen 1..1 BackboneElement "Bouwstenen (1199)" """Geeft de generieke bouwstenen die in de specifieke bouwstenen worden gebruikt.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1199--20210322100358"""
* Bouwstenen.Patient 1..1 BackboneElement "Patient (2)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.2--20201021093202"""
  * ^code[+] = http://snomed.info/sct#116154003 "Patient"
* Bouwstenen.Patient.NameInformation 0..1 BackboneElement "NameInformation (3)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3--20201021094827"""
* Bouwstenen.Patient.NameInformation.FirstNames 0..1 string "FirstNames (4)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.4--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Johanna Petronella Maria"
* Bouwstenen.Patient.NameInformation.Initials 0..1 string "Initials (5)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.5--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "J.P.M."
* Bouwstenen.Patient.NameInformation.GivenName 0..1 string "GivenName (6)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.6--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Jo"
* Bouwstenen.Patient.NameInformation.NameUsage 0..1 CodeableConcept "NameUsage (7)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.7--20201021094827"""
* Bouwstenen.Patient.NameInformation.NameUsage from http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.40.2.20.4.1--20200901000000 (required)  // NaamgebruikCodelijst
  * ^example[+].label = "# 1"
  * ^example[=].valueCodeableConcept.coding = urn:oid:2.16.840.1.113883.2.4.3.11.60.101.5.4#NL3 "Geslachtsnaam partner gevolgd door eigen geslachtsnaam"
  * ^example[=].valueCodeableConcept.text = """Geslachtsnaam partner gevolgd door eigen geslachtsnaam"""
* Bouwstenen.Patient.NameInformation.LastName 0..1 BackboneElement "LastName (8)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.8--20201021094827"""
* Bouwstenen.Patient.NameInformation.LastName.Prefix 0..1 string "Prefix (9)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.9--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "van"
* Bouwstenen.Patient.NameInformation.LastName.LastName 0..1 string "LastName (10)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.10--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Putten"
* Bouwstenen.Patient.NameInformation.LastNamePartner 0..1 BackboneElement "LastNamePartner (11)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.11--20201021094827"""
* Bouwstenen.Patient.NameInformation.LastNamePartner.PartnerPrefix 0..1 string "PartnerPrefix (12)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.12--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "van der"
* Bouwstenen.Patient.NameInformation.LastNamePartner.PartnerLastName 0..1 string "PartnerLastName (13)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.13--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Giessen"
* Bouwstenen.Patient.AddressInformation 0..* BackboneElement "AddressInformation (15)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.15--20201021094827"""
* Bouwstenen.Patient.AddressInformation.Street 0..1 string "Street (16)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.16--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "1e Jacob van Campenstr"
* Bouwstenen.Patient.AddressInformation.HouseNumber 0..1 string "HouseNumber (17)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.17--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "15"
* Bouwstenen.Patient.AddressInformation.HouseNumberLetter 0..1 string "HouseNumberLetter (18)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.18--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "E"
* Bouwstenen.Patient.AddressInformation.HouseNumberAddition 0..1 string "HouseNumberAddition (19)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.19--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Rood"
  * ^example[+].label = "# 2"
  * ^example[=].valueString = "Twee hoog achter"
* Bouwstenen.Patient.AddressInformation.Postcode 0..1 string "Postcode (21)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.21--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "1012 NX"
* Bouwstenen.Patient.AddressInformation.PlaceOfResidence 0..1 string "PlaceOfResidence (22)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.22--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Hoogmade"
* Bouwstenen.Patient.AddressInformation.Country 0..1 CodeableConcept "Country (24)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.24--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueCodeableConcept.coding = http://terminology.hl7.org/CodeSystem/iso3166-1edition2alpha2#NL "Nederland"
  * ^example[=].valueCodeableConcept.text = """Nederland"""
  * ^example[=].valueCodeableConcept.coding = urn:oid:2.16.840.1.113883.2.4.4.16.34#6030 "Nederland"
  * ^example[=].valueCodeableConcept.text = """Nederland"""
* Bouwstenen.Patient.AddressInformation.AdditionalInformation 0..1 string "AdditionalInformation (25)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.25--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Huis Zon en Licht"
* Bouwstenen.Patient.ContactInformation 0..1 BackboneElement "ContactInformation (27)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.27--20201021094827"""
* Bouwstenen.Patient.ContactInformation.TelephoneNumbers 0..* BackboneElement "TelephoneNumbers (28)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.28--20201021094827"""
* Bouwstenen.Patient.ContactInformation.TelephoneNumbers.TelephoneNumber 1..1 string "TelephoneNumber (29)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.29--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "+31612341234"
* Bouwstenen.Patient.ContactInformation.EmailAddresses 0..* BackboneElement "EmailAddresses (33)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.33--20201021094827"""
* Bouwstenen.Patient.ContactInformation.EmailAddresses.EmailAddress 1..1 string "EmailAddress (34)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.34--20201021094827"""
* Bouwstenen.Patient.PatientIdentificationNumber 0..* Identifier "PatientIdentificationNumber (36)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.36--20201021094827"""
  * ^example[+].label = "# 1"
  * ^example[=].valueIdentifier.value =  "111222333"
* Bouwstenen.Patient.DateOfBirth 0..1 dateTime "DateOfBirth (37)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.37--20201021094827"""
  * ^code[+] = http://loinc.org#21112-8 "Birth date"
* Bouwstenen.Patient.Gender 0..1 CodeableConcept "Gender (38)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.38--20201021094827"""
  * ^code[+] = http://loinc.org#46098-0 "Sex"
* Bouwstenen.Patient.Gender from http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.40.2.0.1.1--20200901000000 (required)  // GeslachtCodelijst
  * ^example[+].label = "# 1"
  * ^example[=].valueCodeableConcept.coding = http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender#F "Female"
  * ^example[=].valueCodeableConcept.text = """Female"""
* Bouwstenen.Contact 0..* BackboneElement "Contact (5253)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5253--20221130122929"""
  * ^code[+] = http://snomed.info/sct#70862002 "Contact person"
* Bouwstenen.Contact.NameInformation 0..1 BackboneElement "NameInformation (5254)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5254--20221130123035"""
* Bouwstenen.Contact.NameInformation.VolledigeNaam 0..1 string "VolledigeNaam (5785)" """Bevat de gehele naam zoals deze moet worden weergegeven bijv. in een applicatie UI. Deze representatie kan worden gespecificeerd in plaats van of naast de naamdelen.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5785--20260622052834"""
* Bouwstenen.Contact.ContactInformation 0..1 BackboneElement "ContactInformation (5266)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5266--20221130123035"""
* Bouwstenen.Contact.ContactInformation.TelephoneNumbers 0..1 BackboneElement "TelephoneNumbers (5267)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5267--20221130123035"""
* Bouwstenen.Contact.ContactInformation.TelephoneNumbers.TelephoneNumber 1..1 string "TelephoneNumber (5268)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5268--20221130123035"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "+31612341234"
* Bouwstenen.Contact.Relationship 0..1 CodeableConcept "Relationship (5288)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5288--20221130123035"""
* Bouwstenen.Contact.Relationship from http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.40.2.3.1.1--20200901000000 (extensible)  // RelatieCodelijst
  * ^example[+].label = "# 1"
* Envelop 1..1 BackboneElement "Envelop (1673)" """Geeft alle relevante gegevens in de envelop conform de richtlijn.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1673--20211110140357"""
* Envelop.Patientgegevens 1..1 BackboneElement "Patiëntgegevens (1679)" """Geeft de gegevens van de patiënt en de eventuele gegevens over de contactpersonen van de patiënt.  
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1679--20211110144602"""
* Envelop.Patientgegevens.Patient 1..1 BackboneElement "(containment) Patient (1676)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1676--20211110143930"""
  * ^code[+] = http://snomed.info/sct#116154003 "Patient"
* Envelop.Patientgegevens.Contact 0..* BackboneElement "(containment) Contact (5309)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5309--20230329152109"""
  * ^code[+] = http://snomed.info/sct#70862002 "Contact person"
* Envelop.Sender 1..1 BackboneElement "Sender (5089)" """Geeft de volledige identificatie- en contactgegevens van de verzender van het bericht.

 

In de HASP-richtlijn van de NHG is aangegeven dat de beheerder meestal de verzender is van het bericht.

 

Binnen de informatiestandaard huisartsenzorg wordt de beheerder altijd beschouwd als de verzender.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5089--20220921200553"""
* Envelop.Sender.HealthProfessional 0..* BackboneElement "HealthProfessional (5814)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5814--20260622082840"""
  * ^code[+] = http://snomed.info/sct#223366009 "Healthcare professional"
* Envelop.Sender.HealthProfessional.HealthProfessionalIdentificationNumber 1..* Identifier "HealthProfessionalIdentificationNumber (5815)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5815--20260622082912"""
  * ^example[+].label = "# 1"
  * ^example[=].valueIdentifier.value =  "21870932"
* Envelop.Sender.HealthProfessional.Specialty 0..1 CodeableConcept "Specialty (5828)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5828--20260622082912"""
  * ^code[+] = http://snomed.info/sct#394658006 "klinisch specialisme (kwalificatiewaarde)"
  * ^example[+].label = "# 1"
  * ^example[=].valueCodeableConcept.coding = http://fhir.nl/fhir/NamingSystem/uzi-rolcode#01.010 "Cardioloog"
  * ^example[=].valueCodeableConcept.text = """Cardioloog"""
* Envelop.Sender.HealthProfessional.ContactInformation 0..1 BackboneElement "ContactInformation (5842)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5842--20260622082912"""
* Envelop.Sender.HealthProfessional.ContactInformation.TelephoneNumbers 0..1 BackboneElement "TelephoneNumbers (5843)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5843--20260622082912"""
* Envelop.Sender.HealthProfessional.ContactInformation.TelephoneNumbers.TelephoneNumber 1..1 string "TelephoneNumber (5844)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5844--20260622082912"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "+31612341234"
* Envelop.Sender.HealthProfessional.HealthcareProvider 1..1 BackboneElement "HealthcareProvider (5851)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5851--20260622082912"""
* Envelop.Sender.HealthProfessional.HealthcareProvider.HealthcareProvider 1..1 BackboneElement "HealthcareProvider (5852)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5852--20260622082912"""
  * ^code[+] = http://snomed.info/sct#257622000 "Healthcare facility"
* Envelop.Sender.HealthProfessional.HealthcareProvider.HealthcareProvider.HealthcareProviderIdentificationNumber 1..* Identifier "HealthcareProviderIdentificationNumber (5853)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5853--20260622082912"""
  * ^example[+].label = "# 1"
  * ^example[=].valueIdentifier.value =  "21870932"
* Envelop.Sender.HealthProfessional.HealthcareProvider.HealthcareProvider.OrganizationName 0..1 string "OrganizationName (5854)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5854--20260622082912"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Erasmus Universitair Medisch Centrum"
* Envelop.Sender.HealthcareProvider 0..1 BackboneElement "HealthcareProvider (5648)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5648--20260603094559"""
  * ^code[+] = http://snomed.info/sct#257622000 "Healthcare facility"
* Envelop.Sender.HealthcareProvider.HealthcareProviderIdentificationNumber 1..* Identifier "HealthcareProviderIdentificationNumber (5649)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5649--20260603094606"""
  * ^example[+].label = "# 1"
  * ^example[=].valueIdentifier.value =  "21870932"
* Envelop.Sender.HealthcareProvider.OrganizationName 0..1 string "OrganizationName (5650)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5650--20260603094606"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Erasmus Universitair Medisch Centrum"
* Envelop.Ontvanger 1..1 BackboneElement "Ontvanger (1680)" """Geeft de volledige identificatie- en contactgegevens van de ontvanger van het bericht. In de HASP-richtlijn wordt de ontvanger aangeduid met de geadresseerde.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1680--20211110145437"""
* Envelop.Ontvanger.HealthcareProvider 1..1 BackboneElement "HealthcareProvider (5756)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5756--20260603094911"""
  * ^code[+] = http://snomed.info/sct#257622000 "Healthcare facility"
* Envelop.Ontvanger.HealthcareProvider.HealthcareProviderIdentificationNumber 1..* Identifier "HealthcareProviderIdentificationNumber (5757)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5757--20260603094918"""
  * ^example[+].label = "# 1"
  * ^example[=].valueIdentifier.value =  "21870932"
* Envelop.Ontvanger.HealthcareProvider.OrganizationName 0..1 string "OrganizationName (5758)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5758--20260603094918"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Erasmus Universitair Medisch Centrum"
* Envelop.Ontvanger.HealthcareProvider.OrganizationType 0..1 CodeableConcept "OrganizationType (5781)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5781--20260603094918"""
  * ^example[+].label = "# 1"
  * ^example[=].valueCodeableConcept.coding = http://nictiz.nl/fhir/NamingSystem/organization-type#Z4 "Zelfstandig behandelcentrum"
  * ^example[=].valueCodeableConcept.text = """Zelfstandig behandelcentrum"""
* Envelop.Bestemmingsgegevens 0..1 BackboneElement "Bestemmingsgegevens (5555)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5555--20250821072958"""
* Envelop.Bestemmingsgegevens.Bestemmingsstatus 1..1 CodeableConcept "Bestemmingsstatus (5556)" """Geeft de status van de ambulance naar deze bestemming. De waarden zijn:* Actief = patiënt is onderweg naar de bestemming. 
* Geannuleerd = patiënt gaat niet meer naar de bestemming. Dit is het laatste bericht van de ambulance naar de bestemming.
* Overgedragen =  patiënt is overgedragen aan de bestemming. Dit is het laatste bericht van de ambulance naar de bestemming.
 
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5556--20250821073017"""
* Envelop.Bestemmingsgegevens.Bestemmingsstatus from http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.55.11.116--20250827000000 (required)  // Bestemmingsstatussen
  * ^example[+].label = "# 1"
* Envelop.Ritnummer 1..1 Identifier "Ritnummer (6034)" """Het ritnummer bestaat uit een aantal onderdelen die worden gescheiden door een koppelteken "-". De structuur is [ambulancevoorziening-jaartal-ritvolgnummer-patiëntvolgnummer]* 
ambulancevoorziening N1..2 - Identificatienummer van de ambulancevoorziening

* 
jaartal N4

* 
ritvolgnummer N1..14 - Volgnummer van de rit, uniek binnen de ambulancevoorziening en het jaartal

* 
patiëntvolgnummer N1..2 - Volgnummer van de patiënt binnen de rit. Dit is alleen hoger dan 1 als er meerdere patiënten vervoerd worden of als de rit is geannuleerd en vervolgens wordt de patiënt opnieuw ingestuurd (zie toelichting).

 **Toelichting** Indien een patiënt wordt ingestuurd naar een ziekenhuis met een verkeerd BSN, dan wordt deze rit geannuleerd. Het ritnummer heeft voor de extensie patiëntvolgnummer 1. Vanuit de ambulance wordt een nieuw bericht gestuurd met patiëntvolgnummer 2 en het nieuwe BSN, dus een “andere” patiënt. De annulering van de rit is wel belangrijk, want anders lijkt het alsof er 2 patiënten komen, wat in principe ook kan. Bij een annulering van de rit moet er een nieuw ritnummer komen waarbij het patiëntvolgnummer opgehoogd wordt met 1. Voorbeeld; Na 09-2023-1234567-1 komt 09-2023-1234567-2. 
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.6034--20260624133541"""
  * ^example[+].label = "# 1"
  * ^example[=].valueIdentifier.value =  "05-2019-12345678901314-11"
* Envelop.DateTimeSend 1..1 dateTime "DateTimeSend (1684)" """Geeft het tijdstip waarop de verzender het bericht afrondt en aanbiedt voor verzending. Dit gegeven kan automatisch worden ingevuld door de verzendende applicatie.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1684--20211110150321"""
  * ^example[+].label = "# 1"
  * ^example[=].valueDateTime.value =  "2115-10-12T07:00:00Z"
* Kern 1..1 BackboneElement "Kern (1709)" """Geeft de zorginhoudelijke kerngegevens van de berichten die genoemd zijn in de verschillende NHG-richtlijnen voor verwijzing, update, ontslag, directe toegang en eindrapportage voor paramedici. 
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1709--20211115095055"""
* Kern.ReasonMessage 1..1 BackboneElement "ReasonMessage (1872)" """Geeft de reden van de verwijzing of de update.
Hierbij is de beschrijving als vrije tekst op aangeven van het NHG verplicht.
Daarnaast kan er ook een ICPC-code van de episode worden meegestuurd, al dan niet aangevuld met meer details over de vastlegging van de ICPC.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1872--20220629112326"""
  * ^code[+] = http://snomed.info/sct#440378000 "verwijzing voor (waarneembare entiteit)"
* Kern.ReasonMessage.Context 1..1 string "Context (1710)" """Geeft aan waarom een zorgverlener (bijv. huisarts, paramedicus, medisch specialist, ambulance verpleegkundige) de patiënt verwijst, en waarom op dit moment.

In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op de 'Reden van melding'.In de richtlijnen HASP Medisch specialist en Paramedicus wordt dit veld in het updatebericht van huisarts naar medisch specialist/paramedicus 'Reden bericht' genoemd.De HASP-richtlijn (NHG) geeft aan:'De huisarts bedenkt of de geconsulteerde naast de korte verwijsreden nog extra context nodig heeft om het stokje goed te kunnen overnemen.Vaak kan de reden van een verwijzing kort zijn: de huisarts verwijst omdat er afspraken zijn om de noodzakelijke zorg in de tweede lijn te geven en het type verwijzing komt vaak voor, zie ook de voorbeelden in het volgende kader. Belangrijk is om concreet aan te geven:
• welk alarmsymptoom de huisarts ziet;
• welk ongewone beloop het ziektebeeld vertoont.
Of er speelt meer mee om deze patiënt op dit moment te verwijzen; de huisarts verwijst omdat:
• de klachten het functioneren van de patiënt te veel in de weg staan;
• de thuissituatie hierom vraagt;
• de huisarts de eigen koers onvoldoende vertrouwt;
• de huisarts een oorzaak wil uitsluiten alvorens een andere weg in te slaan;
• er sprake is van lastig te managen complexiteit.
Juist deze aanvullingen zijn essentieel om de medisch specialist het juiste startpunt te bieden.' 
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1710--20211115095548"""
  * ^code[+] = http://loinc.org#46239-0 "Belangrijkste klacht + reden voor bezoek"
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Naar allergoloog. Graag uw analyse bij hinderlijke klachten van vermoedelijk allergische conjunctivitis en/of allergische rinitis."
* Kern.IngesteldeBehandeling 0..* string "IngesteldeBehandeling (1711)" """Geeft de ingestelde behandeling in het verwijsbericht, de update en het DT-bericht.* In de richtlijn HASP Paramedicus wordt dit veld in de verwijzing, de update door de paramedicus en het DT-bericht 'Beleid, ingestelde behandeling' genoemd.
* In de richtlijn HASP Medisch Specialist wordt dit veld in het ontslagbericht 'Beleid' genoemd.
* In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op het veld 'Beleid'
Zie voor het verwijsbericht en de update de HASP-medische specialist richtlijn en HASP-paramedische richtlijn van het NHG.
Zie voor het DT-bericht de HASP-paramedische richtlijn van het NHG.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1711--20211115100719"""
  * ^code[+] = http://loinc.org#51847-2 "Evaluation + Plan note"
  * ^code[+] = http://snomed.info/sct#182991002 "behandeling gegeven (situatie)"
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Zyrtec oraal gedurende twee weken helpt onvoldoende. Geen specifieke allergie aangetoond tot op heden."
* Kern.DiagnosisConclusion 0..1 string "Diagnosis / Conclusion (1749)" """Geeft de diagnose en/of conclusie.In de HASP-paramedicus richtlijn (NHG) is aangegeven:* In het bericht 'DT' van de paramedicus komt de diagnose of conclusie.
* In het bericht 'eindrapportage van de paramedicus komt de conclusie.
 
In de HASP-medische specialist richtlijn (NHG) is aangegeven:* In het bericht 'ontslag' van de medische specialist komt de diagnose en/of conclusie.

In de HASP-GGZ richtlijn (NHG) is aangegeven:* In het bericht 'na intake' van de GGZ komt de diagnose en/of conclusie.
* In het bericht 'kennisgeving overdracht behandeling' van de GGZ komt de diagnose en/of conclusie.
* In het bericht 'einde behandeling / voortgang' ontslagbericht van de GGZ komt de diagnose en/of conclusie.

In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op de opsommingen van de titels van de toestandsbeelden in de Ambulance.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1749--20211123163609"""
  * ^code[+] = http://loinc.org#55110-1 "Conclusies "
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Beperking bij dagelijkse activiteiten op basis van interventie schouder, bij dwarslaesie "
* Kern.AgreedUponWithPatient 0..1 string "AgreedUponWithPatient (1752)" """In de uitwisseling HA-paramedicus geeft de afspraken in de eindrapportage die de zorgverlener heeft gemaakt met de patiënt over de eigen verantwoordelijkheid, bijvoorbeeld dat de patiënt zelf een afspraak maakt met de arts. Zie HASP-paramedicus richtlijn (NHG)

In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op het veld 'Afspraken met patiënt'.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1752--20211123165324"""
  * ^code[+] = http://loinc.org#69730-0 "Instructions"
  * ^code[+] = http://snomed.info/sct#183049006 "advies aan patiënt gegeven (situatie)"
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "Signalen van toenemend oedeem besproken; bij twijfel of constatering van verergering van de klachten neemt mevrouw op eigen initiatief weer contact op."
* Dossiergegevens 1..1 BackboneElement "Dossiergegevens (1725)" """Geeft de gegevens die in het dossier staan.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.1725--20211115111052"""
* Dossiergegevens.CommunicatieItem 1..* BackboneElement "CommunicatieItem (5457)" """CommunicatieItem. Geeft meta-gegevens over de correspondentie. Communicatie-item is een synoniem van correspodentie-item.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5457--20250611123825"""
* Dossiergegevens.CommunicatieItem.Document 1..* BackboneElement "Document (5472)" """ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5472--20250611144114"""
* Dossiergegevens.CommunicatieItem.Document.DocumentIdentificatie 1..1 Identifier "DocumentIdentificatie (5473)" """Nummer dat de instantiatie van de document wereldwijd uniek identificeert. Het nummer is samengesteld uit een identificatie van de uitgevende organisatie en een door deze organisatie toegekend uniek nummer
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5473--20250611144157"""
* Dossiergegevens.CommunicatieItem.Document.DocumentSetIdentificatie 1..1 Identifier "DocumentSetIdentificatie (5474)" """Identificatienummer van de set waar het document toe behoort
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5474--20250611144226"""
* Dossiergegevens.CommunicatieItem.Document.DocumentVersienummer 1..1 Count "DocumentVersienummer (5475)" """Versienummer van het document
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5475--20250611144258"""
* Dossiergegevens.CommunicatieItem.Document.DocumentBestandtype 1..1 string "DocumentBestandtype (5476)" """Het bestandtype als mimetype, bijvoorbeeld "application/pdf" of "text/plain".
Voor de verwijzing vanuit de Ambulance naar de Huisarts of Huisartsenpost is dit een pdf.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5476--20250611144329"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "application/pdf"
* Dossiergegevens.CommunicatieItem.Document.DocumentInhoud 1..1 base64Binary "DocumentInhoud (5477)" """Geeft de inhoud van de bijlage (blob)
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5477--20250611144354"""
* Dossiergegevens.CommunicatieItem.Document.DocumentNaam 1..1 string "DocumentNaam (5552)" """De bestandsnaam die het document heeft bij de verzender.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5552--20250820135844"""
  * ^example[+].label = "# 1"
  * ^example[=].valueString = "chest-xray-1-999999011.jpg"
* Dossiergegevens.CommunicatieItem.Document.DocumentCreatieDatumTijd 0..1 dateTime "DocumentCreatieDatumTijd (5553)" """Datum van het aanmaken van het document
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5553--20250820140054"""
* Dossiergegevens.CommunicatieItem.Document.DocumentType 1..1 CodeableConcept "DocumentType (5554)" """Geeft aan welk type document is toegevoegd.
Op dit moment is de BSA lijst gekoppeld vanuit de Ambulance.
ART-DECOR ID: 2.16.840.1.113883.2.4.3.11.60.103.2.3.5554--20250820141523"""
* Dossiergegevens.CommunicatieItem.Document.DocumentType from http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.103.11.31--20250820144948 (required)  // Bijlagen
  * ^example[+].label = "# 1"


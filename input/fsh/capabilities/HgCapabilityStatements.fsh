// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// CapabilityStatements for the Acute Zorg referral exchange.
//
// REQUIREMENTS-level statements describing what the sending and receiving systems must be capable of. The exchange paradigm is RESTful (decided in GitHub issue #14): the referral travels as one transaction Bundle, so the sender needs the system-level transaction interaction and the receiver has to support it, next to create on each resource type the referral carries. The Messaging and Document options remain described on the Data Exchange page but are not modeled.
// =============================================================================

Instance: hg-CapabilityStatement-Sender
InstanceOf: CapabilityStatement
Usage: #definition
Title: "hg referral Sender Capability Statement"
Description: "Requirements on the sending system (ambulance/Regionale Ambulancevoorziening) for the Acute Zorg referral push. The sender produces the referral and POSTs it to the receiver as a transaction Bundle."
* url = "http://nictiz.nl/fhir/CapabilityStatement/hg-CapabilityStatement-Sender"
* name = "HgCapabilityStatementSender"
* status = #draft
* experimental = true
* date = "2026-09-02"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+json
* format[+] = #application/fhir+xml
* implementationGuide = "http://nictiz.nl/fhir/ImplementationGuide/nictiz.fhir.nl.r4.acutezorg"
* purpose = "Informative in nature; it does not represent minimum or maximum capabilities. Consult this Implementation Guide for the exact capability requirements."
* insert NictizMetadataInstance
* rest[+]
  * mode = #client
  * documentation = "The sending system produces a conformant referral and POSTs it to the receiver in one transaction, conforming to hg-ReferralBundle-AmbulanceHAP. The resources it has to be able to produce are listed below: ServiceRequest (hg-ReferralServiceRequest-AmbulanceHAP), Composition (hg-ReferralComposition-AmbulanceHAP), DocumentReference (hg-ReferralDocumentReference-AmbulanceHAP, when applicable), Patient (hg-Patient-AmbulanceHAP), Encounter (hg-Encounter-AmbulanceHAP), Organization (hg-HealthcareProvider-Organization-AmbulanceHAP), PractitionerRole (hg-HealthProfessional-PractitionerRole-AmbulanceHAP) and Practitioner (nl-core-HealthProfessional-Practitioner). The create interaction per resource type describes what the transaction entries do; the transaction itself is the system-level interaction below."
  * interaction[+]
    * code = #transaction
    * documentation = "The referral is sent as one transaction Bundle conforming to hg-ReferralBundle-AmbulanceHAP: POST entries with urn:uuid fullUrls, so the references between the resources resolve within the transaction and no entry claims an identity on the receiving server."
  * resource[+]
    * type = #ServiceRequest
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Composition
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralComposition-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #DocumentReference
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralDocumentReference-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Patient
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Encounter
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-Encounter-AmbulanceHAP"
    * interaction[+].code = #create  
  * resource[+]
    * type = #Organization
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #PractitionerRole
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthProfessional-PractitionerRole-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Practitioner
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
    * interaction[+].code = #create

Instance: hg-CapabilityStatement-Receiver
InstanceOf: CapabilityStatement
Usage: #definition
Title: "hg referral Receiver Capability Statement"
Description: "Requirements on the receiving system (GP out-of-hours post, HAP) for the Acute Zorg referral push. The receiver exposes a FHIR endpoint that accepts the referral as a transaction Bundle."
* url = "http://nictiz.nl/fhir/CapabilityStatement/hg-CapabilityStatement-Receiver"
* name = "HgCapabilityStatementReceiver"
* status = #draft
* experimental = true
* date = "2026-09-02"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+json
* format[+] = #application/fhir+xml
* implementationGuide = "http://nictiz.nl/fhir/ImplementationGuide/nictiz.fhir.nl.r4.acutezorg"
* purpose = "Informative in nature; it does not represent minimum or maximum capabilities. Consult this Implementation Guide for the exact capability requirements."
* insert NictizMetadataInstance
* rest[+]
  * mode = #server
  * documentation = "The receiving system accepts a conformant referral as one transaction and must not raise an error on any obligation-marked element (SHALL:no-error). It answers the transaction with a transaction-response Bundle in which every entry was created. The resource types it has to accept are listed below: ServiceRequest, Composition, DocumentReference, Patient, Encounter, Organization, PractitionerRole and Practitioner."
  * interaction[+]
    * code = #transaction
    * documentation = "Accepts the referral as one transaction Bundle conforming to hg-ReferralBundle-AmbulanceHAP, resolving the urn:uuid references between its entries."
  * resource[+]
    * type = #ServiceRequest
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Composition
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralComposition-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #DocumentReference
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralDocumentReference-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Patient
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Encounter
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-Encounter-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Organization
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #PractitionerRole
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthProfessional-PractitionerRole-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Practitioner
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
    * interaction[+].code = #create

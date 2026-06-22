// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// Bijlagen (BSA - Bijlagen Standaard Ambulancezorg) attachment-type list, exported from the
// ART-DECOR hg- project. Bound (required) on hg-ReferralDocumentReference-AmbulanceHAP.type.
// The canonicals are pinned to the published OIDs so instances (which carry
// system = urn:oid:2.16.840.1.113883.2.4.3.11.60.55.5.16) validate against this code system.
CodeSystem: AcutezorgCodesysteem16
Id: acutezorg-codesysteem-16
Title: "acutezorg codesysteem 16"
Description: "Document (attachment) types for the Ambulanceverwijzing - the BSA *Bijlagen* list (ART-DECOR codesystem acutezorg-codesysteem-16, OID 2.16.840.1.113883.2.4.3.11.60.55.5.16)."
* ^url = "urn:oid:2.16.840.1.113883.2.4.3.11.60.55.5.16"
* ^caseSensitive = true
* ^content = #complete
* #001 "12 afleidingen ECG"
* #002 "ritmestrook"
* #003 "advies patient"
* #004 "cardiologisch begeleidingsformulier"
* #005 "IBS/CM"
* #006 "intern rapport/overdracht"
* #007 "niet reanimeren verklaring"
* #008 "patient weigert hulp"
* #009 "RM/ZM"
* #010 "eerste hulp, geen vervoer"
* #011 "foto"
* #012 "video"
* #013 "prehospitale EEG"

ValueSet: HgBijlagen
Id: hg-bijlagen
Title: "hg bijlagen"
Description: "Document (attachment) types for the Ambulanceverwijzing - the BSA *Bijlagen* value set (ART-DECOR OID 2.16.840.1.113883.2.4.3.11.60.103.11.31, version BSA). Bound (required) on the DocumentType of the referral DocumentReference."
* ^url = "urn:oid:2.16.840.1.113883.2.4.3.11.60.103.11.31"
* include codes from system AcutezorgCodesysteem16

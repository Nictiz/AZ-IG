### Dutch-English element name mapping

The ART-DECOR dataset is Dutch-only. Each profile element carries three language-related
descriptors sourced differently:

- `alias` carries the Dutch dataset element name verbatim from ART-DECOR, preserving direct
  traceability to the source.
- `definition` carries the Dutch omschrijving from ART-DECOR.
- `short` carries an English translation authored in this IG. Where an equivalent element exists
  in the ELZ FHIR profiles (`nictiz.fhir.nl.r4.elz`), the same English term is used; elements
  specific to the AMB-HAP transaction are translated independently.

| Dutch dataset name | English `short` |
|---|---|
| Envelop | Envelope |
| Bestemmingsstatus | DestinationStatus |
| TypeBericht | MessageType |
| Urgentie | Urgency |
| Patient | Patient |
| Datum en tijd | SendDateTime |
| Verzender | Sender |
| Ontvanger | Recipient |
| RedenBericht | MessageReason |
| Context | Context |
| Kern | Core |
| IngesteldeBehandeling | SetTreatment |
| Diagnose/Conclusie | DiagnosisConclusion |
| AfgesprokenMetPatient | AgreedWithPatient |
| CommunicatieItem | CommunicationItem |
| CommunicatieAfzender | CommunicationSender |
| Document | (folded into DocumentReference root) |
| DocumentIdentificatie | DocumentIdentification |
| DocumentSetIdentificatie | DocumentSetIdentification |
| DocumentType | DocumentType |
| DocumentBestandtype | DocumentMediaType |
| DocumentInhoud | DocumentContent |
| DocumentNaam | DocumentName |
| DocumentCreatieDatumTijd | DocumentCreationDateTime |

---
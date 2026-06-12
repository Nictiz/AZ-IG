These items need confirmation or resolution before the profiles can be finalised.

### Profiles

- **Bestemmingsstatus (Envelop).** Modelled provisionally through `ServiceRequest.status`
  (active maps to active, cancelled maps to revoked). The third dataset value, "transferred",
  has no clean FHIR core equivalent and may need a small extension. To be decided.

- **`DocumentReference.category` binding.** Left open pending a suitable zib, nl-core, or
  generic value set. The original Nictiz profile bound the CommunicatieItem category to an
  NHG-derived set, which is out of scope here.

- **`ServiceRequest.reasonCode`.** Currently text only. A coded binding can be added once
  section 2.16 of the functional design specifies one.

- **Document specification reconciliation.** Section 3.3 of the Nictiz functional design
  specifies the document inside the Ambulanceverwijzing to the HAP. The constraints on
  `hg-ReferralDocumentReference-AmbulanceHAP` should be reconciled against that section once
  published.

- **`HgReferralComposition.type` fixed value.** The generic layer fixes `type` to LOINC
  `57133-1` (Referral note) on the assumption that all Acute Zorg referral compositions are
  referral notes. This should be verified against the ELZ profiles (`nictiz.fhir.nl.r4.elz`)
  before finalising; if any use case requires a different document type, the fixed value must
  move to the use case layer.

- **Zib profile cardinalities.** The cardinalities on `hg-Patient-AmbulanceHAP`,
  `hg-HealthcareProvider-Organization-AmbulanceHAP`, and
  `hg-HealthProfessional-PractitionerRole-AmbulanceHAP` are a first defensible cut. They
  should be reconciled against the published dataset's per-element multiplicities.

### IG infrastructure

- **Downloads page.** A dedicated Downloads page should be added once the IG is published at
  a stable URL. It should include the npm install command for `nictiz.fhir.nl.r4.acutezorg`,
  direct links to `package.tgz`, `full-ig.zip`, and the JSON/XML definition zips generated
  by the IG Publisher.

### Architecture

- **Canonical URL conflict with ELZ.** The generic `hg-Referral*` profiles in this IG share
  their canonical URLs (e.g. `http://nictiz.nl/fhir/StructureDefinition/hg-ReferralComposition`)
  with copies that currently exist in `nictiz.fhir.nl.r4.elz#0.2.0-beta.1`. Both packages are
  in beta so the conflict is manageable for now - Sushi propagates the package version to all
  generated resources, making the two sets distinguishable via versioned canonical references
  (`canonical|version`). The conflict must be resolved before either package reaches a stable
  release: the ELZ team should remove their copies and add `nictiz.fhir.nl.r4.acutezorg` as a
  dependency in the next ELZ release. No renaming of canonical URLs is needed; only the owning
  package changes. If the generic profiles are later extracted into a standalone package, the
  same applies - URLs stay the same, only the dependency pointer changes.

- **Exchange paradigm.** The exchange paradigm (FHIR Messaging, RESTful, or FHIR Document)
  has not yet been selected. The CapabilityStatements and the Data Exchange page will be
  updated once a decision is made. See the [Data Exchange](data-exchange.html) page for a
  description of all three options.

- **Message 23 (AMB naar HA).** The referral from ambulance to regular GP (message 23) is out
  of scope for this version. It follows the same FHIR pattern and can be added as a parallel
  `hg-Referral*-AmbulanceHA` use case layer with a new `ambulance-referral-to-ha` event code.
  No changes to the existing HAP profiles would be required.

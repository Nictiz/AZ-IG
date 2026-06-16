These items need confirmation or resolution before the profiles can be finalised.

### Profiles

- **`DocumentReference.category` binding.** `category` (CommunicatieCategorie,
  hg-dataelement-5463) is modelled and mapped to the dataset, but **no value set is bound yet** -
  left open pending a suitable zib, nl-core, or generic value set. The original Nictiz profile
  bound the CommunicatieItem category to an NHG-derived set, which is out of scope here.

- **`ServiceRequest.reasonCode` coding.** The dataset carries the reason as free text
  (RedenBericht / Context, hg-dataelement-1872 / hg-dataelement-1710): per the NHG the free-text
  description is mandatory and an ICPC code of the episode may optionally accompany it. This maps
  to `reasonCode.text` (the free text) plus an optional `reasonCode.coding` (ICPC) when a code is
  sent. A free-text-only `CodeableConcept` (text, no coding) is valid in FHIR, so no
  `data-absent-reason` is needed. Open: whether to constrain `reasonCode.coding` to an ICPC
  binding (or slice) once the dataset/transaction fixes the code system.

### IG infrastructure

- **Downloads page.** A dedicated Downloads page should be added once the IG is published at
  a stable URL. It should include the npm install command for `nictiz.fhir.nl.r4.acutezorg`,
  direct links to `package.tgz`, `full-ig.zip`, and the JSON/XML definition zips generated
  by the IG Publisher.

- **Publication (version history and publication status).** Version history is deferred to the
  formal publication process, which maintains `package-list.json` and the generated history page
  in the published webroot; it is intentionally not committed to the IG source root (the IG
  Publisher flags a root `package-list.json`). Until the IG is published, the build emits two
  expected, harmless publication-status messages that are not counted in the QA totals: "Error
  fetching package-list from http://nictiz.nl/fhir" (the Publisher probes the canonical for prior
  versions and receives the Nictiz HTML site instead of JSON) and "No publication request found"
  (no `publication-request.json`, which only exists during a formal publication run). Both
  resolve at publication time and need no action meanwhile.

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

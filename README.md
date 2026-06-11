# Acute Zorg - Ambulanceverwijzing naar HAP (AMB naar HAP)

FHIR R4 Implementation Guide for the ambulance to GP out-of-hours post (HAP) referral
(message 24 from the Richtlijn Gegevensuitwisseling Acute Zorg), built on nl-core, authored
in FHIR Shorthand (FSH). Message 23 (AMB to HA) is out of scope for this version but follows
the same FHIR pattern and can be added as a parallel use-case layer later.

## Identity

- Canonical base: `http://nictiz.nl/fhir` (shared Nictiz base; artifacts are disambiguated
  by the `hg-` id prefix, e.g. `http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest`).
- Package id: `nictiz.fhir.nl.r4.acutezorg`.

## Layout

- `sushi-config.yaml` - project configuration and dependencies
- `input/fsh/aliases.fsh` - canonical URL and code system aliases
- `input/fsh/profiles/` - generic `hg-Referral*` layer (FHIR core based) and the
  `hg-Referral*-AmbulanceHAP` use-case layer derived from it
- `input/fsh/extensions/` - TextValue extension for free-text rubrieken
- `input/fsh/terminology/` - message event CodeSystem and ValueSet
- `input/fsh/mappings/` - dataset traceability mappings, attached to the use-case profiles
- `input/fsh/instances/` - scenario 5b example set, including the message bundle
- `input/pagecontent/index.md` - IG narrative and design rationale

## Build

```
sushi .
# then run the HL7 IG Publisher (generates dependency snapshots and the HTML output)
```

## Dependencies note

nl-core profiles derive from zib2020 profiles, and Sushi walks that ancestry both when validating
`Reference(nl-core-...)` constraints and when deriving profiles from nl-core (the
`hg-...-AmbulanceHAP` zib profiles). Deriving a profile requires the parent's **snapshot**, so the
build pins `nictiz.fhir.nl.r4.nl-core` and `nictiz.fhir.nl.r4.zib2020` to `0.12.0-beta.4`, which
ships snapshots (earlier betas are differential-only, which makes Sushi unable to import them as a
parent). `zib2020` is declared explicitly because Sushi does not load that transitive dependency on
its own. `hl7.fhir.uv.tools.r4` is declared so `ActorDefinition` (used by the obligations) resolves
in R4. With these present the build is clean and needs no pre-build snapshot generation.

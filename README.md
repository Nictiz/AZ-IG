# Acute Zorg - FHIR R4 Implementation Guide

FHIR R4 Implementation Guide for information exchange in acute care settings in the Netherlands,
following the Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022). Built on nl-core
(zib2020, R4) and authored in FHIR Shorthand (FSH).

The first use case is the ambulance to GP out-of-hours post referral (AMB naar HAP, message 24).
Message 23 (AMB naar HA) follows the same pattern and is planned as a parallel use-case layer.

**Status: under development - no official release yet.**
This is the first Nictiz IG published as a proper HL7 FHIR Implementation Guide (using the HL7
IG Publisher and FHIR Shorthand), rather than as a specification on the Nictiz wiki. It therefore
looks and works differently from earlier Nictiz FHIR documentation. The canonical output is a
browsable IG with structured profiles, examples, and conformance resources - not a wiki page.

## Identity

- Package id: `nictiz.fhir.nl.r4.acutezorg`
- Canonical base: `http://nictiz.nl/fhir` (shared Nictiz base; artifacts are disambiguated by
  the `hg-` id prefix, e.g. `http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest`)

## Layout

- `sushi-config.yaml` - project configuration, dependencies, and menu
- `input/fsh/aliases.fsh` - canonical URL and code system aliases
- `input/fsh/profiles/` - generic `hg-Referral*` layer (FHIR core based) and the
  `hg-Referral*-AmbulanceHAP` use-case layer derived from it
- `input/fsh/extensions/` - TextValue extension for free-text rubrieken
- `input/fsh/terminology/` - message event CodeSystem and ValueSet
- `input/fsh/mappings/` - dataset traceability mappings attached to the use-case profiles
- `input/fsh/instances/` - scenario 5b example set including the message bundle
- `input/fsh/actors/` - ActorDefinition resources for sender and receiver
- `input/fsh/capabilities/` - CapabilityStatement resources
- `input/pagecontent/index.md` - scope and audience
- `input/pagecontent/functional-design.md` - functional design reference
- `input/pagecontent/data-model.md` - data model
- `input/pagecontent/data-exchange.md` - exchange paradigm options
- `input/pagecontent/design-decisions.md` - modeling and conformance decisions
- `input/pagecontent/open-items.md` - pending decisions

## Building

This IG is built automatically by the [HL7 auto IG builder](https://github.com/FHIR/auto-ig-builder)
on every push. Builds for all branches are available at:
https://build.fhir.org/ig/Nictiz/AZ-IG/branches/

To build locally, run the standard IG Publisher scripts included in the repository:

```
# On macOS/Linux
./_genonce.sh

# On Windows
_genonce.bat
```

This runs Sushi (FSH compilation) followed by the HL7 IG Publisher. No separate Sushi step or
snapshot pre-generation is needed.

## Dependencies

| Package | Version | Purpose |
|---|---|---|
| `nictiz.fhir.nl.r4.nl-core` | 0.12.0-beta.4 | nl-core base profiles |
| `nictiz.fhir.nl.r4.zib2020` | 0.12.0-beta.4 | zib2020 profiles (declared explicitly - Sushi does not pull this transitive dependency on its own) |
| `hl7.fhir.uv.tools.r4` | 1.1.2 | Required for `ActorDefinition` to resolve in R4 |

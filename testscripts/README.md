# Acute Zorg - Conformancelab TestScripts

FHIR **TestScript** resources for testing and qualification of the Acute Zorg use cases on [Conformancelab](https://fhir.interoplab.eu/ig/index.html) (the Interoplab platform Nictiz uses). They are authored in [FHIR Shorthand](https://fshschool.org/) and built with Sushi, in a project **separate from the IG**.

## Approach and rationale

**FSH, not NTS - same output.** Nictiz's own TestScripts ([Nictiz/Nictiz-testscripts](https://github.com/Nictiz/Nictiz-testscripts)) are authored in **NTS** (Nictiz Test Scripts), a proprietary XML shorthand expanded by an Apache ANT pipeline. This IG instead authors its TestScripts in **FHIR Shorthand** and builds them with Sushi. The *output is the same* - FHIR `TestScript` resources plus the Conformancelab folder layout (`<usecase>/<goal>/<role>/` with a `properties.json` and fixtures) - so Conformancelab consumes them identically. FSH was chosen because the rest of this IG is authored in FSH: one toolchain (Sushi), no separate Java/ANT build, and the TestScripts sit next to the profiles they test. NTS's built-in component library is replaced by FSH **RuleSets** for the same reuse.

**PZP (IKNL) style.** IKNL publishes working FSH TestScripts for Conformancelab in [PZP-test-en-kwalificatiemateriaal](https://github.com/IKNL/PZP-test-en-kwalificatiemateriaal). Rather than invent our own conventions, we follow theirs: reusable RuleSets (`Metadata`, `ClientTesting`/`ServerTesting` carrying the Interoplab `Interoplab-CL-ext-SUT` marker), role-folder organization, `validateProfileId` for profile conformance, and the standard content asserts (a Coding has a system and a code, an Identifier has a system and a value, every entry declares `meta.profile`, ...). This keeps us aligned with a proven, maintained FSH-for-Conformancelab pattern.

**R5 TestScripts over R4 data.** Conformancelab officially supports the **R5** `TestScript` resource, so the TestScripts are R5 even though the IG and its data are **R4**. The versions are decoupled: Conformancelab loads the R4 data package (`nictiz.fhir.nl.r4.acutezorg`) via the per-role `properties.json`, and the TestScripts reference the **version-independent profile canonical URLs**. (IKNL author their TestScripts in R4, which also works in Conformancelab; we use R5 as the officially-supported version.)

**Separate Sushi tank.** A Sushi project is single-version and mixing FHIR versions in one IG-Publisher run is fragile, so the TestScripts live in this separate tank pinned to `fhirVersion: 5.0.0` with `FSHOnly: true` (we want only the resources, not an IG). It builds independently of the R4 IG.

**Interoplab dependency.** The tank depends on `interoplab.fhir.r5.conformancelab` (the CL extensions). That package is `notForPublication` and not on the public registry; install it into the local FHIR package cache (extract `https://fhir.interoplab.eu/ig/package.tgz` into `~/.fhir/packages/interoplab.fhir.r5.conformancelab#1.0.0/`).

## Layout

```
testscripts/
  sushi-config.yaml                 # R5, FSHOnly, Interoplab dependency
  input/fsh/*.fsh                   # the TestScripts (R5)
  conformancelab/                   # Conformancelab per-role properties.json (source)
    AMB-naar-HAP/Test/<role>/properties.json
  build-conformancelab.sh           # assembles the Conformancelab deployment into output/
  fsh-generated/                    # Sushi output (git-ignored)
  output/                           # assembled Conformancelab layout (git-ignored)
```

## Build

```
sushi .                    # generate the R5 TestScript resources
./build-conformancelab.sh  # assemble the Conformancelab <usecase>/<goal>/<role> layout
```
(`build-conformancelab.sh` also copies the R4 example fixtures from the main IG, so run `sushi .` in the repo root first.)

The reusable RuleSets live in `input/fsh/RuleSet.fsh` and the aliases in `input/fsh/Alias.fsh` (see *Approach and rationale* above).

## TestScripts (Phase A - content validation)

Roles mirror the IG's `hg-ActorSender` / `hg-ActorReceiver` actors:

- **Sending-System** (`hg-TestScript-AmbulanceHAP-Sender`) - the sender is the system under test; validates that the message it pushes is a conformant AMB-naar-HAP message (message Bundle, event 145, a ServiceRequest conforming to `hg-ReferralServiceRequest-AmbulanceHAP`, the mandatory reason section).
- **Receiving-System** (`hg-TestScript-AmbulanceHAP-Receiver`) - the receiver is the system under test; sends the worked scenario-5b message and confirms it is accepted.

## Provisional / to confirm

- The **transport operation** is modelled as a plain `create`/POST pending the exchange-paradigm choice (Open Items #14). The content **assertions** are paradigm-independent.
- The exact Conformancelab `properties.json` semantics (`serverAlias`, and the `fhirVersion` field's meaning for an R5 TestScript over R4 data) should be confirmed with the Conformancelab team.
- See the Nictiz reference materials in [Nictiz/Nictiz-testscripts](https://github.com/Nictiz/Nictiz-testscripts) (NTS source + generated output).

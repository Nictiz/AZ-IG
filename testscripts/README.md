# Acute Zorg - Conformancelab TestScripts

FHIR TestScript resources for testing and qualification of the Acute Zorg use cases on [Conformancelab](https://fhir.interoplab.eu/ig/index.html) (the Interoplab platform Nictiz uses). They are authored in [FHIR Shorthand](https://fshschool.org/) and built with Sushi, in a project separate from the IG.

## Approach and rationale

FSH, not NTS - same output. Nictiz's own TestScripts ([Nictiz/Nictiz-testscripts](https://github.com/Nictiz/Nictiz-testscripts)) are authored in NTS (Nictiz Test Scripts), a proprietary XML shorthand expanded by an Apache ANT pipeline. This IG instead authors its TestScripts in FHIR Shorthand and builds them with Sushi. The *output is the same* - FHIR `TestScript` resources plus the Conformancelab folder layout (`<usecase>/<goal>/<role>/` with a `properties.json` and fixtures) - so Conformancelab consumes them identically. FSH was chosen because the rest of this IG is authored in FSH: one toolchain (Sushi), no separate Java/ANT build, and the TestScripts sit next to the profiles they test. NTS's built-in component library is replaced by FSH RuleSets for the same reuse.

PZP (IKNL) style. IKNL authors working FSH TestScripts for Conformancelab in their PZP test-materials project (`IKNL/PZP-test-en-kwalificatiemateriaal`; currently a private repository - no public link). Rather than invent our own conventions, we follow theirs: reusable RuleSets (`Metadata`, `ClientTesting`/`ServerTesting` carrying the Interoplab `Interoplab-CL-ext-SUT` marker), role-folder organization, `validateProfileId` for profile conformance, and the standard content asserts (a Coding has a system and a code, an Identifier has a system and a value, every entry declares `meta.profile`, ...). This keeps us aligned with a proven, maintained FSH-for-Conformancelab pattern.

R5 TestScripts over R4 data. Conformancelab officially supports the R5 `TestScript` resource, so the TestScripts are R5 even though the IG and its data are R4. The versions are decoupled: Conformancelab loads the R4 data package (`nictiz.fhir.nl.r4.acutezorg`) via the per-role `properties.json`, and the TestScripts reference the version-independent profile canonical URLs. (IKNL author their TestScripts in R4, which also works in Conformancelab; we use R5 as the officially-supported version.)

Separate Sushi tank. A Sushi project is single-version and mixing FHIR versions in one IG-Publisher run is fragile, so the TestScripts live in this separate tank pinned to `fhirVersion: 5.0.0` with `FSHOnly: true` (we want only the resources, not an IG). It builds independently of the R4 IG.

Interoplab dependency. The tank depends on `interoplab.fhir.r5.conformancelab` (the CL extensions). That package is `notForPublication` and not on the public registry; install it into the local FHIR package cache (extract `https://fhir.interoplab.eu/ig/package.tgz` into `~/.fhir/packages/interoplab.fhir.r5.conformancelab#1.0.0/`).

## Layout

Following the IKNL PZP convention, TestScripts are organized in role folders, each with its own `properties.json`:

```
testscripts/
  sushi-config.yaml                 # R5, FSHOnly, Interoplab dependency
  generate.py                       # runs Sushi + assembles the Conformancelab layout
  input/fsh/
    Alias.fsh                       # shared aliases
    RuleSet.fsh                     # reusable RuleSets (Metadata, Client/ServerTesting, asserts)
    Sending-System/                 # role folder: TestScript(s) + properties.json
    Receiving-System/               # role folder: TestScript(s) + properties.json
  fsh-generated/                    # Sushi output (git-ignored)
  output/                           # assembled deployment (committed, like Nictiz-testscripts):
                                    #   <usecase>/<goal>/_reference/resources/  (shared fixtures)
                                    #   <usecase>/<goal>/<Role>/                (TestScripts + properties.json)
```

`output/` is committed (as in the Nictiz-testscripts repo) so the generated TestScripts and fixtures are viewable and consumable without a build; regenerate it with `python generate.py` whenever the FSH changes. `fsh-generated/` (the raw Sushi output) stays git-ignored.

## Build

```
python generate.py
```
`generate.py` (adapted from the IKNL PZP build script) runs `sushi .`, then uses `fsh-generated/data/fsh-index.json` to route each generated TestScript to its role folder, copies the co-located `properties.json`, and pulls in the referenced R4 example fixtures from the main IG. Run `sushi .` in the repo root first so those fixtures exist under `../fsh-generated`.

## TestScripts (Phase A - content validation)

Roles mirror the IG's `hg-ActorSender` / `hg-ActorReceiver` actors:

- Sending-System (`hg-TestScript-AmbulanceHAP-Sender`) - the sender is the system under test; validates that the message it pushes is a conformant AMB-naar-HAP message (message Bundle, event 145, a ServiceRequest conforming to `hg-ReferralServiceRequest-AmbulanceHAP`, the mandatory reason section).
- Receiving-System (`hg-TestScript-AmbulanceHAP-Receiver`) - the receiver is the system under test; sends the worked scenario-5b message and confirms it is accepted.

## Provisional / to confirm

- The transport operation is modelled as a plain `create`/POST pending the exchange-paradigm choice (Open Items #14). The content assertions are paradigm-independent.
- The exact Conformancelab `properties.json` semantics (`serverAlias`, and the `fhirVersion` field's meaning for an R5 TestScript over R4 data) should be confirmed with the Conformancelab team.
- See the Nictiz reference materials in [Nictiz/Nictiz-testscripts](https://github.com/Nictiz/Nictiz-testscripts) (NTS source + generated output).

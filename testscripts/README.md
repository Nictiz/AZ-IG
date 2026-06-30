# Acute Zorg - ConformanceLab TestScripts

FHIR **TestScript** resources for testing and qualification of the Acute Zorg use cases on [ConformanceLab](https://fhir.interoplab.eu/ig/index.html) (the Interoplab platform Nictiz uses). They are authored in [FHIR Shorthand](https://fshschool.org/) and built with Sushi, in a project **separate from the IG**.

## Why a separate, R5 project

ConformanceLab officially supports the **R5** `TestScript` resource, while the Acute Zorg IG is **R4**. The TestScript version is decoupled from the data version: an R5 TestScript can test R4 data because ConformanceLab loads the R4 data package (`nictiz.fhir.nl.r4.acutezorg`) via the per-role `properties.json`, and the TestScripts reference the **version-independent profile canonical URLs**. So this tank is pinned to `fhirVersion: 5.0.0` and kept out of the R4 IG build.

It depends on the Interoplab CL extensions package `interoplab.fhir.r5.conformancelab`. That package is `notForPublication` and not on the public registry; install it into the local FHIR package cache (e.g. extract `https://fhir.interoplab.eu/ig/package.tgz` into `~/.fhir/packages/interoplab.fhir.r5.conformancelab#1.0.0/`).

## Layout

```
testscripts/
  sushi-config.yaml                 # R5, FSHOnly, Interoplab dependency
  input/fsh/*.fsh                   # the TestScripts (R5)
  conformancelab/                   # ConformanceLab per-role properties.json (source)
    AMB-naar-HAP/Cert/<role>/properties.json
  build-conformancelab.sh           # assembles the ConformanceLab deployment into output/
  fsh-generated/                    # Sushi output (git-ignored)
  output/                           # assembled ConformanceLab layout (git-ignored)
```

## Build

```
sushi .                    # generate the R5 TestScript resources
./build-conformancelab.sh  # assemble the ConformanceLab <usecase>/<goal>/<role> layout
```
(`build-conformancelab.sh` also copies the R4 example fixtures from the main IG, so run `sushi .` in the repo root first.)

## TestScripts (Phase A - content validation)

Roles mirror the IG's `hg-ActorSender` / `hg-ActorReceiver` actors:

- **Sending-System** (`hg-TestScript-AmbulanceHAP-Sender`) - the sender is the system under test; validates that the message it pushes is a conformant AMB-naar-HAP message (message Bundle, event 145, a ServiceRequest conforming to `hg-ReferralServiceRequest-AmbulanceHAP`, the mandatory reason section).
- **Receiving-System** (`hg-TestScript-AmbulanceHAP-Receiver`) - the receiver is the system under test; sends the worked scenario-5b message and confirms it is accepted.

## Provisional / to confirm

- The **transport operation** is modelled as a plain `create`/POST pending the exchange-paradigm choice (Open Items #14). The content **assertions** are paradigm-independent.
- The exact ConformanceLab `properties.json` semantics (`serverAlias`, the `fhirVersion` field for an R5 TestScript over R4 data) and whether `conformsTo()` is the right profile-validation mechanism (vs `validateProfileId`) should be confirmed with the ConformanceLab team.
- See the Nictiz reference materials in [Nictiz/Nictiz-testscripts](https://github.com/Nictiz/Nictiz-testscripts) (NTS source + generated output).

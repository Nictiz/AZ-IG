# Repo for the Acute Zorg IG

## Introduction

This is the git repository for the Acute Zorg FHIR R4 Implementation Guide maintained by Nictiz. The IG covers information exchange in acute care settings in the Netherlands, following the Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022). It is built on nl-core (zib2020, R4) and authored in FHIR Shorthand (FSH).

The first use case is the transfer from the ambulance service to the GP out-of-hours service (Ambulanceverwijzing naar HAP, AMB to HAP).

The current version is 1.0.0-beta.1, for testing with vendors. It is not meant for production use.

| | |
|---|---|
| Published versions | <http://ig.nictiz.nl/az/history.html> |
| CI build (`develop`) | <https://build.fhir.org/ig/Nictiz/AZ-IG/branches/develop/> |
| Package id | `nictiz.nl.az` |
| Canonical base | `http://ig.nictiz.nl/az` |

The `hg-` prefix in the resource ids is the ART-DECOR project prefix. Profiles from nl-core and zib2020 keep their own canonical `http://nictiz.nl/fhir`.

## Sources

This repo is not the source of truth for all content in the IG:

- The data set, the transaction and the project terminology are maintained in [ART-DECOR](https://decor.nictiz.nl/ad/#/hg-) (project `hg-`). The terminology and the logical model are downloaded from ART-DECOR into `input/resources/` and must not be edited by hand; see the README in that folder.
- The example instances are generated from the ADA test instances in ART-DECOR with the Nictiz ADA-to-FHIR tooling.
- The functional design is part of this IG, on the Functional Design page.
- The TestScripts for Conformancelab are maintained in [Nictiz/Nictiz-testscripts](https://github.com/Nictiz/Nictiz-testscripts).

## Building

### Local

Local building uses the `_genonce.sh` script in the root folder, like any other FHIR IG build. This requires Node and Java, and [SUSHI](https://github.com/FHIR/sushi):

    $ npm install -g fsh-sushi

To only compile the FSH, which is much faster, run:

    $ sushi .

The full build writes the QA report to `output/qa.html`.

### Remote

Every push is built by the [HL7 auto IG builder](https://github.com/FHIR/auto-ig-builder). The builds of all branches are at <https://build.fhir.org/ig/Nictiz/AZ-IG/branches/>.

Official versions are published on ig.nictiz.nl through [Nictiz/IG-publications](https://github.com/Nictiz/IG-publications).

## Branching and releases

- `develop` holds the current state. New and changed content is added on a branch and merged into `develop` through a pull request.
- For a release, a branch `release-[version]` is created from `develop`. Nictiz/IG-publications builds the published version from that branch.
- After publication, the release branch is merged into `main` and tagged with the version, for example `1.0.0-beta.1`.
- Versions follow the Nictiz Nationaal Releasebeleid (semantic versioning). Notable changes per version are on the Changelog page of the IG.

## Content

| Folder or file | Content |
|---|---|
| `sushi-config.yaml` | Project configuration, dependencies and menu |
| `input/fsh/aliases.fsh` | Aliases for canonical URLs and code systems |
| `input/fsh/profiles/` | The generic `hg-*` layer on FHIR core, the use case layer for AMB to HAP derived from it and the use case profiles on nl-core |
| `input/fsh/extensions/` | Extensions used by the profiles |
| `input/fsh/terminology/` | Local code systems |
| `input/fsh/mappings/` | Mappings from the use case profiles to the ART-DECOR data set |
| `input/fsh/actors/` | ActorDefinitions for sender and receiver |
| `input/fsh/capabilities/` | CapabilityStatements for sender and receiver |
| `input/resources/` | Terminology and the logical model from ART-DECOR, embedded as is |
| `input/images-source/` | PlantUML sources of the diagrams, rendered by the IG Publisher |
| `input/pagecontent/` | The narrative pages, one Markdown file per page; the menu is in `sushi-config.yaml` |
| `publication-request.json` | Version information for the publication on ig.nictiz.nl |

## Quality control

The IG Publisher writes all validation messages to `output/qa.html`, with a summary in `output/qa.txt`. Broken links are reported separately from errors.

The [Nictiz QA tooling](https://github.com/Nictiz/Nictiz-tooling-R4-QA), as used by GBB-IG, is not set up for this IG yet (#10, #109).

## Dependencies

| Package | Version | Purpose |
|---|---|---|
| `nictiz.fhir.nl.r4.nl-core` | 0.12.0-beta.4 | nl-core base profiles |
| `nictiz.fhir.nl.r4.zib2020` | 0.12.0-beta.4 | zib2020 profiles (declared explicitly, because SUSHI does not pull this transitive dependency on its own) |

## Use of AI

How the authors use AI is described in the Authoring note on the Home page of the IG.

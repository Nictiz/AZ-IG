#!/usr/bin/env bash
# Assemble the Conformancelab deployment layout for the Acute Zorg TestScripts.
#
# Conformancelab does not ingest the published IG; it ingests a folder layout of
# <usecase>/<goal>/<role>/ each containing the TestScript(s), a properties.json,
# and (where needed) a _reference/resources folder with the fixtures. This script
# assembles that layout under testscripts/output/ from:
#   - the R5 TestScripts in testscripts/fsh-generated/resources (run `sushi .` here first)
#   - the per-role properties.json templates in testscripts/conformancelab/
#   - the R4 example fixtures from the main IG (run `sushi .` in the repo root first)
#
# NOTE: this is a draft layout, modelled on the Nictiz-testscripts output. The
# exact Conformancelab field semantics (serverAlias, fhirVersion meaning for an
# R5 TestScript over R4 data) should be confirmed with the Conformancelab team.
set -euo pipefail
cd "$(dirname "$0")"

TS=fsh-generated/resources          # R5 TestScripts (this tank)
IG=../fsh-generated/resources       # R4 example fixtures (main IG)
CL=conformancelab/AMB-naar-HAP/Cert
OUT=output/AMB-naar-HAP/Cert

echo "Building R5 TestScripts (sushi)..."
sushi . >/dev/null

rm -rf output
mkdir -p "$OUT/Sending-System" "$OUT/Receiving-System/_reference/resources"

# Sending-System: the sender content-validation TestScript
cp "$TS/TestScript-hg-TestScript-AmbulanceHAP-Sender.json" "$OUT/Sending-System/"
cp "$CL/Sending-System/properties.json" "$OUT/Sending-System/"

# Receiving-System: the receiver acceptance TestScript + the message fixture it sends
cp "$TS/TestScript-hg-TestScript-AmbulanceHAP-Receiver.json" "$OUT/Receiving-System/"
cp "$CL/Receiving-System/properties.json" "$OUT/Receiving-System/"
if [ -f "$IG/Bundle-hg-ReferralBundle-AmbulanceHAP-referral.json" ]; then
  cp "$IG/Bundle-hg-ReferralBundle-AmbulanceHAP-referral.json" "$OUT/Receiving-System/_reference/resources/"
else
  echo "WARN: fixture Bundle not found - run 'sushi .' in the repo root first to generate the R4 examples." >&2
fi

echo "Done. Conformancelab layout assembled under testscripts/$OUT"

#!/usr/bin/env python3
"""
Build the Conformancelab deployment for the Acute Zorg TestScripts.

Adapted from the IKNL PZP build script
(https://github.com/IKNL/PZP-test-en-kwalificatiemateriaal/blob/develop/generate.py):
same idea - run Sushi, then use fsh-generated/data/fsh-index.json to route each
generated TestScript to its role folder and copy the co-located properties.json -
adjusted for this project:

- runs `sushi .` (this tank is FHIR R5, FSHOnly);
- role source folders live under input/fsh/<Role>/ (each with a properties.json);
- fixtures are the R4 example resources from the *main* IG (../fsh-generated),
  not authored in this tank, so referenced fixtures are copied in from there;
- output mirrors the Nictiz-testscripts layout:
      output/<usecase>/<goal>/_reference/resources/   (shared fixtures)
      output/<usecase>/<goal>/<Role>/                 (TestScripts + properties.json)
  and each TestScript's fixture references are rewritten to the copied file.

The IKNL-specific parts (interactive project discovery, date-ruleset replacement,
and the purge/PUT _LoadResources loader) are omitted: this is a single tank, and
the AMB-naar-HAP exchange is a one-directional PUSH, not a seed-then-retrieve flow.

Usage:  python generate.py          (run `sushi .` in the repo root first, so the
                                      R4 example fixtures exist under ../fsh-generated)
"""

import json
import shutil
import subprocess
import sys
from pathlib import Path

TANK = Path(__file__).parent.resolve()
FSH_IN = TANK / "input" / "fsh"
GENERATED = TANK / "fsh-generated" / "resources"
FSH_INDEX = TANK / "fsh-generated" / "data" / "fsh-index.json"
IG_RESOURCES = TANK.parent / "fsh-generated" / "resources"   # main R4 IG output (fixtures)
OUTPUT = TANK / "output"


def run_sushi():
    print("Running Sushi (sushi .) ...")
    result = subprocess.run("sushi .", shell=True, cwd=TANK)
    if result.returncode != 0:
        sys.exit(f"Sushi failed with exit code {result.returncode}")


def discover_roles():
    """Role source folders = subfolders of input/fsh that contain a properties.json."""
    return sorted(d for d in FSH_IN.iterdir()
                  if d.is_dir() and (d / "properties.json").exists())


def testscripts_for_role(role_name, fsh_index):
    """Output filenames of TestScript instances authored in the given role folder."""
    files = []
    for item in fsh_index:
        fsh_file = item.get("fshFile", "").replace("\\", "/")
        output_file = item.get("outputFile", "")
        if (fsh_file == f"{role_name}" or fsh_file.startswith(f"{role_name}/")) \
                and output_file.startswith("TestScript-"):
            files.append(output_file)
    return files


def copy_fixture(reference, dest_resources):
    """Copy an R4 fixture (e.g. 'Bundle/hg-...-referral') from the main IG output.
    Returns the deployed file name, or None if the source is not found."""
    file_name = reference.replace("/", "-") + ".json"
    src = IG_RESOURCES / file_name
    if not src.exists():
        print(f"    WARN: fixture not found in main IG output: {src.name} "
              f"(run `sushi .` in the repo root first)", file=sys.stderr)
        return None
    dest_resources.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest_resources / file_name)
    return file_name


def process_testscript(ts_path, role_dir, ref_resources):
    """Copy a TestScript to its role folder, pulling in and re-pointing its fixtures."""
    ts = json.loads(ts_path.read_text(encoding="utf-8"))
    for fx in ts.get("fixture", []):
        ref = fx.get("resource", {}).get("reference")
        if ref and "/" in ref and not ref.startswith("http"):
            deployed = copy_fixture(ref, ref_resources)
            if deployed:
                fx["resource"]["reference"] = f"../_reference/resources/{deployed}"
    (role_dir / ts_path.name).write_text(
        json.dumps(ts, indent=2, ensure_ascii=False), encoding="utf-8")


def main():
    run_sushi()

    if not FSH_INDEX.exists():
        sys.exit(f"fsh-index not found: {FSH_INDEX}")
    fsh_index = json.loads(FSH_INDEX.read_text(encoding="utf-8"))

    roles = discover_roles()
    if not roles:
        sys.exit("No role folders (input/fsh/<Role>/properties.json) found.")

    if OUTPUT.exists():
        shutil.rmtree(OUTPUT)

    total_ts = 0
    for role in roles:
        props = json.loads((role / "properties.json").read_text(encoding="utf-8"))
        usecase = props.get("usecase", "usecase")
        goal = props.get("goal", "Test")
        goal_dir = OUTPUT / usecase / goal
        role_dir = goal_dir / role.name
        ref_resources = goal_dir / "_reference" / "resources"
        role_dir.mkdir(parents=True, exist_ok=True)

        names = testscripts_for_role(role.name, fsh_index)
        for name in names:
            src = GENERATED / name
            if src.exists():
                process_testscript(src, role_dir, ref_resources)
                total_ts += 1
                print(f"  {role.name}: {name}")
        shutil.copy2(role / "properties.json", role_dir / "properties.json")

    print(f"\nDone. {total_ts} TestScript(s) assembled under {OUTPUT.relative_to(TANK.parent)}")


if __name__ == "__main__":
    main()

# Task 1 Report: Local SAR profile validator

## Scope

Implemented Task 1 only:

- `_scripts/verify_sar_profiles.rb`
- `_scripts/test/verify_sar_profiles_test.rb`

No changes were made under `_data`, `_includes`, `ota`, `ota-partner`, or Postman assets.

## Changed files

### `_scripts/verify_sar_profiles.rb`

- Added a standalone Ruby validator invoked as `ruby _scripts/verify_sar_profiles.rb _site`.
- Validates both required entry pages:
  - `_site/ota/OTA_API_SAR.html`
  - `_site/ota-partner/OTA_API_SAR.html`
- Traverses reachable local HTML links, images, downloads, and anchors.
- Reads normal SAR hosts from `_data/sar_profiles.yml` when present and blocks those hosts from partner output.
- Scans partner HTML for populated credential-like fields and JWT-shaped tokens.
- Scans partner-linked JSON downloads for populated sensitive Postman variables while allowing placeholders such as `{{apiUrl}}`.
- Reports findings in `category relative/path:line` format only.

### `_scripts/test/verify_sar_profiles_test.rb`

- Added Minitest coverage for:
  - safe output
  - partner host leakage
  - partner credential leakage
  - partner JWT leakage
  - partner cross-tree links into `/docs/ota/`
  - missing assets
  - missing anchors
  - unresolved Liquid expressions
  - populated partner Postman variables
  - allowed literal Postman placeholders

## Test-first evidence

Initial red run before implementation:

```text
Run options: --seed 5405

# Running:

FFFFFFF

Finished in 0.655882s, 10.6727 runs/s, 32.0180 assertions/s.

7 runs, 21 assertions, 7 failures, 0 errors, 0 skips
```

The first failure was the expected missing script error:

```text
ruby: No such file or directory -- .../_scripts/verify_sar_profiles.rb (LoadError)
```

## Verification commands

Focused suite:

```bash
ruby /Users/sittiwetmahapratoom/Workspace/go7-ai/worktrees/ST-1807/wt/docs/_scripts/test/verify_sar_profiles_test.rb
```

Green completion run:

```text
Run options: --seed 3670

# Running:

.......

Finished in 0.922155s, 7.5909 runs/s, 34.7013 assertions/s.

7 runs, 32 assertions, 0 failures, 0 errors, 0 skips
```

Relevant full suite:

- No broader Ruby test suite exists in this docs worktree beyond the new focused test file.

## Design decisions

- Used only Ruby standard library components (`json`, `yaml`, `uri`, `pathname`, `set`) so the validator stays runnable in the existing docs environment without adding gem dependencies.
- Implemented a lightweight HTML reference scanner with regex-based attribute and anchor extraction because the validator only needs deterministic local traversal and leak detection, not full DOM mutation.
- Limited host leakage rules to hosts derived from the normal `sar` profile values when `_data/sar_profiles.yml` is present, matching the plan’s task boundary and avoiding hard-coded production data in the validator.
- Reported missing files and anchors against the resolved target file path so failures point at the broken output artifact rather than the referring page.
- Kept partner Postman validation value-aware:
  - placeholders like `{{apiUrl}}` and `{base_url}/...` are allowed
  - blank sensitive values are allowed
  - populated sensitive values are rejected

## Self-review notes

- Output does not print leaked values, credentials, or tokens.
- The validator is scoped to reachable files from the two entry pages, which matches the navigation-based verification requirement in the design.
- JSON partner-download scanning is currently triggered for partner-linked `.json` files; if future partner-sensitive downloads use other formats, the validator will need a small extension in a later task.

## Concerns

- No blocking concerns within Task 1 scope.
- The validator intentionally depends on the future wrapper/profile/link structure from later tasks. It is ready for that integration but cannot prove production docs correctness until those tasks generate the real `_site` tree.

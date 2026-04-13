## Why

The `product_manager/scripts/` directory is a legacy shell-based workflow that no longer matches the current `product_manager` skill architecture. Keeping it in the active skill tree creates confusion because the live nodes and documentation now center on `_manage`, `Memory.json`, and relative output paths, while the scripts still assume `/AIPM`, `Memory.md`, and an outdated output layout.

## What Changes

- Move `product_manager/scripts/` out of the active skill surface into an archive location that clearly marks it as legacy material.
- Update `product_manager` documentation to stop presenting the scripts as part of the current directory structure.
- Add explicit archive guidance so maintainers understand the scripts are retained only for historical reference and are not part of the supported workflow.
- Align node and skill documentation around the current `Memory.json` and `_manage` model where legacy script-era wording still causes confusion.

## Capabilities

### New Capabilities
- `legacy-script-archival`: Define how legacy workflow scripts are archived, how the active skill surface excludes them, and how maintainers are directed toward the supported workflow.

### Modified Capabilities

## Impact

- Affected code and docs: `product_manager/scripts/`, `product_manager/README.md`, `product_manager/nodes/README.md`, and any nearby skill documentation that still implies the scripts are active.
- No runtime API changes are intended.
- Main risk area is maintainers who may still use the scripts manually; the change should preserve discoverability through an archive location and explicit documentation.

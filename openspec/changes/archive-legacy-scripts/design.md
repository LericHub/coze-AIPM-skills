## Context

The repository currently contains two overlapping mental models for the `product_manager` skill.

The active model is documented in `SKILL.md` and the node files: it uses `_manage` as the coordination layer, stores state in `Memory.json`, and writes outputs under relative `./output/V{version}/...` paths.

The legacy model survives in `product_manager/scripts/`, where shell helpers still assume `/AIPM` as a root, use `Memory.md`, and generate an older directory layout. Recent cleanup work already downgraded these scripts to deprecated status, and repo exploration shows no active node file or skill manifest that invokes them. Their main remaining effect is cognitive: they suggest a supported execution path that does not match the current workflow.

## Goals / Non-Goals

**Goals:**
- Remove legacy scripts from the active `product_manager` surface without losing historical traceability.
- Make the current workflow easier to understand by eliminating mixed signals between docs and filesystem layout.
- Preserve enough archive context that future maintainers can inspect the old scripts if they need historical reference.
- Clean up obviously conflicting documentation terms around script-era concepts where they directly mislead the current workflow.

**Non-Goals:**
- Rebuild the old shell workflow on top of the current architecture.
- Add executable replacements for the archived scripts.
- Rewrite the full `product_manager` documentation set beyond the parts needed to clarify archival.
- Remove archived OpenSpec history that mentions the scripts.

## Decisions

### D1: Archive instead of immediate deletion
**Decision:** Move `product_manager/scripts/` into a clearly named archive location rather than deleting the files outright in this change.

**Rationale:** Repository evidence suggests the scripts are inactive, but external manual usage cannot be ruled out from static analysis alone. Archiving preserves history and gives maintainers a fallback reference while still removing the scripts from the active path.

**Alternatives considered:**
- Delete the scripts entirely: simplest end state, but higher risk if someone still uses them manually.
- Leave them in place with stronger warnings: lowest operational risk, but continues the present ambiguity and clutter.

### D2: Make the active surface reflect the current workflow only
**Decision:** Update the `product_manager` docs so the active directory structure and workflow descriptions no longer list `scripts/` as part of the current skill shape.

**Rationale:** Archiving only solves half the problem. If the docs still mention `scripts/`, the archive change will remain conceptually incomplete and future readers may still look for a supported script-based path.

**Alternatives considered:**
- Add a note pointing from active docs to the archive only: helpful, but still keeps outdated structure visible in the main workflow description.
- Avoid doc changes: faster, but leaves documentation drift behind.

### D3: Correct the most misleading legacy terminology in nearby docs
**Decision:** Update directly affected docs that still mix in `Memory.md` or similar legacy workflow terms when those terms conflict with the current `Memory.json`-based model.

**Rationale:** Once the scripts are archived, lingering script-era terminology becomes more obviously wrong. Tightening the most visible mismatches reduces confusion without requiring a large-scale doc rewrite.

**Alternatives considered:**
- Leave all wording as-is for a later cleanup: lower scope now, but weakens the value of the archive change.
- Perform a full documentation sweep: more complete, but larger than needed for this focused cleanup.

## Risks / Trade-offs

- [Risk] A maintainer may still run these scripts manually from the current path.
  - Mitigation: Archive rather than delete, and document the new archive location.
- [Risk] Archive placement could be inconsistent with the repo's existing conventions.
  - Mitigation: Choose an archive path under `product_manager/` that is self-explanatory and easy to discover during future maintenance.
- [Risk] Partial doc cleanup may leave some older terminology elsewhere in the repo.
  - Mitigation: Focus this change on directly adjacent `product_manager` docs and treat deeper cleanup as follow-on work if needed.
- [Risk] Readers may confuse archived scripts with supported fallback tooling.
  - Mitigation: Add explicit language that the archived scripts are historical reference only and not part of the supported workflow.

## Migration Plan

1. Move the legacy scripts from `product_manager/scripts/` to the chosen archive location.
2. Update `product_manager` documentation to remove the scripts from the active structure and reference the archive as historical-only material.
3. Correct nearby legacy wording that conflicts with the current workflow model.
4. Verify there are no remaining active references to the old script path inside the live `product_manager` skill docs.

Rollback is straightforward: move the archived scripts back to `product_manager/scripts/` and restore the prior documentation references.

## Open Questions

- What archive path name best fits the repository's conventions, for example `product_manager/archive/scripts/` versus `product_manager/legacy/scripts/`?
- Should this change also add a short archive README beside the moved scripts, or is a note in the main docs sufficient?

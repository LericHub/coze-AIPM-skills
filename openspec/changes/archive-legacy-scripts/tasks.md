## 1. Archive legacy scripts

- [x] 1.1 Choose and create the archive location for the `product_manager` legacy scripts
- [x] 1.2 Move all files from `product_manager/scripts/` into the archive location without changing their contents
- [x] 1.3 Add archive-facing guidance that marks the moved scripts as historical reference only

## 2. Align active documentation

- [x] 2.1 Update `product_manager/README.md` so the active directory structure and workflow no longer present `scripts/` as part of the live skill
- [x] 2.2 Update `product_manager/nodes/README.md` to remove conflicting script-era terminology such as `Memory.md` where it describes the active workflow
- [x] 2.3 Review adjacent `product_manager` docs touched by the archive change and correct any directly conflicting references to the old script-based model

## 3. Verify the archived state

- [x] 3.1 Confirm the active `product_manager/nodes` and `SKILL.md` surfaces do not reference the old script path after the move
- [x] 3.2 Confirm the archived scripts remain discoverable for historical reference
- [x] 3.3 Run an OpenSpec status check to ensure the change remains apply-ready with all artifacts in place

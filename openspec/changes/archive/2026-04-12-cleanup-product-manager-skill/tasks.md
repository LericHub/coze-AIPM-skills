## 1. Update SKILL.md References

- [x] 1.1 Change STATE_RULES.md reference to nodes/_manage.md (lines 45, 163, 266)
- [x] 1.2 Verify all references point to existing files:
  - references/loreal_mock_database.md exists
  - references/other files do not exist (remove from index)
- [x] 1.3 Update scripts/ note to indicate deprecated

## 2. Fix Node References in SKILL.md

- [x] 2.1 Update line 180-188: node file references match actual files
- [x] 2.2 Update line 242-253: node mapping table matches actual files

Current mapping:
| SKILL.md | Actual |
|---------|-------|
| 06-init.md | 06-prototyping.md |
| 07-prototyping.md | 07-writing.md |
| 08-writing.md | 08-change.md |
| 09-change.md | (doesn't exist) |

## 3. Simplify Duplicate Content

- [x] 3.1 Keep forced actions section only once (remove 2 duplicates)
- [x] 3.2 Keep version notes only once

## 4. Delete STATE_RULES.md

- [x] 4.1 Delete product_manager/STATE_RULES.md
- [x] 4.2 Verify no remaining references
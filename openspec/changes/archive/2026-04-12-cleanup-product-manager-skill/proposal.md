## Why

The product_manager SKILL.md file has accumulated technical debt:
1. References STATE_RULES.md which was just merged into _manage.md
2. References non-existent directories (references/, scripts/)
3. Node file references don't match actual file names
4. Duplicate content (forced actions 0-4 appear 3 times)

This cleanup will consolidate scattered references and fix outdated links.

## What Changes

1. Delete STATE_RULES.md (content merged to _manage.md)
2. Update SKILL.md: change STATE_RULES.md references to nodes/_manage.md
3. Update SKILL.md: clean up references/ section (only保留存在的文件)
4. Update SKILL.md: fix node naming (01-router, 02-brainstorm, etc. → actual names)
5. Simplify SKILL.md: merge duplicate forced actions sections
6. Add comment noting scripts/ are deprecated

## Capabilities

### New Capabilities
(None - this is cleanup, no new features)

### Modified Capabilities
(None - no requirement changes)

## Impact

Files affected:
- product_manager/SKILL.md
- product_manager/STATE_RULES.md (to be deleted)
- product_manager/nodes/_manage.md (receives confirmation mechanism)
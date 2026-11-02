---
name: doc-sweep
description: Sync documentation after completing work. Update changed logic, register new files, enforce ownership.
disable-model-invocation: true
---

# /doc-sweep

## Process

1. Read `docs/ARCH_governance.md` for ownership mapping
2. Identify all files changed in this session
3. For each changed concern, find the owning doc via registry
4. Update owning doc with accurate description of changes
5. Register any new files in governance registry
6. Delete duplicate rules found across docs
7. Move misplaced rules to correct owner
8. Flag STUBBORN_FACTs found during sweep

## Rules

- **One file = one concern.** If a rule exists in two places, delete the wrong one.
- **Code is truth for behavior.** Docs are truth for intent.
  - Code does X but doc says Y → doc is stale (fix doc) OR code is buggy (fix code)
- **Don't document the obvious.** `src/auth.py exists` belongs nowhere.
- **Do document:** gotchas, STUBBORN_FACTs, architectural decisions, domain rules.

## Output

```
## Doc sweep report

### Updated
- docs/GUIDE_workflow.md — added PR review step

### Created
- docs/LOGIC_billing.md — registered in governance.md

### Removed
- docs/notes.md — content migrated to LOGIC_billing.md

### STUBBORN_FACTs flagged
- config.py:87 — timeout of 30s is intentional
```

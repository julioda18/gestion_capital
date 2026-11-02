# GUIDE_workflow.md — Agent Workflow Guide

## Standard sequence

```
1. READ context (AGENTS.md, RULES.md, docs/)
2. EXPLORE (read relevant files, trace flows)
3. PLAN (or GRILL if ambiguous)
4. CODE (implement with verify loop)
5. VERIFY (tests, typecheck, lint)
6. DOC SWEEP (on human instruction: update docs)
7. COMMIT (one concern per commit)
8. REPORT (DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT)
```

## Small fix (skip planning)

```
1. Read error/file
2. Fix + verify
3. Report
```

## Multi-file change

```
1. Read all affected files
2. State plan: "I'm going to: [list changes]"
3. Implement each change
4. Verify all tests pass
5. Report with status
```

## Large feature

```
1. Read AGENTS.md, RULES.md, docs/, relevant source
2. Write spec (or use /grill-me)
3. Get human approval
4. Break into tickets / vertical slices
5. Implement slice by slice with TDD
6. Code review each slice
7. Verify integration
8. Doc sweep
9. Commit
```

## Error-driven workflow

```
Error reported → read doc_errores.md or docs/INCIDENT_*.md
  → check if same error exists
    → YES: apply known fix, verify
    → NO: reproduce → diagnose → fix → write regression test
      → append to error doc
      → skillify if repeat pattern
```

## Doc sweep (on instruction)

1. Read `docs/ARCH_governance.md` to understand ownership
2. Sync changed logic to owning doc files
3. Register new files in governance registry
4. Delete duplicates
5. Move misplaced rules to correct owner
6. Flag STUBBORN_FACTs found during sweep

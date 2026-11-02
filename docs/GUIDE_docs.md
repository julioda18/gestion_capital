# GUIDE_docs.md — Living Docs Workflow

## Principles

1. **Docs are code.** Same commit, same review, same standards.
2. **One file = one concern.** No duplication. If a rule exists in two places, delete one.
3. **Read before acting.** Agent reads docs before touching code.
4. **Update after, on instruction.** Human confirms correctness first, then instructs doc sweep.
5. **Registry governs.** `docs/ARCH_governance.md` maps which file owns what and when to load it.

## Doc sweep protocol

On instruction "run a doc sweep":

1. Read `docs/ARCH_governance.md` for ownership mapping
2. Identify files changed this session
3. For each changed concern, update the owning doc
4. Register any new files in governance registry
5. Delete duplicate rules
6. Move misplaced rules to correct owner
7. Flag STUBBORN_FACTs found during sweep
8. Report what was updated

## Naming conventions

| Prefix | Purpose | Example |
|---|---|---|
| `ARCH_` | Architecture, decisions, governance | `ARCH_governance.md` |
| `GUIDE_` | Workflow guides, how-tos | `GUIDE_workflow.md` |
| `STANDARDS_` | Coding standards, conventions | `STANDARDS_prompting.md` |
| `LOGIC_` | Feature-specific behavior | `LOGIC_billing.md` |
| `REF_` | Reference, indices | `REF_developer-reference.md` |
| `INCIDENT_` | Post-mortems, regression logs | `INCIDENT_db-timeout.md` |
| `REFACTOR_TODO_` | Technical debt tracker | `REFACTOR_TODO_.md` |

## STUBBORN_FACT

```
> STUBBORN_FACT: [what it is] — [why it must stay this way]
```

Agent never "fixes" these. They mark intentional quirks.

## Cross-project memory

Global LLM Wiki repo holds institutional knowledge across projects:
- Each project's `AGENTS.md` references global wiki via relative path
- Local docs override global on conflict
- Shared conventions stored once, not duplicated per repo

## What the agent does automatically

| Trigger | Action |
|---|---|
| Logic appears 2+ times | Flag → extract into named function |
| Function > 20 lines | Warn → extract inner logic |
| Expression needs comment to understand | Extract into named function |
| Function reused across 2+ files | Move to shared helper |
| File > 200 lines | Warn → review for split |
| File > 400 lines | Split mandatory |
| File has 2+ unrelated concerns | Split regardless of line count |

## When agent stops and asks

- Task scope wider than described
- Task contradicts a rule in docs/ or STUBBORN_FACT
- Task requires deleting/overwriting existing content
- Task is ambiguous with 2+ valid interpretations
- Code has no test coverage and task requires TDD

One question. The most blocking unknown.

## Zero-loss refactor protocol

1. **Audit** — read existing code fully before touching
2. **Create targets** — new structure in place before removing old
3. **Bridge** — re-exports/adapters connect old to new (never skip)
4. **Verify** — typecheck + tests pass
5. **Cut** — remove old code only after behavior confirmed stable
6. **Verify again** — full suite after cleanup

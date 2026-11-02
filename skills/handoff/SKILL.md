---
name: handoff
description: Compact the current session into a handoff document so another agent session can continue the work.
disable-model-invocation: true
---

# /handoff

## Process

1. Review full session context
2. Extract: what was done, what remains, key decisions, gotchas
3. Write handoff document to `docs/HANDOFF_latest.md`

## Output format

```markdown
# Handoff: [project/feature] — [date]

## Session summary
[What was accomplished this session]

## Current state
- Files changed: [...]
- Branch: [...]
- Uncommitted: [yes/no — what]

## Remaining work
- [ ] [Task 1]
- [ ] [Task 2]

## Key decisions
- [Decision] — [rationale]

## Gotchas / STUBBORN_FACTs
- [Gotcha 1]
- [Gotcha 2]

## Next action for agent
[The first thing the next session should do]

## Commands
- Run tests: `[command]`
- Typecheck: `[command]`
- Start server: `[command]`
```

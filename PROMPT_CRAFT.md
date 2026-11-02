# PROMPT_CRAFT.md — Prompt Engineering Methodology

## 1. Anatomy of an effective prompt

```
[CONTEXT]    → What is the situation? What files matter?
[CONSTRAINT] → What must/should not happen?
[ACTION]     → What exactly to do?
[FORMAT]     → How to structure the answer?
[EVIDENCE]   → How to verify correctness?
```

Not every prompt needs all 5. But missing CONTEXT or EVIDENCE is the most common failure.

## 2. Context injection patterns

- **Reference, don't describe:** `@src/auth/login.py` over "look at the auth module"
- **Pipe errors:** `cat error.log | <agent>` over pasting
- **Exact paths:** File:line references always
- **Diff-based context:** `git diff main...HEAD` to describe current state
- **Max 3 relevant files** per prompt unless multi-file change requires more
- **Session seeding:** Start a new session with `"Review recent changes"` → agent runs `git log`, loads context instantly

## 3. The grill-first principle

Before any non-trivial task, grill (use `/grill-me` skill):
- What are we building?
- What does success look like?
- What edge cases exist?
- What shouldn't change?
- What existing code/patterns should we follow?

This catches misalignment before tokens are spent on code.

## 4. Domain language (CONTEXT.md)

A shared language document reduces verbosity by ~40%:
- Defines project-specific jargon
- Names modules and their responsibilities
- Documents architectural decisions (ADRs)
- Updated by the agent after each session (on explicit instruction)

Without shared language, the agent uses 20 words where 1 will do.

## 5. Verification hooks

Always include in prompts:
- ✅ `"Run the tests after"`
- ✅ `"Typecheck before claiming done"`
- ✅ `"Verify the output with this command: ..."`
- ✅ `"Update error log if anything fails"`

Without verification, output is a guess.

## 6. Chain of delegation

```
User prompt → AGENTS.md (standing contract)
  → RULES.md (coding standards)
    → docs/ARCH_governance.md (which docs to load)
      → docs/*.md (domain/architecture context)
        → CONTEXT.md (shared language)
          → skills/ (composable workflows)
```

Each layer adds precision. Each layer is optional — load only what the task needs.

## 7. Personal rules file (private layer)

Create `AGENTS.local.md` (gitignored) for personal habits:
- PR feedback that keeps repeating
- Personal anti-patterns to correct
- Machine-specific tool paths

```markdown
# AGENTS.local.md — Personal rules (never commit)

# From PR feedback
- Always include auth-failure test case for new endpoints
- Update OpenAPI spec when adding endpoints

# Personal habits to correct
- Don't use console.log; use the project logger
```

Prune after a few weeks. Anything muscle memory can go. Keep what's still in flux.

## 8. Anti-patterns to avoid

| Anti-pattern | Fix |
|---|---|
| Vague context ("fix the auth bug") | Paste exact error + file:line |
| All-in-one prompt | Break into plan → implement → verify |
| Asking permission for routine work | State what you want done |
| Multiple unconnected requests | One prompt = one task |
| "Be careful" | Specific rules in AGENTS.md |
| Over-explaining | Micro-diffs + zero-why |
| Approving bad code then doc sweep | Verify correctness first, then update docs |

## 9. Prompt templates by task type

### Bug fix
```
Error: [paste traceback]
Files: [relevant paths]
Expected: [what should happen]
Actual: [what happens]
Verify: [command to confirm fix]
```

### Feature
```
Goal: [one sentence]
Context: [relevant files + patterns]
Constraints: [what not to touch]
Success: [how to verify]
```

### Code review
```
Review diff: [branch/range]
Focus: [security | correctness | performance | style]
Format: [file:line → issue → suggestion]
```

### Refactor
```
Files: [paths]
Goal: [what to improve]
Constraints: [preserve API, tests must pass]
Protocol: [audit → create → bridge → verify → cut → verify]
```

### Doc sweep
```
Run a doc sweep:
- Sync changed logic to relevant docs/*.md
- Register new files in ARCH_governance.md
- Flag any STUBBORN_FACTs you find
- Enforce ownership: one rule = one file
```

### Self-correction
```
You made a mistake: [describe it]
Update AGENTS.md so you don't repeat this.
```

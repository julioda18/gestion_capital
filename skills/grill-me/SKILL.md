---
name: grill-me
description: Interview the user relentlessly about a plan or design before any code is written. Use when the task is ambiguous or multi-file.
disable-model-invocation: true
---

# /grill-me

> ⚠️ CRITICAL PROHIBITION: DO NOT EDIT, CREATE, OR DELETE ANY CODE. DO NOT RUN COMMANDS TO FIX ISSUES.
> YOUR ONLY JOB IS TO ASK QUESTIONS AND GENERATE TEXT. IF YOU EDIT ANY PROJECT FILE, YOU HAVE FAILED THIS INSTRUCTION.

## Process

Interview the user about:
- **Goal:** What exactly should this achieve? What is the measurable outcome?
- **Scope:** What files/modules will we touch? What is explicitly out of scope?
- **Existing patterns:** Are there similar features we should mirror?
- **Edge cases:** What happens with empty states, errors, concurrent access?
- **Verification:** How do we confirm it works?

## Rules

- Ask ONE question at a time. Wait for answer before next.
- Do NOT proceed to implementation until user says "go" or "proceed".
- If user answers vaguely, drill deeper. "Can you be more specific?"
- Capture key decisions made during grilling.
- End with a summary of what will be built and how it will be verified.

## Output

After grilling, output:
```
## Plan
- Files to change: [...]
- Approach: [...]
- Key decisions: [...]
- Verification: [...]
```

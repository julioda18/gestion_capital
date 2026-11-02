---
name: diagnose
description: Disciplined debugging loop for hard bugs. Checks doc_errores.md first via /fix-known. Reproduce → minimize → hypothesize → instrument → fix → regression test.
---

# /diagnose

## Process

### 0. Check known errors first
- Run `/fix-known` with the error keywords
- If match in `doc_errores.md` → apply documented solution directly, STOP here
- If no match → continue with steps below

- Get a reliable reproduction case. No repro, no fix.
- Document: input, expected output, actual output, environment.

### 2. Minimize
- Strip away everything not related to the bug.
- Find the minimal input / code path that triggers it.
- The trigger is already evidence.

### 3. Hypothesize
- State the root cause hypothesis in one sentence.
- "I think X causes Y because Z."
- If you can't state the hypothesis, you don't understand the bug.

### 4. Instrument
- Add logging / assertions / print to confirm the hypothesis.
- NOT a fix — just confirmation or refutation.
- Run with minimal reproduction case.

### 5. Fix
- Apply the smallest correct fix. Not a workaround.
- One guard in the shared function is smaller than one per caller.
- Fix the root cause, not the symptom.

### 6. Regression test
- Write a test that would have caught this bug.
- Test passes → bug is fixed.
- Test with edge case variations.

## Output

```
## Diagnosis
- fix-known: [MATCH → applied / NO MATCH → full analysis]
- Reproduction: [minimal case]
- Root cause: [one sentence]
- Fix: [file:line — what changed]
- Regression test: [test name]
- doc_errores.md: [updated with new entry if new error]
```

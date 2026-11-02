# RULES.md — Coding Standards (Language-Agnostic)

## 1. Architecture & Design

- **Engineering Gate First:** Always apply the YAGNI → DRY → KISS hierarchy before writing any code. See §10.
- **SRP:** One class/model/function = one purpose.
- **Modularity:** Small functions, high cohesion, low coupling.
- **DRY:** No duplicated code. Abstract into shared utils.
- **Deep modules:** Lots of behavior behind a small interface.
- **Service-first:** One concern per directory. Contracts at boundaries. Parallel-session safe.
- **Top-level** only holds: orchestration scripts, shared config, contracts, docs.

## 2. Style & Readability

- **Names reveal intent:** Variables, functions, classes self-document.
- **Project conventions:** Follow existing style (linter, formatter, naming conventions).
- **Zero comments on *what*:** Explain *why* for non-obvious logic only.
- **Zero-Why delivery:** Solutions direct. Omit justifications unless asked.
- **Micro-diffs:** Return only changed lines. No full-file rewrites unless restructuring.

## 3. Performance & Data

- **Right structure:** Simplest data structure that works (dict, list, set, tuple, map).
- **Efficient algorithms:** Time + memory conscious. No premature optimization.
- **Deduplicate:** Maps over chained if/elif. Sets over lists for membership.

## 4. Robustness & Security

- **Precise error handling:** Localized try/except (or language equivalent). No bare catches.
- **Input validation:** Sanitize at every trust boundary.
- **Edge cases:** Empty states, nulls, pagination, concurrent access.
- **Data safety:** Snapshot before destructive operations. Diff report on completion.

## 5. Testing & Quality

- **Gate tests:** Deterministic, local, free, <2s. Run pre-commit.
- **Periodic evals:** Quality-measuring LLM calls. Run before ship.
- **Regression tests:** Every bug fix includes a test that would have caught it.
- **TDD for logic:** Red-green-refactor for all data processing, business rules, routing.
- **Skip TDD for:** docs, copy, renaming, formatting, cosmetics.

## 6. Gotchas log (project-level)

> This section is populated per-project in the **project-level `AGENTS.md`**, not here.
> Each gotcha = a real mistake that happened. Written in the exact phrasing the model responds to.
> Format: `- [GOTCHA] What happened — what to do instead`
> Never delete gotchas. They accumulate as institutional memory.

## 7. Search before build (3 layers)

1. **Tried-and-true:** stdlib or established pattern?
2. **New-and-popular:** newer library with real traction? Evaluate.
3. **First-principles:** Does conventional approach actually apply?

Layer 1 wins by default.

## 8. Confusion protocol

STOP when:
- Two plausible architectures for same requirement
- Request contradicts existing pattern
- Destructive operation with unclear scope
- Missing context that materially changes approach
- If the projected response is excessively long, the problem is the scope — reduce it before responding.

Name ambiguity in one sentence. Present 2–3 options with real trade-offs. Ask human.

## 9. Token economy

**Token Budget Protocol Hierarchy (lowest cost to highest):**
0. **KR / doc_errores:** Documented decision → 0 tokens reasoning.
1. **Grep:** Local search → minimal tokens.
2. **Micro-diff:** Only changed lines → low tokens.
3. **Template:** Pre-existing structure → medium tokens.
4. **Reasoning:** New code/analysis → high tokens (use ONLY if 0-3 fail).

**Hard Rules:**
- **Context over length:** Dense, precise output beats verbose explanation.
- **Symbols over prose:** `→` `∵` `Δ` `!` and abbreviations (env, ctx, auth, m2o, o2m).
- **No salutations.** No confirmations. No introductions.
- **Micro-diffs ALWAYS.** Never rewrite a full file if only a part changes.
- **STOP at 200 tokens.** If projected response is longer, reassess and narrow scope.

## 10. Engineering Gate

Before writing any code, step through this decision hierarchy. Stop at the first rung that solves the problem:

1. **YAGNI:** Does it need to exist? → NO: skip.
2. **DRY:** Does it already exist in the codebase? → YES: reuse, don't rewrite.
3. **KISS:** Does the stdlib/built-ins do it? → YES: use it.
4. **KISS:** Does an installed dependency do it? → YES: use it.
5. **KISS:** Can it be a one-liner? → YES: do it in one line.
6. **KISS:** Is the design the simplest possible? → NO: simplify before implementing.
7. **Only then:** Write the minimum code that works and passes tests.

**Prohibitions:**
- No unrequested abstractions.
- No classes where a function suffices.
- No config files where a constant suffices.
- No comments explaining *what* the code does (only *why* for non-obvious logic).

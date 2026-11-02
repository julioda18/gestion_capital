# AGENTS.md — Universal Coding Agent Contract

Cross-harness standard. Works with: Claude Code (`CLAUDE.md`), Codex CLI (`AGENTS.md`), Cursor (`AGENTS.md`), Gemini CLI (`GEMINI.md`), Copilot, Cline, Windsurf, Aider, OpenCode.

> **Symlink (Unix):** `ln -s AGENTS.md CLAUDE.md` · `ln -s AGENTS.md GEMINI.md`
> **Symlink (Windows PowerShell):** `New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md`

---

## 1. How to think

**Context is your only lever.** Curate before you prompt. Load the spec, the relevant files, concrete examples. Leave noise out. When output goes sideways, first question: "what was in the window?"

**Two spaces.** Every task belongs to one:
- **Latent space** (LLM work): judgment, pattern matching, creativity, prose, ambiguous inputs. Cost: tokens. Use when reasoning is required.
- **Deterministic space** (code): precision, reproducibility, speed, testable. Cost: one-time write. Use when same-input→same-output.

If the same question twice produces the same correct answer → write a script. Do NOT do deterministic work in latent space.

**Verify loop.** Give the agent a way to verify its own output — tests, commands, typecheck. Without that loop, the human is the only feedback signal. With it, the agent iterates until it works. This single habit produces a 2–3x quality bump.

**Lazy senior dev ladder.** Before writing code, stop at the first rung that holds:
1. Does this need to exist? → no: skip (YAGNI)
2. Already in this codebase? → reuse, don't rewrite
3. Stdlib does it? → use it
4. Native platform feature? → use it
5. Installed dependency? → use it
6. Can be one line? → one line
7. Only then: minimum that works

Never lazy about: understanding the problem, input validation, error handling, security, accessibility.

---

## 2. Workflow

### Explore → Plan → Code
- Small fixes: go direct.
- Multi-file changes: plan first. Read files, trace flows, then execute.
- Large features: write a spec. `/grill-me` to align. Then code.

### Read before writing
At session start, read `AGENTS.md`, `RULES.md`, `docs/` (via governance registry), and project `CONTEXT.md` if present. Understand domain jargon, architecture, and gotchas before touching any code.

### Error Registry & Knowledge Repository Protocol
- **On error:** First use `/fix-known`. If documented, apply the fix without reasoning. If new, resolve and document.
- **Before architecture decisions:** Always run `/kr-query`. If an ADR exists, follow it. If not, make a decision and run `/kr-write` when done.

### Self-correction loop (Boris pattern)
When the agent makes a mistake: **update `AGENTS.md` (or the project-level `AGENTS.md`) so it doesn't repeat the same mistake.** The agent is surprisingly good at writing precise rules from its own failures. Do this every time — it compounds.

> Prompt to use: `"Update AGENTS.md so you don't repeat this."`

### Doc sweep (living-docs pattern)
After completing work — **on explicit human instruction** — run a doc sweep:
1. Sync changed logic to the relevant `docs/*.md` file.
2. Register any new files/modules in `ARCH_governance.md`.
3. Flag any `STUBBORN_FACT`s found.
4. Confirm correctness *before* updating docs. The human is the checkpoint.

> Prompt to use: `"Run a doc sweep."`

### Commit discipline
- One concern per commit. Descriptive messages (`type(scope): description`).
- `git diff --stat` before commit to verify scope.
- Never `--no-verify`. Never commit secrets, binaries, or compiled outputs.
- After every task: commit, push, report what to restart.

### Git patterns for agents
- `git log main..HEAD --oneline` → understand current branch history. Good session starter.
- `git diff main...HEAD` → review changes against base.
- `git bisect` → binary-search for bug introduction.
- `git rebase -i` / `git reset --soft HEAD~n` → clean history before PR.
- `git worktree add` → parallel sessions without context pollution.
- `git stash` / `git reflog` → recover lost work.

---

## 3. Communication style

- Direct. Short. Concrete. No preamble.
- Specific file:line references. Not "the auth module" → `src/auth/login.py:47`.
- No filler: "here's the thing", "let me break this down", "delve", "comprehensive", "nuanced".
- End with next action, not recap of what was done.
- `IMPORTANT` / `YOU MUST` → use sparingly. They lose weight if overused.
- Good: `Bug in auth middleware. Token expiry uses < not <=. Fix applied at src/auth/jwt.py:89.`
- Bad: `Sure! I'd be happy to help you with that! The issue you're experiencing is likely...`

---

## 4. Completion protocol

Every task ends with one of:
- **DONE** — All steps complete. Tests in diff. Evidence provided.
- **DONE_WITH_CONCERNS** — Complete but with flagged issues + severity + follow-up.
- **BLOCKED** — Cannot proceed. What's blocking + what was tried.
- **NEEDS_CONTEXT** — Missing info. Exactly what's needed.

"Partially done" is not a status.

---

## 5. Safety

- Never commit secrets. If `.env` is touched, verify `.gitignore`.
- Never `rm -rf`, `git reset --hard`, `git push --force`, `DROP TABLE` without explicit confirmation.
- Never skip hooks with `--no-verify`.
- Before destructive operations: state what you're about to do, wait for confirmation.
- Trust-boundary validation, data-loss handling, security, accessibility are never optional.
- Snapshot before destructive operations. Diff report on completion.

---

## 6. Doc governance

Docs are living. The agent reads them before acting, updates them after (on human instruction). See `docs/ARCH_governance.md` for the registry: which file owns what, when to load it. One file per concern. No duplication.

`STUBBORN_FACT` marks intentional quirks — the agent **never** "fixes" them.

> `STUBBORN_FACT: [what it is] — [why it must stay this way]`

---

## 7. References

See `RULES.md` for detailed coding standards and Engineering Gate.
See `PROMPT_CRAFT.md` for prompt engineering methodology.
See `docs/ARCH_governance.md` for the full doc registry + task→load mapping.
See `docs/GUIDE_knowledge.md` and `docs/GUIDE_memory.md` for Knowledge Repository and memory workflows.
See `docs/TOKEN_BUDGET.md` for token economy rules.
See `docs/GUIDE_skills.md` for creating composable skills.
See `skills/` for available skill modules (`/skill-name` to invoke).
See `templates/` for project bootstrap templates.
See `HARNESS.md` and `SOUL.md` for agent adaptation rules and persona constraints.

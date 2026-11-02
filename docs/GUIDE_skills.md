# GUIDE_skills.md — Writing & Managing Skills

## What is a skill

A skill is a composable, reusable instruction set invoked via `/name`. It lives in its own folder and acts as the agent's institutional knowledge for a specific workflow.

```
skills/<name>/
├── SKILL.md          # Required: instructions + frontmatter
├── templates/        # (optional) scaffolding templates
├── examples/         # (optional) reference examples
└── scripts/          # (optional) helper scripts
```

**Progressive disclosure:** At session start, the agent reads only the frontmatter `description` (~100 tokens). The full `SKILL.md` and any helper files load only when the skill fires. This keeps session overhead minimal.

## SKILL.md structure

```markdown
---
description: When to use this skill — one sentence, triggers auto-invocation if not disabled
disable-model-invocation: true   # true = only fires on explicit /name (use for side-effect skills)
allowed-tools: Read, Grep, Bash  # restrict tool access per skill
agent: read-only                 # run as isolated subagent
---

# Skill title

## What it does
Brief description of the workflow.

## Process
Step-by-step instructions.
Use `!command` on its own line to run shell commands at invocation time — output splices into prompt.

## Rules / Gotchas
Project-specific conventions and pitfalls.

## Output format
Expected structure of the result.
```

## Critical frontmatter flags

| Flag | Effect | When to use |
|---|---|---|
| `disable-model-invocation: true` | Only fires on explicit `/name` | Skills with side effects: deploy, ship, delete |
| `allowed-tools: Read, Grep` | Restricts tools available to skill | Security, audit-only skills |
| `agent: read-only` | Runs in isolated subagent context | Large context tasks, parallel analysis |

> **IMPORTANT:** Use `disable-model-invocation: true` for any skill that deploys, writes, or deletes. You want `/ship` to run only when you type it, not when the agent decides it's relevant.

## Rules

- **One concern per skill.** If it does two things, split it.
- **Inline shell:** `!git diff HEAD` on its own line runs at invocation and splices output.
- **Composable:** model-invoked skills can invoke other model-invoked skills. User-invoked → model-invoked: ✅. User-invoked → user-invoked: ❌.
- **Check into git.** Skills become institutional knowledge; new engineers get them for free on clone.
- **Global vs project scope:** project-skills → `skills/<name>/` (or `.claude/skills/<name>/`). Global → `~/.claude/skills/<name>/`.

## When to create a skill

- You do the same thing more than once a day → skillify it
- You catch yourself typing the same prompt twice → that's a skill
- A bug pattern repeats → skillify the diagnosis process
- A team convention needs to be repeatable and transferable

## Skill categories

| Category | Invocation | Purpose |
|---|---|---|
| **User-invoked** | `/name` only (set `disable-model-invocation: true`) | Orchestration with side effects: grill-me, doc-sweep, handoff, ship |
| **Model-invoked** | Auto + `/name` | Reusable discipline: tdd, code-review, diagnose, ponytail |

## Pre-built skills in this repo

| Skill | Invocation | Purpose |
|---|---|---|
| `grill-me` | `/grill-me` | Interviews you about a plan before any code gets written |
| `tdd` | `/tdd` | Enforces red-green-refactor strictly |
| `diagnose` | `/diagnose` | Disciplined debugging: reproduce → minimize → hypothesize → fix → regression test |
| `code-review` | `/code-review` | Audits diff for bugs, security, edge cases, conventions |
| `doc-sweep` | `/doc-sweep` | Syncs docs after a task — run after human confirms correctness |
| `handoff` | `/handoff` | Generates a session handoff summary for the next agent/session |
| `spec` | `/spec` | Turns a vague requirement into a structured spec |
| `ponytail` | `/ponytail` | Forces YAGNI check — "does this need to exist?" |

## Installation methods

### Via skills package (Claude Code)
```bash
npx skills@latest add mattpocock/skills
```

### Via plugin marketplace (Claude Code)
```
/plugin marketplace add owner/repo
/plugin install name@owner
```

### Manual
Copy `skills/<name>/` into project's `skills/` directory.

### Symlink for cross-harness
```bash
# Unix
ln -s skills .claude/skills

# Windows PowerShell
New-Item -ItemType Junction -Path .claude/skills -Target skills
```

# STANDARDS_prompting.md — Prompt Standards by Harness

## Cross-harness structure

All harnesses support markdown-based instruction files. Map via symlinks:

| Harness | File |
|---|---|
| Claude Code | `CLAUDE.md` |
| Codex CLI | `AGENTS.md` |
| Cursor | `AGENTS.md` or `.cursor/rules/` |
| Gemini CLI | `GEMINI.md` |
| Copilot | `.github/copilot-instructions.md` |
| Cline | `.clinerules/` |
| Windsurf | `.windsurf/rules/` |
| Qoder | `.qoder/rules/` |
| OpenCode | `AGENTS.md` |
| Kiro | `.kiro/steering/` |

**One source:** Write `AGENTS.md`, symlink the rest.
> Windows: `New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md`

## Project structure

```
project/
├── AGENTS.md              # or CLAUDE.md — main contract
├── AGENTS.local.md        # gitignored — personal overrides
├── RULES.md               # coding rules
├── PROMPT_CRAFT.md        # prompt methodology
├── CONTEXT.md             # domain language, jargon, architecture
├── docs/
│   ├── ARCH_governance.md      # doc registry (MANDATORY)
│   ├── guide_*.md         # workflow guides
│   ├── LOGIC_*.md         # feature-specific logic docs
│   ├── ADR_*.md           # architecture decisions
│   └── INCIDENT_*.md      # post-mortems
├── skills/
│   └── <name>/
│       └── SKILL.md       # composable skills
└── agent.md               # project-specific session rules (optional)
```

## Global vs Project scope

- **Global** (`~/.claude/`, `~/.config/opencode/`, etc.): personal preferences, cross-project rules.
- **Project** (`.claude/`, `AGENTS.md` at root): team-shared rules, committed to repo.
- **Local** (`AGENTS.local.md`, `.claude/settings.local.json`): gitignored, personal overrides.

## Skill frontmatter format

```yaml
---
description: When to use this skill
disable-model-invocation: true   # only on explicit /name
allowed-tools: Read, Grep, Bash  # restrict tool access
agent: read-only                 # subagent config
---
```

## Error doc format

```
# [error title]

**Error:** [traceback / symptom]

**Causa:** [technical explanation]

**Solución:** [exact commands / code changes]

**Resultado:** [current state]
```

Accumulate errors. Never delete old entries when adding new ones.

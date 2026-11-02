# ARCH_governance.md — Doc Registry

Each doc file owns exactly one concern. No duplication.
One rule = one file. If a rule appears in two files, delete from the wrong one.

## File registry

| File | Contents | Load when |
|---|---|---|
| `AGENTS.md` | Standing contract, workflow, communication, safety, self-correction | Every session |
| `RULES.md` | Coding standards, architecture, testing, token economy | Every session |
| `PROMPT_CRAFT.md` | How to write effective prompts, templates, anti-patterns | When writing prompts |
| `docs/ARCH_governance.md` | This file. Registry + task→load mapping. | When loading docs |
| `docs/STANDARDS_prompting.md` | Detailed prompt standards by harness/format | When writing prompts |
| `docs/GUIDE_workflow.md` | Workflow step-by-step: explore, plan, code, verify | Every session (quick ref) |
| `docs/GUIDE_git.md` | Agentic git patterns | When using git |
| `docs/GUIDE_skills.md` | Writing and managing skills | When creating/editing skills |
| `docs/GUIDE_docs.md` | Living docs workflow | On doc sweep |
| `CONTEXT.md` | Project-level domain language, glossary, module map | Every session (project scope) |
| `templates/PROJECT_AGENTS.md` | Per-project AGENTS.md template | On project init |
| `templates/CONTEXT.md` | Per-project domain language template | On project init |
| `templates/ERROR_LOG.md` | Error log template | On error |
| `templates/KR_ADR.md` | Architecture Decision Record template | On `/kr-write` for ADR |
| `templates/KR_LOGIC.md` | Domain Rule template | On `/kr-write` for LOGIC |
| `templates/AGENTS.local.md.example` | Personal private rules template (gitignored) | On new dev setup |
| `skills/*/SKILL.md` | Composable skill definitions | On `/skill-name` invocation |
| `HARNESS.md` | Active harness detection and capabilities | Every session |
| `SOUL.md` | Agent identity, Engineering Gate, Token Budget | Every session |
| `docs/HARNESS_profiles.md` | Detailed setup per harness | On new project setup |
| `docs/GUIDE_knowledge.md` | Knowledge Repository workflow | On KR query/write |
| `docs/GUIDE_memory.md` | Engram vs KR workflow | On session start/end |
| `docs/MCP_config.md` | MCP server reference | When configuring MCP |
| `docs/TOKEN_BUDGET.md` | Token economy protocol | When optimizing responses |

## Ownership rules

- `AGENTS.md` owns: workflow, safety, completion protocol, communication, self-correction loop.
- `RULES.md` owns: coding standards, test requirements, architecture principles, Token Economy hierarchy, Engineering Gate.
- `CONTEXT.md` (project-level) owns: domain jargon, module map, ADRs, STUBBORN_FACTs, ENGRAM block.
- `docs/STANDARDS_prompting.md` owns: structured prompt templates per harness.
- `docs/GUIDE_workflow.md` owns: procedural workflow, not principles.
- `SOUL.md` owns: agent sequence, communication tone, strict prohibitions.
- `HARNESS.md` owns: tool capabilities and fallback strategies.

## Task→Load mapping

| Task type | Load |
|---|---|
| New feature | `docs/GUIDE_workflow.md`, project `CONTEXT.md`, run `/kr-query` |
| Bug fix | project `doc_errores.md` via `/fix-known`, relevant files |
| Code review | `RULES.md`, project conventions, project `CONTEXT.md` |
| Architecture | `docs/GUIDE_workflow.md`, run `/kr-query`, project `CONTEXT.md` |
| Prompting | `PROMPT_CRAFT.md`, `docs/STANDARDS_prompting.md` |
| Git | `docs/GUIDE_git.md` |
| Skill creation | `docs/GUIDE_skills.md` |
| Doc sweep | `docs/ARCH_governance.md`, `docs/GUIDE_docs.md` |
| New project | `scripts/bootstrap.ps1` or `bootstrap.sh` |

## STUBBORN_FACT markers

> `STUBBORN_FACT: [what it is] — [why it must stay this way]`

These are intentional quirks. The agent reads them as hard constraints and never "fixes" them.
They live in the project-level `CONTEXT.md`, not in global files.

# AGENTS.md — [Project Name]

> Copy this template to your project root as `AGENTS.md`.
> Also symlink: `New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md`
> This file is **team-shared** (commit it). For personal rules, use `AGENTS.local.md` (gitignore it).

---

## Workflow

- Build: `[command]`
- Test: `[command]` (single: `[command] -- -t "test name"`)
- Lint/check: `[command]`
- Pre-submit: `[command]`
- **Always run typecheck before claiming done.**
- **Never push to main directly. Always open a PR.**

## Code style

- [Style rule 1: e.g., use ES modules not CommonJS]
- [Style rule 2: e.g., error handling pattern]
- [Style rule 3: e.g., preferred data access pattern]

## Architecture

- [Architecture rule 1: e.g., all API routes go through src/api/middleware/auth.ts]
- [Architecture rule 2: e.g., new DB queries go in src/db/queries/ — no inline raw SQL]
- [Architecture rule 3: e.g., shared vs local state rules]

## Gotchas

> These are real mistakes that happened. Update after every PR or agent error.
> Prompt: `"Update AGENTS.md so you don't repeat this."`

- [Gotcha 1: e.g., `User` and `UserRecord` are distinct types — UserRecord is the DB row]
- [Gotcha 2: e.g., `formatCurrency` assumes USD — for international use `formatCurrencyByLocale`]

## Domain language

See `CONTEXT.md` for project-specific jargon, module map, and STUBBORN_FACTs.

## References

See `docs/ARCH_governance.md` for the full doc registry.
See `RULES.md` for universal coding standards.

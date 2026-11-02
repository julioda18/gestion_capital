# HARNESS.md — Detección y Adaptación de Herramienta IA

> El agente lee este archivo al inicio de cada sesión para identificar el harness activo y ajustar su comportamiento.

---

## Detección automática

El agente evalúa las señales en orden. Se detiene en la primera coincidencia.

| # | Señal detectada | Harness |
|---|---|---|
| 1 | Plugin Antigravity activo / variable `$ANTIGRAVITY` | **Antigravity** |
| 2 | `CLAUDE.md` existe en el directorio de trabajo | **Claude Code** |
| 3 | `.cursor/` existe en el directorio de trabajo | **Cursor** |
| 4 | `.opencode/` o `.kilo/` existen | **OpenCode / Kilo Code** |
| 5 | `.windsurf/rules/` existe | **Windsurf** |
| 6 | `.github/copilot-instructions.md` existe | **VS Code Copilot** |
| 7 | `GEMINI.md` existe | **Gemini CLI** |
| 8 | CLI `codex` detectado en PATH | **Codex CLI** |
| 9 | `.kiro/` existe | **Kiro IDE** |
| 10 | Ninguna de las anteriores | **Genérico** |

---

## Perfiles de capacidades

### Antigravity
- Skills: via plugins en `~/.gemini/config/plugins/`
- Subagentes: ✅ (browser, terminal subagents nativos)
- MCP: ✅
- Slash commands: ✅ (nativos)
- Adaptación SDD: delegar fases a subagentes
- Leer instrucciones desde: `AGENTS.md`, `SOUL.md`, plugins instalados

### Claude Code
- Skills: via `SKILL.md` en `skills/` o `.claude/skills/`
- Subagentes: ✅ (Task tool)
- MCP: ✅
- Slash commands: ✅ (`/skill-name`)
- Adaptación SDD: delegar fases con Task tool
- Leer instrucciones desde: `CLAUDE.md` (symlink a `AGENTS.md`), `SOUL.md`

### Cursor
- Skills: via `.cursor/agents/` o `.cursor/rules/`
- Subagentes: ✅ (native subagents)
- MCP: ✅
- Slash commands: via reglas en `.cursor/`
- Adaptación SDD: delegar fases a subagentes de Cursor
- Leer instrucciones desde: `AGENTS.md`, `.cursorrules`

### OpenCode / Kilo Code
- Skills: overlay multi-mode
- Subagentes: ✅
- MCP: ✅
- Slash commands: ✅
- Adaptación SDD: delegar fases por modo
- Leer instrucciones desde: `AGENTS.md`

### Windsurf
- Skills: via `.windsurf/rules/`
- Subagentes: ❌ (solo agent)
- MCP: ✅
- Slash commands: Plan Mode / Code Mode
- Adaptación SDD: ejecutar fases secuencialmente
- Leer instrucciones desde: `.windsurf/rules/AGENTS.md`

### VS Code Copilot
- Skills: via `.github/copilot-instructions.md`
- Subagentes: ✅ (runSubagent, paralelo)
- MCP: ✅
- Slash commands: limitado
- Adaptación SDD: paralelo con runSubagent
- Leer instrucciones desde: `.github/copilot-instructions.md`

### Gemini CLI
- Skills: via `~/.gemini/agents/`
- Subagentes: ✅ (experimental)
- MCP: ✅
- Slash commands: via agents
- Adaptación SDD: delegar a custom agents
- Leer instrucciones desde: `GEMINI.md` (symlink a `AGENTS.md`)

### Codex CLI
- Skills: via instrucciones en `AGENTS.md`
- Subagentes: ❌
- MCP: via TOML config
- Slash commands: ❌ (CLI-only)
- Adaptación SDD: secuencial en texto plano
- Leer instrucciones desde: `AGENTS.md`

### Kiro IDE
- Skills: via `~/.kiro/agents/`
- Subagentes: ✅
- MCP: ✅
- Slash commands: via steering
- Adaptación SDD: subagentes nativos
- Leer instrucciones desde: `AGENTS.md`, steering docs

### Genérico (fallback)
- Skills: instrucciones en texto plano dentro del prompt
- Subagentes: ❌
- MCP: ❌ (asumir no disponible)
- Slash commands: ❌
- Adaptación SDD: secuencial, checkpoint manual por fase
- Leer instrucciones desde: `AGENTS.md`

---

## Regla de adaptación SDD

```
¿Harness soporta subagentes?
  SÍ → delegar cada fase SDD a un subagente especializado
  NO → ejecutar fases en secuencia, checkpoint explícito con el humano entre fases
```

## Regla de adaptación MCP

```
¿Harness soporta MCP?
  SÍ → /kr-query puede usar servidor `memory` si está configurado
  NO → /kr-query usa grep local sobre docs/kr/
```

## Declaración de sesión

Al inicio de cada sesión, el agente declara en 1 línea:
`[Harness: X — Subagentes: ✅/❌ — MCP: ✅/❌ — Modo SDD: delegado/secuencial]`

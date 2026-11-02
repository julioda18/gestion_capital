# HARNESS_profiles.md — Guía de Configuración por Herramienta

> Guía extendida. Para detección automática de harness → `HARNESS.md`.

---

## Antigravity

**Cómo registrar skills:** plugins en `~/.gemini/config/plugins/[nombre]/skills/SKILL.md`
**Cómo activar MCP:** via plugin config en `~/.gemini/config/`
**AGENTS.md:** leído automáticamente desde el directorio de trabajo
**SOUL.md:** leído automáticamente
**Subagentes:** browser subagent + terminal subagent nativos
**Slash commands:** nativos del harness

Mínimo funcional:
```
Directorio del proyecto:
├── AGENTS.md    ← copia o symlink
├── RULES.md     ← copia o symlink
├── CONTEXT.md   ← específico del proyecto
└── docs/kr/     ← Knowledge Repository
```

---

## Claude Code

**Cómo registrar skills:** `SKILL.md` en `.claude/skills/[nombre]/` o `skills/[nombre]/`
**Cómo activar MCP:** `~/.claude/mcp.json` o `.claude/mcp.json` en proyecto
**AGENTS.md:** via symlink `CLAUDE.md → AGENTS.md`
```powershell
New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md
```
**SOUL.md:** leído automáticamente si existe
**Subagentes:** Task tool nativo
**Slash commands:** `/skill-name` nativo

---

## Cursor

**Cómo registrar skills:** `.cursor/agents/` o `.cursor/rules/`
**Cómo activar MCP:** `.cursor/mcp.json`
**AGENTS.md:** leído directamente o via `.cursorrules`
**Subagentes:** native subagents en `.cursor/agents/`
**Slash commands:** via `.cursor/` config

Mínimo funcional:
```powershell
mkdir .cursor
copy AGENTS.md .cursor\rules\AGENTS.md
```

---

## OpenCode / Kilo Code

**Cómo registrar skills:** overlay multi-mode
**Cómo activar MCP:** config de OpenCode
**AGENTS.md:** leído directamente
**Subagentes:** multi-mode overlay
**Config Kilo:** `~/.config/kilo`

---

## Windsurf

**Cómo registrar skills:** `.windsurf/rules/`
**Cómo activar MCP:** `.windsurf/mcp.json`
**AGENTS.md:** copiar a `.windsurf/rules/AGENTS.md`
**Subagentes:** ❌ (modo solo agente)
**SDD en Windsurf:** fases secuenciales, usar Plan Mode para fases 1-3, Code Mode para fase 4

```powershell
mkdir .windsurf\rules
copy AGENTS.md .windsurf\rules\AGENTS.md
```

---

## VS Code Copilot

**Cómo registrar skills:** `.github/copilot-instructions.md`
**Cómo activar MCP:** `.vscode/mcp.json`
**AGENTS.md:** contenido en `.github/copilot-instructions.md`
**Subagentes:** runSubagent, paralelo
**SDD en Copilot:** paralelo con runSubagent para fases independientes

```powershell
mkdir .github
copy AGENTS.md .github\copilot-instructions.md
```

---

## Gemini CLI

**Cómo registrar skills:** `~/.gemini/agents/`
**Cómo activar MCP:** config de Gemini CLI
**AGENTS.md:** via symlink `GEMINI.md → AGENTS.md`
```powershell
New-Item -ItemType SymbolicLink -Path GEMINI.md -Target AGENTS.md
```
**Subagentes:** experimental, via `~/.gemini/agents/`

---

## Codex CLI

**Cómo registrar skills:** instrucciones en texto plano dentro de `AGENTS.md`
**Cómo activar MCP:** TOML config
**AGENTS.md:** leído directamente
**Subagentes:** ❌ (CLI-only, solo agente)
**SDD en Codex:** secuencial en texto plano, checkpoint manual entre fases

---

## Kiro IDE

**Cómo registrar skills:** `~/.kiro/agents/`
**Cómo activar MCP:** config de Kiro
**AGENTS.md:** leído + steering orchestration
**Subagentes:** nativos en `~/.kiro/agents/`

---

## Modo Genérico (fallback)

Usar cuando el harness no es reconocido.

**Skills:** pegar el contenido del SKILL.md relevante directamente en el prompt
**MCP:** asumir no disponible; usar grep local para `/kr-query`
**AGENTS.md:** pegar secciones relevantes en el contexto inicial
**Subagentes:** ❌ — SDD secuencial con checkpoints explícitos
**Limitaciones:** sin slash commands nativos, sin memoria persistente automática

**Workaround para memoria:**
```
Al inicio de cada sesión, incluir en el prompt:
"Lee docs/kr/ y CONTEXT.md antes de responder."
```

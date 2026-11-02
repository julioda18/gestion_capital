# MCP_config.md — Referencia de Servidores MCP

> Solo documentación de referencia. Adaptar la config JSON al harness activo (ver `HARNESS.md`).

## Principio

Un MCP por responsabilidad. Igual que un archivo por concern.
Activar solo los que el proyecto necesita activamente.

---

## Servidores recomendados

| Servidor | Utilidad | Nivel Token Budget | Cuándo activar |
|---|---|---|---|
| `filesystem` | Leer/escribir archivos del proyecto directamente | 1 | Siempre (acceso a docs/kr/) |
| `memory` | Búsqueda semántica en KR — mejora `/kr-query` | 0 | Proyectos con KR crecido (>10 ADRs) |
| `context7` | Documentación actualizada de librerías | 1 | Al trabajar con deps externas |
| `git` | Operaciones git, diff, log, blame | 1 | Siempre en repos con historial |
| `brave-search` | Búsqueda web cuando el KR no tiene respuesta | 4 | Solo si KR y context7 no alcanzan |

---

## Plantilla JSON genérica

Adaptar al harness activo según `docs/HARNESS_profiles.md`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/ruta/al/proyecto"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "/ruta/al/repo"]
    },
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "[tu-api-key]"
      }
    }
  }
}
```

---

## Integración con Token Budget

Con `memory` MCP activo, `/kr-query` opera en nivel 0 (búsqueda semántica, sin razonamiento).
Sin `memory`, `/kr-query` usa grep (nivel 1). Ambos son válidos.

---

## Dónde guardar la config por harness

| Harness | Ruta de config MCP |
|---|---|
| Antigravity | `~/.gemini/config/` o plugin config |
| Claude Code | `~/.claude/mcp.json` o `.claude/mcp.json` en proyecto |
| Cursor | `.cursor/mcp.json` |
| OpenCode | config de OpenCode |
| VS Code Copilot | `.vscode/mcp.json` |

Ver `docs/HARNESS_profiles.md` para instrucciones detalladas por harness.

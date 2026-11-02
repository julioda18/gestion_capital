# GUIDE_quickstart.md — Cómo usar esto en tu proyecto

## En 30 segundos

```powershell
# 1. Usa el script de bootstrap (1 comando lo hace todo)
powershell -File d:\recursos_ia\scripts\bootstrap.ps1 -ProjectPath "C:\tu-proyecto"

# Si usas Unix/macOS:
bash /ruta/a/recursos_ia/scripts/bootstrap.sh /ruta/a/tu-proyecto
```

**2. Configura tu proyecto (¡Importante!)**
Abre el archivo `CONTEXT.md` que el script creó en tu proyecto y llena la plantilla:
- **Domain:** Explica qué es tu proyecto y qué tecnologías usas (ej. "Esta es una tesis, un CRUD en Node.js").
- **Glossary:** Términos de negocio o siglas que usas en tu código.
- **Module map:** Para qué sirve cada carpeta principal (ej. `src/controllers`: lógica).

**3. Listo. Abre el agente en ese directorio y empieza.**

---

## Paso a paso

### 1. Elige qué copiar

No necesitas todo. Solo lo que tu proyecto requiera:

| Necesitas | Copia esto |
|---|---|
| Reglas base + workflow | `AGENTS.md` + `RULES.md` |
| Mejorar prompts | + `PROMPT_CRAFT.md` |
| Skills (grill, review, tdd) | + `skills/` completo |
| Documentación viva | + `docs/` completo |
| Template para proyectos nuevos | + `templates/PROJECT_AGENTS.md` |

### 2. Conecta AGENTS.md a tu harness

| Harness | Archivo que lee | Acción |
|---|---|---|
| Claude Code | `CLAUDE.md` | Symlink: `New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md` |
| Codex CLI | `AGENTS.md` | Ya funciona directo |
| Cursor | `AGENTS.md` o `.cursor/rules/` | Copia o symlink |
| Gemini CLI | `GEMINI.md` | Symlink: `New-Item -ItemType SymbolicLink -Path GEMINI.md -Target AGENTS.md` |
| Copilot | `.github/copilot-instructions.md` | Copia el contenido |
| OpenCode | `AGENTS.md` | Ya funciona directo |
| Cline | `.clinerules/` | Copia AGENTS.md allí |
| Windsurf | `.windsurf/rules/` | Copia AGENTS.md allí |
| Qoder | `.qoder/rules/` | Copia AGENTS.md allí |

### 3. Personaliza para tu proyecto

Crea un `AGENTS.md` específico con tu stack y reglas del proyecto:

```markdown
## Workflow
- Build: `[comando de build]`
- Test: `[comando de tests]`
- Lint: `[comando de linter]`
- Pre-submit: `[comando pre-PR]`

## Code style
- [Regla 1: ejemplo, convención de nombres]
- [Regla 2: ejemplo, manejo de errores]
- [Regla 3: ejemplo, nivel de tipado]

## Architecture
- [Regla 1: ejemplo, dónde van las rutas/endpoints]
- [Regla 2: ejemplo, patrón de acceso a datos]
- [Regla 3: ejemplo, límites entre módulos]

## Gotchas
- [Escribe aquí cada error que el agente repita]
```

### 4. Conecta skills (opcional)

Skills se invocan con `/nombre` en Claude Code, Codex CLI, OpenCode, etc.

```powershell
# Opción A: Copia skills al proyecto
xcopy /E d:\recursos_ia\skills\. C:\tu-proyecto\.claude\skills\

# Opción B: Configura skills globales (disponibles en todos los proyectos)
xcopy /E d:\recursos_ia\skills\. C:\Users\tu-user\.claude\skills\
```

### 5. Úsalo en tu sesión diaria

```
# Al iniciar el agente, ya tiene las reglas cargadas.
# Puedes invocar skills directamente:

/sdd                   ← spec-driven development (5 fases) antes de codificar
/craft                 ← transforma tu prompt vago en uno estructurado
/grill-me              ← te entrevista antes de codificar algo complejo
/code-review           ← revisa tu diff actual antes del PR
/tdd                   ← red-green-refactor
/diagnose              ← debug disciplinado (chequea doc_errores primero)
/fix-known             ← aplica soluciones conocidas de doc_errores.md
/kr-query              ← busca decisiones previas en docs/kr/
/kr-write              ← registra decisiones en docs/kr/
/engram                ← persiste el contexto al cerrar sesión
/ponytail              ← modo lazy senior dev (YAGNI)
/handoff               ← pasa el contexto a otra sesión
/doc-sweep             ← sincroniza docs después de completar
```

---

## Ejemplo: Proyecto multi-módulo (ej. ERP, CMS, microservicios)

### Estructura recomendada

```
C:\proyecto\
├── AGENTS.md                  # Reglas globales del proyecto (symlink o copia)
├── AGENTS.local.md            # Gitignored, overrides personales
├── doc_errores.md             # Error log (template ERROR_LOG.md)
├── modulo-uno/
│   ├── src/
│   └── tests/
├── modulo-dos/
│   ├── src/
│   └── tests/
└── docs/
    ├── ARCH_governance.md     # Registry de docs
    └── ...
```

### AGENTS.md mínimo

```markdown
# Workflow
- Build: [comando de build]
- Test: [comando de tests unitarios]
- Logs: [comando para ver logs]

# Project gotchas
- [Regla 1: no tocar X módulo]
- [Regla 2: siempre validar Y antes de Z]
- [Regla 3: convención de nombres específica]
```

### Symlink a reglas globales

```powershell
# Reglas globales compartidas entre todos tus módulos
New-Item -ItemType SymbolicLink -Path C:\proyecto\AGENTS.md -Target d:\recursos_ia\AGENTS.md
New-Item -ItemType SymbolicLink -Path C:\proyecto\RULES.md -Target d:\recursos_ia\RULES.md
```

Cada módulo puede tener su propio `AGENTS.md` local que los agentes cargan además del global.

---

## Casos de uso comunes

### Quiero empezar un proyecto nuevo desde cero

```powershell
# Todo en un solo comando (si la ruta tiene espacios, usa comillas):
powershell -File d:\recursos_ia\scripts\bootstrap.ps1 -ProjectPath "."
```

### Quiero mejorar los prompts que le doy al agente

Usa `PROMPT_CRAFT.md` como referencia. Los templates de la sección 8 son los más útiles:

```
# Bug fix prompt
Error: [traceback]
Files: [paths]
Expected: [qué debería pasar]
Actual: [qué pasa]
Verify: [comando para confirmar]
```

### Quiero que el agente no escriba código de más

Usa el skill `/ponytail` o incorpora la ladder en tu `AGENTS.md` local:

```
## Código
- YAGNI: Si no hace falta, no lo escribas
- Stdlib > dependencias > código propio
- Una línea si alcanza
- Sin abstracciones no pedidas
```

### Quiero que el agente revise mi código antes del PR

```powershell
# En la sesión del agente:
/code-review
# Te devuelve: issues por severidad + verdict SHIP/FIX FIRST/REWORK
```

### Quiero pasar contexto entre sesiones

```
# Sesión 1 (antes de terminar):
/handoff
# → Crea docs/HANDOFF_latest.md

# Sesión 2 (al empezar):
# El agente lee AGENTS.md + docs/HANDOFF_latest.md y continúa
```

---

## Tips de token economy

- **Skills > prompts largos.** Skills cargan ~100 tokens de descripción, no todo el contenido
- **Max 3 archivos por prompt.** Más que eso, usa `/grill-me` primero
- **Referencia, no copies.** `@src/auth/login.py` vs describir el archivo
- **Pipe errores, no los pegues.** `cat error.log | claude`
- **Micro-diffs.** Pide solo las líneas cambiadas, no el archivo completo
- **`AGENTS.md` corto.** Máximo 30 líneas de reglas. Lo demás va en `docs/` o `skills/`

---

## Cómo usar esto AQUÍ para mejorar tus prompts ahora mismo

Este sistema no es solo para copiar a un proyecto — también puedes usarlo **en esta conversación** para que el agente (yo) entienda mejor qué quieres y te dé respuestas más precisas.

### Principio: el prompt ES el contexto

Cada mensaje que me escribes es un prompt. La calidad de la respuesta depende de:
1. **Qué contexto incluyes** (archivos, errores, objetivo)
2. **Qué formato usas** (estructurado vs. narrativo)
3. **Qué evidencia pides** (verificación)

### Fórmula para prompts robustos

```
## Contexto
[Archivos o código relevante — pega rutas exactas]

## Objetivo
[Quiero que pase exactamente — una frase]

## Constraints
[Lo que NO debe pasar — límites claros]

## Formato de respuesta deseado
[Cómo quieres que te responda: micro-diff, lista, explicación]

## Verificación
[Cómo confirmar que está bien — comando o test]
```

### Antes vs Después

❌ **Antes** (vago):
> "El login no funciona, arréglalo"

✅ **Después** (robusto):
> **Contexto:** `src/auth/login.py:34`, el método `authenticate()` lanza `KeyError: 'token'`
> **Objetivo:** Que `authenticate()` maneje el caso donde `token` falta en el payload
> **Constraints:** No cambiar la firma del método, no tocar otros archivos
> **Verificación:** `[comando de test correspondiente]`

### Plug & play templates para copiar/pegar

**Template: Bug fix**
```markdown
Error: [pega traceback o mensaje de error exacto]
Archivo: [ruta:línea]
Qué espero: [comportamiento esperado]
Qué pasa: [comportamiento actual]
Verificar con: [comando exacto para probar]
```

**Template: Feature request**
```markdown
Feature: [nombre]
Archivos a tocar: [lista de rutas]
Comportamiento deseado: [descripción en 2-3 líneas]
Qué NO tocar: [scope negativo]
Cómo verifico: [test o comando]
```

**Template: Code review**
```markdown
Revisa este diff: [branch o rango]
Enfócate en: [seguridad | correctitud | performance]
Formato: [file:línea → problema → sugerencia]
```

**Template: Investigación / Análisis**
```markdown
Necesito entender: [qué quieres saber]
Archivos relevantes: [rutas]
Contexto: [lo que ya sabes]
Entrégame: [resumen | diagrama | plan de acción]
```

### Anti-patrones que matan prompts

| Mal | Bien |
|---|---|---|
| "Hazlo bien" | "Usa try/except con logging, sin bare except" |
| "Explícame" (genérico) | "Explícame el patrón de inyección de dependencias con un ejemplo" |
| Varios pedidos en uno | Un prompt = una cosa |
| "Arréglalo" sin error | Pegar traceback o symptom exacto |
| Describir código | `@src/file.py:42` |
| "Ten cuidado" | Reglas específicas en AGENTS.md |
| No pedir verificación | Terminar con "Verifica con: [comando]" |

### Cómo aplicar esto en cualquier proyecto

Funciona igual para cualquier lenguaje, framework o harness:

```markdown
Error: `NullReferenceException: Object reference not set to an instance of an object`
Contexto: API REST en producción, endpoint POST /api/users
Archivo: `src/controllers/user_controller.js:88`
Qué espero: El método debe validar que el body no sea nulo antes de procesar
Constraints: No cambiar la interfaz del endpoint, no tocar la capa de datos
Verificar: `[comando de test unitario para ese endpoint]`
```

Solo cambian: la sintaxis del error, el comando de build/test, y las rutas de archivos.

### Regla de oro para prompts

> **Antes de escribir un prompt, pregúntate:**
> 1. ¿Incluí el archivo:línea exacto?
> 2. ¿El agente puede verificar su propio output?
> 3. ¿Pedí solo una cosa?
> 
> Si alguna respuesta es NO, corrige antes de enviar.

### Cómo leer las respuestas del agente

Cuando recibes mi respuesta, evalúa:

| Señal | Significa |
|---|---|
| `file:line` específico | Sé exactamente dónde está el problema |
| Comando de verificación incluido | Puedo probar que funciona |
| Micro-diff (+/- líneas) | Solo toqué lo necesario |
| Termina con next action | Sé qué sigue |
| "DONE" + evidencia | Completado |
| "BLOCKED" + razón | Me falta contexto o hay un impedimento real |

Si mi respuesta es vaga, **re-pregunta con más contexto** — no aceptes una respuesta incompleta.

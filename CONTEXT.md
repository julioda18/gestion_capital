# CONTEXT.md — Contexto Global de la Biblioteca `d:\recursos_ia`

> Cargado por el agente en cada sesión. Define el mapa del ecosistema.
> El contexto específico de cada proyecto va en el `CONTEXT.md` del propio proyecto.

---

## Qué es este ecosistema

Sistema de configuración agnóstico para agentes de IA de código.
Equipa cualquier agente con: persona, memoria consultable, SDD, engineering discipline, y adaptación automática a la herramienta activa.

---

## Mapa de skills disponibles

| Skill | Propósito | Disparo |
|---|---|---|
| `/grill-me` | Entrevista al humano antes de codificar algo complejo | Manual |
| `/craft` | Transforma un prompt vago en uno estructurado y robusto | Manual |
| `/spec` | Alias → redirige a `/sdd` | Manual |
| `/sdd` | Spec-Driven Development en 5 fases | Manual |
| `/code-review` | Review del diff actual antes del PR | Manual |
| `/tdd` | Red-green-refactor | Manual |
| `/diagnose` | Debug disciplinado (llama `/fix-known` primero) | Manual |
| `/fix-known` | Consulta `doc_errores.md` antes de proponer corrección | Auto desde `/diagnose` |
| `/ponytail` | Modo lazy senior dev — YAGNI primero | Manual |
| `/engram` | Persiste estado de sesión en `## ENGRAM` de `CONTEXT.md` | Manual al cerrar sesión |
| `/handoff` | Crea `docs/HANDOFF_latest.md` para pasar contexto entre sesiones | Manual |
| `/kr-query` | Busca en `docs/kr/` antes de razonar una decisión | Auto desde `/sdd`, manual |
| `/kr-write` | Registra decisión/regla en `docs/kr/` | Auto desde `/sdd`, manual |
| `/doc-sweep` | Sincroniza docs después de completar trabajo | Manual, post-tarea |

---

## Archivos del ecosistema

| Archivo | Propósito | Cargar cuando |
|---|---|---|
| `SOUL.md` | Identidad, arranque, engineering gate, token budget | Siempre |
| `HARNESS.md` | Detección de herramienta y perfiles de capacidades | Siempre (primer arranque) |
| `AGENTS.md` | Contrato de workflow, comunicación, safety | Siempre |
| `RULES.md` | Estándares de código agnósticos | Siempre |
| `PROMPT_CRAFT.md` | Cómo escribir prompts efectivos | Al escribir prompts |
| `docs/ARCH_governance.md` | Registro completo de docs y su ownership | Al cargar docs |
| `docs/GUIDE_knowledge.md` | Sistema KR — cómo usar el Knowledge Repository | Al crear/consultar KR |
| `docs/GUIDE_memory.md` | Dos capas de memoria: KR vs Engram | Al trabajar con memoria |
| `docs/HARNESS_profiles.md` | Guía detallada por herramienta | Al configurar harness nuevo |
| `docs/TOKEN_BUDGET.md` | Protocolo completo de economía de tokens | Al optimizar respuestas |
| `docs/MCP_config.md` | Referencia de servidores MCP útiles | Al configurar MCP |

---

## Glosario del sistema

| Término | Definición |
|---|---|
| **Harness** | La herramienta de IA activa (Antigravity, Claude, Cursor, etc.) |
| **KR** | Knowledge Repository — `docs/kr/` del proyecto, verdad permanente |
| **Engram** | Estado volátil de sesión en bloque `## ENGRAM` del `CONTEXT.md` del proyecto |
| **ADR** | Architecture Decision Record — decisión + contexto + alternativas descartadas |
| **LOGIC doc** | Regla de dominio no evidente en el código |
| **Engineering Gate** | Jerarquía YAGNI→DRY→KISS antes de escribir cualquier código |
| **Token Budget** | Jerarquía de coste: KR → grep → micro-diff → template → razonamiento |
| **SDD** | Spec-Driven Development — Brief→Spec→Review→Build→Verify |
| **STUBBORN_FACT** | Quirk intencional que el agente nunca "corrige" |
| **Micro-diff** | Solo líneas cambiadas (`- antiguo / + nuevo`), nunca archivo completo |
| **Zero-Why** | Entregar soluciones directas sin justificación teórica salvo petición |

---

## STUBBORN_FACTs del ecosistema

> `STUBBORN_FACT: Los contextos de proyecto son aislados — nunca mezclar CONTEXT.md ni doc_errores.md de un proyecto con otro.`

> `STUBBORN_FACT: doc_errores.md es acumulativo — nunca borrar entradas, solo añadir.`

> `STUBBORN_FACT: El Engineering Gate no tiene excepciones — si el agente quiere saltárselo, primero justifica en 1 línea y el humano aprueba.`

---

## ENGRAM (estado de sesión de la biblioteca)

> Esta sección la escribe `/engram` al final de cada sesión de trabajo sobre la propia biblioteca.
> No borrar; solo añadir bloques nuevos con fecha.

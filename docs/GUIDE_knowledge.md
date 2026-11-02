# GUIDE_knowledge.md — Knowledge Repository (KR)

## Qué es el KR

Colección de archivos markdown estructurados que viven en `docs/kr/` de cada proyecto.
Permite que cualquier agente consulte decisiones previas sin reconstruir contexto desde cero.

**Resultado directo:** los tokens se gastan solo en lo nuevo. Lo ya documentado cuesta 0.

---

## Estructura de `docs/kr/`

```
docs/kr/
├── README.md              ← índice de entradas (auto-generado por /kr-write)
├── ADR-001-[slug].md      ← Architecture Decision Records
├── ADR-002-[slug].md
├── LOGIC-[dominio].md     ← Reglas de dominio
└── DISCUSSION-[fecha]-[slug].md  ← Resúmenes de decisiones por discusión
```

---

## Tipos de entrada

| Tipo | Cuándo crear | Template | Quién lo crea |
|---|---|---|---|
| **ADR** | Decisión que afecta estructura, patrones o contratos | `templates/KR_ADR.md` | `/kr-write` |
| **LOGIC** | Regla de negocio / comportamiento no evidente en código | `templates/KR_LOGIC.md` | `/kr-write` |
| **DISCUSSION** | Decisión tomada en conversación larga | formato libre | `/kr-write` |

---

## Protocolo de consulta

**Antes de codificar cualquier decisión no trivial:**

```
/kr-query [términos del problema]
```

El agente hace grep en `docs/kr/`. Si existe entrada relevante → la cita y aplica. No razona de nuevo.

**Regla de conflicto:** si la solución propuesta contradice un ADR → declarar el conflicto y esperar decisión del humano.

---

## Protocolo de escritura

**Después de cada decisión arquitectónica:**

```
/kr-write
```

El agente identifica el tipo correcto, usa el template, asigna número secuencial, guarda en `docs/kr/`.

**Disparos automáticos:**
- `/sdd` fase Review aprobado → `/kr-write` registra spec como `LOGIC-*.md`
- `/sdd` fase Verify DONE → `/kr-write` registra decisiones como `ADR-###.md`

---

## Reglas de integridad

- ADRs nunca se borran. Si la decisión cambia → nuevo ADR con `Status: Supersedes ADR-###`
- LOGIC docs se actualizan en el mismo archivo (con `Last updated`)
- DISCUSSION son inmutables
- El índice `docs/kr/README.md` se actualiza en cada `/kr-write`

---

## Initializar KR en un proyecto nuevo

```powershell
# El script bootstrap.ps1 lo hace automáticamente.
# Manual:
mkdir docs\kr
echo "# Knowledge Repository\n\n| Archivo | Tipo | Descripción |\n|---|---|---|" > docs\kr\README.md
```

---

## Diferencia con Engram y doc_errores.md

| Mecanismo | Qué almacena | Duración | Quién lo escribe |
|---|---|---|---|
| `docs/kr/` | Decisiones arquitectónicas y reglas de dominio | Permanente | `/kr-write` |
| `## ENGRAM` en CONTEXT.md | Estado de sesión en curso | Hasta completar la tarea | `/engram` |
| `doc_errores.md` | Historial de errores resueltos | Permanente, acumulativo | `/fix-known` |

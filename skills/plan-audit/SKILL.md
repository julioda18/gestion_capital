---
name: plan-audit
description: Audita un plan de implementación contra código y documentación reales, corrige errores silenciosos con diffs mínimos, reescribe el archivo del plan para reflejar la realidad, y reporta hallazgos. Usar tras crear o ejecutar un plan, antes de cerrar una tarea, o cuando el usuario pida revisar plan vs realidad, drift, o inconsistencias silenciosas.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---

# /plan-audit

> Parte del **plan como fuente de verdad**. Cruza plan + código + docs. **Corrige** errores silenciosos con diffs mínimos, **reescribe el archivo del plan** para que refleje la realidad, y reporta al final.
> Diferencia vs `/code-review`: ese skill solo audita el diff contra estándares; este verifica que la implementación cumpla el plan acordado.

## Cuándo usar

- Tras ejecutar un plan de implementación
- Antes de cerrar una tarea o declarar DONE
- Cuando sospechas drift entre lo planeado y lo construido
- Cuando docs y código no coinciden con lo acordado

## Proceso

### 1. Localizar el plan

Buscar en este orden:

1. Archivo `*.plan.md` en el workspace (incluye `.cursor/plans/`)
2. Documento en `docs/` referenciado en la sesión
3. Bloque "Plan" pegado por el usuario en el chat
4. `CONTEXT.md` si aplica

Si no hay plan → **NEEDS_CONTEXT**: pedir al usuario que indique cuál auditar.

### 2. Extraer checklist del plan

Del plan, listar:

- Requisitos y criterios de aceptación
- Archivos a crear o modificar
- Pasos de implementación (marcados hechos o pendientes)
- Comandos de verificación prometidos
- Exclusiones explícitas (qué NO debe hacer)

### 3. Contrastar con realidad

- Leer archivos citados en el plan (**archivo completo**, no solo diff)
- `Grep` para nombres de funciones, rutas, flags, strings mencionados en el plan
- Leer docs relacionados: `docs/`, `RULES.md`, `docs/kr/` si aplica
- Ejecutar verificación del plan si existe (tests, typecheck, lint)
- Comparar cada ítem del checklist con evidencia concreta

### 4. Clasificar hallazgos

**Silencioso corregible** (arreglar directamente):

- Doc desactualizada que contradice el código o el plan
- Ruta o nombre incorrecto en plan o docs
- Paso marcado hecho pero no implementado
- Validación o límite del plan omitido en código
- Nombre inconsistente entre plan, código y docs
- Test que no cubre lo que el plan prometió
- Plan desactualizado respecto a lo ya implementado correctamente

**Bloqueante** (reportar, no inventar solución):

- Conflicto de alcance o arquitectura no resuelto en el plan
- Requisito del plan imposible con el estado actual del código base
- Decisión que contradice un ADR en `docs/kr/`

### 5. Corregir (automático)

- Diffs mínimos, un concern por cambio
- Prioridad: código que no cumple el plan → docs que mienten → plan desactualizado
- No reescribir archivos completos (excepto el plan — ver paso 7)
- No cambiar arquitectura sin aprobación — eso va a "Sin corregir"

### 6. Reescribir el plan

**Obligatorio.** Tras corregir código y docs, editar el archivo `*.plan.md` auditado para que refleje la realidad actual. El plan reescrito es el entregable que el usuario verá en Cursor.

#### Qué actualizar en el plan

- **Frontmatter `todos`:** marcar `completed` lo hecho, `pending` lo pendiente, `cancelled` lo descartado
- **Rutas y nombres:** corregir paths, funciones o módulos que estaban mal en el plan original
- **Pasos de implementación:** marcar ✅ hecho / ⚠️ parcial / ❌ pendiente con evidencia (`archivo:línea`)
- **Checklist de verificación:** actualizar con comandos reales ejecutados y su resultado
- **Sección nueva al final del plan:**

```markdown
---

## Auditoría ([fecha])

**Veredicto:** ALINEADO | ALINEADO_CON_RESERVAS | DESALINEADO

### Cambios aplicados
- [qué se corrigió en código/docs/plan]

### Pendiente
- [ítems bloqueantes o sin resolver]

### Evidencia
- [comandos ejecutados + resultado]
```

#### Reglas al reescribir

- **No borrar** el frontmatter YAML (`name`, `overview`, `todos`) — actualizarlo
- **No eliminar** secciones del plan original — corregirlas in-place
- Si el plan original tenía supuestos falsos, reemplazarlos por lo que realmente existe
- Si un todo del plan resultó innecesario (YAGNI), marcarlo `cancelled` con nota breve
- Si surgió trabajo nuevo no previsto, añadir todo `pending` con descripción concreta
- El plan reescrito debe poder usarse como punto de partida para la siguiente sesión sin releer el chat

#### Si el plan no es un archivo

Si el plan vino pegado en el chat (no hay `*.plan.md`):

1. Crear `docs/plans/[nombre-descriptivo].plan.md` con el contenido auditado y actualizado
2. Indicar en el reporte la ruta del archivo creado

### 7. Reporte final

```markdown
## Auditoría del plan

**Plan auditado:** [ruta o referencia]

### Corregido

- `archivo:línea` — qué estaba mal — qué se hizo

### Sin corregir (bloqueante)

- [descripción] — por qué requiere decisión humana

### Plan vs realidad

| Ítem del plan | Estado | Evidencia |
|---|---|---|
| [requisito/paso] | ✅ / ⚠️ / ❌ | `archivo:línea` o comando |

## Verificación

[comando ejecutado + resultado]

## Veredicto

**ALINEADO** | **ALINEADO_CON_RESERVAS** | **DESALINEADO**

**Plan actualizado:** [ruta del .plan.md reescrito]
```

### Criterios de veredicto

| Veredicto | Condición |
|---|---|
| **ALINEADO** | Todos los ítems del plan cumplidos; verificación pasa |
| **ALINEADO_CON_RESERVAS** | Ítems menores corregidos; bloqueantes pendientes de decisión humana |
| **DESALINEADO** | Requisitos core del plan no cumplidos o verificación falla |

## Reglas

- El plan manda sobre la conversación — si hay conflicto, el plan gana salvo instrucción explícita del usuario
- Leer archivos completos, no confiar solo en el diff
- Si corriges código, incluir evidencia de que la verificación pasa
- Si el plan tiene todos marcados como hechos pero el código no coincide, eso es error silencioso prioritario
- No expandir scope más allá de lo que el plan define
- **Siempre reescribir el plan al terminar** — el usuario no debe releer el chat para saber el estado real

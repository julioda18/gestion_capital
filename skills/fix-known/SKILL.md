---
name: fix-known
description: Check doc_errores.md before proposing any fix. If the error is documented, apply the known solution directly — zero re-analysis tokens. If new, solve and document.
---

# /fix-known

> Un error documentado nunca se re-razona. Cero tokens para errores ya resueltos.
> Auto-disparado por `/diagnose` como primer paso.

## Proceso

### Paso 1 — Búsqueda en historial (nivel 1 Token Budget)

```
grep -i "[términos del error]" doc_errores.md
```

Buscar por:
- Mensaje de error exacto o fragmento clave
- Nombre del módulo / archivo afectado
- Tipo de excepción / código de error

### Paso 2 — Si existe match

Aplicar **directamente** la sección `**Solución implementada:**` del error encontrado.

```
[fix-known: MATCH]
  → Error: [título del error encontrado]
  → Aplicando solución documentada: [extracto de la solución]
  → Sin re-análisis (nivel 0 Token Budget)
```

No reexplicar la causa. No proponer alternativas. Aplicar y verificar.

### Paso 3 — Si NO existe match

Continuar con el flujo normal de `/diagnose`:
1. Reproducir → Minimizar → Hipotétizar → Instrumentar → Corregir → Regression test
2. Al resolver: **documentar obligatoriamente** en `doc_errores.md`

### Paso 4 — Documentar error nuevo

Formato obligatorio (nunca omitir campos):

```markdown
# [título descriptivo en minúsculas — qué falló exactamente]

**Error:** [traceback clave o mensaje exacto]

**Causa:** [explicación técnica — máximo 3 líneas]

**Solución implementada:** [comandos exactos, archivos y líneas modificadas]

**Resultado:** [estado tras aplicar la solución]
```

Reglas de integridad:
- Añadir siempre al final de `doc_errores.md` (nunca borrar entradas existentes)
- Nunca modificar entradas anteriores (si la solución cambió → añadir nueva entrada)
- Si el error pertenece a un módulo específico → añadir también en `doc_errores.md` de ese módulo

## Output (match encontrado)

```
[fix-known: MATCH en doc_errores.md]
Aplicando: [título del error]
Solución: [extracto]
Verificar con: [comando si existe en la entrada]
```

## Output (no encontrado)

```
[fix-known: NO MATCH — iniciando análisis]
[continuar con /diagnose]
[al resolver: documentar en doc_errores.md]
```

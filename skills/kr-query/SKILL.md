---
name: kr-query
description: Query the Knowledge Repository (docs/kr/) before reasoning about any decision. Zero-token retrieval of prior architectural decisions, domain rules, and discussions.
---

# /kr-query

> ⚠️ CRITICAL PROHIBITION: DO NOT EDIT, CREATE, OR DELETE ANY CODE. 
> YOUR ONLY JOB IS TO SEARCH AND OUTPUT TEXT. IF YOU EDIT ANY SOURCE CODE FILE, YOU HAVE FAILED THIS INSTRUCTION.

> Regla cardinal: si la decisión ya fue documentada, citar — no razonar de nuevo.
> Esto reduce tokens al nivel 0 (cero razonamiento para hechos conocidos).

## Cuándo invocar

- Antes de proponer cualquier solución de arquitectura o diseño
- Al inicio de `/sdd` fase 3 (Review)
- Al diagnosticar un comportamiento inesperado del sistema
- Antes de cambiar cualquier patrón o convención existente
- Auto-disparado desde `/diagnose` y `/sdd`

## Proceso

### Paso 1 — Búsqueda (grep, no razonamiento)

```
Buscar en docs/kr/ los términos clave del problema:
  - Sustantivos del dominio involucrados
  - Nombres de módulos o componentes
  - El tipo de decisión (auth, routing, caching, schema, etc.)
```

Herramientas: `grep -r "[término]" docs/kr/` — nivel 1 del Token Budget.

### Paso 2 — Evaluar resultados

```
¿Existe ADR relevante?
  SÍ → citar el ADR, aplicar su decisión, NO rerazonar
       Formato: "Según ADR-###: [decisión]. Aplicando directamente."

¿Existe LOGIC doc relevante?
  SÍ → citar la regla, aplicarla sin re-derivarla

¿No existe nada?
  → proceder con razonamiento propio
  → al finalizar: invocar /kr-write para documentar la nueva decisión
```

### Paso 3 — Si hay conflicto

Si la solución propuesta contradice un ADR existente:
1. Declarar el conflicto explícitamente
2. Presentar opciones: (a) respetar el ADR existente, (b) proponer superseding ADR
3. Esperar decisión del humano antes de continuar

## Output

```
[KR-Query: "[términos buscados"]
  → ADR-###: [título] — decisión: [resumen de 1 línea] ✅ aplicando
  → LOGIC-[nombre]: [regla] ✅ aplicando
  → Sin resultados: procediendo con razonamiento propio]
```

## Adaptación por harness

```
MCP disponible + servidor memory configurado → usar MCP para búsqueda semántica
Sin MCP → grep local sobre docs/kr/ (funciona en cualquier harness)
```

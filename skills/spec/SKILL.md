---
name: spec
description: Alias for /sdd. Use /sdd for new features. Use /spec to document decisions from a conversation that already happened.
disable-model-invocation: true
---

# /spec

> **Redirige a `/sdd`** para features nuevas.
> Usar `/spec` solo para sintetizar una conversación ya ocurrida en un documento estructurado.

## Cuándo usar /spec (no /sdd)

- La feature ya fue discutida — necesitas documentar lo que se decidió
- Quieres un snapshot de la conversación actual como spec de referencia

## Cuándo usar /sdd (no /spec)

- Estás a punto de codificar algo nuevo
- Quieres definir contratos antes de implementar
- Quieres que el agente aplique Engineering Gate antes de empezar

---

## Proceso /spec (síntesis de conversación)

1. Leer historial de la conversación
2. Extraer: objetivo, contexto, restricciones, decisiones, verificación
3. Escribir spec estructurado

## Output format

```markdown
# Spec: [title]

## Goal
[Una oración]

## Context
[Archivos relevantes, patrones, dependencias]

## Requirements
- [Requisito 1]

## Non-requirements
- [Explícitamente fuera de scope]

## Design decisions
- [Decisión]: [rationale]

## Verification
- [Cómo confirmar cada requisito]

## Related
- [ADRs, issues, docs]
```

> Después de generar → invocar `/kr-write` para registrarlo en `docs/kr/`.

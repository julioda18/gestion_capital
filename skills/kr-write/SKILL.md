---
name: kr-write
description: Write a decision, domain rule, or discussion summary to the Knowledge Repository (docs/kr/). Triggered automatically by /sdd. Run manually after any architectural decision.
---

# /kr-write

> La decisión que no se documenta se repite. Cada entrada en KR elimina futuros tokens de re-razonamiento.

## Cuándo invocar

- Al finalizar `/sdd` fase 3 (Review aprobado) → registrar spec como LOGIC
- Al finalizar `/sdd` fase 5 (Verify DONE) → registrar decisiones de diseño como ADR
- Después de cualquier decisión arquitectónica tomada en conversación
- Cuando se resuelve un conflicto de diseño importante
- Manualmente, en cualquier momento que el humano lo indique

## Tipos de entrada

### ADR — Architecture Decision Record
Cuándo: decisión que afecta la estructura, patrones, o contratos del sistema.

Template: `templates/KR_ADR.md`
Nombre de archivo: `docs/kr/ADR-[###]-[slug-descriptivo].md`
Numeración: secuencial, buscar el último `ADR-*.md` en `docs/kr/` y sumar 1.

### LOGIC — Regla de dominio
Cuándo: regla de negocio o comportamiento esperado que no es evidente en el código.

Template: `templates/KR_LOGIC.md`
Nombre de archivo: `docs/kr/LOGIC-[nombre-del-dominio].md`

### DISCUSSION — Resumen de decisión por discusión
Cuándo: la decisión emergió de una conversación larga; no es un ADR formal pero importa.

Nombre de archivo: `docs/kr/DISCUSSION-[YYYY-MM-DD]-[slug].md`
Formato libre, mínimo: fecha, participantes, decisión tomada, alternativas descartadas.

## Proceso

1. Identificar el tipo correcto (ADR / LOGIC / DISCUSSION)
2. Copiar el template correspondiente
3. Asignar nombre de archivo con numeración o slug
4. Completar todos los campos del template — sin campos vacíos
5. Guardar en `docs/kr/` del proyecto
6. Actualizar `ARCH_governance.md` del proyecto con la nueva entrada

## Output

```
[KR-Write: ADR-###]
  → Archivo: docs/kr/ADR-###-[slug].md ✅
  → ARCH_governance.md actualizado ✅
  → Próxima /kr-query sobre [términos] lo encontrará en nivel 0
```

## Regla de integridad

- Un ADR nunca se borra. Si la decisión cambia → crear nuevo ADR con `Status: Supersedes ADR-###`
- Los LOGIC docs se actualizan en el mismo archivo (con `Last updated`)
- Los DISCUSSION son inmutables una vez escritos

# LOGIC: [Nombre del dominio o regla]

Scope: [módulo, feature, o área del sistema donde aplica]
Last updated: YYYY-MM-DD
Related ADR: ADR-### (si la regla emergió de una decisión arquitectónica)

---

## Rule

[La regla en 1-3 oraciones. Empezar con verbo de obligación o prohibición:
"Siempre X antes de Y", "Nunca Z sin validar W", "Todo X debe tener Y".]

## Rationale

[¿Por qué existe esta regla? ¿Qué rompe si no se respeta?
Máximo 3 líneas. Sin historia — solo la razón técnica o de negocio actual.]

## Edge cases

- [Edge case 1]: [cómo se maneja]
- [Edge case 2]: [cómo se maneja]

## Examples

**Correcto:**
```
[ejemplo de código o comportamiento que respeta la regla]
```

**Incorrecto:**
```
[ejemplo de código o comportamiento que viola la regla]
```

## Do NOT change without

- Actualizar ADR-### si la regla emergió de una decisión arquitectónica
- Revisar [módulos o archivos que dependen de esta regla]
- Aprobación explícita del humano

---
name: sdd
description: Five-phase spec-driven workflow. Run before coding any non-trivial feature. Guarantees the agent builds what was agreed, not what was assumed.
---

# /sdd

> Reemplaza a `/spec`. Usa `/sdd` para features. Usa `/spec` para documentar conversaciones ya ocurridas.

## Engineering Gate (obligatorio antes de iniciar)

```
¿Esta feature necesita existir?       → NO: YAGNI, cancelar
¿Ya existe en el código?              → SÍ: extender, no reescribir (DRY)
¿Es la solución la más simple?        → NO: simplificar el approach primero
Solo entonces: continuar con las fases
```

## Fases

### 1. Brief
Preguntas mínimas para entender el problema:
- ¿Qué comportamiento nuevo aparece?
- ¿Qué deja de funcionar si no existe?
- ¿Quién lo usa y en qué contexto?

Output: 3-5 bullets. El humano confirma antes de avanzar.

### 2. Spec
Formalizar contratos:
- **Entradas:** tipos, formatos, valores válidos e inválidos
- **Salidas:** tipos, formato, garantías
- **Restricciones:** qué NO hace, qué NO puede tocar
- **Edge cases:** vacíos, nulos, concurrencia, límites

Output: documento en `docs/` o bloque en la sesión. Checkpoint obligatorio.

### 3. Review
- Consultar `docs/kr/` con `/kr-query` → ¿existe ADR que afecte este diseño?
- Si hay conflicto con ADR existente → resolver antes de continuar
- El humano aprueba el spec o lo ajusta

### 4. Build
- Implementar **contra el spec**, no contra la conversación
- Aplicar Engineering Gate línea por línea
- Micro-diffs únicamente; nunca reescribir archivos completos
- `[Budget: nivel X]` antes de cada bloque de código

### 5. Verify
- Evidencia de que cada requisito del spec se cumple
- Comando de verificación incluido en el output
- Si hay tests: pasar todos antes de declarar DONE
- Llamar `/kr-write` para registrar decisiones de diseño tomadas en las fases 2-3

## Output por fase

```
## Phase [N]: [Name]
[contenido de la fase]

Checkpoint: ✅ continuar | 🔄 ajustar → [qué cambiar]
```

## Adaptación por harness

```
Subagentes disponibles → delegar fases 1-2 a un agente de exploración, 4 a un agente de escritura
Sin subagentes → ejecutar secuencialmente, checkpoint explícito entre cada fase
```

## Disparo automático al finalizar

- Fase 3 (Review aprobado) → `/kr-write` registra el spec como `LOGIC-*.md`
- Fase 5 (Verify DONE) → `/kr-write` registra decisiones como `ADR-###.md`

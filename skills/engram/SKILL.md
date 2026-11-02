---
name: engram
description: Persist critical session state to CONTEXT.md before closing a session. Prevents context loss between sessions. Run at end of every working session.
---

# /engram

> Persiste estado volátil de sesión. No confundir con KR (verdad permanente).
> Regla: si el dato vale para cualquier agente futuro → `/kr-write`. Si solo importa para continuar esta tarea → `/engram`.

## Cuándo invocar

- Al cerrar una sesión de trabajo incompleta
- Antes de un `/handoff`
- Cuando el contexto acumulado en la sesión sería costoso de reconstruir

## Proceso

1. Identificar los 3-5 hechos de estado críticos de la sesión:
   - ¿Qué tarea está en curso?
   - ¿Qué archivos fueron modificados y cuál es su estado?
   - ¿Qué decisiones se tomaron pero NO se registraron en KR?
   - ¿Qué está bloqueado y por qué?
   - ¿Cuál es el próximo paso exacto?

2. Escribir bloque `## ENGRAM` en el `CONTEXT.md` del proyecto (no en el global):

```markdown
## ENGRAM — [YYYY-MM-DD]

**Tarea en curso:** [descripción]
**Estado:** [qué está hecho / qué falta]
**Archivos tocados:** [lista]
**Decisiones pendientes de KR:** [si hay → crear ADR antes de cerrar]
**Bloqueado por:** [si aplica]
**Próximo paso:** [exacto — el agente puede continuar sin preguntar]
```

3. Si hay decisiones pendientes de KR → llamar `/kr-write` antes de cerrar sesión.

## Lectura al inicio de siguiente sesión

Al detectar bloque `## ENGRAM` en `CONTEXT.md`:
- Leerlo antes que cualquier otra instrucción
- Declarar: `[Engram encontrado: tarea=[...] — próximo paso=[...]]`
- Continuar sin pedir qué se estaba haciendo

## Output

```
## ENGRAM — [fecha]
[bloque escrito en CONTEXT.md del proyecto]

Próxima sesión: continuar desde [paso exacto]
```

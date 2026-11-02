---
name: craft
description: Translate a vague user prompt into a robust, structured prompt using the CONTEXT, GOAL, CONSTRAINTS, FORMAT, VERIFICATION template.
disable-model-invocation: true
---

# /craft

> ⚠️ CRITICAL PROHIBITION: DO NOT EDIT, CREATE, OR DELETE ANY CODE. DO NOT SEARCH FILES TO FIX THE BUG.
> YOUR ONLY JOB IS TO GENERATE TEXT. IF YOU EDIT ANY PROJECT FILE, YOU HAVE SEVERELY FAILED THIS INSTRUCTION.
>
> Transforma un requerimiento o prompt vago en un prompt de nivel experto listo para copiar y pegar.

## Proceso

1. Analiza el prompt inicial del usuario.
2. Identifica qué partes de la fórmula robusta faltan: contexto preciso (rutas/líneas), objetivo claro, restricciones, formato de salida y método de verificación.
3. Si el prompt inicial carece de información absolutamente crítica (ej. es imposible saber de qué lenguaje o archivo está hablando y no hay contexto en la sesión), pídele al usuario que provea esa info. Si se puede inferir del contexto de la sesión, hazlo.
4. Genera el prompt robusto siguiendo la fórmula estructurada de `PROMPT_CRAFT.md` y `GUIDE_quickstart.md`.

## Estructura objetivo del prompt generado

El prompt generado debe contener estas secciones de forma concisa:
- **Contexto:** Archivos relevantes (ej. `@ruta:línea`), qué está pasando actualmente, logs de error exactos si aplica.
- **Objetivo:** Qué debe lograrse exactamente (1-2 oraciones).
- **Constraints:** Qué NO se debe tocar, cambiar, o hacer (ej. no cambiar la firma del método, respetar X convención).
- **Formato:** Cómo debe responder el agente (ej. usa micro-diffs, lista de pasos, explicación breve).
- **Verificación:** Comando exacto de terminal o test para confirmar que el código funciona.

## Output format

```markdown
## 🛠️ Prompt Mejorado

Copia y pega el siguiente texto en el chat o úsalo como tu próximo prompt:

\```markdown
**Contexto:** [Archivos, líneas, error]
**Objetivo:** [Qué lograr]
**Constraints:** [Qué no tocar]
**Formato:** [Formato deseado]
**Verificación:** [Comando/Test]
\```

*Nota: Asegúrate de reemplazar cualquier campo entre corchetes con las rutas o comandos reales antes de enviarlo.*
```

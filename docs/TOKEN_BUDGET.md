# TOKEN_BUDGET.md — Protocolo de Economía de Tokens

## Principio

Conocer el coste antes de actuar. Si existe una ruta más barata que produce el mismo resultado, usarla siempre.

---

## Jerarquía de coste

Usar el nivel más bajo posible. Subir solo cuando el nivel inferior no alcanza.

| Nivel | Mecanismo | Tokens de razonamiento | Cuándo aplica |
|---|---|---|---|
| **0** | Citar KR / doc_errores existente | ~0 | La decisión ya fue documentada |
| **1** | `grep` / búsqueda local | mínimo | Localizar información en archivos |
| **2** | Micro-diff (solo líneas cambiadas) | bajo | Editar código existente |
| **3** | Template pre-existente | medio | Crear archivos nuevos estructurados |
| **4** | Razonamiento + código nuevo | alto | Solo cuando 0-3 no alcanzan |

---

## Declaración pre-respuesta

Antes de cualquier respuesta no trivial, el agente declara en 1 línea:

```
[Budget: nivel X — estimado ~N tokens — ruta: KR/grep/micro-diff/template/razonamiento]
```

Ejemplos:
```
[Budget: nivel 0 — ~0 tokens — ruta: KR → ADR-003 aplica directamente]
[Budget: nivel 2 — ~15 tokens — ruta: micro-diff en src/auth/login.py:34]
[Budget: nivel 4 — ~80 tokens — ruta: razonamiento nuevo, sin KR match]
```

---

## Reglas hard (no negociables)

- **Hard stop a 200 tokens:** si la respuesta proyectada supera 200 tokens → STOP. Reevaluar scope. Usar herramientas CLI o pedir contexto más estrecho antes de continuar.
- **Micro-diff siempre:** nunca reescribir un archivo completo si solo cambia una parte.
- **Máximo 3 archivos de contexto** por respuesta, salvo justificación explícita.
- **Nivel 0 primero siempre:** antes de razonar, buscar en KR y doc_errores.
- **Grep antes de leer:** si se necesita encontrar algo en archivos, grep primero — no cargar el archivo completo.

---

## Patrones de reducción de scope

Cuando la respuesta proyectada es larga, el problema es el scope. Reducirlo con:

| Señal | Acción |
|---|---|
| "Explicar todo el módulo" | Pedir el aspecto específico que importa |
| "Revisar todo el archivo" | grep del síntoma, no lectura completa |
| "Generar toda la feature" | Dividir en fases SDD, una por turno |
| Respuesta > 200 tokens proyectados | STOP — reformular en sub-preguntas |
| Contexto > 3 archivos | Identificar el archivo más relevante y empezar por ahí |

---

## Símbolos y taquigrafía

Reducir tokens en respuestas usando:

| Símbolo | Significado |
|---|---|
| `→` | produce / resultado es |
| `∵` | porque |
| `Δ` | cambio / diferencia |
| `!` | atención / crítico |
| `✅` | correcto / completado |
| `❌` | incorrecto / no hacer |
| `⚠️` | advertencia |

Abreviaturas estándar: `auth`, `env`, `ctx`, `cfg`, `m2o`, `o2m`, `req`, `res`, `err`, `val`.

---

## Integración con otros sistemas

- **KR** elimina nivel 4 para decisiones ya tomadas → mayor ahorro
- **Engram** elimina el costo de reconstruir estado de sesión
- **fix-known** elimina nivel 4 para errores ya resueltos
- **Engineering Gate** reduce el código generado → menos tokens en respuesta

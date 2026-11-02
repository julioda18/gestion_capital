# GUIDE_memory.md — Dos capas de memoria

## Resumen

El ecosistema tiene dos capas de memoria complementarias. Nunca se mezclan.

| Capa | Mecanismo | Duración | Qué almacena | Skill |
|---|---|---|---|---|
| **KR** | `docs/kr/*.md` | Permanente | Decisiones, reglas, discusiones | `/kr-write` / `/kr-query` |
| **Engram** | bloque `## ENGRAM` en `CONTEXT.md` | Duración de la tarea activa | Estado de sesión, próximo paso | `/engram` |

**Regla de clasificación:**
```
¿El dato vale para cualquier agente futuro sobre este proyecto?
  SÍ → KR (/kr-write)
  NO, solo para continuar ahora → Engram (/engram)
```

---

## Capa 1: KR (Knowledge Repository)

**Protocolo de consulta:** `/kr-query` — antes de razonar cualquier decisión.
**Protocolo de escritura:** `/kr-write` — después de cualquier decisión arquitectónica.
**Guía completa:** `docs/GUIDE_knowledge.md`

**Cuándo usar KR y NO Engram:**
- Una decisión de diseño tomada hoy
- Una regla de negocio descubierta
- El porqué de un patrón implementado
- Una alternativa descartada y su razón

---

## Capa 2: Engram (estado de sesión)

**Protocolo:** `/engram` al cerrar sesión. Lectura automática al iniciar si existe.
**Guía completa:** `skills/engram/SKILL.md`

**Cuándo usar Engram y NO KR:**
- Qué tarea está en curso ahora mismo
- Qué archivos están a medio editar
- El próximo paso exacto para continuar
- Una decisión pendiente de documentar (→ se documenta en KR al cerrar)

**Formato del bloque Engram:**
```markdown
## ENGRAM — [YYYY-MM-DD]

**Tarea en curso:** [descripción]
**Estado:** [qué está hecho / qué falta]
**Archivos tocados:** [lista]
**Decisiones pendientes de KR:** [si hay → /kr-write antes de cerrar]
**Bloqueado por:** [si aplica]
**Próximo paso:** [exacto]
```

---

## Capa 3: doc_errores.md (memoria de errores)

No es KR ni Engram, pero es memoria permanente. Ver `skills/fix-known/SKILL.md`.

**Regla clave:** el agente lee `doc_errores.md` al inicio de cada sesión de debugging. Un error documentado nunca se re-razona.

---

## Flujo de sesión óptimo

```
Inicio:
  1. Detectar harness (HARNESS.md)
  2. Leer CONTEXT.md del proyecto → ¿hay bloque ENGRAM? → continuar desde ahí
  3. Leer doc_errores.md del proyecto (si va a haber debugging)

Durante trabajo:
  4. /kr-query antes de cada decisión de diseño
  5. /kr-write después de cada decisión aprobada
  6. Micro-diffs siempre, declarar Budget level antes de respuesta no trivial

Al cerrar:
  7. /engram → escribir bloque ENGRAM en CONTEXT.md del proyecto
  8. Si hay decisiones pendientes de KR → /kr-write primero
```

---

## Orden de consulta

```
Al tomar una decisión:
  1. KR (docs/kr/) — nivel 0 tokens
  2. Engram (## ENGRAM en CONTEXT.md) — nivel 0 tokens
  3. doc_errores.md — nivel 0 tokens
  4. Razonamiento propio — nivel 4 tokens
```

Nunca saltar al nivel 4 si los niveles 0-3 tienen la respuesta.

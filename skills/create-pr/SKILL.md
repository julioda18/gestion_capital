---
name: create-pr
description: Abre un pull request hacia main u otra rama base tras revisar el diff. Genera título corto y cuerpo con tipo (Fix/Patch/Feature), descripción, modelos Odoo tocados e instrucciones de despliegue (solo comandos sudo docker). Usar cuando el usuario pida crear un PR, abrir PR, o mencione /create-pr. Nunca hace merge ni modifica código.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---

# /create-pr

> ⚠️ PROHIBICIONES CRÍTICAS
>
> 1. **NUNCA** hacer merge (`gh pr merge`, `git merge`, squash, rebase merge).
> 2. **NUNCA** editar, crear ni eliminar código fuente, vistas, tests, docs ni configs del repo.
> 3. **SOLO** operaciones de lectura en git + `git push` (si hace falta subir la rama) + `gh pr create`.
> 4. Si falta algo para el PR (commits, push, `gh` auth), **informar** — no improvisar cambios en archivos.

## Entrada del usuario

- **Rama base** (opcional): default `main`. Aceptar `master`, `develop`, etc. si el usuario lo indica en el prompt.
- El usuario puede pedir solo el borrador del cuerpo sin abrir PR; en ese caso omitir `gh pr create` y devolver el markdown.

## Proceso

### 1. Estado del repo (paralelo)

```bash
git status
git branch -vv
git log --oneline <base>..HEAD
git diff <base>...HEAD
```

Si `<base>` no existe localmente, usar `origin/<base>`.

### 2. Revisar el diff

Leer el diff completo. Identificar:

| Señal | Cómo detectarla |
|-------|-----------------|
| Tipo | Bug/corrección → **Fix**; ajuste menor sin feature nueva → **Patch**; capacidad nueva → **Feature** |
| Módulos Odoo | Carpetas addon con `__manifest__.py` en paths cambiados; si el repo es un solo addon, usar su nombre (`name` en manifest) |
| Modelos tocados | Archivos en `models/*.py` modificados → `_name = '...'` en esos archivos; incluir modelos nuevos, campos relevantes en mixins/herencias |
| Migraciones | `migrations/*/pre-*.py` o `post-*.py` → implica `-u` obligatorio |
| Solo assets/XML/data | Listar modelos afectados vía XML (`model="..."`) si no hay `.py` |

Si no hay modelos Odoo (repo no-Odoo), sección **Modelos tocados**: `N/A` o componentes equivalentes (API routes, tablas SQL) según el diff.

### 3. Título del PR

- Máximo ~72 caracteres.
- Imperativo, sin punto final.
- Prefijo opcional alineado al tipo: `fix:`, `feat:`, `chore:` — solo si el repo ya lo usa en commits recientes (`git log -5 --oneline`).

### 4. Cuerpo del PR (estructura obligatoria)

Usar exactamente estas secciones en el cuerpo que se pasa a `gh pr create --body`:

```markdown
## Título
[Título corto — mismo sentido que el título del PR]

## Identificación principal
Fix | Patch | Feature
[Elegir **una**; una línea de justificación opcional si no es obvia]

## Descripción breve
[2–4 oraciones: qué cambia y por qué, basado solo en el diff]

## Modelos tocados
- `modelo.technical_name` — [cambio en una línea]
- ...

## Instrucciones de despliegue
```bash
sudo docker compose exec web odoo --config /etc/odoo/odoo.conf -d <database> -u <modulo> --workers=0 --stop-after-init
```

(Solo bloques de comandos `sudo docker ...`. Sin texto explicativo en esta sección.)
```

**Reglas de despliegue:**

- Un comando `-u <modulo>` por cada addon Odoo modificado.
- Usar `sudo docker compose exec web` como default; si el proyecto documenta otro patrón (p. ej. `sudo docker exec <container>`), seguir el doc del repo (`AGENTS.md`, `docs/REF_developer-reference.md`, README).
- Base de datos: la del entorno de producción documentada en el repo; si no consta, placeholder `<database>` y avisar al usuario.
- Si el cambio es solo JS/CSS/XML sin migración ni Python, aún incluir `-u` del módulo (Odoo recarga assets/data).
- Si no aplica despliegue Odoo, bloque vacío con `# N/A` en una sola línea comentada.

### 5. Abrir el PR

Solo si el usuario pidió crear el PR (no solo borrador):

```bash
git push -u origin HEAD   # si la rama no está en remoto
gh pr create --base <base> --title "<título corto>" --body "$(cat <<'EOF'
<cuerpo markdown>
EOF
)"
```

Alternativa en PowerShell/Git Bash Windows: escribir el cuerpo a un archivo temporal, `gh pr create --body-file /tmp/pr-body.md`, borrar el temporal.

### 6. Reporte al usuario

Devolver:

- URL del PR creado (o el markdown si fue solo borrador).
- Rama → base.
- Tipo elegido y módulos en `-u`.

## Checklist antes de `gh pr create`

- [ ] Diff revisado; descripción fiel al cambio real.
- [ ] Ningún archivo del repo fue modificado en esta sesión.
- [ ] No se ejecutó ningún comando de merge.
- [ ] Instrucciones de despliegue: solo comandos `sudo docker`, sin prosa.
- [ ] Modelos listados coinciden con archivos del diff.

## Ejemplo de salida (cuerpo)

```markdown
## Título
fix: orden Plaza misma hora por saldo ASC

## Identificación principal
Fix
Corrección de orden intradía en extractos Banco Plaza.

## Descripción breve
Reordena movimientos con la misma hora usando saldo banco ascendente. Alinea SF con la última línea del extracto. Incluye tests de regresión para el parser diario DESC.

## Modelos tocados
- `tesoreria.bank.statement.line` — lógica de orden y SF en importación Plaza
- `tesoreria.bank.statement.import.wizard` — resync sin gate infer

## Instrucciones de despliegue
```bash
sudo docker compose exec web odoo --config /etc/odoo/odoo.conf -d odoo-maploca -u maploca_tesoreria --workers=0 --stop-after-init
```
```

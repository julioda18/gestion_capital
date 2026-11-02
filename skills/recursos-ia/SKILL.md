---
name: recursos-ia
description: Instala, sincroniza y cataloga skills personales desde D:\recursos_ia\skills. Usar al agregar skills nuevos, reinstalar junctions en ~/.cursor/skills, o cuando el usuario mencione recursos_ia.
disable-model-invocation: true
---

# Recursos IA — Skills personales

## Ubicación canónica

| Rol | Ruta |
|-----|------|
| Fuente (editar aquí) | `D:\recursos_ia\skills\{nombre}\SKILL.md` |
| Cursor (junction) | `~/.cursor/skills/{nombre}\` → fuente |

**No** crear skills en `~/.cursor/skills-cursor/` — reservado para Cursor.

## Instalar o re-sincronizar

Ejecutar en PowerShell (crea directorio y junctions; omite los que ya existen):

```powershell
$src = "D:\recursos_ia\skills"
$dst = "$env:USERPROFILE\.cursor\skills"
New-Item -ItemType Directory -Force -Path $dst | Out-Null
Get-ChildItem -Directory $src | ForEach-Object {
    $link = Join-Path $dst $_.Name
    if (-not (Test-Path $link)) {
        cmd /c mklink /J `"$link`" `"$($_.FullName)`"
    }
}
```

Para un skill nuevo: crear carpeta en `D:\recursos_ia\skills\{nombre}\`, luego ejecutar el bloque anterior o solo el `mklink` de esa carpeta.

## Catálogo

| Skill | Cuándo usar |
|-------|-------------|
| `sdd` | Feature no trivial — spec antes de codificar |
| `spec` | Documentar decisiones de conversación ya ocurrida |
| `kr-query` | Consultar `docs/kr/` antes de decidir |
| `kr-write` | Persistir decisión arquitectónica en KR |
| `tdd` | Red-green-refactor, slice vertical |
| `code-review` | Revisar diff antes de PR (solo texto, sin editar) |
| `create-pr` | Abrir PR con título, resumen estructurado y comandos sudo docker (sin merge ni editar código) |
| `diagnose` | Bug difícil — loop reproducir → fix → test |
| `fix-known` | Buscar en `doc_errores.md` antes de arreglar |
| `craft` | Vago → prompt estructurado CONTEXT/GOAL/… |
| `grill-me` | Plan ambiguo — entrevistar antes de código |
| `ponytail` | Mínimo código, YAGNI |
| `doc-sweep` | Sincronizar docs tras completar trabajo |
| `handoff` | Compactar sesión para otra sesión |
| `engram` | Guardar estado en `CONTEXT.md` al cerrar sesión |
| `client-brief` | Capturar/sintetizar requerimientos del cliente en lenguaje llano |
| `plan-audit` | Verificar plan vs código/docs, corregir drift y reescribir el plan |

## Añadir skill nuevo

1. Carpeta `D:\recursos_ia\skills\{nombre}/` con `SKILL.md`
2. Frontmatter en línea 1:

```yaml
---
name: nombre-en-minusculas
description: Qué hace. Usar cuando...
---
```

3. Junction: `cmd /c mklink /J "%USERPROFILE%\.cursor\skills\{nombre}" "D:\recursos_ia\skills\{nombre}"`
4. Reiniciar Cursor o nueva conversación para que aparezca en el menú `/`

## Convenciones

- `disable-model-invocation: true` en skills de solo lectura (`/code-review`, `/create-pr`, `/grill-me`, `/craft`, `/handoff`, `/doc-sweep`, `/spec`)
- Editar siempre la fuente en `D:\recursos_ia\skills` — los junctions reflejan al instante

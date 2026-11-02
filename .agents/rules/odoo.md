---
trigger: always_on
---

# Antigravity Global Rules - Odoo Multiversion Framework (v17 / v18)

## Activation
Type: Always On
Description: Reglas globales de aislamiento, estandarización de estructuras XML/Scaffold, protocolo estricto de errores, enfoque exclusivo en código fuente y máxima densidad de respuesta para entornos Odoo 17 y Odoo 18.

---

## REGLA 1: DETECCIÓN DE ENTORNO Y AISLAMIENTO DE DIRECTORIOS
- Antes de procesar cualquier orden, generar código o documentar, DEBES identificar la ruta y versión actual del proyecto:
  * **Entorno Maploca (Odoo 18):** Ubicado en `d:\maploca\odoo\addons\`. Se ejecuta sobre Docker (`odoo18-web`).
  * **Entorno Secundario (Odoo 17):** Ubicado en `D:\odoo17\server\odoo\addons\`.
- **Aislamiento Absoluto:** Queda prohibido mezclar el contexto de ambos entornos. No sugieras código, manifiestos ni documentación de un módulo dentro de la carpeta de otro. Cada addon es un universo independiente.

---

## REGLA 2: ESTÁNDAR DE ESTRUCTURA Y COMPATIBILIDAD XML
- **Scaffolding e Inserciones:** Toda nueva creación de archivos o módulos debe replicar rigurosamente la convención y arquitectura limpia ya existente en la carpeta de `addons` correspondiente.
- **Estructura Requerida:** Todo módulo nuevo debe nacer con `__init__.py`, `__manifest__.py`, `models/`, `views/` y `security/ir.model.access.csv`.
- **Compatibilidad ORM/XML:** Al escribir vistas XML (`<record>`, `<field>`), herencias de vistas (`position="inside"`, `position="after"`) o lógica de modelos en Python, debes asegurar que la sintaxis sea 100% compatible con la versión detectada (v17 o v18). Revisa estrictamente que las dependencias lógicas estén declaradas en el manifiesto para evitar fallos de carga en el árbol de dependencias de Odoo.

---

## REGLA 3: PROTOCOLO DE DOCUMENTACIÓN DE ERRORES (ESTRICTO)
Cuando se reporte un error, bug, traceback o falla de logs (sea de Docker en v18 o del servicio en v17), la ÚNICA respuesta permitida debe ser el análisis y la solución formateados como el archivo `doc_errores.md` en la raíz del módulo afectado. Esto se usara para cuando el usuario mande el error de nuevo por el prompt, lo lea y lo corrija sin tanta busqueda
No borres un error cuando agregues otro, ve acumulando los errores uno debajo del otro.

*Instrucciones de formato:* Cero saludos. Cero introducciones. Cero confirmaciones. Se generará ÚNICAMENTE el siguiente bloque de texto en formato Markdown:

# [título del error en minúsculas y muy descriptivo]

**Error:** [Pega el traceback clave, mensaje del log, o el síntoma principal]

**Causa:** [Explicación técnica orientada al entorno detectado (Docker/Odoo 18 o Local/Odoo 17), dependencias de addons o código Python/XML]

**Solución implementada:** [Comandos exactos de terminal, ajustes en la configuración, o correcciones en el código fuente, especificar archivo y ruta]

**Resultado:** [Estado del entorno de desarrollo tras aplicar la solución]

---

## REGLA 4: ENFOQUE EXCLUSIVO EN CÓDIGO (PROHIBICIÓN DE BÚSQUEDAS POR COMANDOS O BD)
- **No realizar búsquedas de comandos del sistema** (`docker build`, `git pull`, `ps aux`, `ls`, `systemctl`) a menos que el usuario lo solicite explícitamente.
- **No sugerir ni ejecutar consultas directas a la base de datos** (SQL, `psql`, inspección de datos en caliente del ORM) como diagnóstico.
- **Concentrarse únicamente en el código fuente** del módulo Odoo afectado: Python (`models/`, `controllers/`, `wizards/`), XML (`views/`, `data/`, `security/`), manifiestos y estructura.
- **Excepción:** Se permite mencionar el comando `docker exec` una sola vez si el problema requiere ejecutar algo dentro del contenedor Docker (ej. dependencias del sistema), justificándolo técnicamente según el código.
- **Incumplimiento:** Incluir búsquedas prohibidas se considerará una violación grave de estas reglas globales.

---

## REGLA 5: PROTOCOLO DE CONCISIÓN Y DENSIDAD
**Objetivo:** Maximizar la densidad de información, minimizar el consumo de tokens y mantener la precisión técnica absoluta.

### 1. Protocolo Semántico
- **Sin Prosa:** Prohibido el texto explicativo o introductorio. Usar exclusivamente listas con viñetas y pares Clave-Valor.
- **Taquigrafía:** Utilizar símbolos (`→`, `∵`, `Δ`, `!`) y abreviaturas estándar (`auth`, `env`, `ctx`, `m2o`, `o2m`).
- **Cero Porqués ("Zero-Why"):** Entregar soluciones e instrucciones directas e inmediatas. Omitir justificaciones teóricas a menos que se soliciten explícitamente.
- **Micro-Diffs:** Retornar ÚNICAMENTE las líneas modificadas (`- antiguo` / `+ nuevo`). Queda prohibido reescribir archivos o funciones completas si solo cambia una parte.

### 2. Simplicidad del Código
- **Sintaxis:** Priorizar estructuras modernas y compactas (retornos tempranos, guardas, comprensión de listas/diccionarios) sobre bucles verbosos.
- **Cero Comentarios ("Zero-Comment"):** Eliminar comentarios redundantes. Explicar únicamente el *porqué* de lógicas altamente complejas, nunca el *qué* hace el código.
- **Alcance Estricto:** Aplicar correcciones localizadas. No realizar refactorizaciones amplias o no solicitadas.
- **Datos > Lógica:** Reemplazar condicionales encadenados pesados (`if/else`, `switch`) por mapas de búsqueda (`dict` de Python o mapeos simples).

### 3. Restricción de Respaldo (Fallback Constraint)
- **Límite:** Si la salida proyectada supera los **200 tokens**, DETENERSE. Reevaluar la respuesta, utilizar herramientas CLI internas (`grep`, `jq`) o las herramientas de CLI de Powershell si es necesario, o solicitar permiso explícito del usuario antes de continuar.

---

## REGLA 6: OPTIMIZACIÓN Y MEJORES PRÁCTICAS DE INGENIERÍA DE CÓDIGO
**Enfoque:** Garantizar código eficiente, limpio, seguro y mantenible bajo estándares estrictos de desarrollo.

### 1. Arquitectura y Diseño
- **Principio de Responsabilidad Única (SRP):** Cada clase, modelo o función debe cumplir un único propósito bien definido.
- **Modularidad:** Dividir la lógica en funciones/módulos pequeños con alta cohesión y bajo acoplamiento.
- **DRY (Don't Repeat Yourself):** Prohibido duplicar código. Abstraer lógica recurrente en métodos o funciones utilitarias reutilizables.
- **Planificación Previa:** Estructurar y diseñar la solución conceptualmente antes de proceder con la escritura del código fuente.

### 2. Estilo y Legibilidad (Clean Code)
- **Nombres Descriptivos:** Variables, funciones, campos y clases con nombres autoexplicativos que revelen su intención explícita.
- **Estilo Consistente:** Mantener rigurosamente las convenciones de estilo del proyecto (PEP 8 para Python, XML estándar de Odoo).
- **Comentarios Mínimos:** *Restricción estricta:* Usar comentarios solo para documentar el *porqué* de lógicas complejas no evidentes o formatos estándar de documentación pública. Cero comentarios redundantes sobre el *qué*.
- **Sin Variables Globales:** Minimizar o eliminar el uso de variables globales para evitar efectos secundarios y facilitar el debugging.

### 3. Rendimiento y Datos
- **Eficiencia Espacio-Temporal:** Escribir algoritmos optimizados evaluando el consumo de tiempo de ejecución (CPU) y el uso eficiente de memoria (RAM).
- **Estructuras de Datos Adecuadas:** Seleccionar siempre la estructura de datos más simple y eficiente para el problema (`dict`, `list`, `set`), evitando complejidades innecesarias.
- **Refactorización Continua:** Revisar y limpiar el código regularmente para eliminar redundancias y mejorar la eficiencia del módulo.

### 4. Robustez, Pruebas y Seguridad
- **Gestión de Errores:** Controlar excepciones de forma precisa (`try/except` localizados) para evitar caídas del sistema o comportamientos inesperados.
- **Validación y Seguridad:** Sanitizar y validar rigurosamente toda entrada de usuario o datos externos para prevenir vulnerabilidades de seguridad.
- **Pruebas Unitarias y Escenarios:** Implementar tests unitarios (en su carpeta "tests") y asegurar la validación del código en escenarios diversos, incluyendo casos límite (*edge cases*) y flujos de error.
- **Registro de Cambios:** Documentar cambios significativos en el código (esto guiado de la estructura que estara en docs) o en el archivo de errores (siguiendo la estrcutura del archivo `doc_errores.md`) para mantener la trazabilidad de su evolución.
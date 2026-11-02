# Gestión de Capital y Acciones

Módulo para Odoo 17 que permite registrar y consultar la estructura financiera de la empresa: activos, pasivos, patrimonio y participación accionaria.

| | |
|---|---|
| **Nombre técnico** | `gestion_capital` |
| **Versión** | 17.0.1.0.0 |
| **Dependencias** | `base`, `web` |
| **Tipo** | Aplicación independiente |

---

## Funcionalidades

- Registro de **activos**: efectivo, cuentas por cobrar, inventario, inversiones y propiedades/equipo.
- Registro de **pasivos**: deudas bancarias, cuentas por pagar, gastos acumulados y préstamos a largo plazo.
- Cálculo automático de **total de activos**, **total de pasivos** y **patrimonio**.
- Gestión de **accionistas** con porcentaje de participación y validación de que la suma no supere el 100%.
- Barra de progreso con colores según el porcentaje total asignado:
  - Verde = 100%
  - Amarillo = menos de 100%
  - Rojo = más de 100%
- Vista lista con filas en rojo cuando el patrimonio es negativo.
- Flujo de estados: **Borrador** → **Confirmado**.
- Restricción de acceso por grupo de seguridad y por compañía (multi-compañía).

---

## Modelos

### `gestion.capital`

Modelo principal de configuración de capital.

| Campo | Tipo | Descripción |
|---|---|---|
| `referencia` | Char | Nombre o referencia del registro |
| `estado` | Selection | `borrador` / `confirmado` |
| `compania_id` | Many2one | Compañía asociada |
| `moneda_id` | Many2one | Moneda de la compañía |
| `efectivo` | Monetary | Efectivo |
| `cuentas_por_cobrar` | Monetary | Cuentas por cobrar |
| `inventario` | Monetary | Inventario |
| `inversiones` | Monetary | Inversiones |
| `propiedades_equipo` | Monetary | Propiedades y equipo |
| `deudas_bancarias` | Monetary | Deudas bancarias |
| `cuentas_por_pagar` | Monetary | Cuentas por pagar |
| `gastos_acumulados` | Monetary | Gastos acumulados |
| `prestamos_largo_plazo` | Monetary | Préstamos a largo plazo |
| `total_activos` | Monetary | Calculado (almacenado) |
| `total_pasivos` | Monetary | Calculado (almacenado) |
| `patrimonio` | Monetary | Calculado: activos − pasivos |
| `accionista_ids` | One2many | Lista de accionistas |
| `porcentaje_total` | Float | Suma de porcentajes de accionistas |

### `gestion.accionista`

Modelo de accionistas vinculado a una configuración de capital.

| Campo | Tipo | Descripción |
|---|---|---|
| `nombre` | Char | Nombre del accionista |
| `porcentaje` | Float | Participación (0 < x ≤ 100) |
| `gestion_capital_id` | Many2one | Registro de capital padre |
| `compania_id` | Many2one | Compañía asociada |

**Validaciones:**
- Cada accionista debe tener un porcentaje mayor a 0 y menor o igual a 100.
- La suma de porcentajes de un mismo registro de capital no puede superar el 100%.

---

## Seguridad

| Grupo | XML ID | Permisos |
|---|---|---|
| Admin de Capital | `gestion_capital.group_admin_capital` | Crear, leer, editar y eliminar |
| Usuario interno (`base.group_user`) | — | Sin acceso (0, 0, 0, 0) |

- Solo los usuarios con el grupo **Admin de Capital** ven el menú y pueden acceder a los modelos.
- Reglas de registro (`ir.rule`) limitan los datos a la compañía del usuario.

---

## Menús

- **Capital y Acciones** (menú raíz)
  - **Configuración de Capital** → vista lista y formulario de `gestion.capital`

---

## Estructura del módulo

```
gestion_capital/
├── __init__.py
├── __manifest__.py
├── README.md
├── models/
│   ├── __init__.py
│   ├── gestion_capital.py
│   └── gestion_accionista.py
├── views/
│   ├── gestion_capital_views.xml
│   └── gestion_accionista_views.xml
└── security/
    ├── groups.xml
    ├── ir.model.access.csv
    └── gestion_capital_security.xml
```

---

## Instalación

1. Asegúrate de que la carpeta `gestion_capital` esté en el `addons_path` de Odoo.
2. Reinicia el servicio de Odoo.
3. Ve a **Aplicaciones** → **Actualizar lista de aplicaciones**.
4. Busca **"Gestión de Capital y Acciones"** e instálalo.
5. Asigna el grupo **Admin de Capital** a los usuarios que deban usar el módulo:
   **Ajustes → Usuarios → [usuario] → pestaña Derechos de acceso**.

---

## Datos de demostración

Este módulo **no incluye datos de demostración**. Al instalarlo no se crean registros de prueba.

Si en algún momento necesitas datos de ejemplo para desarrollo, puedes crearlos manualmente desde la aplicación o restaurar un archivo `data/demo_data.xml` y la clave `demo` en `__manifest__.py` de forma temporal en tu entorno local.

---

## Autor

Academos — Licencia LGPL-3

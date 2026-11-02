
# pago cashea no marca al dia y boton sincronizar no actualiza inscripcion

**Error:** Pago registrado en contabilidad (Cashea / curso / diplomado) visible en historial pero la fila del estudiante en la sección no muestra "Al día"; el botón Sincronizar no da feedback ni refresca la vista.

**Causa:** Sync fragmentado en varios métodos (`_sync_enrollment_payment`, botones con dominios distintos) sin recompute ni corrección de Cashea/BCV. Cashea quedaba como Abono con fecha vencida ? insolvente. Fallback tasa BCV 1.0. Botones solo buscaban huérfanas y devolvían sin notificación/reload.

**Solución implementada:**
- Nuevo pipeline `academy.payment.sync` en `addons/classroom_admin/models/payment_sync.py` (tasa BCV, normalizar Cashea, link estricto, solvencia, certificación, notify+reload).
- `contabilidad.transaccion`: Cashea forzado en create/write, constraint Cashea?Abono, onchange moneda/fecha, `get_rate_for_date`.
- `academos_bcv_rate`: `get_rate_for_date`, sin fallback 1.0 silencioso.
- Depends explícitos: `contabilidad` y `classroom_admin` ? `academos_bcv_rate`.
- Botones Sincronizar y wizard de sección delegan al pipeline con `display_notification` + reload.
- UI: columna "Al día", Cashea readonly en formulario de pago.

**Resultado:** Guardar un pago académico sincroniza automáticamente; recovery con toast y refresco inmediato de la lista de estudiantes.

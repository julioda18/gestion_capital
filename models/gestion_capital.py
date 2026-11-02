from odoo import api, fields, models


class GestionCapital(models.Model):
    _name = 'gestion.capital'
    _description = 'Gestión de Capital y Acciones'
    _order = 'create_date desc, id desc'

    referencia = fields.Char(
        string='Referencia',
        required=True,
        default='Nueva Configuración de Capital',
    )
    estado = fields.Selection(
        selection=[
            ('borrador', 'Borrador'),
            ('confirmado', 'Confirmado'),
        ],
        string='Estado',
        default='borrador',
        required=True,
    )
    compania_id = fields.Many2one(
        'res.company',
        string='Compañía',
        required=True,
        default=lambda self: self.env.company,
    )
    moneda_id = fields.Many2one(
        'res.currency',
        string='Moneda',
        related='compania_id.currency_id',
        store=True,
        readonly=True,
    )

    # Activos
    efectivo = fields.Monetary(string='Efectivo', currency_field='moneda_id', default=0.0)
    cuentas_por_cobrar = fields.Monetary(string='Cuentas por Cobrar', currency_field='moneda_id', default=0.0)
    inventario = fields.Monetary(string='Inventario', currency_field='moneda_id', default=0.0)
    inversiones = fields.Monetary(string='Inversiones', currency_field='moneda_id', default=0.0)
    propiedades_equipo = fields.Monetary(string='Propiedades/Equipo', currency_field='moneda_id', default=0.0)

    # Pasivos
    deudas_bancarias = fields.Monetary(string='Deudas Bancarias', currency_field='moneda_id', default=0.0)
    cuentas_por_pagar = fields.Monetary(string='Cuentas por Pagar', currency_field='moneda_id', default=0.0)
    gastos_acumulados = fields.Monetary(string='Gastos Acumulados', currency_field='moneda_id', default=0.0)
    prestamos_largo_plazo = fields.Monetary(string='Préstamos a Largo Plazo', currency_field='moneda_id', default=0.0)

    # Campos calculados
    total_activos = fields.Monetary(
        string='Total Activos',
        compute='_compute_totales',
        store=True,
        currency_field='moneda_id',
    )
    total_pasivos = fields.Monetary(
        string='Total Pasivos',
        compute='_compute_totales',
        store=True,
        currency_field='moneda_id',
    )
    patrimonio = fields.Monetary(
        string='Patrimonio',
        compute='_compute_totales',
        store=True,
        currency_field='moneda_id',
    )

    # Accionistas
    accionista_ids = fields.One2many(
        'gestion.accionista',
        'gestion_capital_id',
        string='Accionistas',
    )
    porcentaje_total = fields.Float(
        string='Participación Total (%)',
        compute='_compute_porcentaje_total',
        store=True,
        digits=(5, 2),
    )

    @api.depends(
        'efectivo', 'cuentas_por_cobrar', 'inventario', 'inversiones', 'propiedades_equipo',
        'deudas_bancarias', 'cuentas_por_pagar', 'gastos_acumulados', 'prestamos_largo_plazo',
    )
    def _compute_totales(self):
        for registro in self:
            registro.total_activos = (
                registro.efectivo
                + registro.cuentas_por_cobrar
                + registro.inventario
                + registro.inversiones
                + registro.propiedades_equipo
            )
            registro.total_pasivos = (
                registro.deudas_bancarias
                + registro.cuentas_por_pagar
                + registro.gastos_acumulados
                + registro.prestamos_largo_plazo
            )
            registro.patrimonio = registro.total_activos - registro.total_pasivos

    @api.depends('accionista_ids.porcentaje')
    def _compute_porcentaje_total(self):
        for registro in self:
            registro.porcentaje_total = sum(registro.accionista_ids.mapped('porcentaje'))

    def action_confirmar(self):
        self.write({'estado': 'confirmado'})

    def action_borrador(self):
        self.write({'estado': 'borrador'})

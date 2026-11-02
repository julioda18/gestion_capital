from odoo import api, fields, models
from odoo.exceptions import ValidationError


class GestionAccionista(models.Model):
    _name = 'gestion.accionista'
    _description = 'Accionista'
    _order = 'porcentaje desc, nombre'

    nombre = fields.Char(string='Nombre del Accionista', required=True)
    porcentaje = fields.Float(
        string='Porcentaje de Participación (%)',
        required=True,
        digits=(5, 2),
    )
    gestion_capital_id = fields.Many2one(
        'gestion.capital',
        string='Gestión de Capital',
        required=True,
        ondelete='cascade',
    )
    compania_id = fields.Many2one(
        'res.company',
        string='Compañía',
        required=True,
        default=lambda self: self.env.company,
    )

    @api.constrains('porcentaje')
    def _check_rango_porcentaje(self):
        for registro in self:
            if registro.porcentaje <= 0 or registro.porcentaje > 100:
                raise ValidationError(
                    'El porcentaje de participación debe ser mayor a 0 y menor o igual a 100.'
                )

    @api.constrains('porcentaje', 'gestion_capital_id')
    def _check_porcentaje_total(self):
        for registro in self:
            if not registro.gestion_capital_id:
                continue
            accionistas = registro.gestion_capital_id.accionista_ids
            total = sum(accionistas.mapped('porcentaje'))
            if total > 100:
                raise ValidationError(
                    'La suma de los porcentajes de participación no puede superar el 100%. '
                    f'Total actual: {total:.2f}%.'
                )

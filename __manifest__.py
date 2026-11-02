{
    'name': 'Gestión de Capital y Acciones',
    'version': '17.0.1.0.0',
    'category': 'Accounting',
    'summary': 'Gestión de capital, activos, pasivos y accionistas',
    'description': """
        Módulo para gestionar la configuración de capital y acciones de la empresa.
        Permite registrar activos, pasivos, patrimonio y participación accionaria.
    """,
    'author': 'Academos',
    'depends': ['base', 'web'],
    'data': [
        'security/groups.xml',
        'security/ir.model.access.csv',
        'security/gestion_capital_security.xml',
        'views/gestion_accionista_views.xml',
        'views/gestion_capital_views.xml',
    ],
    'application': True,
    'installable': True,
    'license': 'LGPL-3',
}

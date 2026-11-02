---
name: client-brief
description: Genera el correo de captura de requerimientos al cliente (5 puntos, sin tecnicismos) y sintetiza sus respuestas en resumen + preguntas de confirmación. Usar al iniciar un proyecto con cliente, recopilar necesidades, o cuando el usuario pida brief de cliente, requerimientos no técnicos, o plantilla de correo al cliente.
disable-model-invocation: true
---

# /client-brief

> ⚠️ PROHIBICIÓN CRÍTICA: NO ESCRIBIR CÓDIGO NI SPECS TÉCNICAS.
> TU TRABAJO ES COMUNICACIÓN CON EL CLIENTE EN LENGUAJE LLANO. SI GENERAS CONTRATOS DE CÓDIGO O ARQUITECTURA, FALLASTE.

## Cuándo usar

- Inicio de proyecto con cliente externo
- El usuario necesita enviar o procesar requerimientos no técnicos
- Antes de `/sdd` — capturar el **qué** y el **para quién**, no el **cómo**

## Diferencia vs otros skills

| Skill | Rol |
|---|---|
| `/grill-me` | Entrevista técnica al desarrollador, 1 pregunta/vez |
| `/craft` | Prompt técnico para el agente |
| `/client-brief` | Correo y síntesis para el **cliente**, sin jerga |

---

## Fase A — Generar correo al cliente

Si el usuario pide la plantilla o va a contactar al cliente, generar el correo con este texto **verbatim** (misma estructura, mismos 5 puntos, mismo orden):

```
Para construir lo que necesitas no me hace falta un documento largo. Me hace falta poco texto y un ejemplo real. Respóndeme este correo con cinco puntos cortos —dos o tres renglones cada uno, en tus palabras, sin tecnicismos— y los adjuntos.

1. Contexto. ¿Quién hace esto hoy, en qué momento, cada cuánto, y con qué herramienta?

2. Logro. ¿Qué debería cambiar y cómo lo notarías? Si puedes, dime qué te cuesta hoy (horas, errores, dinero, retrabajos). Un número aproximado sirve.

3. Un caso real. Escoge un caso verdadero, reciente y completo, y adjúntame:
   - el archivo o formato que usan hoy (Excel con las fórmulas visibles, captura, formato en papel escaneado)
   - ese caso ya resuelto, con datos reales
   - lo que tuvo que salir al final (etiqueta, reporte, PDF, correo)
   Si tienes un caso que se salió de lo normal, mándame ese también. Vale por diez casos normales.

4. Reglas. ¿Qué hace que un caso se trate distinto de otro? ¿Qué se le olvida siempre a la gente nueva? ¿Hay algún límite o validación que no se puede violar?

5. Cuándo lo das por bueno. Complétame la frase: "Lo daré por bueno cuando __." Y dime tres cosas que NO quieres que haga en esta primera versión.

Opcional pero muy útil: si quieres indicarme cómo debería verse una pantalla, no la dibujes. Escríbeme algo así:
PANTALLA: <nombre> muestra: <qué datos ve> se puede: <qué botones o acciones hay> lleva a: <a dónde va después>
O simplemente mándame una foto del pizarrón, o una captura con flechas y anotaciones encima.

No te preocupes por que quede completo ni bien redactado. Con esto te devuelvo un resumen de lo que entendí y una lista corta de preguntas ya con la respuesta que yo propongo, para que solo me digas "sí" o me corrijas. De ahí arrancamos.

Saludos.
```

### Reglas al generar el correo

- Español claro, cero tecnicismos
- No parafrasear la estructura de los 5 puntos
- Personalizar solo el saludo/cierre si el usuario da contexto (nombre del cliente, proyecto)
- Recordar al usuario que adjunte ejemplos en el punto 3

---

## Fase B — Sintetizar respuestas del cliente

Cuando el usuario pegue la respuesta del cliente (texto, transcripción, descripción de adjuntos):

1. Extraer los 5 puntos en lenguaje llano (palabras del cliente, no jerga técnica)
2. Identificar el caso real del punto 3 como ancla principal
3. Traducir reglas y criterio de "bueno" a frases concretas y verificables
4. Señalar huecos: sin caso real, sin números de costo, sin criterio de aceptación, sin reglas explícitas, adjuntos faltantes
5. Generar preguntas de confirmación con respuesta propuesta — el cliente solo dice "sí" o corrige

### Output format (Fase B)

```markdown
## Resumen de lo entendido

### 1. Contexto
[2-3 renglones en palabras del cliente]

### 2. Logro
[Qué cambia, cómo se nota, costo actual si lo dio]

### 3. Caso real
[Descripción del caso ancla + qué adjuntos recibió o faltan]

### 4. Reglas
[Reglas explícitas e implícitas, sin tecnicismos]

### 5. Criterio de bueno
["Lo daré por bueno cuando..." + 3 exclusiones de v1]

## Preguntas para confirmar

1. [Pregunta] → Propongo: [respuesta]. ¿Correcto?
2. ...

## Huecos / adjuntos faltantes

- [...]

## Siguiente paso

Esperar confirmación del cliente. Tras el "sí", pasar a `/sdd` o `/spec` para la spec técnica.
```

### Reglas de síntesis

- Si el cliente usó jerga técnica, traducir a lenguaje de negocio en el resumen
- Si hay contradicción entre puntos, señalarla en preguntas de confirmación
- Si hay bloque `PANTALLA:`, incluirlo tal cual en el resumen
- Un caso anómalo del punto 3 vale por diez casos normales — priorizarlo en la síntesis
- No inventar requisitos que el cliente no mencionó

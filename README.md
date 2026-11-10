# Despliegue de la API de la app de pedidos con Terraform

El equipo de desarrollo móvil de una fintech necesita desplegar la API de la app de pedidos en la nube utilizando Terraform. La aplicación móvil, construida con Flutter, consume servicios de esta API para procesar pedidos de los clientes. El objetivo es aprovisionar la infraestructura necesaria para que la API opere de manera eficiente y escalable. Los recursos incluyen una base de datos, servidores de aplicación y un balanceador de carga. El dominio es el de una aplicación móvil de pedidos en una fintech, donde los actores son los clientes (que hacen pedidos), el sistema de pedidos (que procesa las solicitudes) y el almacenamiento de datos (que persiste la información de los pedidos).

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el proyecto de la API de la app de pedidos.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los recursos necesarios para la API (base de datos, servidores de aplicación, balanceador de carga).
- Configurar el archivo principal de Terraform con los proveedores y variables necesarias.
- Definir los outputs para verificar la correcta configuración del entorno.

**Entregable:** Archivo de configuración de Terraform con proveedores, variables y outputs definidos.

<details>
<summary>Pistas de conocimiento</summary>

- Terraform permite la gestión de infraestructura como código.
- Las variables en Terraform facilitan la parametrización de la configuración.

</details>

### Fase 2: Aprovisionamiento de la base de datos

**Objetivo:** Aprovisionar una base de datos para la API utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Seleccionar el tipo de base de datos adecuado para las necesidades de la aplicación.
- Configurar el recurso de base de datos en Terraform, incluyendo parámetros como el tamaño, la región y las reglas de acceso.
- Verificar que la base de datos se ha creado correctamente y está accesible.

**Entregable:** Recurso de base de datos configurado y verificado en Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- La elección del tipo de base de datos depende de los requisitos de la aplicación.
- Los parámetros de configuración de la base de datos incluyen tamaño, región y reglas de acceso.

</details>

### Fase 3: Despliegue de los servidores de aplicación

**Objetivo:** Desplegar los servidores de aplicación para la API utilizando Terraform.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Definir el número de instancias de servidores necesarias para manejar la carga de la aplicación.
- Configurar los recursos de servidores de aplicación en Terraform, incluyendo la imagen del contenedor y las variables de entorno.
- Verificar que los servidores se han desplegado correctamente y están operativos.

**Entregable:** Servidores de aplicación desplegados y verificados en Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- El número de instancias de servidores depende de la carga esperada de la aplicación.
- Las variables de entorno en los servidores de aplicación pueden incluir configuraciones de la API y secretos.

</details>

### Fase 4: Configuración del balanceador de carga

**Objetivo:** Configurar un balanceador de carga para distribuir el tráfico entre los servidores de aplicación.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Seleccionar el tipo de balanceador de carga adecuado para la aplicación.
- Configurar el recurso de balanceador de carga en Terraform, incluyendo las reglas de distribución del tráfico.
- Verificar que el balanceador de carga está configurado correctamente y distribuye el tráfico como se espera.

**Entregable:** Balanceador de carga configurado y verificado en Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- El tipo de balanceador de carga depende de las necesidades de distribución del tráfico de la aplicación.
- Las reglas de distribución del tráfico pueden incluir métodos de balanceo como round-robin o least connections.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y para qué se utiliza en el despliegue de la API de la app de pedidos?
- **paraQueSirve**: ¿Para qué sirve configurar variables en Terraform y cómo se aplican en el despliegue de la infraestructura?
- **comoSeUsa**: ¿Cómo se utiliza Terraform para aprovisionar una base de datos y cuáles son los parámetros importantes a considerar?
- **erroresComunes**: ¿Cuáles son los errores comunes al desplegar servidores de aplicación con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica la selección del tipo de balanceador de carga para la API de la app de pedidos y cómo se justifican?

## Criterios de Evaluacion

- Configuración inicial de Terraform con proveedores y variables definidas.
- Aprovisionamiento de una base de datos configurada correctamente en Terraform.
- Despliegue de servidores de aplicación verificados y operativos en Terraform.
- Configuración de un balanceador de carga que distribuye el tráfico como se espera.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: http://<load_balancer_dns>/api):
  - `GET /api/orders`
  - `POST /api/orders`
- `client` expone http (api: http://<load_balancer_dns>/api):
  - `GET /api/orders`
  - `POST /api/orders`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*

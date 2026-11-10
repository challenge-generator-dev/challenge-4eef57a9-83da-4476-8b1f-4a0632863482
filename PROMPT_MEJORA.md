# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/app_servers/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/app_servers/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/app_servers/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/load_balancer/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/load_balancer/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/load_balancer/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

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

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261109223818458), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el proyecto de la API de la app de pedidos. — entregable (NO resolver): Archivo de configuración de Terraform con proveedores, variables y outputs definidos.
- Fase 2: Aprovisionamiento de la base de datos — objetivo: Aprovisionar una base de datos para la API utilizando Terraform. — entregable (NO resolver): Recurso de base de datos configurado y verificado en Terraform.
- Fase 3: Despliegue de los servidores de aplicación — objetivo: Desplegar los servidores de aplicación para la API utilizando Terraform. — entregable (NO resolver): Servidores de aplicación desplegados y verificados en Terraform.
- Fase 4: Configuración del balanceador de carga — objetivo: Configurar un balanceador de carga para distribuir el tráfico entre los servidores de aplicación. — entregable (NO resolver): Balanceador de carga configurado y verificado en Terraform.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
terraform {
  required_version = ">= 1.8.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}

# Provider AWS con configuración regional y credenciales
provider "aws" {
  region = var.aws_region
  # Las credenciales se configuran mediante variables de entorno o AWS CLI
  # para evitar exponerlas en el código. Ejemplo:
  # export AWS_ACCESS_KEY_ID="your_access_key"
  # export AWS_SECRET_ACCESS_KEY="your_secret_key"
}

# Provider Google Cloud con configuración regional
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  # Las credenciales se configuran mediante GOOGLE_APPLICATION_CREDENTIALS
  # export GOOGLE_APPLICATION_CREDENTIALS="/path/to/credentials.json"
}

# Provider Azure con configuración de suscripción
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  # Las credenciales se configuran mediante Azure CLI o variables de entorno
}

# Configuración de backend para estado remoto (ejemplo con S3)
terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-orders-api"
    key            = "terraform/orders-api/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tf-state-lock-orders-api"
  }
}

# Outputs para exponer información crítica del despliegue
output "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  value       = var.aws_region
}

output "gcp_project_id" {
  description = "ID del proyecto de Google Cloud donde se desplegarán los recursos"
  value       = var.gcp_project_id
  sensitive   = true
}

output "azure_subscription_id" {
  description = "ID de la suscripción de Azure donde se desplegarán los recursos"
  value       = var.azure_subscription_id
  sensitive   = true
}

// === ARCHIVO: infra/variables.tf ===
# Variables globales para parametrizar la infraestructura de la API de pedidos

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "gcp_region" {
  description = "Región de Google Cloud donde se desplegarán los recursos"
  type        = string
  default     = "us-central1"
}

variable "gcp_project_id" {
  description = "ID del proyecto de Google Cloud"
  type        = string
  sensitive   = true
}

variable "azure_region" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
  default     = "eastus"
}

variable "azure_subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, staging, prod."
  }
}

variable "app_port" {
  description = "Puerto en el que escuchará la aplicación"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type        = number
  default     = 5432
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "orders_db"
}

variable "instance_type" {
  description = "Tipo de instancia para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "min_instances" {
  description = "Número mínimo de instancias para autoescalado"
  type        = number
  default     = 2
}

variable "max_instances" {
  description = "Número máximo de instancias para autoescalado"
  type        = number
  default     = 5
}

# Variables para el balanceador de carga
variable "lb_listener_port" {
  description = "Puerto del listener del balanceador de carga"
  type        = number
  default     = 80
}

variable "lb_target_port" {
  description = "Puerto objetivo del balanceador de carga"
  type        = number
  default     = 8080
}

variable "lb_protocol" {
  description = "Protocolo del balanceador de carga"
  type        = string
  default     = "HTTP"
}

// === ARCHIVO: infra/modules/database/variables.tf ===
# Variables específicas para el módulo de base de datos

variable "db_engine" {
  description = "Motor de la base de datos (postgres, mysql, etc.)"
  type        = string
  default     = "postgres"

  validation {
    condition     = contains(["postgres", "mysql"], var.db_engine)
    error_message = "El motor de base de datos debe ser postgres o mysql."
  }
}

variable "db_engine_version" {
  description = "Versión del motor de la base de datos"
  type        = string
  default     = "15.4"
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos"
  type        = string
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado a la base de datos en GB"
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Habilitar despliegue multi-AZ para alta disponibilidad"
  type        = bool
  default     = false
}

variable "db_publicly_accessible" {
  description = "Permitir acceso público a la base de datos"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Omitir la creación de un snapshot final al eliminar la base de datos"
  type        = bool
  default     = true
}

variable "db_storage_encrypted" {
  description = "Habilitar cifrado del almacenamiento de la base de datos"
  type        = bool
  default     = true
}

variable "db_backup_retention_period" {
  description = "Período de retención de backups en días"
  type        = number
  default     = 7
}

variable "db_deletion_protection" {
  description = "Protección contra eliminación accidental de la base de datos"
  type        = bool
  default     = false
}

variable "db_vpc_security_group_ids" {
  description = "IDs de los security groups asociados a la base de datos"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Nombre del grupo de subnets para la base de datos"
  type        = string
  default     = "default"
}

# Outputs del módulo (se definen en outputs.tf)
output "db_endpoint" {
  description = "Endpoint de conexión a la base de datos"
  value       = aws_db_instance.orders_db.endpoint
}

output "db_username" {
  description = "Usuario de la base de datos"
  value       = var.db_username
  sensitive   = true
}

// === ARCHIVO: infra/modules/app_servers/variables.tf ===
# Variables específicas para el módulo de servidores de aplicación

variable "app_image_id" {
  description = "ID de la AMI para los servidores de aplicación"
  type        = string
}

variable "app_instance_type" {
  description = "Tipo de instancia para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "app_key_name" {
  description = "Nombre de la clave SSH para acceder a las instancias"
  type        = string
}

variable "app_min_size" {
  description = "Número mínimo de instancias en el grupo de autoescalado"
  type        = number
  default     = 2
}

variable "app_max_size" {
  description = "Número máximo de instancias en el grupo de autoescalado"
  type        = number
  default     = 5
}

variable "app_desired_capacity" {
  description = "Capacidad deseada del grupo de autoescalado"
  type        = number
  default     = 2
}

variable "app_health_check_type" {
  description = "Tipo de health check para las instancias"
  type        = string
  default     = "ELB"
}

variable "app_health_check_grace_period" {
  description = "Período de gracia para el health check en segundos"
  type        = number
  default     = 300
}

variable "app_user_data" {
  description = "Script de user data para configurar las instancias"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                echo "Iniciando configuración de la instancia..."
                # Aquí iría la lógica para instalar dependencias y desplegar la aplicación
                EOF
}

variable "app_security_group_ids" {
  description = "IDs de los security groups asociados a las instancias"
  type        = list(string)
  default     = []
}

variable "app_subnet_ids" {
  description = "IDs de las subnets donde se desplegarán las instancias"
  type        = list(string)
}

variable "app_environment_variables" {
  description = "Variables de entorno para la aplicación"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "DB_HOST"
      value = ""
    },
    {
      name  = "DB_PORT"
      value = "5432"
    },
    {
      name  = "DB_NAME"
      value = "orders_db"
    },
    {
      name  = "DB_USER"
      value = ""
    },
    {
      name  = "DB_PASSWORD"
      value = ""
    }
  ]
}

# Outputs del módulo (se definen en outputs.tf)
output "app_auto_scaling_group_name" {
  description = "Nombre del grupo de autoescalado de servidores"
  value       = aws_autoscaling_group.app_servers.name
}

output "app_launch_template_id" {
  description = "ID de la plantilla de lanzamiento de servidores"
  value       = aws_launch_template.app_servers.id
}

// === ARCHIVO: infra/modules/load_balancer/variables.tf ===
# Variables específicas para el módulo de balanceador de carga

variable "lb_name" {
  description = "Nombre del balanceador de carga"
  type        = string
  default     = "orders-api-lb"
}

variable "lb_internal" {
  description = "Indica si el balanceador de carga es interno"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "Tipo de balanceador de carga (application, network)"
  type        = string
  default     = "application"

  validation {
    condition     = contains(["application", "network"], var.lb_type)
    error_message = "El tipo de balanceador debe ser application o network."
  }
}

variable "lb_listener_port" {
  description = "Puerto del listener del balanceador de carga"
  type        = number
  default     = 80
}

variable "lb_listener_protocol" {
  description = "Protocolo del listener del balanceador de carga"
  type        = string
  default     = "HTTP"
}

variable "lb_target_group_port" {
  description = "Puerto del target group"
  type        = number
  default     = 8080
}

variable "lb_target_group_protocol" {
  description = "Protocolo del target group"
  type        = string
  default     = "HTTP"
}

variable "lb_health_check_path" {
  description = "Ruta para el health check del target group"
  type        = string
  default     = "/health"
}

variable "lb_health_check_port" {
  description = "Puerto para el health check del target group"
  type        = number
  default     = 8080
}

variable "lb_health_check_protocol" {
  description = "Protocolo para el health check del target group"
  type        = string
  default     = "HTTP"
}

variable "lb_health_check_interval" {
  description = "Intervalo entre health checks en segundos"
  type        = number
  default     = 30
}

variable "lb_health_check_timeout" {
  description = "Timeout para el health check en segundos"
  type        = number
  default     = 5
}

variable "lb_healthy_threshold" {
  description = "Número de health checks exitosos para considerar una instancia saludable"
  type        = number
  default     = 2
}

variable "lb_unhealthy_threshold" {
  description = "Número de health checks fallidos para considerar una instancia no saludable"
  type        = number
  default     = 2
}

variable "lb_security_group_ids" {
  description = "IDs de los security groups asociados al balanceador de carga"
  type        = list(string)
  default     = []
}

variable "lb_subnet_ids" {
  description = "IDs de las subnets donde se desplegará el balanceador de carga"
  type        = list(string)
}

# Outputs del módulo (se definen en outputs.tf)
output "lb_dns_name" {
  description = "DNS name del balanceador de carga"
  value       = aws_lb.orders_api_lb.dns_name
}

output "lb_arn" {
  description = "ARN del balanceador de carga"
  value       = aws_lb.orders_api_lb.arn
}

// === ARCHIVO: infra/versions.tf ===
# Configuración de versiones de Terraform
# Este archivo define la versión requerida de Terraform y sus proveedores
# IMPORTANTE: El bloque required_providers NO debe estar aquí porque ya está
# definido en providers.tf. Terraform solo permite un bloque required_providers
# en todo el proyecto.

terraform {
  required_version = ">= 1.8.5"
}

// === ARCHIVO: infra/README.md ===
# Módulo de Infraestructura - API de App de Pedidos

## Propósito

Este módulo aprovisiona la infraestructura necesaria para desplegar la API backend que consume la aplicación móvil de pedidos de la fintech. La arquitectura contempla tres componentes principales: base de datos relacional, servidores de aplicación y balanceador de carga.

## Componentes del Módulo

### 1. Base de Datos (`modules/database/`)
Aprovisiona una instancia de base de datos gestionada con configuración de alta disponibilidad. Provee endpoint de conexión, credenciales y identificador de instancia mediante outputs seguros.

### 2. Servidores de Aplicación (`modules/app_servers/`)
Despliega un grupo de instancias de cómputo que ejecutan la API. Configura auto-scaling, grupos de seguridad y asociación con el balanceador de carga.

### 3. Balanceador de Carga (`modules/load_balancer/`)
Configura un balanceador de aplicación que distribuye tráfico HTTP/HTTPS hacia los servidores de aplicación. Expone el endpoint público de la API.

## Estructura de Directorios

```
infra/
├── versions.tf              # Configuración de versiones de Terraform y providers
├── providers.tf             # Configuración de credenciales de cloud
├── variables.tf             # Variables de entrada del módulo raíz
├── outputs.tf               # Outputs del módulo raíz
├── main.tf                  # Orquestación de módulos
├── modules/
│   ├── database/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── app_servers/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── load_balancer/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev.tfvars
    ├── prod.tfvars
    └── dev/
        └── terraform.tfvars
```

## Uso del Módulo

### Inicialización

```bash
cd infra
terraform init
```

### Validación

```bash
terraform validate
```

### Plan de Ejecución

```bash
# Para desarrollo
terraform plan -var-file=environments/dev.tfvars

# Para producción
terraform plan -var-file=environments/prod.tfvars
```

### Aplicar Cambios

```bash
terraform apply -var-file=environments/dev.tfvars
```

## Variables Requeridas

| Variable | Descripción | Tipo | Valor por defecto |
|----------|-------------|------|--------------------|
| `project_name` | Nombre del proyecto para etiquetado | string | - |
| `environment` | Entorno de despliegue (dev/stg/prod) | string | - |
| `region` | Región de AWS para el despliegue | string | `"us-east-1"` |
| `vpc_cidr` | CIDR block para la VPC | string | `"10.0.0.0/16"` |
| `db_instance_class` | Clase de instancia de base de datos | string | `"db.t3.micro"` |
| `db_allocated_storage` | Almacenamiento allocated en GB | number | `20` |
| `app_instance_type` | Tipo de instancia EC2 para app servers | string | `"t3.medium"` |
| `app_min_size` | Mínimo de instancias en auto-scaling group | number | `2` |
| `app_max_size` | Máximo de instancias en auto-scaling group | number | `6` |
| `app_desired_capacity` | Capacidad deseada inicial | number | `3` |
| `certificate_arn` | ARN del certificado ACM para HTTPS | string | `""` |

## Outputs Expuestos

| Output | Descripción | Sensitive |
|--------|-------------|-----------|
| `api_endpoint` | URL pública del balanceador de carga | no |
| `database_endpoint` | Endpoint de conexión a la base de datos | no |
| `database_password` | Contraseña de la base de datos | yes |
| `app_servers_security_group_id` | ID del security group de app servers | no |
| `lb_dns_name` | DNS name del balanceador de carga | no |

## Validación Local

Para validar la configuración sin ejecutar un plan real:

```bash
terraform validate
terraform fmt -recursive
```

Para verificar que los módulos referenciados existen:

```bash
ls -la modules/database/
ls -la modules/app_servers/
ls -la modules/load_balancer/
```

## Consideraciones de Seguridad

- Las credenciales de base de datos se exponen únicamente como output sensible
- Los security groups siguen el principio de mínimo privilegio
- El balanceador de carga puede configurarse con HTTPS usando certificado ACM
- Los logs de CloudWatch se habilitan para auditoría
- Las instancias usan IAM roles en lugar de credenciales embebidas

## Endpoints de la API

Una vez desplegada la infraestructura, la API queda disponible en:

- **Base URL**: `http://<load_balancer_dns>/api`
- **Get Orders**: `GET /api/orders`
- **Create Order**: `POST /api/orders`

## Destrucción

Para destruir la infraestructura:

```bash
terraform destroy -var-file=environments/dev.tfvars
```

**Advertencia**: Esta operación elimina todos los recursos aprovisionados. Asegúrate de tener backups de la base de datos si es necesario.

// === ARCHIVO: infra/main.tf ===
# Orquestación principal del despliegue de infraestructura para la API de la app de pedidos
# Este archivo coordina los tres módulos: base de datos, servidores de aplicación y balanceador de carga

# Módulo de base de datos - provee almacenamiento persistente para los pedidos
module "database" {
  source = "./modules/database"

  project_name         = var.project_name
  environment          = var.environment
  region               = var.region
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
  vpc_id               = var.vpc_id
  db_subnet_ids        = var.db_subnet_ids
  security_group_id    = var.db_security_group_id
}

# Módulo de servidores de aplicación - ejecuta la API que consume la app móvil
# Se pasa cada parámetro individualmente según lo que el módulo acepta
module "app_servers" {
  source = "./modules/app_servers"

  count             = var.app_servers.instance_count
  instance_type     = var.app_servers.instance_type
  ami_id            = var.app_servers.ami_id
  key_name          = var.app_servers.key_name
  user_data         = var.app_servers.user_data
  vpc_id            = var.vpc_id
  subnet_ids        = var.app_subnet_ids
  security_group_id = var.app_security_group_id

  # Conexión a la base de datos aprovisionada
  database_endpoint = module.database.endpoint
  database_name     = var.db_name
  database_username = var.db_username
  database_password = module.database.password
}

# Módulo de balanceador de carga - distribuye tráfico hacia los servidores de aplicación
module "load_balancer" {
  source = "./modules/load_balancer"

  project_name               = var.project_name
  environment                = var.environment
  region                     = var.region
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.lb_subnet_ids
  security_group_id          = var.lb_security_group_id
  certificate_arn            = var.certificate_arn
  enable_deletion_protection = var.enable_deletion_protection

  # Registra los servidores de aplicación como targets
  target_group_instances = module.app_servers.instance_ids
}

// === ARCHIVO: infra/outputs.tf ===
# Outputs del módulo de infraestructura para la API de la app de pedidos
# Este archivo expone los valores críticos que otros componentes necesitan para consumir la API

# Endpoint del balanceador de carga - URL base para consumir la API
output "api_endpoint" {
  description = "URL base del balanceador de carga para acceder a la API"
  value       = module.load_balancer.lb_dns_name
}

# Endpoint completo de la API
output "api_base_url" {
  description = "URL completa de la API incluyendo el path base"
  value       = "http://${module.load_balancer.lb_dns_name}/api"
}

# Endpoint para obtener pedidos (GET)
output "get_orders_endpoint" {
  description = "Endpoint para obtener la lista de pedidos"
  value       = "http://${module.load_balancer.lb_dns_name}/api/orders"
}

# Endpoint para crear pedidos (POST)
output "create_order_endpoint" {
  description = "Endpoint para crear un nuevo pedido"
  value       = "http://${module.load_balancer.lb_dns_name}/api/orders"
}

# Información de la base de datos
output "database_endpoint" {
  description = "Endpoint de conexión a la base de datos"
  value       = module.database.endpoint
  sensitive   = true
}

output "database_port" {
  description = "Puerto de la base de datos"
  value       = module.database.port
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = module.database.name
}

# Información de los servidores de aplicación
output "app_servers_ips" {
  description = "IPs privadas de los servidores de aplicación"
  value       = module.app_servers.server_private_ips
}

output "app_servers_count" {
  description = "Cantidad de servidores de aplicación desplegados"
  value       = module.app_servers.server_count
}

# Información del balanceador de carga
output "load_balancer_dns" {
  description = "DNS del balanceador de carga"
  value       = module.load_balancer.lb_dns_name
}

output "load_balancer_arn" {
  description = "ARN del balanceador de carga para referencia cruzada"
  value       = module.load_balancer.lb_arn
}

# Resumen de la infraestructura desplegada
output "infra_summary" {
  description = "Resumen de los recursos desplegados"
  value = {
    api_endpoint      = "http://${module.load_balancer.lb_dns_name}/api"
    database_endpoint = module.database.endpoint
    app_servers_count = module.app_servers.server_count
    region            = var.region
  }
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Archivo de variables para el entorno de desarrollo
# Ubicado en environments/dev/ para mantener consistencia con la estructura del proyecto
# Este archivo contiene los valores específicos del entorno de desarrollo

# Configuración general del entorno
environment_name = "dev"
project_name     = "fintech-orders-api"

# Configuración de la base de datos para desarrollo
# Uso de instancia pequeña para reducir costos en desarrollo
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_engine_version    = "15.7"
db_multi_az          = false
db_backup_retention  = 1

# Configuración de servidores de aplicación para desarrollo
# Una sola instancia es suficiente para pruebas de desarrollo
app_instance_count    = 1
app_instance_type     = "t3.small"
app_ami_id            = "ami-0c55b159cbfafe1f0"
app_instance_key_pair = "dev-key-pair"

# Configuración del balanceador de carga para desarrollo
lb_type                       = "application"
lb_scheme                     = "internet-facing"
lb_enable_deletion_protection = false

# Configuración de red para desarrollo
vpc_cidr_block       = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

# Configuración de seguridad
allowed_cidr_blocks = ["0.0.0.0/0"]
enable_flow_logs    = false

# Configuración de etiquetas para identificación
tags = {
  Environment = "development"
  Project     = "fintech-orders-api"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
}

// === ARCHIVO: infra/environments/dev.tfvars ===
# Valores de variables para el entorno de desarrollo
# Este archivo se referencia desde la raíz del proyecto con -var-file=environments/dev.tfvars
# Contiene la configuración completa necesaria para aprovisionar la infraestructura

# Identificación del proyecto y entorno
environment  = "development"
project_name = "fintech-orders-api"
region       = "us-east-1"

# Configuración de base de datos PostgreSQL
# Desarrollo usa db.t3.micro (2 vCPU, 1 GiB) por costos
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "orders_db"
db_username          = "dbadmin"
db_password          = "DevPassword123!"

# Configuración de servidores de aplicación
# Una sola instancia para desarrollo
app_servers = {
  instance_count = 1
  instance_type  = "t3.small"
  ami_id         = "ami-0c55b159cbfafe1f0"
  key_name       = "dev-key-pair"

  # Configuración de user data para inicialización
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p 8080:8080 --name orders-api fintech/orders-api:latest
              EOF
}

# Configuración de red
vpc_id                = "vpc-xxxxxxxx"
db_subnet_ids         = ["subnet-xxxxx1", "subnet-xxxxx2"]
app_subnet_ids        = ["subnet-xxxxx1", "subnet-xxxxx2"]
lb_subnet_ids         = ["subnet-xxxxx1", "subnet-xxxxx2"]
db_security_group_id  = "sg-xxxxx1"
app_security_group_id = "sg-xxxxx2"
lb_security_group_id  = "sg-xxxxx3"

# Configuración de seguridad
ssh_key_name               = "dev-key-pair"
certificate_arn            = ""
enable_deletion_protection = false

# Configuración de etiquetas
tags = {
  Environment = "development"
  Project     = "fintech-orders-api"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Team        = "mobile-development"
  Purpose     = "API backend for orders mobile app"
}

// === ARCHIVO: infra/environments/prod.tfvars ===
# Valores de variables para el entorno de producción
# Este archivo contiene la configuración completa para el entorno de producción
# de la API de la app de pedidos de la fintech
# Configuración optimizada para alta disponibilidad y rendimiento

# Identificación del proyecto y entorno
environment = "production"
project_id  = "fintech-orders-api-prod"
region      = "us-east-1"

# Configuración de base de datos PostgreSQL
# Producción usa configuración de alta disponibilidad con Multi-AZ
database = {
  identifier            = "fintech-orders-db-prod"
  engine                = "postgres"
  engine_version        = "15.7"
  instance_class        = "db.r6g.large"
  allocated_storage     = 100
  storage_type          = "gp3"
  multi_az              = true
  backup_retention_days = 7
  skip_final_snapshot   = false
  deletion_protection   = true

  performance_insights_enabled = true
  enhanced_monitoring_interval = 60

  db_name  = "orders_db"
  username = "dbadmin"
}

# Configuración de servidores de aplicación
# Múltiples instancias con auto-scaling para producción
app_instance_type    = "t3.medium"
app_min_size         = 2
app_max_size         = 10
app_desired_capacity = 3
app_ami_id           = "ami-0c55b159cbfafe1f0"
app_key_name         = "prod-key-pair"
app_instance_count   = 3
app_root_volume_size = 30
app_root_volume_type = "gp3"

# User data para producción - configuración de Docker y CloudWatch
app_user_data = <<-EOT
#!/bin/bash
yum update -y
yum install -y docker amazon-cloudwatch-agent
systemctl start docker
systemctl enable docker

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << 'CWAGENT'
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/orders-api.log",
            "log_group_name": "/aws/ec2/orders-api/prod",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
CWAGENT

systemctl start amazon-cloudwatch-agent

docker run -d --restart always -p 8080:8080 \
  --log-driver=awslogs \
  --log-opt awslogs-group=/aws/ec2/orders-api/prod \
  --log-opt awslogs-stream={instance_id} \
  --name orders-api fintech/orders-api:latest
EOT

# Health check para producción
app_health_check_path     = "/api/health"
app_health_check_interval = 10

# Métricas para auto-scaling
app_scaling_metric    = "CPUUtilization"
app_scaling_threshold = 70

# Configuración del balanceador de carga
load_balancer = {
  name                       = "fintech-orders-lb-prod"
  type                       = "application"
  scheme                     = "internet-facing"
  enable_deletion_protection = true

  listener_port     = 443
  listener_protocol = "HTTPS"

  ssl_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/example-cert-id"

  http_redirect_to_https = true

  health_check_path     = "/api/health"
  health_check_interval = 10
  healthy_threshold     = 2
  unhealthy_threshold   = 2
  timeout               = 5

  idle_timeout = 60

  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true
}

# Configuración de red para producción
network = {
  vpc_cidr = "10.1.0.0/16"

  public_subnets = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24"
  ]

  private_subnets = [
    "10.1.10.0/24",
    "10.1.11.0/24",
    "10.1.12.0/24"
  ]

  db_subnets = [
    "10.1.20.0/24",
    "10.1.21.0/24",
    "10.1.22.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = false
}

# Configuración de seguridad reforzada para producción
security = {
  allowed_cidr_blocks = ["10.0.0.0/8"]
  allowed_ports       = [443]

  enable_vpc_flow_logs      = true
  flow_log_destination_type = "cloud-watch-logs"

  enable_guardduty = true
  enable_config    = true

  enable_security_group_rules = true
}

# Configuración de alta disponibilidad y disaster recovery
dr_config = {
  enable_backup            = true
  backup_schedule          = "cron(0 5 ? * * *)"
  backup_replication       = true
  cross_region_replication = true

  recovery_point_objective = 24
  recovery_time_objective  = 4
}

# Configuración de monitoreo y alertas
monitoring = {
  enable_cloudwatch_dashboard = true
  enable_detailed_monitoring  = true

  alarm_actions = {
    cpu_utilization    = 80
    memory_utilization = 85
    disk_utilization   = 90
    network_throughput = 80
  }

  sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:fintech-alerts"
}

# Configuración de etiquetas para producción
tags = {
  Environment        = "production"
  Project            = "fintech-orders-api"
  ManagedBy          = "terraform"
  CostCenter         = "engineering"
  Team               = "mobile-development"
  Purpose            = "API backend for orders mobile app"
  Compliance         = "SOC2"
  DataClassification = "Confidential"
  BackupRequired     = "true"
}

# Variables de red que deben coincidir con la VPC existente
vpc_id = "vpc-0example1234567890a"

# Security group para los servidores de aplicación
app_security_group_id = "sg-0example1234567890b"

# Parámetros de base de datos que el módulo de app_servers necesita
db_name     = "orders_db"
db_username = "dbadmin"

// === ARCHIVO: infra/modules/database/main.tf ===
# Configuración del recurso de base de datos para la API de la app de pedidos
# Provider seleccionado según el entorno de destino

terraform {
  required_version = ">= 1.8.5"
}

# Configuración para AWS RDS
resource "aws_db_instance" "main" {
  # Identificador de la instancia de base de datos
  identifier = var.db_identifier

  # Motor de base de datos (mysql, postgres, oracle-license, etc.)
  engine         = var.engine
  engine_version = var.engine_version

  # Tamaño de la instancia
  instance_class = var.instance_class

  # Almacenamiento
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  # Credenciales (se obtienen de variables osecrets)
  username = var.db_username
  password = var.db_password

  # Nombre de la base de datos
  name = var.db_name

  # Configuración de red
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = var.subnet_group_name

  # Configuración de disponibilidad
  multi_az              = var.multi_az
  backup_retention_days = var.backup_retention_days
  backup_window         = var.backup_window
  maintenance_window    = var.maintenance_window

  # Configuración de conexión
  port                = var.port
  publicly_accessible = var.publicly_accessible

  # Opciones de base de datos
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  # Configuración de eliminación
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  # Tags
  tags = var.common_tags
}

# Security Group para la base de datos
resource "aws_security_group" "database" {
  name        = "${var.project_name}-database-sg"
  description = "Security group para RDS ${var.project_name}"
  vpc_id      = var.vpc_id

  # Regla de entrada: permitir tráfico desde los servidores de aplicación
  ingress {
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
    description     = "Permitir acceso desde servidores de aplicación"
  }

  # Reglas de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir todo el tráfico saliente"
  }

  tags = var.common_tags
}

// === ARCHIVO: infra/modules/database/outputs.tf ===
# Outputs del módulo de base de datos
# Exponen información crítica para otros módulos y para la configuración de la aplicación

output "db_instance_address" {
  description = "Dirección de conexión principal de la base de datos"
  value       = aws_db_instance.main.address
}

output "db_instance_arn" {
  description = "ARN de la instancia de base de datos"
  value       = aws_db_instance.main.arn
}

output "db_instance_endpoint" {
  description = "Endpoint completo de la base de datos (host:puerto)"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_id" {
  description = "Identificador de la instancia de base de datos"
  value       = aws_db_instance.main.id
}

output "db_instance_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.main.name
}

output "db_instance_port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.main.port
}

output "db_instance_status" {
  description = "Estado actual de la instancia de base de datos"
  value       = aws_db_instance.main.status
}

output "db_security_group_id" {
  description = "ID del security group de la base de datos"
  value       = aws_security_group.database.id
}

output "db_security_group_arn" {
  description = "ARN del security group de la base de datos"
  value       = aws_security_group.database.arn
}

// === ARCHIVO: infra/modules/app_servers/main.tf ===
# Configuración de los servidores de aplicación para la API de la app de pedidos
# Despliega instancias de computación (EC2, GCE, VM) con la configuración necesaria

# ===========================================
# VARIABLES DEL MÓDULO
# ===========================================
# Estas variables deben ser proporcionadas por el módulo padre (main.tf)

variable "project_name" {
  description = "Nombre del proyecto para identificar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, etc.)"
  type        = string
}

variable "region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los servidores"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subnets para el Auto Scaling Group"
  type        = list(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Nombre del par de claves SSH para acceso a instancias"
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "ID de la AMI utilizada para las instancias"
  type        = string
}

variable "associate_public_ip" {
  description = "Asociar IP pública a las instancias"
  type        = bool
  default     = false
}

variable "admin_cidr_block" {
  description = "Bloque CIDR para acceso administrativo (SSH)"
  type        = string
  default     = "10.0.0.0/24"
}

variable "db_host" {
  description = "Host de la base de datos"
  type        = string
  default     = "localhost"
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "appuser"
}

variable "app_port" {
  description = "Puerto donde escucha la aplicación"
  type        = number
  default     = 8080
}

variable "log_level" {
  description = "Nivel de logging de la aplicación"
  type        = string
  default     = "INFO"
}

variable "min_size" {
  description = "Tamaño mínimo del Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Tamaño máximo del Auto Scaling Group"
  type        = number
  default     = 10
}

variable "desired_capacity" {
  description = "Capacidad deseada inicial del ASG"
  type        = number
  default     = 3
}

variable "health_check_type" {
  description = "Tipo de health check (ELB o EC2)"
  type        = string
  default     = "ELB"
}

variable "health_check_grace_period" {
  description = "Período de gracia para health checks"
  type        = number
  default     = 300
}

variable "scale_up_adjustment" {
  description = "Ajuste de escalado hacia arriba"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "Ajuste de escalado hacia abajo"
  type        = number
  default     = -1
}

variable "scale_cooldown" {
  description = "Tiempo de cooldown entre escalados"
  type        = number
  default     = 300
}

variable "cpu_threshold_high" {
  description = "Umbral de CPU alto para escalar"
  type        = number
  default     = 70
}

variable "cpu_threshold_low" {
  description = "Umbral de CPU bajo para escalar"
  type        = number
  default     = 30
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default     = {}
}

# ===========================================
# RECURSOS
# ===========================================

# Security Group para los servidores de aplicación
resource "aws_security_group" "app_servers" {
  name        = "${var.project_name}-app-servers-sg"
  description = "Security group para servidores de aplicación de ${var.project_name}"
  vpc_id      = var.vpc_id

  # Regla de entrada: HTTP desde el balanceador de carga
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTP desde cualquier origen"
  }

  # Regla de entrada: HTTPS desde el balanceador de carga
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTPS desde cualquier origen"
  }

  # Regla de entrada: SSH desde red administrativa
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr_block]
    description = "Permitir SSH solo desde red administrativa"
  }

  # Regla de salida: todo el tráfico
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir todo el tráfico saliente"
  }

  tags = var.common_tags
}

# Launch Template para Auto Scaling Group
resource "aws_launch_template" "app_server" {
  name_prefix   = "${var.project_name}-"
  description   = "Launch template para servidores de aplicación de ${var.project_name}"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name != "" ? var.key_name : null

  # Configuración de red
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [aws_security_group.app_servers.id]
    subnet_id                   = var.subnet_ids[0]
  }

  # Datos de usuario para inicialización
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = var.environment
    db_host     = var.db_host
    db_port     = var.db_port
    db_name     = var.db_name
    db_username = var.db_username
    app_port    = var.app_port
    log_level   = var.log_level
  }))

  # Metadatos de instancia
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  # Configuración de monitoreo
  monitoring {
    enabled = var.enable_monitoring
  }

  # Tags para los recursos creados
  tag_specifications {
    resource_type = "instance"
    tags          = var.common_tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.common_tags
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.common_tags
}

# Auto Scaling Group para los servidores de aplicación
resource "aws_autoscaling_group" "app_servers" {
  name                      = "${var.project_name}-asg"
  vpc_zone_identifier       = var.subnet_ids
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  # Usar el launch template
  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  # Etiquetas para las instancias
  tag {
    key                 = "Name"
    value               = "${var.project_name}-app-server"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Políticas de Auto Scaling
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.project_name}-scale-up"
  scaling_adjustment     = var.scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_cooldown
  autoscaling_group_name = aws_autoscaling_group.app_servers.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.project_name}-scale-down"
  scaling_adjustment     = var.scale_down_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_cooldown
  autoscaling_group_name = aws_autoscaling_group.app_servers.name
}

# Alarmas de CloudWatch para Auto Scaling
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.cpu_threshold_high
  alarm_description   = "Alarma cuando el CPU supera el umbral alto"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_servers.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.project_name}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.cpu_threshold_low
  alarm_description   = "Alarma cuando el CPU está por debajo del umbral bajo"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_servers.name
  }
}

// === ARCHIVO: infra/modules/app_servers/outputs.tf ===
# Outputs del módulo de servidores de aplicación
# Superficie de práctica: definir outputs para exponer información crítica

output "instance_ids" {
  description = "IDs de las instancias de los servidores de aplicación"
  value       = aws_instance.app_server[*].id
}

output "private_ips" {
  description = "Direcciones IP privadas de los servidores de aplicación"
  value       = aws_instance.app_server[*].private_ip
}

output "public_ips" {
  description = "Direcciones IP públicas de los servidores de aplicación"
  value       = aws_instance.app_server[*].public_ip
}

output "instance_arns" {
  description = "ARNs de las instancias para integración con otros servicios"
  value       = aws_instance.app_server[*].arn
}

// === ARCHIVO: infra/modules/load_balancer/main.tf ===
# Configuración del balanceador de carga para la API de la app de pedidos
# Superficie de práctica: implementar la configuración del balanceador

resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name        = var.alb_name
    Environment = var.environment
    Project     = "pedidos-app"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = var.target_group_name
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = var.target_group_name
    Environment = var.environment
  }
}

resource "aws_lb_listener" "app_https" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  ssl_policy      = var.ssl_policy
  certificate_arn = var.certificate_arn
}

resource "aws_lb_listener_rule" "api_path" {
  listener_arn = aws_lb_listener.app_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

// === ARCHIVO: infra/modules/load_balancer/outputs.tf ===
# Outputs del módulo de balanceador de carga
# Superficie de práctica: definir outputs para exponer endpoints y DNS

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.app_alb.arn
}

output "alb_arn_suffix" {
  description = "Sufijo del ARN del ALB"
  value       = aws_lb.app_alb.arn_suffix
}

output "alb_dns_name" {
  description = "Nombre DNS del balanceador de carga para acceder a la API"
  value       = aws_lb.app_alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para configuración de DNS"
  value       = aws_lb.app_alb.zone_id
}

output "alb_id" {
  description = "ID del ALB"
  value       = aws_lb.app_alb.id
}

output "target_group_arn" {
  description = "ARN del target group de los servidores de aplicación"
  value       = aws_lb_target_group.app_tg.arn
}

output "target_group_name" {
  description = "Nombre del target group"
  value       = aws_lb_target_group.app_tg.name
}

output "listener_arn" {
  description = "ARN del listener del ALB"
  value       = aws_lb_listener.app_https.arn
}

output "api_endpoint" {
  description = "Endpoint completo de la API para consumo desde la app móvil"
  value       = "http://${aws_lb.app_alb.dns_name}/api"
}

// === ARCHIVO: client/pubspec.yaml ===
name: order_app_client
description: A Flutter client for the order API
version: 1.0.0+1

environment:
  sdk: ">=3.6.0 <4.0.0"
  flutter: ">=3.27.0"

dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  riverpod: ^2.5.1
  flutter_riverpod: ^2.5.1
  json_annotation: ^4.8.1
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.8
  json_serializable: ^6.7.1

flutter:
  uses-material-design: true

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app_client/presentation/screens/orders_screen.dart';

void main() {
  runApp(const ProviderScope(child: OrderApp()));
}

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OrdersScreen(),
    );
  }
}

// Providers globales para inyección de dependencias
final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://<load_balancer_dns>/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
});

final orderRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return OrderRepositoryImpl(OrderApi(dio));
});

// === ARCHIVO: client/lib/domain/entities/order.dart ===
part of 'order.g.dart';

@JsonSerializable()
class Order {
  final String id;
  final String customerId;
  final List<OrderItem> items;
  final DateTime createdAt;
  final OrderStatus status;
  final double totalAmount;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.createdAt,
    required this.status,
    required this.totalAmount,
  }) {
    if (id.isEmpty) {
      throw ArgumentError('Order ID cannot be empty');
    }
    if (customerId.isEmpty) {
      throw ArgumentError('Customer ID cannot be empty');
    }
    if (items.isEmpty) {
      throw ArgumentError('Order must contain at least one item');
    }
    if (totalAmount <= 0) {
      throw ArgumentError('Total amount must be positive');
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    String? customerId,
    List<OrderItem>? items,
    DateTime? createdAt,
    OrderStatus? status,
    double? totalAmount,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

@JsonSerializable()
class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  }) {
    if (productId.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }
    if (productName.isEmpty) {
      throw ArgumentError('Product name cannot be empty');
    }
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive');
    }
    if (unitPrice <= 0) {
      throw ArgumentError('Unit price must be positive');
    }
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

// === ARCHIVO: client/lib/domain/usecases/get_orders.dart ===
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:order_app_client/domain/entities/order.dart';
import 'package:order_app_client/domain/repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders(this.repository);

  Future<List<Order>> call() async {
    try {
      final orders = await repository.getOrders();
      if (orders.isEmpty) {
        return [];
      }
      return orders;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return Exception('Network timeout. Please check your connection.');
        case DioExceptionType.badResponse:
          return Exception('Server error: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        default:
          return Exception('Network error. Please try again.');
      }
    } else if (error is FormatException) {
      return Exception('Invalid data format received');
    } else {
      return Exception('Failed to fetch orders: $error');
    }
  }
}

final getOrdersProvider = Provider<GetOrders>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return GetOrders(repository);
});

// === ARCHIVO: client/lib/domain/usecases/create_order.dart ===
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:order_app_client/domain/entities/order.dart';
import 'package:order_app_client/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder(this.repository);

  Future<Order> call(Order order) async {
    try {
      if (order.items.isEmpty) {
        throw ArgumentError('Order must contain at least one item');
      }

      final calculatedTotal = order.items.fold(
        0.0,
        (sum, item) => sum + (item.quantity * item.unitPrice),
      );

      final orderWithTotal = order.copyWith(
        totalAmount: calculatedTotal,
        createdAt: DateTime.now(),
        status: OrderStatus.pending,
      );

      final createdOrder = await repository.createOrder(orderWithTotal);
      return createdOrder;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return Exception('Network timeout. Please check your connection.');
        case DioExceptionType.badResponse:
          if (error.response?.statusCode == 400) {
            return Exception('Invalid order data');
          } else if (error.response?.statusCode == 409) {
            return Exception('Order already exists');
          }
          return Exception('Server error: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        default:
          return Exception('Network error. Please try again.');
      }
    } else if (error is ArgumentError) {
      return Exception(error.message);
    } else if (error is FormatException) {
      return Exception('Invalid data format received');
    } else {
      return Exception('Failed to create order: $error');
    }
  }
}

final createOrderProvider = Provider<CreateOrder>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return CreateOrder(repository);
});

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    
    <application
        android:label="order_app_client"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
import 'package:dio/dio.dart';
import '../../domain/entities/order.dart';
import '../sources/remote/order_api.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi _orderApi;
  
  OrderRepositoryImpl(this._orderApi);
  
  @override
  Future<List<Order>> getOrders() async {
    try {
      final response = await _orderApi.getOrders();
      final List<dynamic> data = response['orders'] as List<dynamic>;
      return data
          .map((json) => Order.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw OrderRepositoryException('Error al obtener pedidos: $e');
    }
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    try {
      final response = await _orderApi.createOrder(order.toJson());
      return Order.fromJson(response as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw OrderRepositoryException('Error al crear pedido: $e');
    }
  }
  
  Exception _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return OrderRepositoryException('Tiempo de conexión agotado. Verifica tu conexión a internet.');
      case DioExceptionType.connectionError:
        return OrderRepositoryException('No se pudo conectar al servidor. Verifica tu conexión.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Error del servidor';
        return OrderRepositoryException('Error $statusCode: $message');
      case DioExceptionType.cancel:
        return OrderRepositoryException('Solicitud cancelada');
      default:
        return OrderRepositoryException('Error de red: ${e.message}');
    }
  }
}

class OrderRepositoryException implements Exception {
  final String message;
  OrderRepositoryException(this.message);
  
  @override
  String toString() => message;
}

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> createOrder(Order order);
}

// === ARCHIVO: client/lib/data/sources/remote/order_api.dart ===
import 'package:dio/dio.dart';

class OrderApi {
  final Dio _dio;
  static const String _baseUrl = 'http://<load_balancer_dns>/api';
  
  OrderApi(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (object) => print('[OrderApi] $object'),
    ));
  }
  
  Future<Map<String, dynamic>> getOrders() async {
    try {
      final response = await _dio.get('/orders');
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _enhanceError(e);
    }
  }
  
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _dio.post('/orders', data: orderData);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _enhanceError(e);
    }
  }
  
  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode != null && 
        response.statusCode! >= 200 && 
        response.statusCode! < 300) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return {'data': response.data};
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Respuesta inesperada: ${response.statusCode}',
    );
  }
  
  DioException _enhanceError(DioException e) {
    String message;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Tiempo de conexión agotado';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Tiempo de envío agotado';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Tiempo de recepción agotado';
        break;
      case DioExceptionType.connectionError:
        message = 'Error de conexión: no se pudo conectar al servidor';
        break;
      case DioExceptionType.badResponse:
        message = 'Error del servidor: ${e.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        message = 'Solicitud cancelada';
        break;
      default:
        message = e.message ?? 'Error desconocido';
    }
    return DioException(
      requestOptions: e.requestOptions,
      response: e.response,
      type: e.type,
      error: e.error,
      message: message,
    );
  }
}

// === ARCHIVO: client/lib/presentation/screens/orders_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../../domain/entities/order.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerIdController = TextEditingController();
  final List<_OrderItemForm> _items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersViewModelProvider.notifier).loadOrders();
    });
  }

  @override
  void dispose() {
    _customerIdController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _addItem() {
    setState(() {
      _items.add(_OrderItemForm());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un producto al pedido')),
      );
      return;
    }

    final orderItems = _items.map((item) => OrderItem(
      productId: item.productIdController.text,
      productName: item.productNameController.text,
      quantity: int.tryParse(item.quantityController.text) ?? 1,
      unitPrice: double.tryParse(item.priceController.text) ?? 0.0,
    )).toList();

    final totalAmount = orderItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.quantity * item.unitPrice),
    );

    final order = Order(
      id: '',
      customerId: _customerIdController.text,
      items: orderItems,
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
      totalAmount: totalAmount,
    );

    final success = await ref.read(ordersViewModelProvider.notifier).createOrder(order);
    if (success && mounted) {
      _customerIdController.clear();
      for (final item in _items) {
        item.clear();
      }
      setState(() {
        _items.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido creado exitosamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ordersViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? _buildErrorView(state.error!)
              : _buildContent(state.orders),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateOrderDialog,
        tooltip: 'Crear pedido',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error al cargar pedidos',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(ordersViewModelProvider.notifier).loadOrders();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay pedidos aún',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Toca el botón + para crear tu primer pedido',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(ordersViewModelProvider.notifier).loadOrders();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(order: order);
        },
      ),
    );
  }

  void _showCreateOrderDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _CreateOrderForm(
          formKey: _formKey,
          customerIdController: _customerIdController,
          items: _items,
          scrollController: scrollController,
          onAddItem: _addItem,
          onRemoveItem: _removeItem,
          onSubmit: _submitOrder,
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => _showOrderDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${order.id.substring(0, 8)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _StatusChip(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    order.customerId,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(order.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.items.length} producto(s)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pedido #${order.id.substring(0, 8)}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(label: 'Cliente', value: order.customerId),
              _DetailRow(label: 'Estado', value: order.status.name),
              _DetailRow(label: 'Fecha', value: _formatDate(order.createdAt)),
              const Divider(),
              const Text('Productos:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...order.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• ${item.productName} x${item.quantity} (\$${(item.quantity * item.unitPrice).toStringAsFixed(2)})'),
              )),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _StatusChip extends StatelessWidget {
  final OrderStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case OrderStatus.pending:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
      case OrderStatus.confirmed:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
      case OrderStatus.shipped:
        backgroundColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
      case OrderStatus.delivered:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
      case OrderStatus.cancelled:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _statusLabel(status),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _OrderItemForm {
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1');
  final TextEditingController priceController = TextEditingController();

  void dispose() {
    productIdController.dispose();
    productNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }

  void clear() {
    productIdController.clear();
    productNameController.clear();
    quantityController.text = '1';
    priceController.clear();
  }
}

class _CreateOrderForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController customerIdController;
  final List<_OrderItemForm> items;
  final ScrollController scrollController;
  final VoidCallback onAddItem;
  final void Function(int) onRemoveItem;
  final VoidCallback onSubmit;

  const _CreateOrderForm({
    required this.formKey,
    required this.customerIdController,
    required this.items,
    required this.scrollController,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nuevo Pedido',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: customerIdController,
              decoration: const InputDecoration(
                labelText: 'ID Cliente',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa el ID del cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Productos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: onAddItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _ItemFormCard(
                    index: index,
                    item: items[index],
                    onRemove: () => onRemoveItem(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Crear Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemFormCard extends StatelessWidget {
  final int index;
  final _OrderItemForm item;
  final VoidCallback onRemove;

  const _ItemFormCard({
    required this.index,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Producto ${index + 1}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: item.productIdController,
              decoration: const InputDecoration(
                labelText: 'ID Producto',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: item.productNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: item.quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requerido';
                      }
                      if (int.tryParse(value) == null || int.parse(value) < 1) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: item.priceController,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requerido';
                      }
                      if (double.tryParse(value) == null || double.parse(value) < 0) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// === ARCHIVO: client/lib/presentation/viewmodels/orders_viewmodel.dart ===
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/create_order.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/sources/remote/order_api.dart';
import 'package:dio/dio.dart';

class OrdersState {
  final List<Order> orders;
  final bool isLoading;
  final String? error;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrdersState copyWith({
    List<Order>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class OrdersViewModel extends StateNotifier<OrdersState> {
  final GetOrders _getOrders;
  final CreateOrder _createOrder;

  OrdersViewModel(this._getOrders, this._createOrder) : super(const OrdersState());

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final orders = await _getOrders();
      state = state.copyWith(orders: orders, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapDioError(e),
      );
    } on Exception catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  Future<bool> createOrder(Order order) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createdOrder = await _createOrder(order);
      state = state.copyWith(
        orders: [...state.orders, createdOrder],
        isLoading: false,
      );
      return true;
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapDioError(e),
      );
      return false;
    } on Exception catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error inesperado: ${e.toString()}',
      );
      return false;
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado. Verifica tu conexión a internet.';
      case DioExceptionType.sendTimeout:
        return 'Tiempo de envío agotado. Intenta de nuevo.';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de espera de respuesta agotado. Intenta de nuevo.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return 'No autorizado. Inicia sesión nuevamente.';
        } else if (statusCode == 403) {
          return 'Acceso denegado.';
        } else if (statusCode == 404) {
          return 'Recurso no encontrado.';
        } else if (statusCode != null && statusCode >= 500) {
          return 'Error del servidor. Intenta más tarde.';
        }
        return 'Error en la respuesta del servidor.';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada.';
      case DioExceptionType.connectionError:
        return 'Error de conexión. Verifica tu conexión a internet.';
      default:
        return 'Error de red: ${e.message}';
    }
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://<load_balancer_dns>/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    error: true,
  ));

  return dio;
});

final orderApiProvider = Provider<OrderApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderApi(dio);
});

final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {
  final api = ref.watch(orderApiProvider);
  return OrderRepositoryImpl(api);
});

final getOrdersProvider = Provider<GetOrders>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrders(repository);
});

final createOrderProvider = Provider<CreateOrder>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CreateOrder(repository);
});

final ordersViewModelProvider = StateNotifierProvider<OrdersViewModel, OrdersState>((ref) {
  final getOrders = ref.watch(getOrdersProvider);
  final createOrder = ref.watch(createOrderProvider);
  return OrdersViewModel(getOrders, createOrder);
});

// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
import 'package:order_app_client/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> createOrder(Order order);
}
```

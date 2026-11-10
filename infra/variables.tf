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
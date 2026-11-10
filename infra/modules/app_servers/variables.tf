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
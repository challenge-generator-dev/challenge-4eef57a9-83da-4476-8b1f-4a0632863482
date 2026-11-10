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
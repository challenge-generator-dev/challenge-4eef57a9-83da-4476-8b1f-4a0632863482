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
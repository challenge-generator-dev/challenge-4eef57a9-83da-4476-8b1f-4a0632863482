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
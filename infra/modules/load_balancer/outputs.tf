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
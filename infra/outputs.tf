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
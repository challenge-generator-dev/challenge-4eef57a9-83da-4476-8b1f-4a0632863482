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
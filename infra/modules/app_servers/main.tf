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
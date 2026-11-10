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
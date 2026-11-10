# Valores de variables para el entorno de producción
# Este archivo contiene la configuración completa para el entorno de producción
# de la API de la app de pedidos de la fintech
# Configuración optimizada para alta disponibilidad y rendimiento

# Identificación del proyecto y entorno
environment = "production"
project_id  = "fintech-orders-api-prod"
region      = "us-east-1"

# Configuración de base de datos PostgreSQL
# Producción usa configuración de alta disponibilidad con Multi-AZ
database = {
  identifier            = "fintech-orders-db-prod"
  engine                = "postgres"
  engine_version        = "15.7"
  instance_class        = "db.r6g.large"
  allocated_storage     = 100
  storage_type          = "gp3"
  multi_az              = true
  backup_retention_days = 7
  skip_final_snapshot   = false
  deletion_protection   = true

  performance_insights_enabled = true
  enhanced_monitoring_interval = 60

  db_name  = "orders_db"
  username = "dbadmin"
}

# Configuración de servidores de aplicación
# Múltiples instancias con auto-scaling para producción
app_instance_type    = "t3.medium"
app_min_size         = 2
app_max_size         = 10
app_desired_capacity = 3
app_ami_id           = "ami-0c55b159cbfafe1f0"
app_key_name         = "prod-key-pair"
app_instance_count   = 3
app_root_volume_size = 30
app_root_volume_type = "gp3"

# User data para producción - configuración de Docker y CloudWatch
app_user_data = <<-EOT
#!/bin/bash
yum update -y
yum install -y docker amazon-cloudwatch-agent
systemctl start docker
systemctl enable docker

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << 'CWAGENT'
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/orders-api.log",
            "log_group_name": "/aws/ec2/orders-api/prod",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
CWAGENT

systemctl start amazon-cloudwatch-agent

docker run -d --restart always -p 8080:8080 \
  --log-driver=awslogs \
  --log-opt awslogs-group=/aws/ec2/orders-api/prod \
  --log-opt awslogs-stream={instance_id} \
  --name orders-api fintech/orders-api:latest
EOT

# Health check para producción
app_health_check_path     = "/api/health"
app_health_check_interval = 10

# Métricas para auto-scaling
app_scaling_metric    = "CPUUtilization"
app_scaling_threshold = 70

# Configuración del balanceador de carga
load_balancer = {
  name                       = "fintech-orders-lb-prod"
  type                       = "application"
  scheme                     = "internet-facing"
  enable_deletion_protection = true

  listener_port     = 443
  listener_protocol = "HTTPS"

  ssl_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/example-cert-id"

  http_redirect_to_https = true

  health_check_path     = "/api/health"
  health_check_interval = 10
  healthy_threshold     = 2
  unhealthy_threshold   = 2
  timeout               = 5

  idle_timeout = 60

  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true
}

# Configuración de red para producción
network = {
  vpc_cidr = "10.1.0.0/16"

  public_subnets = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24"
  ]

  private_subnets = [
    "10.1.10.0/24",
    "10.1.11.0/24",
    "10.1.12.0/24"
  ]

  db_subnets = [
    "10.1.20.0/24",
    "10.1.21.0/24",
    "10.1.22.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = false
}

# Configuración de seguridad reforzada para producción
security = {
  allowed_cidr_blocks = ["10.0.0.0/8"]
  allowed_ports       = [443]

  enable_vpc_flow_logs      = true
  flow_log_destination_type = "cloud-watch-logs"

  enable_guardduty = true
  enable_config    = true

  enable_security_group_rules = true
}

# Configuración de alta disponibilidad y disaster recovery
dr_config = {
  enable_backup            = true
  backup_schedule          = "cron(0 5 ? * * *)"
  backup_replication       = true
  cross_region_replication = true

  recovery_point_objective = 24
  recovery_time_objective  = 4
}

# Configuración de monitoreo y alertas
monitoring = {
  enable_cloudwatch_dashboard = true
  enable_detailed_monitoring  = true

  alarm_actions = {
    cpu_utilization    = 80
    memory_utilization = 85
    disk_utilization   = 90
    network_throughput = 80
  }

  sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:fintech-alerts"
}

# Configuración de etiquetas para producción
tags = {
  Environment        = "production"
  Project            = "fintech-orders-api"
  ManagedBy          = "terraform"
  CostCenter         = "engineering"
  Team               = "mobile-development"
  Purpose            = "API backend for orders mobile app"
  Compliance         = "SOC2"
  DataClassification = "Confidential"
  BackupRequired     = "true"
}

# Variables de red que deben coincidir con la VPC existente
vpc_id = "vpc-0example1234567890a"

# Security group para los servidores de aplicación
app_security_group_id = "sg-0example1234567890b"

# Parámetros de base de datos que el módulo de app_servers necesita
db_name     = "orders_db"
db_username = "dbadmin"
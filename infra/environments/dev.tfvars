# Valores de variables para el entorno de desarrollo
# Este archivo se referencia desde la raíz del proyecto con -var-file=environments/dev.tfvars
# Contiene la configuración completa necesaria para aprovisionar la infraestructura

# Identificación del proyecto y entorno
environment  = "development"
project_name = "fintech-orders-api"
region       = "us-east-1"

# Configuración de base de datos PostgreSQL
# Desarrollo usa db.t3.micro (2 vCPU, 1 GiB) por costos
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "orders_db"
db_username          = "dbadmin"
db_password          = "DevPassword123!"

# Configuración de servidores de aplicación
# Una sola instancia para desarrollo
app_servers = {
  instance_count = 1
  instance_type  = "t3.small"
  ami_id         = "ami-0c55b159cbfafe1f0"
  key_name       = "dev-key-pair"

  # Configuración de user data para inicialización
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p 8080:8080 --name orders-api fintech/orders-api:latest
              EOF
}

# Configuración de red
vpc_id                = "vpc-xxxxxxxx"
db_subnet_ids         = ["subnet-xxxxx1", "subnet-xxxxx2"]
app_subnet_ids        = ["subnet-xxxxx1", "subnet-xxxxx2"]
lb_subnet_ids         = ["subnet-xxxxx1", "subnet-xxxxx2"]
db_security_group_id  = "sg-xxxxx1"
app_security_group_id = "sg-xxxxx2"
lb_security_group_id  = "sg-xxxxx3"

# Configuración de seguridad
ssh_key_name               = "dev-key-pair"
certificate_arn            = ""
enable_deletion_protection = false

# Configuración de etiquetas
tags = {
  Environment = "development"
  Project     = "fintech-orders-api"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Team        = "mobile-development"
  Purpose     = "API backend for orders mobile app"
}
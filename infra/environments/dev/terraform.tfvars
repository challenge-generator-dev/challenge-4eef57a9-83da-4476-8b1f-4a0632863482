# Archivo de variables para el entorno de desarrollo
# Ubicado en environments/dev/ para mantener consistencia con la estructura del proyecto
# Este archivo contiene los valores específicos del entorno de desarrollo

# Configuración general del entorno
environment_name = "dev"
project_name     = "fintech-orders-api"

# Configuración de la base de datos para desarrollo
# Uso de instancia pequeña para reducir costos en desarrollo
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_engine_version    = "15.7"
db_multi_az          = false
db_backup_retention  = 1

# Configuración de servidores de aplicación para desarrollo
# Una sola instancia es suficiente para pruebas de desarrollo
app_instance_count    = 1
app_instance_type     = "t3.small"
app_ami_id            = "ami-0c55b159cbfafe1f0"
app_instance_key_pair = "dev-key-pair"

# Configuración del balanceador de carga para desarrollo
lb_type                       = "application"
lb_scheme                     = "internet-facing"
lb_enable_deletion_protection = false

# Configuración de red para desarrollo
vpc_cidr_block       = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

# Configuración de seguridad
allowed_cidr_blocks = ["0.0.0.0/0"]
enable_flow_logs    = false

# Configuración de etiquetas para identificación
tags = {
  Environment = "development"
  Project     = "fintech-orders-api"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
}
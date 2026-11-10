# Orquestación principal del despliegue de infraestructura para la API de la app de pedidos
# Este archivo coordina los tres módulos: base de datos, servidores de aplicación y balanceador de carga

# Módulo de base de datos - provee almacenamiento persistente para los pedidos
module "database" {
  source = "./modules/database"

  project_name         = var.project_name
  environment          = var.environment
  region               = var.region
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  db_username          = var.db_username
  vpc_id               = var.vpc_id
  db_subnet_ids        = var.db_subnet_ids
  security_group_id    = var.db_security_group_id
}

# Módulo de servidores de aplicación - ejecuta la API que consume la app móvil
# Se pasa cada parámetro individualmente según lo que el módulo acepta
module "app_servers" {
  source = "./modules/app_servers"

  count             = var.app_servers.instance_count
  instance_type     = var.app_servers.instance_type
  ami_id            = var.app_servers.ami_id
  key_name          = var.app_servers.key_name
  user_data         = var.app_servers.user_data
  vpc_id            = var.vpc_id
  subnet_ids        = var.app_subnet_ids
  security_group_id = var.app_security_group_id

  # Conexión a la base de datos aprovisionada
  database_endpoint = module.database.endpoint
  database_name     = var.db_name
  database_username = var.db_username
  database_password = module.database.password
}

# Módulo de balanceador de carga - distribuye tráfico hacia los servidores de aplicación
module "load_balancer" {
  source = "./modules/load_balancer"

  project_name               = var.project_name
  environment                = var.environment
  region                     = var.region
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.lb_subnet_ids
  security_group_id          = var.lb_security_group_id
  certificate_arn            = var.certificate_arn
  enable_deletion_protection = var.enable_deletion_protection

  # Registra los servidores de aplicación como targets
  target_group_instances = module.app_servers.instance_ids
}
# Módulo de Infraestructura - API de App de Pedidos

## Propósito

Este módulo aprovisiona la infraestructura necesaria para desplegar la API backend que consume la aplicación móvil de pedidos de la fintech. La arquitectura contempla tres componentes principales: base de datos relacional, servidores de aplicación y balanceador de carga.

## Componentes del Módulo

### 1. Base de Datos (`modules/database/`)
Aprovisiona una instancia de base de datos gestionada con configuración de alta disponibilidad. Provee endpoint de conexión, credenciales y identificador de instancia mediante outputs seguros.

### 2. Servidores de Aplicación (`modules/app_servers/`)
Despliega un grupo de instancias de cómputo que ejecutan la API. Configura auto-scaling, grupos de seguridad y asociación con el balanceador de carga.

### 3. Balanceador de Carga (`modules/load_balancer/`)
Configura un balanceador de aplicación que distribuye tráfico HTTP/HTTPS hacia los servidores de aplicación. Expone el endpoint público de la API.

## Estructura de Directorios

```
infra/
├── versions.tf              # Configuración de versiones de Terraform y providers
├── providers.tf             # Configuración de credenciales de cloud
├── variables.tf             # Variables de entrada del módulo raíz
├── outputs.tf               # Outputs del módulo raíz
├── main.tf                  # Orquestación de módulos
├── modules/
│   ├── database/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── app_servers/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── load_balancer/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev.tfvars
    ├── prod.tfvars
    └── dev/
        └── terraform.tfvars
```

## Uso del Módulo

### Inicialización

```bash
cd infra
terraform init
```

### Validación

```bash
terraform validate
```

### Plan de Ejecución

```bash
# Para desarrollo
terraform plan -var-file=environments/dev.tfvars

# Para producción
terraform plan -var-file=environments/prod.tfvars
```

### Aplicar Cambios

```bash
terraform apply -var-file=environments/dev.tfvars
```

## Variables Requeridas

| Variable | Descripción | Tipo | Valor por defecto |
|----------|-------------|------|--------------------|
| `project_name` | Nombre del proyecto para etiquetado | string | - |
| `environment` | Entorno de despliegue (dev/stg/prod) | string | - |
| `region` | Región de AWS para el despliegue | string | `"us-east-1"` |
| `vpc_cidr` | CIDR block para la VPC | string | `"10.0.0.0/16"` |
| `db_instance_class` | Clase de instancia de base de datos | string | `"db.t3.micro"` |
| `db_allocated_storage` | Almacenamiento allocated en GB | number | `20` |
| `app_instance_type` | Tipo de instancia EC2 para app servers | string | `"t3.medium"` |
| `app_min_size` | Mínimo de instancias en auto-scaling group | number | `2` |
| `app_max_size` | Máximo de instancias en auto-scaling group | number | `6` |
| `app_desired_capacity` | Capacidad deseada inicial | number | `3` |
| `certificate_arn` | ARN del certificado ACM para HTTPS | string | `""` |

## Outputs Expuestos

| Output | Descripción | Sensitive |
|--------|-------------|-----------|
| `api_endpoint` | URL pública del balanceador de carga | no |
| `database_endpoint` | Endpoint de conexión a la base de datos | no |
| `database_password` | Contraseña de la base de datos | yes |
| `app_servers_security_group_id` | ID del security group de app servers | no |
| `lb_dns_name` | DNS name del balanceador de carga | no |

## Validación Local

Para validar la configuración sin ejecutar un plan real:

```bash
terraform validate
terraform fmt -recursive
```

Para verificar que los módulos referenciados existen:

```bash
ls -la modules/database/
ls -la modules/app_servers/
ls -la modules/load_balancer/
```

## Consideraciones de Seguridad

- Las credenciales de base de datos se exponen únicamente como output sensible
- Los security groups siguen el principio de mínimo privilegio
- El balanceador de carga puede configurarse con HTTPS usando certificado ACM
- Los logs de CloudWatch se habilitan para auditoría
- Las instancias usan IAM roles en lugar de credenciales embebidas

## Endpoints de la API

Una vez desplegada la infraestructura, la API queda disponible en:

- **Base URL**: `http://<load_balancer_dns>/api`
- **Get Orders**: `GET /api/orders`
- **Create Order**: `POST /api/orders`

## Destrucción

Para destruir la infraestructura:

```bash
terraform destroy -var-file=environments/dev.tfvars
```

**Advertencia**: Esta operación elimina todos los recursos aprovisionados. Asegúrate de tener backups de la base de datos si es necesario.
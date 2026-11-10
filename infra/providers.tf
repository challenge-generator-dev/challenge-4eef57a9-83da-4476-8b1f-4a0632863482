terraform {
  required_version = ">= 1.8.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}

# Provider AWS con configuración regional y credenciales
provider "aws" {
  region = var.aws_region
  # Las credenciales se configuran mediante variables de entorno o AWS CLI
  # para evitar exponerlas en el código. Ejemplo:
  # export AWS_ACCESS_KEY_ID="your_access_key"
  # export AWS_SECRET_ACCESS_KEY="your_secret_key"
}

# Provider Google Cloud con configuración regional
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  # Las credenciales se configuran mediante GOOGLE_APPLICATION_CREDENTIALS
  # export GOOGLE_APPLICATION_CREDENTIALS="/path/to/credentials.json"
}

# Provider Azure con configuración de suscripción
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  # Las credenciales se configuran mediante Azure CLI o variables de entorno
}

# Configuración de backend para estado remoto (ejemplo con S3)
terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-orders-api"
    key            = "terraform/orders-api/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tf-state-lock-orders-api"
  }
}

# Outputs para exponer información crítica del despliegue
output "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  value       = var.aws_region
}

output "gcp_project_id" {
  description = "ID del proyecto de Google Cloud donde se desplegarán los recursos"
  value       = var.gcp_project_id
  sensitive   = true
}

output "azure_subscription_id" {
  description = "ID de la suscripción de Azure donde se desplegarán los recursos"
  value       = var.azure_subscription_id
  sensitive   = true
}
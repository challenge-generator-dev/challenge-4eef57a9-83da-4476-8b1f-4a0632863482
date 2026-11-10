# Configuración de versiones de Terraform
# Este archivo define la versión requerida de Terraform y sus proveedores
# IMPORTANTE: El bloque required_providers NO debe estar aquí porque ya está
# definido en providers.tf. Terraform solo permite un bloque required_providers
# en todo el proyecto.

terraform {
  required_version = ">= 1.8.5"
}
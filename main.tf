terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"

    }
  }

  backend "azurerm" {
    
  }
}
variable "ARM_TENANT_ID" {
  description = "Tenant ID"
  type = string
}
variable "ARM_CLIENT_ID" {
  description = "CLIENT ID"
  type = string
}
variable "ARM_CLIENT_SECRET" {
  description = "CLIENT SECRET"
  type = string
}
# Resource Manager Default Sub
provider "azurerm" {
  version = ">=2.0.0"
  features {}
  tenant_id       = "134888ca-e6f2-4fb6-9b49-3042d590ea87"
  subsubscription_id = "3b8667c6-8f75-42ea-b301-bf27c9db8674"
  client_id = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
}
# Azure Resource Manager Timberwolve Prod
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
      }
      }
  alias = "timbdev"
  version = ">=2.0.0"
  client_id = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
  subscription_id = "c46a6ca5-2236-4b9d-aff2-e465190d0b3b"
  tenant_id       = var.ARM_TENANT_ID
  skip_provider_registration = "true"
}
# Azure Resource Manager Warriors Prod
provider "azurerm" {
  alias = "wardev"
  version = ">=2.0.0"
  features {}
  client_id = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
  subscription_id = "50f1a1d8-806c-46ab-82f4-41fb54e730d8"
  tenant_id       = var.ARM_TENANT_ID
  skip_provider_registration = "true"
}
# Azure AD
provider "azuread" {
  version = ">=0.7.0"
  tenant_id       = "134888ca-e6f2-4fb6-9b49-3042d590ea87"
  client_id = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
}


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
# Resource Manager Default Sub
provider "azurerm" {
  version = ">=2.0.0"
  features {}
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
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
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
  skip_provider_registration = "true"
}
# Azure Resource Manager Warriors Prod
provider "azurerm" {
  alias = "wardev"

  version = ">=2.0.0"
  features {}
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
  skip_provider_registration = "true"
}
# Azure AD
provider "azuread" {
  version = ">=0.7.0"
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_SECRET
  tenant_id       = var.ARM_TENANT_ID
}


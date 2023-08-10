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
  features {}
  subscription_id = "3b8667c6-8f75-42ea-b301-bf27c9db8674"
}
# Azure Resource Manager Timberwolve Prod
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
      }
      }
  alias = "timbdev"
  subscription_id = "c46a6ca5-2236-4b9d-aff2-e465190d0b3b"
  skip_provider_registration = "true"
}
# Azure Resource Manager Warriors Prod
provider "azurerm" {
  alias = "wardev"
  features {}
  subscription_id = "50f1a1d8-806c-46ab-82f4-41fb54e730d8"
  skip_provider_registration = "true"
}
# Azure AD
provider "azuread" {
 
}


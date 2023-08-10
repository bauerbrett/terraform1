terraform {
  backend "azurerm" {
    subscription_id      = "3b8667c6-8f75-42ea-b301-bf27c9db8674"
    resource_group_name  = "AZLabs"
    storage_account_name = "cloudstoragebaueraz"
    container_name       = "terraform-project"
    key                  = "terraform-project.tfstate"
  }
}
# Azure Resource Manager Default Sub
provider "azurerm" {
  version = ">=2.0.0"
  features {}
  client_id       = "df100d44-e9e9-4296-bfc6-14e938aa47b7"
  client_secret   = "lk68Q~w7C6uJOg4NiRLrUAFynHJW1NySQNcIoaNe"
  subscription_id = "3b8667c6-8f75-42ea-b301-bf27c9db8674"
  tenant_id       = "134888ca-e6f2-4fb6-9b49-3042d590ea87"
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
  client_id       = "df100d44-e9e9-4296-bfc6-14e938aa47b7"
  client_secret   = "lk68Q~w7C6uJOg4NiRLrUAFynHJW1NySQNcIoaNe"
  subscription_id = "c46a6ca5-2236-4b9d-aff2-e465190d0b3b"
  tenant_id       = "134888ca-e6f2-4fb6-9b49-3042d590ea87"
  skip_provider_registration = "true"
}
# Azure Resource Manager Warriors Prod
provider "azurerm" {
  alias = "wardev"

  version = ">=2.0.0"
  features {}
  client_id       = "df100d44-e9e9-4296-bfc6-14e938aa47b7"
  client_secret   = "lk68Q~w7C6uJOg4NiRLrUAFynHJW1NySQNcIoaNe"
  subscription_id = "50f1a1d8-806c-46ab-82f4-41fb54e730d8"
  tenant_id       = "134888ca-e6f2-4fb6-9b49-3042d590ea87"
  skip_provider_registration = "true"
}
# Azure AD
provider "azuread" {
  version = ">=0.7.0"
  client_id       = "df100d44-e9e9-4296-bfc6-14e938aa47b7"
  client_secret   = "lk68Q~w7C6uJOg4NiRLrUAFynHJW1NySQNcIoaNe"
  subscription_id = "50f1a1d8-806c-46ab-82f4-41fb54e730d8"
  tenant_id       = "134888ca-e6f2-4fb6-9b49-3042d590ea87"
  skip_provider_registration = "true"
}


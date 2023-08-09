# Supscription 1
data "azurerm_subscription" "azuresubscription1" {
    subscription_id = "3b8667c6-8f75-42ea-b301-bf27c9db8674"
}
# Subscription 1 Resource Groups
data "azurerm_resource_group" "AZ500Test" {
    name = "AZ500Test"
}
output "id" {
    value = data.azurerm_resource_group.AZ500Test
}
#Basketball/Timberwolves Prod Subscription
data "azurerm_subscription" "Timbprod" {
    subscription_id = "c46a6ca5-2236-4b9d-aff2-e465190d0b3b"
}
#Basketball/War Prod Subscription
data "azurerm_subscription" "Warprod" {
    subscription_id = "50f1a1d8-806c-46ab-82f4-41fb54e730d8"
}
data "azurerm_client_config" "current" {}

#Timberwolves prod resource groups 
resource "azurerm_resource_group" "timb_prod_vms" {
    provider = azurerm.timbdev
    name = "timb_prod_vms"
    location = "East US"
}
resource "azurerm_resource_group" "timb_prod_app1" {
    provider = azurerm.timbdev
    name = "timb_prod_app1"
    location = "East US"
}
resource "azurerm_resource_group" "timb_prod_sql" {
    provider = azurerm.timbdev
    name = "timb_prod_sql"
    location = "East US"
}
resource "azurerm_resource_group" "timb_prod_net" {
    provider = azurerm.timbdev
    name = "timb_prod_net"
    location = "East US"
}
#Warriors prod resource groups
resource "azurerm_resource_group" "war_prod_vms" {
    provider = azurerm.wardev
    name = "war_prod_vms"
    location = "East US"
}
resource "azurerm_resource_group" "war_prod_app1" {
    provider = azurerm.wardev
    name = "war_prod_app1"
    location = "East US"
}
resource "azurerm_resource_group" "war_prod_sql" {
    provider = azurerm.wardev
    name = "war_prod_sql"
    location = "East US"
}
resource "azurerm_resource_group" "war_prod_net" {
    provider = azurerm.wardev
    name = "war_prod_net"
    location = "East US"
}
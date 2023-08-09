#Give Brett Virtual Machine Contributer on RG Az500Test
resource "azurerm_role_assignment" "brett_bauer" {
    scope                = data.azurerm_resource_group.AZ500Test.id
    role_definition_name = "Virtual Machine Contributor"
    principal_id         = data.azuread_user.brett_bauer.id
}

#Subscription Level Assignments
resource "azurerm_role_assignment" "war-prod-contributor" {
    provider = azurerm.wardev
    scope = data.azurerm_subscription.Warprod.id
    role_definition_name = "Contributor"
    principal_id = azuread_group.war-prod-contributor.id
}
resource "azurerm_role_assignment" "timb-prod-contributor" {
    provider = azurerm.timbdev
    scope = data.azurerm_subscription.Timbprod.id
    role_definition_name = "Contributor"
    principal_id = azuread_group.timb-prod-contributor.id

    depends_on = [azuread_group.timb-prod-contributor]
}
#Timberwolves Prod Resource Group Assignments
#Timb prod vm resource group
resource "azurerm_role_assignment" "timb-prod-vmcontributor" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_vms.id
    role_definition_name = "Virtual Machine Contributor"
    principal_id = azuread_group.timb-prod-vmcontributor.id

    depends_on = [azuread_group.timb-prod-vmcontributor, azurerm_resource_group.timb_prod_vms]
}
resource "azurerm_role_assignment" "timb-prod-vmcontributor-storage" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_vms.id
    role_definition_name = "Storage Blob Data Reader"
    principal_id = azuread_group.timb-prod-vmcontributor.id

    depends_on = [azuread_group.timb-prod-vmcontributor, azurerm_resource_group.timb_prod_vms]
}
resource "azurerm_role_assignment" "timb-prod-vmcontributor-keyvault-keys" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_vms.id
    role_definition_name = "Key Vault Crypto User"
    principal_id = azuread_group.timb-prod-vmcontributor.id

    depends_on = [azuread_group.timb-prod-vmcontributor, azurerm_resource_group.timb_prod_vms]
}
resource "azurerm_role_assignment" "timb-prod-vmcontributor-keyvault-secrets" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_vms.id
    role_definition_name = "Key Vault Secrets User"
    principal_id = azuread_group.timb-prod-vmcontributor.id

    depends_on = [azuread_group.timb-prod-vmcontributor, azurerm_resource_group.timb_prod_vms]
}
resource "azurerm_role_assignment" "timb-prod-vmcontributor-reader" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_vms.id
    role_definition_name = "Reader"
    principal_id = azuread_group.timb-prod-vmcontributor.id

    depends_on = [azuread_group.timb-prod-vmcontributor, azurerm_resource_group.timb_prod_vms]
}
#timb_prod_app1 resource groups assignements
resource "azurerm_role_assignment" "timb-prod-app1contibutor" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_app1.id
    role_definition_name = "Reader"
    principal_id = azuread_group.timb-prod-app1contributor.id

    depends_on = [azuread_group.timb-prod-app1contributor, azurerm_resource_group.timb_prod_app1]
}
resource "azurerm_role_assignment" "timb-prod-app1contibutor-keyvault-keys" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_app1.id
    role_definition_name = "Key Vault Crypto User"
    principal_id = azuread_group.timb-prod-app1contributor.id

    depends_on = [azuread_group.timb-prod-app1contributor, azurerm_resource_group.timb_prod_app1]
}
resource "azurerm_role_assignment" "timb-prod-app1contibutor-keyvault-secrets" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_app1.id
    role_definition_name = "Key Vault Secrets User"
    principal_id = azuread_group.timb-prod-app1contributor.id

    depends_on = [azuread_group.timb-prod-app1contributor, azurerm_resource_group.timb_prod_app1]
}
#timb_prod_sql resource group assignments
resource "azurerm_role_assignment" "timb-prod-sql-db" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_sql.id
    role_definition_name = "SQL DB Contributor"
    principal_id = azuread_group.timb-prod-sqlcontributor.id

    depends_on = [azurerm_resource_group.timb_prod_sql, azuread_group.timb-prod-sqlcontributor]
}
resource "azurerm_role_assignment" "timb-prod-sql-server" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_sql.id
    role_definition_name = "SQL Server Contributor"
    principal_id = azuread_group.timb-prod-sqlcontributor.id

    depends_on = [azurerm_resource_group.timb_prod_sql, azuread_group.timb-prod-sqlcontributor]
}
resource "azurerm_role_assignment" "timb-prod-sql-managedinstance" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_sql.id
    role_definition_name = "SQL Managed Instance Contributor"
    principal_id = azuread_group.timb-prod-sqlcontributor.id

    depends_on = [azurerm_resource_group.timb_prod_sql, azuread_group.timb-prod-sqlcontributor]
}
#timb_prod_net assignments
resource "azurerm_role_assignment" "timb-prod-net-contributor" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_net.id
    role_definition_name = "Network Contributor"
    principal_id = azuread_group.timb-prod-net.id

    depends_on = [azurerm_resource_group.timb_prod_net, azuread_group.timb-prod-net]
}
resource "azurerm_role_assignment" "timb-prod-net-dns" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.timb_prod_net.id
    role_definition_name = "Private DNS Zone Contributor"
    principal_id = azuread_group.timb-prod-net.id

    depends_on = [azurerm_resource_group.timb_prod_net, azuread_group.timb-prod-net]
}

#Warriors Prod Resource Group Role Assignments
#war-prod-vm assignment
resource "azurerm_role_assignment" "war-prod-vmcontributor" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_vms.id
    role_definition_name = "Virtual Machine Contributor"
    principal_id = azuread_group.war-prod-vmcontributor.id

    depends_on = [azuread_group.war-prod-vmcontributor, azurerm_resource_group.war_prod_vms]
}
resource "azurerm_role_assignment" "war-prod-vmcontributor-storage" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_vms.id
    role_definition_name = "Storage Blob Data Reader"
    principal_id = azuread_group.war-prod-vmcontributor.id

    depends_on = [azuread_group.war-prod-vmcontributor, azurerm_resource_group.war_prod_vms]
}
resource "azurerm_role_assignment" "war-prod-vmcontributor-keyvault-keys" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_vms.id
    role_definition_name = "Key Vault Crypto User"
    principal_id = azuread_group.war-prod-vmcontributor.id

    depends_on = [azuread_group.war-prod-vmcontributor, azurerm_resource_group.war_prod_vms]
}
resource "azurerm_role_assignment" "war-prod-vmcontributor-keyvault-secrets" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_vms.id
    role_definition_name = "Key Vault Secrets User"
    principal_id = azuread_group.war-prod-vmcontributor.id

    depends_on = [azuread_group.war-prod-vmcontributor, azurerm_resource_group.war_prod_vms]
}
resource "azurerm_role_assignment" "war-prod-vmcontributor-reader" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_vms.id
    role_definition_name = "Reader"
    principal_id = azuread_group.war-prod-vmcontributor.id

    depends_on = [azuread_group.war-prod-vmcontributor, azurerm_resource_group.war_prod_vms]
}
#war_prod_app1 resource groups assignements
resource "azurerm_role_assignment" "war-prod-app1contibutor" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_app1.id
    role_definition_name = "Reader"
    principal_id = azuread_group.war-prod-app1contributor.id

    depends_on = [azuread_group.timb-prod-app1contributor, azurerm_resource_group.war_prod_app1]
}
resource "azurerm_role_assignment" "war-prod-app1contibutor-keyvault-keys" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_app1.id
    role_definition_name = "Key Vault Crypto User"
    principal_id = azuread_group.war-prod-app1contributor.id

    depends_on = [azuread_group.war-prod-app1contributor, azurerm_resource_group.war_prod_app1]
}
resource "azurerm_role_assignment" "war-prod-app1contibutor-keyvault-secrets" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_app1.id
    role_definition_name = "Key Vault Secrets User"
    principal_id = azuread_group.war-prod-app1contributor.id

    depends_on = [azuread_group.war-prod-app1contributor, azurerm_resource_group.war_prod_app1]
}
#war_prod_sql resource group assignments
resource "azurerm_role_assignment" "war-prod-sql-db" {
    provider = azurerm.timbdev
    scope = azurerm_resource_group.war_prod_sql.id
    role_definition_name = "SQL DB Contributor"
    principal_id = azuread_group.war-prod-sqlcontributor.id

    depends_on = [azurerm_resource_group.war_prod_sql, azuread_group.war-prod-sqlcontributor]
}
resource "azurerm_role_assignment" "war-prod-sql-server" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_sql.id
    role_definition_name = "SQL Server Contributor"
    principal_id = azuread_group.war-prod-sqlcontributor.id

    depends_on = [azurerm_resource_group.war_prod_sql, azuread_group.war-prod-sqlcontributor]
}
resource "azurerm_role_assignment" "war-prod-sql-managedinstance" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_sql.id
    role_definition_name = "SQL Managed Instance Contributor"
    principal_id = azuread_group.war-prod-sqlcontributor.id

    depends_on = [azurerm_resource_group.war_prod_sql, azuread_group.war-prod-sqlcontributor]
}
#war_prod_net assignments
resource "azurerm_role_assignment" "war-prod-net-contributor" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_net.id
    role_definition_name = "Network Contributor"
    principal_id = azuread_group.war-prod-net.id

    depends_on = [azurerm_resource_group.war_prod_net, azuread_group.war-prod-net]
}
resource "azurerm_role_assignment" "war-prod-net-dns" {
    provider = azurerm.wardev
    scope = azurerm_resource_group.war_prod_net.id
    role_definition_name = "Private DNS Zone Contributor"
    principal_id = azuread_group.war-prod-net.id

    depends_on = [azurerm_resource_group.war_prod_net, azuread_group.war-prod-net]
}
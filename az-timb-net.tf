#Deploy Test VM for Defender for Cloud FIM
# Create virtual network
resource "azurerm_virtual_network" "timb-usea-vnet1" {
  provider = azurerm.timbdev
  name                = "timb-usea-vnet1"
  address_space       = ["10.5.0.0/23"]
  location            = azurerm_resource_group.timb_prod_net.location 
  resource_group_name = azurerm_resource_group.timb_prod_net.name
}
# Create timb-vnet1-sub-vm subnet
resource "azurerm_subnet" "timb-vnet1-sub-vm" {
  provider = azurerm.timbdev
  name                 = "timb-vnet1-sub-vm"
  resource_group_name  = azurerm_resource_group.timb_prod_net.name
  virtual_network_name = azurerm_virtual_network.timb-usea-vnet1.name
  address_prefixes     = ["10.5.0.0/25"]
  service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = false
}
# Create timb-vnet1-sub-sql subnet
resource "azurerm_subnet" "timb-vnet1-sub-sql" {
  provider = azurerm.timbdev
  name                 = "timb-vnet1-sub-sql"
  resource_group_name  = azurerm_resource_group.timb_prod_net.name
  virtual_network_name = azurerm_virtual_network.timb-usea-vnet1.name
  address_prefixes     = ["10.5.0.128/25"]
  service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql"]
  private_endpoint_network_policies_enabled = false

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}
# Create timb-vnet1-sub-sql subnet
resource "azurerm_subnet" "timb-vnet1-sub-private" {
  provider = azurerm.timbdev
  name                 = "timb-vnet1-sub-private"
  resource_group_name  = azurerm_resource_group.timb_prod_net.name
  virtual_network_name = azurerm_virtual_network.timb-usea-vnet1.name
  address_prefixes     = ["10.5.1.0/25"]
  service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql"]
  private_endpoint_network_policies_enabled = false
}
#Private Enpoints
resource "azurerm_private_endpoint" "timb-key-disk-pe" {
  provider = azurerm.timbdev
  name                = "timb-key-disk-pe"
  location            = azurerm_resource_group.timb_prod_net.location
  resource_group_name = azurerm_resource_group.timb_prod_net.name
  subnet_id           = azurerm_subnet.timb-vnet1-sub-vm.id

   private_dns_zone_group {
    name = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.keyvaultprivatezone.id]
 }

  private_service_connection {
    name                           = "timb-testvms-pe"
    private_connection_resource_id = azurerm_key_vault.timb-key-disk.id
    subresource_names = ["vault"]
    is_manual_connection           = false
  }
  depends_on = [azurerm_resource_group.timb_prod_net, azurerm_key_vault.timb-key-disk, azurerm_subnet.timb-vnet1-sub-private]
}
resource "azurerm_private_dns_zone" "storageprivatezone" {
  provider = azurerm.timbdev
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.timb_prod_net.name
}
resource "azurerm_private_dns_zone" "keyvaultprivatezone" {
  provider = azurerm.timbdev
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.timb_prod_net.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelink" {
  provider = azurerm.timbdev
  name = "dnszonelink"
  resource_group_name = azurerm_resource_group.timb_prod_net.name
  private_dns_zone_name = azurerm_private_dns_zone.storageprivatezone.name
  virtual_network_id = azurerm_virtual_network.timb-usea-vnet1.id
  depends_on = [azurerm_virtual_network.timb-usea-vnet1, azurerm_private_dns_zone.storageprivatezone]
}
resource "azurerm_private_endpoint" "timb-vmbootestvmstorage" {
  provider = azurerm.timbdev
  name                = "timb-vmbootestvmstorage-pe"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name
  subnet_id           = azurerm_subnet.timb-vnet1-sub-vm.id

 private_dns_zone_group {
    name                 = "example-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.storageprivatezone.id]
  }

  private_service_connection {
    name                           = "timb-testvms-bootstorage-pe"
    private_connection_resource_id = azurerm_storage_account.vmbootteststorage.id
    subresource_names = ["blob"]
    is_manual_connection           = false
  }
  depends_on = [azurerm_resource_group.timb_prod_vms, azurerm_storage_account.vmbootteststorage, azurerm_subnet.timb-vnet1-sub-private, azurerm_windows_virtual_machine.timb-testvm1, azurerm_windows_virtual_machine.timb-testvm2, azurerm_windows_virtual_machine.timb-testvm3]
}
resource "azurerm_private_endpoint" "timb-prod-sql-pe" {
    provider = azurerm.timbdev
    name = "timb-prod-sql-pe"
    location = azurerm_resource_group.timb_prod_sql.location
    resource_group_name = azurerm_resource_group.timb_prod_sql.name
    subnet_id = azurerm_subnet.timb-vnet1-sub-private.id
    
    depends_on = [azurerm_resource_group.timb_prod_sql, azurerm_mssql_server.timb-prod-sql1]

    private_service_connection {
      name = "timb-prod-sql-pe"
      private_connection_resource_id = azurerm_mssql_server.timb-prod-sql1.id
      is_manual_connection = false
      subresource_names = ["sqlServer"]
    }
}

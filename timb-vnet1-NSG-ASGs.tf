#Application Security Group for timb-prod VMs
resource "azurerm_application_security_group" "timb-prod-ASG-vm" {
  provider = azurerm.timbdev
  name                = "timb-prod-ASG-vm"
  location            = azurerm_resource_group.timb_prod_net.location
  resource_group_name = azurerm_resource_group.timb_prod_net.name
  depends_on = [azurerm_resource_group.timb_prod_net]
}
#Application Security Group for timb-prod SQL
resource "azurerm_application_security_group" "timb-prod-ASG-sql" {
  provider = azurerm.timbdev
  name                = "timb-prod-ASG-sql"
  location            = azurerm_resource_group.timb_prod_net.location
  resource_group_name = azurerm_resource_group.timb_prod_net.name
  depends_on = [azurerm_resource_group.timb_prod_net]
}
# Create Network Security Group and rules for timb prod Vms
resource "azurerm_network_security_group" "timb-prod-NSG-vm" {
  provider = azurerm.timbdev
  name                = "timb-prod-NSG-vm"
  location            = azurerm_resource_group.timb_prod_net.location
  resource_group_name = azurerm_resource_group.timb_prod_net.name

  depends_on = [azurerm_resource_group.timb_prod_net, azurerm_subnet.timb-vnet1-sub-vm, azurerm_application_security_group.timb-prod-ASG-sql, azurerm_application_security_group.timb-prod-ASG-vm]


  security_rule {
    name                       = "RDP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ToSql"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-vm.id]
    destination_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-sql.id]
  }
  security_rule {
    name                       = "FromSql"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-sql.id]
    destination_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-vm.id]
  }
}
# Create Network Security Group and rules SQL
resource "azurerm_network_security_group" "timb-prod-NSG-sql" {
  provider = azurerm.timbdev
  name                = "timb-prod-NSG-sql"
  location            = azurerm_resource_group.timb_prod_net.location
  resource_group_name = azurerm_resource_group.timb_prod_net.name

  depends_on = [azurerm_resource_group.timb_prod_net, azurerm_subnet.timb-vnet1-sub-sql, azurerm_application_security_group.timb-prod-ASG-sql, azurerm_application_security_group.timb-prod-ASG-vm]

  security_rule {
    name                       = "RDP"
    priority                   = 1015
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ToSql"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-vm.id]
    destination_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-sql.id]
  }
  security_rule {
    name                       = "FromSql"
    priority                   = 1003
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-sql.id]
    destination_application_security_group_ids = [azurerm_application_security_group.timb-prod-ASG-vm.id]
  }
}
#Assign NSG to timb-vnet1-sub-vm
resource "azurerm_subnet_network_security_group_association" "timb-prod-NSG-vm" {
  provider = azurerm.timbdev
  subnet_id = azurerm_subnet.timb-vnet1-sub-vm.id
  network_security_group_id = azurerm_network_security_group.timb-prod-NSG-vm.id
  depends_on = [azurerm_network_security_group.timb-prod-NSG-vm]
}
#Assign NSG to timb-vnet-sub-sql
resource "azurerm_subnet_network_security_group_association" "timb-prod-NSG-sql" {
  provider = azurerm.timbdev
  subnet_id = azurerm_subnet.timb-vnet1-sub-sql.id
  network_security_group_id = azurerm_network_security_group.timb-prod-NSG-sql.id
  depends_on = [azurerm_network_security_group.timb-prod-NSG-sql]
}
#Attach ASG to VM NICs and SQL
resource "azurerm_network_interface_application_security_group_association" "ASG-to-timb-testvm1" {
  provider = azurerm.timbdev
  network_interface_id          = azurerm_network_interface.timb-testvm1-nic.id
  application_security_group_id = azurerm_application_security_group.timb-prod-ASG-vm.id
  depends_on = [azurerm_network_interface.timb-testvm1-nic]
}
resource "azurerm_network_interface_application_security_group_association" "ASG-to-timb-testvm2" {
  provider = azurerm.timbdev
  network_interface_id          = azurerm_network_interface.timb-testvm2-nic.id
  application_security_group_id = azurerm_application_security_group.timb-prod-ASG-vm.id
  depends_on = [azurerm_network_interface.timb-testvm2-nic]
}
resource "azurerm_network_interface_application_security_group_association" "ASG-to-timb-testvm3" {
  provider = azurerm.timbdev
  network_interface_id          = azurerm_network_interface.timb-testvm3-nic.id
  application_security_group_id = azurerm_application_security_group.timb-prod-ASG-vm.id
  depends_on = [azurerm_network_interface.timb-testvm3-nic]
}
resource "azurerm_private_endpoint_application_security_group_association" "ASG-sql-to-sql-pe" {
  provider = azurerm.timbdev
  application_security_group_id = azurerm_application_security_group.timb-prod-ASG-sql.id
  private_endpoint_id = azurerm_private_endpoint.timb-prod-sql-pe.id
  depends_on = [azurerm_application_security_group.timb-prod-ASG-sql, azurerm_private_endpoint.timb-prod-sql-pe]
}
resource "azurerm_private_endpoint_application_security_group_association" "ASG-sql-to-storage-pe" {
  provider = azurerm.timbdev
  application_security_group_id = azurerm_application_security_group.timb-prod-ASG-sql.id
  private_endpoint_id = azurerm_private_endpoint.timb-vmbootestvmstorage.id
  depends_on = [azurerm_application_security_group.timb-prod-ASG-sql, azurerm_private_endpoint.timb-vmbootestvmstorage]
}
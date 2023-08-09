# Create timb-testvm1
# Create timb-testvm1 public IP
resource "azurerm_public_ip" "timb-testvm1-P-IP" {
  provider = azurerm.timbdev
  name                = "timb-testvm1-P-IP"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name
  allocation_method   = "Dynamic"

  depends_on = [azurerm_resource_group.timb_prod_vms]
}
# Create VM1 network interface
resource "azurerm_network_interface" "timb-testvm1-nic" {
  provider = azurerm.timbdev
  name                = "timb-testvm1-nic"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name

  depends_on = [azurerm_resource_group.timb_prod_vms]

  ip_configuration {
    name                          = "my_testvm1nic_configuration"
    subnet_id                     = azurerm_subnet.timb-vnet1-sub-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.timb-testvm1-P-IP.id
  }
}
# Create storage account for boot diagnostics
resource "azurerm_storage_account" "vmbootteststorage" {
  provider = azurerm.timbdev
  name                     = "vmbootestvmstorage"
  location                 = azurerm_resource_group.timb_prod_vms.location
  resource_group_name      = azurerm_resource_group.timb_prod_vms.name
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
  public_network_access_enabled = false

  depends_on = [azurerm_resource_group.timb_prod_vms]
}
# Create virtual machine
resource "azurerm_windows_virtual_machine" "timb-testvm1" {
  provider = azurerm.timbdev
  name                  = "timb-testvm1"
  admin_username        = "azureuser"
  admin_password        = "testvm_1-G-G-D!"
  location              = azurerm_resource_group.timb_prod_vms.location
  resource_group_name   = azurerm_resource_group.timb_prod_vms.name
  network_interface_ids = [azurerm_network_interface.timb-testvm1-nic.id]
  size                  = "Standard_DS1_v2"

  depends_on = [azurerm_resource_group.timb_prod_vms, azurerm_user_assigned_identity.timb-mi-vm-keyvault, azurerm_storage_account.vmbootteststorage]

  os_disk {
    name                 = "testvm1OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.timb-mi-vm-keyvault.id]
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vmbootteststorage.primary_blob_endpoint
  }
}
#timb-testvm2 creation
# Create timb-testvm2 public IP
resource "azurerm_public_ip" "timb-testvm2-P-IP" {
  provider = azurerm.timbdev
  name                = "timb-testvm2-P-IP"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name
  allocation_method   = "Dynamic"

  depends_on = [azurerm_resource_group.timb_prod_vms]
}
# Create VM2 network interface
resource "azurerm_network_interface" "timb-testvm2-nic" {
  provider = azurerm.timbdev
  name                = "timb-testvm2-nic"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name

  depends_on = [azurerm_resource_group.timb_prod_vms]

  ip_configuration {
    name                          = "my_testvm2nic_configuration"
    subnet_id                     = azurerm_subnet.timb-vnet1-sub-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.timb-testvm2-P-IP.id
  }
}
# Create timb-testvm2 virtual machine
resource "azurerm_windows_virtual_machine" "timb-testvm2" {
  provider = azurerm.timbdev
  name                  = "timb-testvm2"
  admin_username        = "azureuser"
  admin_password        = "testvm_2-G-G-D!"
  location              = azurerm_resource_group.timb_prod_vms.location
  resource_group_name   = azurerm_resource_group.timb_prod_vms.name
  network_interface_ids = [azurerm_network_interface.timb-testvm2-nic.id]
  size                  = "Standard_DS1_v2"

  depends_on = [azurerm_resource_group.timb_prod_vms, azurerm_user_assigned_identity.timb-mi-vm-keyvault, azurerm_storage_account.vmbootteststorage]

  os_disk {
    name                 = "testvm2OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

   identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.timb-mi-vm-keyvault.id]
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vmbootteststorage.primary_blob_endpoint
  }
}
#Creat timb-testvm3
# Create timb-testvm3 public IP
resource "azurerm_public_ip" "timb-testvm3-P-IP" {
  provider = azurerm.timbdev
  name                = "timb-testvm3-P-IP"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name
  allocation_method   = "Dynamic"

  depends_on = [azurerm_resource_group.timb_prod_vms]
}
# Create VM3 network interface
resource "azurerm_network_interface" "timb-testvm3-nic" {
  provider = azurerm.timbdev
  name                = "timb-testvm3-nic"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name

  depends_on = [azurerm_resource_group.timb_prod_vms]

  ip_configuration {
    name                          = "my_testvm2nic_configuration"
    subnet_id                     = azurerm_subnet.timb-vnet1-sub-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.timb-testvm3-P-IP.id
  }
}
# Create virtual machine
resource "azurerm_windows_virtual_machine" "timb-testvm3" {
  provider = azurerm.timbdev
  name                  = "timb-testvm3"
  admin_username        = "azureuser"
  admin_password        = "testvm_3-G-G-D!"
  location              = azurerm_resource_group.timb_prod_vms.location
  resource_group_name   = azurerm_resource_group.timb_prod_vms.name
  network_interface_ids = [azurerm_network_interface.timb-testvm3-nic.id]
  size                  = "Standard_DS1_v2"

  depends_on = [azurerm_resource_group.timb_prod_vms, azurerm_user_assigned_identity.timb-mi-vm-keyvault, azurerm_storage_account.vmbootteststorage]

  os_disk {
    name                 = "testvm3OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

   identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.timb-mi-vm-keyvault.id]
  }
   
   

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.vmbootteststorage.primary_blob_endpoint
  }
}
#Role Assignments for VM managed identities. Key Vault Crypto Officer
#Create user assigned managed identity
resource "azurerm_user_assigned_identity" "timb-mi-vm-keyvault" {
  provider = azurerm.timbdev
  name                = "timb-mi-vm-keyvault"
  location            = azurerm_resource_group.timb_prod_vms.location
  resource_group_name = azurerm_resource_group.timb_prod_vms.name

  depends_on = [azurerm_resource_group.timb_prod_vms]
}
#Assign Crypto Officer role
resource "azurerm_role_assignment" "timb-mi-vm-keyvault-crypto-officer" {
  provider = azurerm.timbdev
  scope                = azurerm_key_vault.timb-key-disk.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.timb-mi-vm-keyvault.principal_id

  depends_on = [azurerm_user_assigned_identity.timb-mi-vm-keyvault]
}
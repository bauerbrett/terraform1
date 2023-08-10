#Timb VM Disk encryption vault
resource "azurerm_key_vault" "timb-key-disk" {
    provider = azurerm.timbdev
    name                        = "timb-key-disk"
    location                    = azurerm_resource_group.timb_prod_vms.location
    resource_group_name         = azurerm_resource_group.timb_prod_vms.name
    enabled_for_disk_encryption = true
    enabled_for_deployment = true
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    enable_rbac_authorization   = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    public_network_access_enabled = true

    sku_name = "standard"
    depends_on = [azurerm_resource_group.timb_prod_vms]
}
#timb-testvm1 disk key
resource "azurerm_key_vault_key" "timb-testvm1-key" {
  provider = azurerm.timbdev
  name         = "timb-testvm1-key"
  key_vault_id = azurerm_key_vault.timb-key-disk.id
  key_type     = "RSA"
  key_size     = 2048
  depends_on = [azurerm_key_vault.timb-key-disk, azurerm_key_vault_access_policy.myPolicy]

    key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
#timb-testvm2 disk key
resource "azurerm_key_vault_key" "timb-testvm2-key" {
  provider = azurerm.timbdev
  name         = "timb-testvm2-key"
  key_vault_id = azurerm_key_vault.timb-key-disk.id
  key_type     = "RSA"
  key_size     = 2048
  depends_on = [azurerm_key_vault.timb-key-disk]

    key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
#timb-testvm3 disk key
resource "azurerm_key_vault_key" "timb-testvm3-key" {
  provider = azurerm.timbdev
  name         = "timb-testvm3-key"
  key_vault_id = azurerm_key_vault.timb-key-disk.id
  key_type     = "RSA"
  key_size     = 2048
  depends_on = [azurerm_key_vault.timb-key-disk]

     key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
#timb-prod key vault
resource "azurerm_key_vault" "timb-key-prod" {
    provider = azurerm.timbdev
    name                        = "timb-key-prod"
    location                    = azurerm_resource_group.timb_prod_vms.location
    resource_group_name         = azurerm_resource_group.timb_prod_vms.name
    enabled_for_disk_encryption = true
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    enable_rbac_authorization   = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false

    sku_name = "standard"
    depends_on = [azurerm_resource_group.timb_prod_vms]
}


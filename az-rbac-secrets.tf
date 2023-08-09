#RBAC Key Vault
data "azurerm_key_vault" "RBACvault-1" {
    name = "RBACvault-1"
    resource_group_name = "AZ500Test"
}
#Timberwolves Secrets
data "azurerm_key_vault_secret" "Kat" {
  name = "Kat"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "Ant" {
  name = "Ant"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "RudyGobert" {
  name = "RudyGobert"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "JadenMcDaniels" {
  name = "JadenMcdaniels"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "KyleAnderson" {
  name = "KyleAnderson"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
#Warriors Secrets
data "azurerm_key_vault_secret" "StephCurry" {
  name = "StephCurry"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "DraymondGreen" {
  name = "DraymondGreen"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "AndrewWiggins" {
  name = "AndrewWiggins"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "KlayThompson" {
  name = "KlayThompson"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "ChrisPaul" {
  name = "ChrisPaul"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
data "azurerm_key_vault_secret" "KevonLoony" {
  name = "KevonLoony"
  key_vault_id = data.azurerm_key_vault.RBACvault-1.id
}
#Global Admin/Owner Exisitng User Brett Bauer
data "azuread_user" "brett_bauer" {
    object_id = "a08321f4-45b6-49d8-8ec0-7e8340c57ac1"
}
#Timberwolves Users
resource "azuread_user" "Kat" {
  user_principal_name = "Kat@bauerAZ.onmicrosoft.com"
  display_name = "Kat"
  password = data.azurerm_key_vault_secret.Kat.value
}
resource "azuread_user" "KyleAnderson" {
  user_principal_name = "KyleAnderson@bauerAZ.onmicrosoft.com"
  display_name = "Kyle Anderson"
  password = data.azurerm_key_vault_secret.KyleAnderson.value
}
resource "azuread_user" "Ant" {
  user_principal_name = "Ant@bauerAZ.onmicrosoft.com"
  display_name = "Ant"
  password = data.azurerm_key_vault_secret.Ant.value
}
resource "azuread_user" "JadenMcDaniels" {
  user_principal_name = "JadenMcDaniels@bauerAZ.onmicrosoft.com"
  display_name = "Jaden McDaniels"
  password = data.azurerm_key_vault_secret.JadenMcDaniels.value
}
resource "azuread_user" "RudyGobert" {
  user_principal_name = "RudyGobert@bauerAZ.onmicrosoft.com"
  display_name = "Rudy Gobert"
  password = data.azurerm_key_vault_secret.RudyGobert.value
}
#Warriors Users
resource "azuread_user" "StephCurry" {
  user_principal_name = "StephCurry@bauerAZ.onmicrosoft.com"
  display_name = "Steph Curry"
  password = data.azurerm_key_vault_secret.StephCurry.value
}
resource "azuread_user" "AndrewWiggins" {
  user_principal_name = "AndrewWiggins@bauerAZ.onmicrosoft.com"
  display_name = "Andrew Wiggins"
  password = data.azurerm_key_vault_secret.AndrewWiggins.value
}
resource "azuread_user" "KevonLoony" {
  user_principal_name = "KevonLoony@bauerAZ.onmicrosoft.com"
  display_name = "Kevon Loony"
  password = data.azurerm_key_vault_secret.KevonLoony.value
}
resource "azuread_user" "DraymondGreen" {
  user_principal_name = "DraymondGreen@bauerAZ.onmicrosoft.com"
  display_name = "Draymond Green"
  password = data.azurerm_key_vault_secret.DraymondGreen.value
}
resource "azuread_user" "KlayThompson" {
  user_principal_name = "KlayThompson@bauerAZ.onmicrosoft.com"
  display_name = "Klay Thompson"
  password = data.azurerm_key_vault_secret.KlayThompson.value
}
resource "azuread_user" "ChrisPaul" {
  user_principal_name = "ChrisPaul@bauerAZ.onmicrosoft.com"
  display_name = "Chris Paul"
  password = data.azurerm_key_vault_secret.ChrisPaul.value
}
#New Warriors Prod Group
resource "azuread_group" "war-prod-contributor" {
    display_name = "war-prod-contributor"
    security_enabled = true

    members = [azuread_user.StephCurry.object_id]
}
#New Timberwolve Prod Security Groups
resource "azuread_group" "timb-prod-contributor" {
    display_name = "timb-prod-contributor"
    security_enabled = true

    members = [azuread_user.Ant.object_id]
}
resource "azuread_group" "timb-prod-vmcontributor" {
    display_name = "timb-prod-vmcontributor"
    security_enabled = true

    members = [azuread_user.KyleAnderson.object_id]
}
resource "azuread_group" "timb-prod-app1contributor" {
    display_name = "timb-prod-appcontributor"
    security_enabled = true

    members = [azuread_user.RudyGobert.object_id]
}
resource "azuread_group" "timb-prod-sqlcontributor" {
    display_name = "timb-prod-sqlcontributor"
    security_enabled = true

    members = [azuread_user.JadenMcDaniels.object_id]
}
resource "azuread_group" "timb-prod-net" {
    display_name = "timb-prod-netcontributor"
    security_enabled = true

    members = [azuread_user.Kat.object_id]
}
#Warriors Security Groups
resource "azuread_group" "war-prod-vmcontributor" {
    display_name = "war-prod-vmcontributor"
    security_enabled = true

    members = [azuread_user.DraymondGreen.object_id]
}
resource "azuread_group" "war-prod-app1contributor" {
    display_name = "war-prod-appcontributor"
    security_enabled = true

    members = [azuread_user.KlayThompson.object_id]
}
resource "azuread_group" "war-prod-sqlcontributor" {
    display_name = "war-prod-sqlcontributor"
    security_enabled = true

    members = [azuread_user.ChrisPaul.object_id]
}
resource "azuread_group" "war-prod-net" {
    display_name = "war-prod-netcontributor"
    security_enabled = true

    members = [azuread_user.AndrewWiggins.object_id]
}
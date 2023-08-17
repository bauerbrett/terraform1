resource "azurerm_mssql_server" "timb-prod-sql1" {
    provider = azurerm.timbdev
    name = "timb-prod-sql1"
    resource_group_name = azurerm_resource_group.timb_prod_sql.name
    location = azurerm_resource_group.timb_prod_sql.location
    version = "12.0"
    administrator_login = "bauerlogin"
    administrator_login_password = "password"
    minimum_tls_version = "1.2"
    public_network_access_enabled = false

    depends_on = [azurerm_resource_group.timb_prod_sql]
}
resource "azurerm_mssql_database" "timb-prod-sql1-db1" {
    provider = azurerm.timbdev
    name = "timb-prod-sql-db1"
    server_id = azurerm_mssql_server.timb-prod-sql1.id
   
    depends_on = [azurerm_mssql_server.timb-prod-sql1, azurerm_resource_group.timb_prod_sql]
}
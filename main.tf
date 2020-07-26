# Create a SQL Server and a database

data "azurerm_resource_group" "sql_rg" {
    name = var.sql_resourcegroup
}

resource "azurerm_sql_server" "sql_svr" {
  name                         = var.sql_svr_name
  resource_group_name          = azurerm_resource_group.data.name
  location                     = azurerm_resource_group.data.location
  version                      = var.sql_version
  edition                      = var.sql_edition
  administrator_login          = var.sql_user
  administrator_login_password = var.sql_pass
  tags                         = var.tags
}

resource "azurerm_sql_database" "default_db" {
  name                = var.default_db_name
  resource_group_name = azurerm_resource_group.data.name
  location            = azurerm_resource_group.data.location
  edition             = var.sql_edition
  server_name         = azurerm_sql_server.sql_svr.name
  tags                = var.tags
}

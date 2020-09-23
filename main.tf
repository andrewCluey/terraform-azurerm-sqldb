# Lookup Existing Resource Group to deploy into
data "azurerm_resource_group" "sql_rg" {
  name = var.sql_resourcegroup
}

# Create a SQL Server and a database
resource "random_string" "password" {
  length      = 24
  min_upper   = 6
  min_special = 6
}

resource "azurerm_sql_active_directory_administrator" "sql_admin" {
  server_name         = azurerm_sql_server.sql_svr.name
  resource_group_name = data.azurerm_resource_group.sql_rg.name
  login               = var.ad_sqladmin_user
  tenant_id           = var.ad_sqladmin_tenant_id
  object_id           = var.ad_sqladmin_object_id
}

resource "azurerm_sql_server" "sql_svr" {
  name                         = var.sql_server_name
  resource_group_name          = data.azurerm_resource_group.sql_rg.name
  location                     = data.azurerm_resource_group.sql_rg.location
  version                      = var.sql_version
  administrator_login          = var.sql_user
  administrator_login_password = random_string.password.result

  tags = merge(var.tags, map("SQLVersion", var.sql_version), map("ManagedBy", var.ad_sqladmin_user))
}

resource "azurerm_sql_database" "default_db" {
  name                             = var.default_db_name
  resource_group_name              = data.azurerm_resource_group.sql_rg.name
  location                         = data.azurerm_resource_group.sql_rg.location
  edition                          = var.sql_edition
  requested_service_objective_name = var.service_objective_name
  server_name                      = azurerm_sql_server.sql_svr.name
  create_mode                      = var.create_mode

  tags = merge(var.tags, map("SQLVersion", var.sql_version), map("Edition", var.sql_edition), map("SQLServiceTier", var.service_objective_name))
}


# If 'var.create_private_endpoint = true, then create private endpoint and assign to the SQL Server.
data "azurerm_subnet" "pe_subnet" {
  count               = var.create_private_endpoint ? 1 : 0
  name                 = var.pe_subnet_name
  virtual_network_name = var.pe_vnet_name
  resource_group_name  = var.pe_vnet_resource_group_name
}

resource "azurerm_private_endpoint" "pe" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.sql_server_name}-pe"
  resource_group_name = data.azurerm_resource_group.sql_rg.name
  location            = data.azurerm_resource_group.sql_rg.location
  subnet_id           = data.azurerm_subnet.pe_subnet.id
  subresource_names   = "sqlServer"

  private_service_connection {
    name                           = "${var.sql_server_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_sql_server.sql_svr.id
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_name
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}






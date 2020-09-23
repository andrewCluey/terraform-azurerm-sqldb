output "sql_pw" {
    value = random_string.password.result
}

output "sql_server_name" {
  value = azurerm_sql_server.sql_svr.name
}

output "sql_server_id" {
  value = azurerm_sql_server.sql_svr.id
}

output "sqdb_name" {
  value = azurerm_sql_database.default_db.name
}

output "sqldb_id" {
  value = azurerm_sql_database.default_db.id
}
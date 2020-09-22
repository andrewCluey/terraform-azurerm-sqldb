# terraform-azurerm-sqldb
Deploy a managed SQL Server and a default DB

## Example Usage

### Deploying a default SQL Server and DB

```hcl
provider "azurerm" {
  version = "=2.25.0"
  features {}
}

resource "azurerm_resource_group" "test_rg" {
  name     = "rg-test-sql-tf-deploy"
  location = "West Europe"
}


module "sqldb" {
  source  = "andrewCluey/sqldb/azurerm"
  version = "0.0.1"
  # insert the 6 required variables here

  sql_resourcegroup                = "RG-DEV-SQL"
  sql_server_name                  = "DEV-SQL01"
  sql_version                      = "12.0"
  sql_edition                      = "GeneralPurpose"
  requested_service_objective_name = "GP_Gen5_4"
  default_db_name                  = "defaultDB"
  sql_user                         = "sql_user"
  ad_sqladmin_user                 = "sql.dba@domain.local"
  ad_sqladmin_tenant_id            = "tenantidtenantid7987987897"
  ad_sqladmin_object_id            = "sql.dbobjectID...sql.db.objectID"

  tags = {environment = "DEV", "DeployedBy = "SQLDBA", Project="Myproject"}
}
```

## Arguments
| Name | Type | Required | Description |
| --- | --- | --- | --- |

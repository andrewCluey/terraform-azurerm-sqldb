variable "tags" { 
    description = "A map of tags to add to the resources."
    type        = map
    default     = {}
}

variable "sql_edition" { 
    description = "The Azure SQL edition to deploy. To view available editions; Run 'az sql db list-editions -l westus -o table' for available editions."
    type        = string
    default     = "GeneralPurpose"
}

variable "requested_service_objective_name" {
  description = "The perforance tier to deploy6. Depends on location and edition chosen. Run 'az sql db list-editions -l westus -o table' for available sizes "
  type        = string
  default     = "GP_S_Gen5_1"
}

variable "default_db_name" { 
    description = "The name to assign to the Default Database of the SQL Server."
    type        = string
}

variable "sql_user" { 
    description = "The new user account ot be created on the local SQL Server for administering the server."
    type        = string
}

variable "sql_server_name" { 
    description = "The name to assign to the new SQL Server."
    type        = string
}

variable "sql_resourcegroup" { 
    description = "The Resource Grup where the new SQL Server should be created."
    type        = string
}

variable "sql_version" { 
    description = "The Version of SQL Server to deploy. Default of 12.0. Options are"
    type        = string
    default     = "12.0"
}

variable "ad_sqladmin_user" {
  description = "The Administrator user located in Active Directory"
  type        = string
}

variable "ad_sqladmin_tenant_id" {
  description = "The ID of the Azure ACtive Direcrtiry Tenant."
  type        = string
}

variable "ad_sqladmin_object_id" {
  description = "The ID of the user/group that will be SQL Admin"
  type        = string
}

variable "create_mode" {
  description = "Specifies how to create the database."
  type        = string
  default     = "Default"
}
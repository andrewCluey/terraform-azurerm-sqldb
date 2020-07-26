variable "tags" { 
    description = ""
    type = map(string)
}

variable "sql_edition" { 
    description = "The edition of SQL. Basic, Premium etc."
    type = string
    default = "basic"
}

variable "default_db_name" { 
    description = ""
    type = string
}

variable "sql_pass" { 
    description = ""
    type = string
}

variable "sql_user" { 
    description = ""
    type = string
}

variable "sql_svr_name" { 
    description = ""
    type = string
}

variable "sql_resourcegroup" { 
    description = "The Resource Grup where the new SQL Server should be created."
    type = string
}

variable "sql_version" { 
    description = "The Version of SQL Server to deploy. Default of 12.0. Options are"
    type = string
    default = 12.0
}
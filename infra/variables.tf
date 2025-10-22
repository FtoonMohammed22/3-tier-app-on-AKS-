
variable "prefix" { type = string }
variable "location" { type = string }


variable "vnet_cidr" { default = "10.0.0.0/16" }
variable "aks_subnet_cidr" { default = "10.0.1.0/24" }
variable "sql_pe_subnet_cidr" { default = "10.0.2.0/24" }

variable "sql_admin_login" { type = string }
variable "sql_admin_password" { 
  type = string
sensitive = true 
}
variable "db_name" { type = string }

variable "jwt_secret" { 
  type = string
  sensitive = true 
 }
variable "docker_username" { type = string }

variable "subscription_id" {
  description = "The Azure Subscription ID to deploy to"
  type        = string
  sensitive   = true 
}


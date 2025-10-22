
output "kube_config_raw" {
  description = "Raw Kubernetes configuration to connect to the cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "sql_server_fqdn" {
  description = "FQDN of the Azure SQL Server (used by backend service)."
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "ingress_public_ip" {
  description = "Public IP address allocated for the NGINX Ingress Controller."
  value       = azurerm_public_ip.ingress_ip.ip_address
}

output "sql_admin_password" {
  description = "The SQL Server Admin Password."
  value       = var.sql_admin_password
  sensitive   = true
}

output "jwt_secret_key" {
  description = "The JWT Secret Key for the backend service."
  value       = var.jwt_secret
  sensitive   = true
}


output "vnet_id" {
  description = "The Resource ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}
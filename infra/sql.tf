# 1. Azure SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                          = "${var.prefix}-sqlserver"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version                       = "12.0"
  administrator_login           = var.sql_admin_login
  administrator_login_password  = var.sql_admin_password
  public_network_access_enabled = false

  minimum_tls_version = "1.2"
}

resource "azurerm_mssql_database" "sql_db" {
  name      = var.db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "Basic"

  //geo_backup_enabled = false
storage_account_type = "Zone"

  max_size_gb = 2
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = "${var.prefix}-sql-pe"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.sql_pe_subnet.id

  private_service_connection {
    name                           = "sql-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
  }
  

  depends_on = [
    azurerm_mssql_server.sql_server,
    azurerm_subnet.sql_pe_subnet,
    azurerm_private_dns_zone_virtual_network_link.sql_dns_link
  ]
}

resource "azurerm_private_dns_a_record" "sql_pe_a_record" {
  name                = azurerm_mssql_server.sql_server.name
  zone_name           = azurerm_private_dns_zone.sql_dns_zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.sql_pe.private_service_connection[0].private_ip_address]
  
  
  depends_on = [azurerm_private_endpoint.sql_pe]
}
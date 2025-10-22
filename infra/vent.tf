
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name =azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_subnet_cidr]
    depends_on = [azurerm_virtual_network.vnet]
}


resource "azurerm_subnet" "sql_pe_subnet" {
  name                 = "sql-pe-subnet"
resource_group_name =azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.sql_pe_subnet_cidr]
  
}


resource "azurerm_private_dns_zone" "sql_dns_zone" {
  name                = "privatelink.database.windows.net"
resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "${var.prefix}-sqldnslink"
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_subnet.aks_subnet,
    azurerm_subnet.sql_pe_subnet
  ]
}
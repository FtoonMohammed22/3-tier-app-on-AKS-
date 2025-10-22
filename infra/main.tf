
resource "azurerm_resource_group" "rg" {
  name  = "${var.prefix}-rg"
  location = var.location 
}


resource "azurerm_public_ip" "ingress_ip" {
  name                = "${var.prefix}-ingress-ip"
  resource_group_name =azurerm_resource_group.rg.name 
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
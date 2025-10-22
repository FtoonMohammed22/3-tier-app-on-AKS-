resource "azurerm_kubernetes_cluster" "aks" {
     name                = "${var.prefix}-aks-cluster"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix          = "${var.prefix}-aks-dns"

    default_node_pool { 
        name       = "systempool" 
        node_count = 2 

        vm_size    = "Standard_A2_v2" 

        vnet_subnet_id = azurerm_subnet.aks_subnet.id
    }

    network_profile {
        network_plugin = "azure"
        service_cidr   = "10.2.0.0/16" 
        dns_service_ip = "10.2.0.10"

    }
    identity {
        type = "SystemAssigned"
    }

}
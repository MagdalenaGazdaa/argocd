resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.name}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${local.name}-aks"
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.aks_node_resource_group

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "system"
    vm_size             = var.aks_system_vm_size
    node_count          = var.aks_system_node_count 
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = azurerm_subnet.aks.id
    os_disk_size_gb     = 60
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    outbound_type      = "loadBalancer"
  }

}

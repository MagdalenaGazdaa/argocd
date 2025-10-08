locals {
  name = "${var.project}-${var.env}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "aks" {
  name                 = "${local.name}-snet-aks"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

resource "random_string" "acr" {
  length  = 8
  upper   = false
  special = false
}

resource "azurerm_container_registry" "acr" {
  name                = replace("${local.name}${random_string.acr.result}", "-", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.name}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${local.name}-api"

  kubernetes_version  = null

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "system"
    vm_size             = var.system_vm_size
    node_count          = var.system_node_count
    os_disk_size_gb     = 128
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = azurerm_subnet.aks.id
    temporary_name_for_rotation = "tmpnp1"
    node_labels = {
      "nodepool" = "system"
    }
    tags = {
      "role" = "system"
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  role_based_access_control_enabled = true

  tags = {
    project = var.project
    env     = var.env
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "work" {
  name                  = "work"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.user_vm_size
  os_disk_size_gb       = 128
  mode                  = "User"
  vnet_subnet_id        = azurerm_subnet.aks.id
  enable_auto_scaling   = true
  min_count             = var.user_min_count
  max_count             = var.user_max_count
  node_labels = {
    "nodepool" = "work"
  }
  tags = {
    "role" = "workloads"
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  depends_on           = [azurerm_kubernetes_cluster.aks]
}


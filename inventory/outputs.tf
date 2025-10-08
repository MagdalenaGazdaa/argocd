output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_api_server" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

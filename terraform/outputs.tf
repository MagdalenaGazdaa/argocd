output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Name of the AKS cluster"
}

output "aks_kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "Kubeconfig to access the cluster"
}

output "aks_fqdn" {
  value       = azurerm_kubernetes_cluster.aks.fqdn
  description = "Control plane FQDN"
}

output "aks_node_resource_group" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "Managed node resource group used by AKS"
}

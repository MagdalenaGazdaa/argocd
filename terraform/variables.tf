variable "subscription_id" { 
    description = "Subscription ID"
    type        = string 
    }
variable "location"        { 
    description = "Azure region"
    type        = string  
    default     = "northeurope" 
    }
variable "project"         { 
    description = "Project name prefix"
    type        = string  
    default     = "argocd01" 
    }
variable "env"             { 
    description = "Environment name"
    type        = string  
    default     = "dev" 
    }
  
# network
variable "vnet_cidr"   { 
    description = "Address space for VNet"
    type        = string 
    default     = "10.30.0.0/16" 
    }
    variable "aks_subnet_cidr" {
  description = "CIDR for AKS subnet"
  type        = string
  default     = "10.30.2.0/24"
}
variable "service_cidr" {
  description = "CIDR for Kubernetes services"
  type        = string
  default     = "10.240.0.0/16"
}
variable "dns_service_ip" {
  description = "IP for kube-dns" # must be inside service_cidr  
  type        = string
  default     = "10.240.0.10"
}

# Cluster configuration
variable "kubernetes_version" { 
    type    = string
    default = "1.34.1" 
    }
variable "aks_system_vm_size" {
  description = "VM size for the system node pool" # >2 vCPU and >=4GB RAM required
  type        = string
  default     = "Standard_D2s_v3" 
}
variable "aks_system_node_count" {
  description = "Number of nodes in the AKS system node pool."
  type        = number
  default     = 2
}

# Resource group for AKS
variable "aks_node_resource_group" {
  description = "Resource group name for AKS" # managed resources (nodes, NICs, LB). If null, AKS will create a managed RG.
  type        = string
  default     = "MC_argocd_aks_node_resource_group"
}

variable "subscription_id" { 
    description = "Subscription ID"
    type = string 
    }
variable "location"        { 
    description = "Azure region"
    type = string  
    default = "northeurope" 
    }
variable "project"         { 
    description = "Project name prefix"
    type = string  
    default = "argo-demo" 
    }
variable "env"             { 
    description = "Environment name"
    type = string  
    default = "single" 
    }

variable "vnet_cidr"   { 
    description = "Address space for VNet"
    type = string 
    default = "10.30.0.0/16" 
    }
variable "bastion_subnet_cidr" { 
    description = "CIDR for Bastion subnet"
    type = string 
    default = "10.30.1.0/24" 
    }
variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}
#########

variable "kubernetes_version" { 
    type = string
    default = "1.31.11" 
    }


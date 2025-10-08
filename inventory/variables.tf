variable "subscription_id" { type = string }
variable "location"        { 
    type = string  
    default = "northeurope" 
    }
variable "project"         { 
    type = string  
    default = "argo-demo" 
    }
variable "env"             { 
    type = string  
    default = "single" 
    }

variable "vnet_cidr"   { 
    type = string 
    default = "10.30.0.0/16" 
    }
variable "subnet_cidr" { 
    type = string 
    default = "10.30.1.0/24" 
    }

variable "system_vm_size"   { 
    type = string 
    default = "Standard_D2as_v5" 
    }
variable "system_node_count"{ 
    type = number 
    default = 2 
    }

variable "user_vm_size"     { 
    type = string 
    default = "Standard_D2as_v5" 
    }
variable "user_min_count"   { 
    type = number 
    default = 1 
    }
variable "user_max_count"   { 
    type = number 
    default = 3 
    }


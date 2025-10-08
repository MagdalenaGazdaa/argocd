terraform {
  backend "azurerm" {
    resource_group_name  = "argocd01"
    storage_account_name = "sttfstateargodemo01"
    container_name       = "tfstate"
    key                  = "aks.single.tfstate"
  }
}

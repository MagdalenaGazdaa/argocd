output "bastion_public_ip" {
  description = "Public IP address of the Bastion VM"
  value       = azurerm_public_ip.bastion.ip_address
}

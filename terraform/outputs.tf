output "vm_public_ip" {
  value = azurerm_public_ip.public_ip_cp2.ip_address
}
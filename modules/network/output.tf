output "subnet-id" {
  value       = aws_subnet.main-subnet.id // azurerm_linux_virtual_machine.vm.*.public_ip_address
  description = "Id of created subnet"
}
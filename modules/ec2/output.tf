output "bastion_ip" {
  value       = aws_eip.eip-main.*.public_ip // azurerm_linux_virtual_machine.vm.*.public_ip_address
  description = "Public IP address of bastion instance."
}

output "bastion_private_ip" {
  value = aws_instance.bastion[0].private_ip
}

output "nodes_private_ips" {
  value = aws_instance.node.*.private_ip
}
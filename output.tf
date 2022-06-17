output "bastion_public_ip" {
  value       = module.ec2.bastion_ip[0]
  description = "Public IP address of instance."
}

output "workers_private_ips" {
  value       = module.ec2.nodes_private_ips
  description = "Public IP address of instance."
}
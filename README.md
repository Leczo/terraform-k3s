# terraform-k3s

**Module provides k3s deployment on AWS with Terraform and Ansible.** 
## Usage
---
-  Set SSH keys path variables for `public_key` and `private_key` that will be used to authenticate to EC2 instances. 

- Set number of worker nodes with `workers` local variable


```hcl
locals {
  bastion_ip        = module.ec2.bastion_ip[0]
  subnet_id         = module.network.subnet-id
  nodes_private_ips = module.ec2.nodes_private_ips
  private_key       = file("<PATH TO PRIVATE SSH KEY >")
  public_key        = file("<PATH TO PUBLIC SSH KEY>")
  workers           = <NUMBER OF WORKERS>
}
```

- At the end of the deployment kubeconfig file is fetched from control node to root repository path `/terraform-k3s/`


## Requirements
| Name | Description | 
|------| ----------- |
| [terraform]() | 
| [ansible]()   | 
| [kubectl]()   | to access cluster | 

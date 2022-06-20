provider "aws" {}
provider "null" {}


locals {
  bastion_ip         = module.ec2.bastion_ip[0]
  bastion_private_ip = module.ec2.bastion_private_ip
  subnet_id          = module.network.subnet-id
  nodes_private_ips  = module.ec2.nodes_private_ips
  # Path to predefined ssh public and private key
  private_key = file("~/.ssh/main_aws.pem")
  public_key  = file("~/.ssh/main_aws.pub")
  workers     = 1

}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = local.public_key
}

module "network" {
  source       = "./modules/network"
  subnet-range = "10.0.0.0/20"
}

module "ec2" {
  source              = "./modules/ec2"
  key-name            = aws_key_pair.ssh-key.key_name
  subnet-id           = local.subnet_id
  worker-nodes-number = local.workers

}


resource "null_resource" "bastion_check" {
  provisioner "remote-exec" {
    inline = ["echo Done!"]

    connection {
      host        = local.bastion_ip
      type        = "ssh"
      user        = "ec2-user"
      private_key = local.private_key
    }
  }

  # Setup inventory and default-vars to properly provision controle and worker nodes
  provisioner "local-exec" {
    working_dir = "./ansible"
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      echo -en '[bastion]\n${local.bastion_ip}' > ./inventory/hosts 
      echo -en '\n[workers]\n' >> ./inventory/hosts
      for i in ${join(" ", local.nodes_private_ips)};do echo $i >> ./inventory/hosts; done 
      echo -en '\n[workers:vars]\n' >> ./inventory/hosts 
      echo $'ansible_ssh_common_args=\'-o ProxyCommand="ssh -i ~/.ssh/main_aws.pem -p 22 -W %h:%p ec2-user@${local.bastion_ip}"\'' >> ./inventory/hosts
      echo  "control_plane_ip: ${local.bastion_private_ip}" > ./roles/k3s/vars/main.yml
      export AWS_BASTION=${local.bastion_ip}
      EOT
  }

  provisioner "local-exec" {
    working_dir = "./ansible"
    interpreter = ["/bin/bash", "-c"]
    command     = "ansible-playbook ./play/main.yml"

  }
}
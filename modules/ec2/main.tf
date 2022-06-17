resource "aws_instance" "bastion" {
  ami           = "ami-09439f09c55136ecf"
  instance_type = "t2.micro"
  subnet_id     = var.subnet-id
  key_name      = var.key-name
  tags = {
    Name = "${var.prefix}-ansible-bastion"
  }

}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.eip-main.id
}

resource "aws_eip" "eip-main" {
  vpc              = true
  instance         = aws_instance.bastion.id
  public_ipv4_pool = "amazon"

}

resource "aws_instance" "node" {
  ami           = "ami-09439f09c55136ecf"
  instance_type = "t2.micro"
  subnet_id     = var.subnet-id
  key_name      = var.key-name
  count         = var.worker-nodes-number
  tags = {
    Name = "${var.prefix}-node-${count.index}"
  }
}


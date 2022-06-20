# Create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block           = var.cidr-vpc-subnet
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "${var.prefix}-main"
  }
}

resource "aws_subnet" "main-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.subnet-range //format("%s%s", join(".",slice(split(".", var.cidr-subnet),0,2)), ".10.0/24")
  depends_on              = [aws_internet_gateway.igw]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "${var.prefix}-gateway"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-route-table"
  }
}

resource "aws_route_table_association" "r-assoc" {
  subnet_id      = aws_subnet.main-subnet.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_default_network_acl" "d-nacl" {
  default_network_acl_id = aws_vpc.main-vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "${var.prefix}"
  }
}

resource "aws_default_security_group" "sg" {
  vpc_id = aws_vpc.main-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = true
    from_port   = 22
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "icmp"
    self        = true
    from_port   = -1
    to_port     = -1
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = true
    from_port   = 6443
    to_port     = 6443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = true
    from_port   = 10250
    to_port     = 10250
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    self        = true
    from_port   = 2379
    to_port     = 2380
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "udp"
    self        = true
    from_port   = 8472
    to_port     = 8472
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "udp"
    self        = true
    from_port   = 51820
    to_port     = 51821
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}
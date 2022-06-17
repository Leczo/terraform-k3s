variable "cidr-vpc-subnet" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Define range of network"
}

variable "subnet-range" {
  type    = string
  default = "10.0.10.0/20" //format("%s%s", join(".",slice(split(".", var.cidr-vpc-subnet),0,2)), ".10.0/24")
}

variable "zone" {
  type        = string
  default     = "europe-central-1"
  description = "Resource zone"
}

variable "prefix" {
  type        = string
  default     = "terraform"
  description = "Default prefix"
}

variable "env" {
  type        = string
  default     = "testing"
  description = "Environment type "
}


variable "public_key_path" {
  type        = string
  default     = "~/.ssh/s_key.pub"
  description = "Path to public ssh key"
}

variable "image-ami" {
  type        = string
  default     = "ami-09439f09c55136ecf"
  description = "Default Amazon Linux 2 AMI eu-central-1"
}

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

variable "key-name" {
  type        = string
  default     = "ssh-key"
  description = "SSH key name"
}


variable "image-ami" {
  type        = string
  default     = "ami-09439f09c55136ecf"
  description = "Default Amazon Linux 2 AMI eu-central-1"
}


variable "subnet-id" {
  type        = string
  default     = ""
  description = "Subnet id"
}

variable "private_key_path" {
  type        = string
  default     = "~/.ssh/main_aws.pem"
  description = "Path to public ssh key"
}

variable "worker-nodes-number" {
  type        = number
  default     = 1
  description = "Number of k3s worker nodes"
}

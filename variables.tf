variable "cidr-vpc-subnet" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Define range of network"
}

variable "subnet-range" {
  type    = string
  default = "10.0.10.0/24"
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
  default     = "~/.ssh/main_aws.pub"
  description = "Path to public ssh key"
}

variable "private_key_path" {
  type        = string
  default     = "~/.ssh/main_aws.pem"
  description = "Path to public ssh key"
}
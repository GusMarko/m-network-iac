variable "region" {
  
}

variable "access_key" {
  
}

variable "secret_key" {
  
}

variable "public_subnet_cidr" {
  type = string
  description = "Public Subnet CIDR value"
  
}

variable "private_subnet_cidr" {
 type        = string
 description = "Private Subnet CIDR value"
}


variable "env"{
  description = "branch"
}

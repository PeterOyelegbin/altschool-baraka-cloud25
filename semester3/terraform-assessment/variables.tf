variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "resource_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "lab"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "web_server_username" {
  description = "Username for web server SSH access"
  type        = string
}

variable "web_server_password" {
  description = "Password for web server SSH access"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Username for database and SSH access"
  type        = string
}

variable "db_password" {
  description = "Password for database and SSH access"
  type        = string
  sensitive   = true
}

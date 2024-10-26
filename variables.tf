variable "aws_region" {
  description = "The AWS region to deploy resources"
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  default = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default = "ami-047126e50991d067b" # Ubuntu free tier in sg region
  
}

variable "key_pair" {
  description = "Name of the key pair to use for EC2 instances"
}

variable "app_name" {
  description = "Name prefix for resources"
  default = "astro-devops"
}

variable "db_username" {
  description = "Username for RDS"
}

variable "db_password" {
  description = "Password for RDS"
  sensitive   = true
}

variable "alert_email" {
  description = "Email address for receiving alerts"
  default = "alerts@example.com"
}
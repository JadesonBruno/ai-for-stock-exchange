# General Variables
variable "project_name" {
  description = "Project name"
  type = string
  default = "ai-for-stock-exchange"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type = string
  default = "dev"

  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be: dev, staging or prod."
  }
}

variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-2"
}


# VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block from VPC"
  type = string
  default = "10.1.0.0/16"
}

variable "allow_ips" {
  description = "List of IPs allowed to access the Web App"
  type = list(string)
}

# Web App Variables
variable "web_app_instance_type" {
  description = "EC2 instance type for Web App"
  type = string
  default = "t3.small"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type = string
  default = "ami-0f5fcdfbd140e4ab7" # Ubuntu Server 22.04 LTS AMI
}

variable "default_user" {
  description = "The default user for the EC2 instance"
  type = string
  default = "ubuntu"
}

variable "deploy_path" {
  description = "Remote path on the EC2 instance where the application will be deployed"
  type = string
  default = "/opt/ai-for-stock-exchange"
}

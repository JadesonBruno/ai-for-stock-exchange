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

# VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block from VPC"
  type = string
  default = "10.1.0.0/16"
}

# Data sources for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Main VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "${var.project_name}-${var.environment}-vpc"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "VPC"
    Terraform = "true"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${var.project_name}-${var.environment}-igw"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "Internet Gateway"
    Terraform = "true"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.1.${count.index}.0/24"  # 10.1.0.0/24, 10.1.1.0/24
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.project_name}-${var.environment}-public-${substr(data.aws_availability_zones.available.names[count.index], -2, 2)}"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "Public Subnet"
    Terraform = "true"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    "Name" = "${var.project_name}-${var.environment}-public-rt"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "Public Route Table"
    Terraform = "true"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count = 2

  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

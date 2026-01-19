# AWS Security Group for Web Application
resource "aws_security_group" "web_app_sg" {
  name = "${var.project_name}-${var.environment}-web-app-sg"
  description = "Security group for web application"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow SSH access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allow_ips
  }

  ingress {
    description = "Allow Instance Connect"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    prefix_list_ids = [ "pl-03915406641cb1f53" ]
  }

  ingress {
    description = "Allow ICMP ping"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = var.allow_ips
  }

  ingress {
    description = "Allow Streamlit access"
    from_port = 8501
    to_port = 8501
    protocol = "tcp"
    cidr_blocks = var.allow_ips
  }

  ingress {
    description = "Allow all traffic from same security group"
    from_port = 0
    to_port = 0
    protocol = -1
    self = true
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.project_name}-${var.environment}-web-app-sg"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "Web App Security Group"
    Terraform = "true"
  }
}

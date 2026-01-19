# Generate locally an SSH key pair for accessing the web application instances
resource "tls_private_key" "web_app" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


# Create an AWS the public key
resource "aws_key_pair" "web_app" {
  key_name = "${var.project_name}-${var.environment}-web-app-key"
  public_key = tls_private_key.web_app.public_key_openssh

  tags = {
    "Name" = "${var.project_name}-${var.environment}-web-app-key"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "Web App Key Pair"
    Terraform = "true"
  }
}


# Save the private key to a local file
resource "local_file" "private_key" {
  content = tls_private_key.web_app.private_key_pem
  filename = "${path.module}/keys/web_app_private_key.pem"
  file_permission = "0400"
}


# Save the public key to a local file
resource "local_file" "public_key" {
  content = tls_private_key.web_app.public_key_openssh
  filename = "${path.module}/keys/web_app_public_key.pub"
  file_permission = "0400"
}

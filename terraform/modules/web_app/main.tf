resource "aws_instance" "web_app" {
  ami = var.ami_id
  instance_type = var.web_app_instance_type
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.web_app_sg.id]
  key_name = aws_key_pair.web_app.key_name

  root_block_device {
    volume_type = "gp3"
    volume_size = "50"
    encrypted = true

    tags = {
      "Name" = "${var.project_name}-${var.environment}-web-app-root-volume"
      "Project" = var.project_name
      "Environment" = var.environment
      "Service" = "Web App Root Volume"
      Terraform = "true"
    }
  }

  # Set connection for remote-exec provisioner
  connection {
    type = "ssh"
    user = var.default_user
    private_key = tls_private_key.web_app.private_key_pem
    host = self.public_ip
    timeout = "5m"
  }

  # Create application directory on the instance
  provisioner "remote-exec" {
    inline = [
        "sudo mkdir -p ${var.deploy_path}",
        "sudo chown -R ${var.default_user}:${var.default_user} ${var.deploy_path}",
    ]
  }

  # Copy application files to the instance
  provisioner "file" {
    source = "${var.app_local_path}/app"
    destination = "${var.deploy_path}/app"
  }

  provisioner "file" {
    source = "${var.app_local_path}/src"
    destination = "${var.deploy_path}/src"
  }

  provisioner "file" {
    source = "${var.app_local_path}/docker-compose.yml"
    destination = "${var.deploy_path}/docker-compose.yml"
  }

  provisioner "file" {
    source = "${var.app_local_path}/dockerfile"
    destination = "${var.deploy_path}/dockerfile"
  }

  provisioner "file" {
    source = "${var.app_local_path}/pyproject.toml"
    destination = "${var.deploy_path}/pyproject.toml"
  }

  provisioner "file" {
    source = "${var.app_local_path}/poetry.lock"
    destination = "${var.deploy_path}/poetry.lock"
  }

  provisioner "file" {
    source = "${var.app_local_path}/.env"
    destination = "${var.deploy_path}/.env"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/setup_web_app.sh"
    destination = "/tmp/setup_web_app.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup_web_app.sh",
      "sudo APP_DIR='${var.deploy_path}' /tmp/setup_web_app.sh",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.project_name}-${var.environment}-web-app"
    "Project" = var.project_name
    "Environment" = var.environment
    "Service" = "Web App"
    Terraform = "true"
  }
}

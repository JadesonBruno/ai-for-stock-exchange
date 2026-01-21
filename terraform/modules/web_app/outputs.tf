output "web_app_connection_info" {
  description = "Web App connection information"
  value = {
    ssh_command = "ssh -i ${path.module}/keys/web_app_private_key.pem ubuntu@${aws_instance.web_app.public_ip}"
    http_endpoint = "http://${aws_instance.web_app.public_ip}:8501"
    }
}

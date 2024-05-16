output "instance_id" {
  description = "ID of the EC2 instance"
  value = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "value of the instance public ip"
  value = aws_instance.app_server.public_ip
}
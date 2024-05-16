# provider block to configure the AWS provider
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

# resource block to create a new aws instance for example
resource "aws_instance" "app_server" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = var.ec2_instance_type
  tags = {
    Name = var.instance_name
  }
}
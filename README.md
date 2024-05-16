# terraform-sample

Sample terraform project to learn

Terraform is useful to declare your infastructure as code, it saves time, and it's declarative meaning you know what your infra looks like, and don't have to depend on what any devops/developer configuration was made in secret in a provider dashboard.

It is also multi-cloud so we don't depend on AWS or GCP etc..

## Prerequesites

You need to install [terraform cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

```
brew tap hashicorp/tap
```

```
brew install hashicorp/tap/terraform
```

## Steps

### Install provider
Create a `main.tf` file and declare what provider you want to use

```
provider "aws" {
  profile = "default"
  region = "us-east-1"
}
```

When you install and configure the aws cli in your machine you create credentials for a profile (by default is named default) in your `.aws/credentials` that contains your aws_access_key_id and aws_access_secret_key to authenticate with aws. It's the same way for provider profile in terraform.

Once the provider is declared we need to run `terraform init` to download that provider in our project.

### Create resources

Now that we can communicate with AWS for example, we can have blocks to create resources in our provider (buckets, instances...)

```
resource "aws_instance" "app_server" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "MyTerraformInstance"
  }
}
```

The first quote after the keyword resource is for the type of instance `"aws_instance"` the seconde quote is for the name we want to give to the instance `"app_server"`. We can also add tags to it.

To deploy our resource to aws we run `terraform apply`

<small>Before actually deploying the cli will show us a preview of what is added or removed, and if it looks okay for us, we can respond `yes` to actually deploy the changes to AWS</small>

Once the changes are made, it will generate a terraform state file `terraform.tfstate`, that represents the entire state of our infrastructure (the single source of truth of our infrastructure). That way the next change we made terraform will compare them to our current state of infrastructure and make changes accordingly.


To delete all resources we run `terraform destroy`. To delete a signle resource we remove it from the code and we run `terraform apply`

### Create Variables

Now that we have our resources, the values in it are hard-coded, imagine having a lot of resources and need to change some value in all of them. This is not good for scale, so we can create variables.

```
variable "instance_name" {
  description = "Value of the name tag for the EC2 instance"
  type        = string
  default = "MyNewInstance"
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type"
  type        = string
  default = "t2.micro"
}
```

And now to use them we can use the keyword `var`

```
resource "aws_instance" "app_server" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = var.ec2_instance_type
  tags = {
    Name = var.instance_name
  }
}
```

This will use the value in `default` field. If we want we can change it when we run terraform apply `terraform apply -var "instance_name=MyNewEC2Name"`, this will override the default.

If we want to override multiple variables, instead of doing it with terraform apply, we can also create a file `terraform.tfvars` that will contain the values to override.

terraform.tfvars
```
ec2_instance_type = "t3.micro"
instance_name = "instance_name=MyNewEC2Name"
```

### Create Outputs

Outputs are used to expose some data for a pipeline or other. For example imagine you want to output some IP adress so that the pipeline can ping it or whatever.

output.tf
```
output "instance_id" {
  description = "ID of the EC2 instance"
  value = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "value of the instance public ip"
  value = aws_instance.app_server.public_ip
}
```

We are accessing our resource by it's type and name and then some internal values (that we can find on each provider resource documentation).

We can see the output values once we run `terraform apply`

If we want to see them before actually apllying them we can run `terraform output`

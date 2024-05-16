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
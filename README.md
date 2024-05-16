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

Create a `main.tf` file and declare what provider you want to use

```
provider "aws" {
  profile = "default"
  region = "us-east-1"
}
```

When you install and configure the aws cli in your machine you create credentials for a profile (by default is named default) in your `.aws/credentials` that contains your key and secret key to authenticate with aws. It's the same way for provider profile in terraform.

Once the provider is declared we need to run `terraform init` to install that provider in our project.


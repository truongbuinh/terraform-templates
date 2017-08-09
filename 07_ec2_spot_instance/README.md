# Terraform template for AWS EC2 spot instance
You need to check and change the vars.tf as your need.

## Prerequisites
- Apply 01_vpc first
- AWS account
- AWS IAM access key
- AWS IAM secret key
- AWS region

## Installing
Terraform must first be installed on your machine
https://www.terraform.io/intro/getting-started/install.html

## How it works
```
terraform init          # Initialize the Terraform configuration
terraform plan          # See the resources which will be created
terraform apply         # Create the resources defined in all .tf files
terraform show          # Show the resources
terraform plan -destroy # See what will be removed
terraform destroy       # Remove the resources
```

## The below items will be created:
- Multi spot EC2 instances (root volume size is 30GB) in private subnets
- One EC2 Instance per availability zone (AZ) in the current AWS region
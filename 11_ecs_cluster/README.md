# Terraform template for AWS ECS
Amazon EC2 Container Service (ECS) is a highly scalable, high performance container management service that supports Docker containers and allows you to easily run applications on a managed cluster of Amazon EC2 instances.

## Prerequisites
- You need to check and change the vars.tf as your need
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
terraform init          # Initialize a new or existing Terraform configuration
terraform plan          # Generate and show an execution plan
terraform apply         # Builds or changes infrastructure
terraform show          # Inspect Terraform state or plan
terraform plan -destroy # Generate and show an execution plan to check what will be removed
terraform destroy       # Destroy Terraform-managed infrastructure
```

## The below items will be created
- 1 simple AWS ECS cluster
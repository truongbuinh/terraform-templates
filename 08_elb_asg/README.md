# Terraform template for AWS Elastic Load Balancer and Auto Scaling Group
Elastic Load Balancing automatically distributes your incoming application traffic across multiple targets, such as EC2 instances. It monitors the health of registered targets and routes traffic only to the healthy targets. Elastic Load Balancing supports two types of load balancers: Application Load Balancers and Classic Load Balancers.

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

## The below items will be created:
- Multi spot EC2 instances (root volume size is 30GB) in private subnets
- 1 Elastic Load Balancer
- 1 Launch Configuration
- 1 Auto Scaling Group
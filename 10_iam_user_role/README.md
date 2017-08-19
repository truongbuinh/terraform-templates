# Terraform template for AWS Identity and Access Management
AWS Identity and Access Management (IAM) is a web service that helps you securely control access to AWS resources for your users. You use IAM to control who can use your AWS resources (authentication) and what resources they can use and in what ways (authorization).


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
- Multiple IAM users and policies
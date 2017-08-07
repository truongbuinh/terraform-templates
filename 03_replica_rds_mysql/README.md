# Terraform template for AWS RDS
You need to check and change the vars.tf as your need.

## Prerequisites
- Apply 01_vpc first
- Apply 02_simple_rds_mysql
- AWS account
- AWS IAM access key
- AWS IAM secret key
- AWS region

## Installing
Terraform must first be installed on your machine
https://www.terraform.io/intro/getting-started/install.html

## How it works
```
terraform init          # Initialize the Terraform configuration. Store the terraform state to S3 bucket and lock it by DynamoDB
terraform plan          # See the resources which will be created
terraform apply         # Create the resources defined in all .tf files
terraform show          # Show the resources
terraform plan -destroy # See what will be removed
terraform destroy       # Remove the resources
```

## The below items will be created:
- 1 READ replication MySQL database with AWS RDS

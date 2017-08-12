# Terraform template for AWS RDS MySQL Read Replication
You need to check and change the vars.tf as your need.

Amazon Relational Database Service (Amazon RDS) is a web service that makes it easier to set up, operate, and scale a relational database in the cloud. It provides cost-efficient, resizable capacity for an industry-standard relational database and manages common database administration tasks.

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
terraform init          # Initialize the Terraform configuration
terraform plan          # See the resources which will be created
terraform apply         # Create the resources defined in all .tf files
terraform show          # Show the resources
terraform plan -destroy # See what will be removed
terraform destroy       # Remove the resources
```

## The below items will be created:
- 1 READ replication MySQL database with AWS RDS

# Terraform template for AWS EC2 on-demand instance
Amazon Elastic Compute Cloud (Amazon EC2) provides scalable computing capacity in the Amazon Web Services (AWS) cloud. Using Amazon EC2 eliminates your need to invest in hardware up front, so you can develop and deploy applications faster. You can use Amazon EC2 to launch as many or as few virtual servers as you need, configure security and networking, and manage storage. Amazon EC2 enables you to scale up or down to handle changes in requirements or spikes in popularity, reducing your need to forecast traffic.

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
- 1 on-demand EC2 instance (root volume size is 30GB) with an Elastic IP address

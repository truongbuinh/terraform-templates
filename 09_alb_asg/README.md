# Terraform template for AWS Elastic Load Balancer and Auto Scaling Group
You need to check and change the vars.tf as your need.

An Application Load Balancer is a load balancing option for the Elastic Load Balancing service that operates at the application layer and allows you to define routing rules based on content across multiple services or containers running on one or more Amazon Elastic Compute Cloud (Amazon EC2) instances.
- Content-Based Routing: If your application is composed of several individual services, an Application Load Balancer can route a request to a service based on the content of the request.

- Host-based Routing: You can route a client request based on Host field of the HTTP header allowing you to route to multiple domains from the same load balancer.

- Path-based Routing: You can route a client request based on the URL path of the HTTP header.

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
- 1 Application Load Balancer
- 1 Launch Configuration
- 1 Auto Scaling Group
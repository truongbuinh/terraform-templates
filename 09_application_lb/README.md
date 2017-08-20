# Terraform template for AWS Application Load Balancer
An Application Load Balancer is a load balancing option for the Elastic Load Balancing service that operates at the application layer and allows you to define routing rules based on content across multiple services or containers running on one or more Amazon Elastic Compute Cloud (Amazon EC2) instances.
- **Content-Based Routing**: If your application is composed of several individual services, an Application Load Balancer can route a request to a service based on the content of the request.
- **Host-based Routing**: You can route a client request based on Host field of the HTTP header allowing you to route to multiple domains from the same load balancer.
- **Path-based Routing**: You can route a client request based on the URL path of the HTTP header.

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
- 1 Application Load Balancer
- 1 Security group for ALB
- 1 Default target group
- 2 Listeners(HTTP and HTTPS) forward to the default target group
- 2 Path-based Routing rules for each HTTP and HTTPS protocol
- 1 Target group for each /app1 and /app2
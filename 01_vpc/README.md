# Terraform template for AWS VPC resource
You need to check and change the vars.tf as your need.

Amazon Virtual Private Cloud (VPC)
Amazon Virtual Private Cloud (Amazon VPC) lets you provision a logically isolated section of the Amazon Web Services (AWS) cloud where you can launch AWS resources in a virtual network that you define. You have complete control over your virtual networking environment, including selection of your own IP address range, creation of subnets, and configuration of route tables and network gateways.  You can use both IPv4 and IPv6 in your VPC for secure and easy access to resources and applications.

## The below items will be created:
- 1 S3 bucket with versioning and encryption to store terraform state
- 1 DynamoDB table to lock the terraform state
- 1 VPC
- 1 Internet Gateway
- 1 Route table for public subnets
- 1 Security group for NAT instance
- 1 NAT instance
- 2 Public subnets
- 2 Private subnets

## How it works
```
terraform init          # Initialize the Terraform configuration. Store the terraform state to S3 bucket and lock it by DynamoDB
```
Example output:
```
Do you want to copy state from "local" to "s3"?
  Pre-existing state was found in "local" while migrating to "s3". No existing
  state was found in "s3". Do you want to copy the state from "local" to
  "s3"? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes

Releasing state lock. This may take a few moments...
```
```
terraform plan          # See the resources which will be created
terraform apply         # Create the resources defined in all .tf files
terraform show          # Show the resources
terraform plan -destroy # See what will be removed
terraform destroy       # Remove the resources
```

If there are many team members who run the above terraform commands at the same time, they might see this error:
```
Error locking state: Error acquiring the state lock: ConditionalCheckFailedException: The conditional request failed
	status code: 400, request id: FIFxxxxxxx43SCCGOL3JEFURVV4KQNSO5AxxxxxxxxAJG
Lock Info:
  ID:        8414e07c-5a82-16b1-fd3e-5add7587dfe0
  Path:      tmp-tf-state-s3/01_vpc.tfstate
  Operation: OperationTypeApply
  Who:       truongbuinh@Mr-MacBook-Pro
  Version:   0.9.11
  Created:   2017-08-01 14:17:17.068420269 +0000 UTC
  Info:      

Terraform acquires a state lock to protect the state from being written
by multiple users at the same time. Please resolve the issue above and try
again. For most commands, you can disable locking with the "-lock=false"
flag, but this is not recommended.
```
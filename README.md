# Terraform Templates for AWS resources
The Terraform templates are used to create the AWS resources.
The Terraform introduction: https://www.terraform.io/intro/index.html

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
- AWS account
- AWS IAM access key
- AWS IAM secret key
- AWS region
- AWS EC2 key pair # For SSH access

### Installing
Terraform must first be installed on your machine
https://www.terraform.io/intro/getting-started/install.html

## How it works
```
Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Environment management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a new or existing Terraform configuration
    output             Read an output from a state file
    plan               Generate and show an execution plan
    push               Upload this Terraform module to Atlas to run
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
```

## Overview
Directory | Description
------------ | -------------
01_vpc | Create VPC, NAT instance
02_simple_rds_mysql | Create a simple AWS RDS MySQL
03_replica_rds_mysql | Add a READ replication AWS RDS MySQL
04_simple_elasticache_redis | Create an AWS ElastiCache Redis with one server
05_cluster_elasticache_redis | Create an AWS ElastiCache Redis with one master and one replica node on each availability zone
06_ec2_ondemand_instance | Create a simple on-demand AWS EC2 instance with Elastic IP in public subnets
07_ec2_spot_instance | Create spot AWS EC2 instance in private subnets
08_elb_asg | Create an Elastic Load Balancer and Auto Scaling Group with EC2 spot instances


## Authors
* **Truong Bui** - [truongbuinh](https://github.com/truongbuinh)
* Please feel free to contact me at **truongbuinh@gmail.com** if you have any concern.
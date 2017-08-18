/*
# Retrieves state meta data from a remote backend
*/
data "terraform_remote_state" "01_vpc" {
  backend = "s3"
  config {
    bucket = "tmp-tf-state-s3" # YOUR_BUCKET_NAME
    key = "01_vpc.tfstate"
    region = "ap-southeast-2" # Your region
    encrypt = "true"
    dynamodb_table = "terraform_statelock" # Your DynamoDB table with LockID
  }
}

variable "aws_region" {
    default     = "ap-southeast-2"
}

variable "aws_access_key" {
  description   = "Type your AWS access key here"
}

variable "aws_secret_key" {
  description   = "Type your AWS secret key here"
}

variable "aws_key_name" {
  default       = "sample-keypair"
}

data "aws_availability_zones" "aws_az_all" {
}

variable "availability_zone" {
  type = "list"
  default = [
    "ap-southeast-2a",
    "ap-southeast-2b",
    "ap-southeast-2c"
  ]
}

variable "vpc_list_private_subnets_id" {
  type = "list"
  default = [
    "subnet-e1cbc485",
    "subnet-d76955a1",
    "subnet-6c8cfe35"
  ]
}

variable "root_block_device_type" {
  default = "gp2"
}

variable "root_block_device_size" {
  default = "30"
}

data "aws_ami" "aws_ecs_ami_latest" {
    most_recent = true

    filter {
      name   = "name"
      values = ["amzn-ami-*-amazon-ecs-optimized*"]
    }

    filter {
      name   = "owner-alias"
      values = ["amazon"]
    }
}

variable "ecs_simple_cluster_name" {
  default     = "ecs-simple-cluster"
}

variable "ecs_cluster_size" {
  description = "Number of servers in cluster"
  default     = 2
}

variable "ecs_instance_type" {
  description = "ECS instance type"
  default     = "t2.micro"
}
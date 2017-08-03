variable "aws_region" {
    default       = "ap-southeast-2"
    description   = "The AWS region you want to launch your services"
}

variable "availability_zone" {
    type = "map"
    default = {
      availability_zone_a = "ap-southeast-2a"
      availability_zone_b = "ap-southeast-2b"
    }
}

variable "aws_access_key" {
    description   = "Type your AWS access key here"
}

variable "aws_secret_key" {
    description   = "Type your AWS secret key here"
}

variable "aws_s3_bucket_statelock" {
    description   = "Type your AWS S3 bucket name here"
    default = "tmp-tf-state-s3"
}

variable "vpc_name" {
    description = "Type your AWS VPC name here"
    default     = "your_test_terraform_vpc"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    type        = "map"
    default     = {
      public_subnet_cidr_1 = "10.0.1.0/24"
      public_subnet_cidr_2 = "10.0.2.0/24"
    }
}

variable "public_subnet_cidr_all" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
    type        = "map"
    default     = {
      private_subnet_cidr_1 = "10.0.11.0/24"
      private_subnet_cidr_2 = "10.0.12.0/24"
    }
}

variable "private_subnet_cidr_all" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

# Search the latest AMI to launch NAT server
data "aws_ami" "aws_nat_ami" {
    most_recent = true

    filter {
      name   = "name"
      values = ["amzn-ami-vpc-nat-hvm-2017*"]
    }

    filter {
      name   = "owner-alias"
      values = ["amazon"]
    }

}

variable "aws_nat_instance_type" {
    description = "Choose instance_type for NAT server"
    default = "t2.micro"
}

# Choose the exising AWS key pair in your AWS account
variable "aws_key_name" {
    description = "Enter your AWS keypair name for SSH access"
    default = "sample-keypair"
}

variable "aws_dynamodb_table_name" {
    description = "Enter your AWS DynamoDB table name used to lock the terraform state"
    default     = "terraform_statelock"
}
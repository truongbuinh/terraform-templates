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
  default       = "ap-southeast-2"
  description   = "The AWS region you want to launch your services"
}

variable "availability_zone" {
  type = "map"
  default = {
    availability_zone_a = "ap-southeast-2a"
    availability_zone_b = "ap-southeast-2b"
    availability_zone_c = "ap-southeast-2c"
  }
}

variable "aws_access_key" {
  description   = "Type your AWS access key here"
}

variable "aws_secret_key" {
  description   = "Type your AWS secret key here"
}

# Choose the exising AWS key pair in your AWS account
variable "aws_key_name" {
    description = "Enter your AWS keypair name for SSH access"
    default = "sample-keypair"
}

data "aws_availability_zones" "aws_az_all" {
}

variable "aws_instance_type" {
  description = "Type your EC2 instance type"
  default     = "m3.medium"
}

variable "aws_ec2_spot_price" {
  description = "Type your EC2 spot price"
  default = "0.25"
}

variable "number_of_server" {
  description = "Type number of instance you want to create"
  default = "2"
}

variable "aws_instance_sg" {
  description = "Type your EC2 security group name"
  default     = "ec2_spot_instance_sg"
}

# Search the latest AMI to launch EC2 instance
data "aws_ami" "ec2_spot_instance" {
    most_recent = true

    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server*"]
    }

    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical

}

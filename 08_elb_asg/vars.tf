/*
# Retrieves state meta data from a remote backend
*/
data "terraform_remote_state" "01_vpc" {
  backend = "s3"
  config {
    bucket          = "tmp-tf-state-s3" # YOUR_BUCKET_NAME
    key             = "01_vpc.tfstate"
    region          = "ap-southeast-2" # Your region
    encrypt         = "true"
    dynamodb_table  = "terraform_statelock" # Your DynamoDB table with LockID
  }
}

variable "aws_region" {
  default       = "ap-southeast-2"
  description   = "The AWS region you want to launch your services"
}

variable "availability_zone" {
  type    = "map"
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

# Choose the exising AWS key pair in your AWS account
variable "aws_key_name" {
    description = "Enter your AWS keypair name for SSH access"
    default     = "sample-keypair"
}

data "aws_availability_zones" "aws_az_all" {
}

variable "aws_instance_type" {
  description = "Type your EC2 instance type"
  default     = "m3.medium"
}

variable "aws_ec2_spot_price" {
  description = "Type your EC2 spot price"
  default     = "0.25"
}

variable "asg_min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  default     = "2"
}
variable "asg_max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  default     = "10"
}

variable "aws_instance_sg" {
  description = "Type your EC2 security group name"
  default     = "tf_ec2_instance_sg"
}

variable "aws_elb_sg" {
  description = "Type your ELB security group name"
  default     = "tf_app_elb_sg"
}

variable "aws_elb_name" {
  description = "Type your ELB name"
  default     = "tf-simple-elb"
}

variable "aws_launch_conf_name" {
  description = "Type your AWS Launch Configuration name"
  default     = "tf_simple_launch_conf"
}

variable "aws_asg_name" {
  description = "Type your AWS Auto Scaling Group name"
  default     = "tf_simple_asg"
}

# variable "aws_ssl_cert" {
#     default     = "Your_SSL_Cert"
#     description = "Your_SSL_Cert"
# }

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

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
    default     = "sample-keypair"
}

data "aws_availability_zones" "aws_az_all" {
}

variable "aws_alb_sg" {
  description = "Type your ALB security group name"
  default     = "tf_alb_sg"
}

variable "aws_alb_name" {
  description = "Type your AWS ALB name"
  default     = "tf-simple-alb"
}
/*
# In case you want to create ALB in private subnets
*/
# variable "vpc_list_private_subnets_id" {
#   type = "list"
#   default = [
#     "subnet-e1cbc485",
#     "subnet-d76955a1",
#     "subnet-6c8cfe35"
#   ]
# }

variable "vpc_list_public_subnets_id" {
  type = "list"
  default = [
    "subnet-1dc9c679",
    "subnet-9e6854e8",
    "subnet-39f28060"
  ]
}

variable "default_target_group_port" {
  type    = "string"
  default = "80"
}

variable "default_target_group_protocol" {
  type    = "string"
  default = "HTTP"
}

variable "listener_certificate_arn" {
  type    = "string"
  default = "arn:aws:iam::xxxxx:server-certificate/xxxxx" # Choose an existing certificate from AWS Identity and Access Management (IAM)
}
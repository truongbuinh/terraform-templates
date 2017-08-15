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

variable "aws_access_key" {
  description   = "Type your AWS access key here"
}

variable "aws_secret_key" {
  description   = "Type your AWS secret key here"
}

variable "aws_user_names" {
  description   = "Create IAM users with these names"
  type          = "list"
  default       = ["tfapple", "tforange", "tfbanana"]
}

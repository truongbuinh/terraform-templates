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

variable "aws_db_instance_class" {
  description = "Type your database instance class"
  default     = "db.t2.micro"
}

variable "aws_db_allocated_storage" {
  description = "Type your database allocated storage"
  default     = "5" # Gigabytes
}

variable "aws_database_sg" {
  description = "Type your AWS security group name for database"
  default     = "aws_database_sg"
}

variable "main_db_subnet_group" {
  description = "Type your database subnet group name for database"
  default     = "main_db_subnet_group"
}

variable "aws_rds_mysql_identifier" {
  description = "Type your RDS database identifier name"
  default     = "tf-simple-rds-mysql"  # The identifier is unique. You should change it here.
}

variable "aws_rds_mysql_dbname" {
  description = "Type your database name"
  default     = "simplerdsmysql"
}

variable "aws_rds_mysql_admin" {
  description = "Type your database admin account"
  default     = "dbadmin"
}

variable "aws_rds_mysql_password" {
  description = "Type your database admin password"
  # default     = "adm1n2345678" # Only printable ASCII characters besides '/', '@', '"', ' ' may be used.
}

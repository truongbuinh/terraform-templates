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

data "aws_availability_zones" "aws_az_all" {
}

variable "aws_access_key" {
  description   = "Type your AWS access key here"
}

variable "aws_secret_key" {
  description   = "Type your AWS secret key here"
}

variable "aws_elasticache_redis_security_group_name" {
  description = "Your ElastiCache Redis security group name"
  default     = "replica_elasticache_redis_sg"
}

variable "aws_elasticache_redis_subnetgrp" {
  description = "Your ElastiCache Redis subnet group name"
  default     = "tf-cluster-redis-subnetgrp" # Identifiers must begin with a letter; must contain only ASCII letters, digits, and hyphens; and must not end with a hyphen or contain two consecutive hyphens.
}

variable "aws_elasticache_redis_cluster_name" {
  description = "Your ElastiCache Redis cluster name"
  default     = "tf-cluster-redis" # "replication_group_id" must contain from 1 to 20 alphanumeric characters or hyphens
}

variable "aws_elasticache_redis_parameter_group" {
  description = "ElastiCache Redis Parameter group"
  default     = "default.redis3.2"
}

variable "aws_elasticache_redis_node_type" {
  default = "cache.m4.large"
}

variable "aws_elasticache_redis_engine_version" {
  default = "3.2.4"
}
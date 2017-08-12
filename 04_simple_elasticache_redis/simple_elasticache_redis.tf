/*
# Create security group to allow Redis access from private subnets
*/

resource "aws_security_group" "simple_elasticache_redis_sg" {
    name        = "${var.aws_elasticache_redis_security_group_name}"
    description = "Allow access from private subnets to AWS ElastiCache (terraform-managed)"
    vpc_id      = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

    ingress {
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      cidr_blocks = ["${data.terraform_remote_state.01_vpc.private_subnet_cidr_all}"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["${data.terraform_remote_state.01_vpc.private_subnet_cidr_all}"]
    }

    tags {
      Name = "${var.aws_elasticache_redis_security_group_name}"
    }
}

resource "aws_elasticache_subnet_group" "simple_elasticache_redis_subnetgrp" {
    name        = "${var.aws_elasticache_redis_subnetgrp}"
    description = "Subnet group for AWS ElastiCache (terraform-managed)"
    subnet_ids  = ["${data.terraform_remote_state.01_vpc.private_subnet_id_1}", "${data.terraform_remote_state.01_vpc.private_subnet_id_2}", "${data.terraform_remote_state.01_vpc.private_subnet_id_3}"]
}

resource "aws_elasticache_cluster" "simple_elasticache_redis_cluster" {
    cluster_id                    = "${var.aws_elasticache_redis_cluster_name}"
    engine                        = "redis"
    node_type                     = "${var.aws_elasticache_redis_node_type}"
    num_cache_nodes               = 1
    engine_version                = "${var.aws_elasticache_redis_engine_version}"
    parameter_group_name          = "${var.aws_elasticache_redis_parameter_group}"
    subnet_group_name             = "${aws_elasticache_subnet_group.simple_elasticache_redis_subnetgrp.name}"
    security_group_ids            = ["${aws_security_group.simple_elasticache_redis_sg.id}"]
    port                          = "6379"
    availability_zone             = "${var.availability_zone["availability_zone_a"]}"

    tags {
        Name = "${var.aws_elasticache_redis_cluster_name}"
    }
}
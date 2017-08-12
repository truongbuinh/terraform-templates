
/*
# Create security group to allow Redis access from private subnets
*/

resource "aws_security_group" "replica_elasticache_redis_sg" {
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

resource "aws_elasticache_subnet_group" "replica_elasticache_redis_subnetgrp" {
    name        = "${var.aws_elasticache_redis_subnetgrp}"
    description = "Subnet group for AWS ElastiCache (terraform-managed)"
    subnet_ids  = ["${data.terraform_remote_state.01_vpc.private_subnet_id_1}", "${data.terraform_remote_state.01_vpc.private_subnet_id_2}", "${data.terraform_remote_state.01_vpc.private_subnet_id_3}"]
}


/*
# Create Redis Master with One Replica node in each availability zone
*/
resource "aws_elasticache_replication_group" "replica_elasticache_redis_cluster" {
  replication_group_id          = "${var.aws_elasticache_redis_cluster_name}" # "replication_group_id" must contain from 1 to 20 alphanumeric characters or hyphens
  replication_group_description = "AWS ElastiCache Redis Replica"
  node_type                     = "${var.aws_elasticache_redis_node_type}"
  number_cache_clusters         = 3 # Must match the number of preferred availability zones.
  port                          = 6379
  parameter_group_name          = "${var.aws_elasticache_redis_parameter_group}"
  availability_zones            = ["${data.aws_availability_zones.aws_az_all.names}"]
  automatic_failover_enabled    = true # Automatic failover is not supported for T1 and T2 cache node types.
  subnet_group_name             = "${aws_elasticache_subnet_group.replica_elasticache_redis_subnetgrp.name}"
  security_group_ids            = ["${aws_security_group.replica_elasticache_redis_sg.id}"]
  apply_immediately             = true

  tags {
      Name = "${var.aws_elasticache_redis_cluster_name}"
  }

}


/*
# Create Native Redis Cluser 2 Masters 2 Replicas
*/
# resource "aws_elasticache_replication_group" "replica_elasticache_redis_cluster" {
#   replication_group_id          = "${var.aws_elasticache_redis_cluster_name}" # "replication_group_id" must contain from 1 to 20 alphanumeric characters or hyphens
#   replication_group_description = "AWS ElastiCache Redis Replica"
#   node_type                     = "${var.aws_elasticache_redis_node_type}"
#   port                          = 6379
#   parameter_group_name          = "${var.aws_elasticache_redis_parameter_group}"
#   availability_zones            = ["${data.aws_availability_zones.aws_az_all.names}"]
#   automatic_failover_enabled    = true # Automatic failover is not supported for T1 and T2 cache node types.
#   subnet_group_name             = "${aws_elasticache_subnet_group.replica_elasticache_redis_subnetgrp.name}"
#   security_group_ids            = ["${aws_security_group.replica_elasticache_redis_sg.id}"]
#   apply_immediately             = true
#
#   cluster_mode {
#     replicas_per_node_group     = 1
#     num_node_groups             = 2
#   }
#
#   tags {
#       Name = "${var.aws_elasticache_redis_cluster_name}"
#   }
#
# }


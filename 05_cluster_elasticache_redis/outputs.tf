output "replica_elasticache_redis_port" {
  value = "${aws_elasticache_replication_group.replica_elasticache_redis_cluster.port}"
}

output "replica_elasticache_redis_primary_endpoint_address" {
  value = "${aws_elasticache_replication_group.replica_elasticache_redis_cluster.primary_endpoint_address}"
}

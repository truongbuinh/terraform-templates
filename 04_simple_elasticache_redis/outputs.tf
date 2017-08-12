output "simple_elasticache_redis_node_address" {
  value = "${aws_elasticache_cluster.simple_elasticache_redis_cluster.cache_nodes.0.address}"
}

output "simple_elasticache_redis_port" {
  value = "${aws_elasticache_cluster.simple_elasticache_redis_cluster.port}"
}
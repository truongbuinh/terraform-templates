output "ecs_simple_cluster_id" {
  value = "${aws_ecs_cluster.ecs_simple_cluster.id}"
}

output "ecs_instance_private_ip" {
  value = "${aws_instance.ecs_simple_instance.*.private_ip}"
}
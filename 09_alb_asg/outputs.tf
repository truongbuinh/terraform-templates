output "aws_autoscaling_group_name" {
  value = "${aws_autoscaling_group.simple_asg.name}"
}

output "aws_simple_alb_name" {
  value = "${aws_alb.simple_alb.name}"
}

output "aws_simple_alb_dns_name" {
  value = "${aws_alb.simple_alb.dns_name}"
}
output "aws_autoscaling_group_name" {
  value = "${aws_autoscaling_group.simple_asg.name}"
}

output "aws_simple_elb_name" {
  value = "${aws_elb.simple_elb.name}"
}

output "aws_simple_elb_dns_name" {
  value = "${aws_elb.simple_elb.dns_name}"
}
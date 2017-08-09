output "aws_autoscaling_group_name" {
  value = "${aws_autoscaling_group.simple_asg.name}"
}

output "simple_elb_name" {
  value = "${aws_elb.simple_elb.name}"
}
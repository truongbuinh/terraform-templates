output "alb_security_group_id" {
  value = "${aws_security_group.alb_sg.id}"
}
# The ARN of the created Application Load Balancer
output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}

output "alb_arn_suffix" {
  value = "${aws_alb.alb.arn_suffix}"
}

# The ARN of the created Application Load Balancer Listener
output "alb_listener_arn" {
  value = "${aws_alb_listener.alb_listener.arn}"
}

# The DNS name of the created Application Load Balancer.
output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
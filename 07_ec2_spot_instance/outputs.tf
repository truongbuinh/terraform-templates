output "ec2_spot_instance_private_ip" {
  value = "${aws_spot_instance_request.ec2_spot_instance.*.private_ip}"
}

output "ec2_spot_instance_id" {
  value = "${aws_spot_instance_request.ec2_spot_instance.*.id}"
}

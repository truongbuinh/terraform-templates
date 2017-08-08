output "ec2_ondemand_instance_public_ip" {
  value = "${aws_instance.ec2_ondemand_instance.public_ip}"
}

output "ec2_ondemand_instance_private_ip" {
  value = "${aws_instance.ec2_ondemand_instance.private_ip}"
}

output "ec2_ondemand_instance_id" {
  value = "${aws_instance.ec2_ondemand_instance.id}"
}

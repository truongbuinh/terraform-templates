output "terraform_state_s3_arn" {
  value = "${aws_s3_bucket.terraform_state_s3.arn}"
}

output "test_terraform_vpc_id" {
  value = "${aws_vpc.your_test_terraform_vpc.id}"
}

output "public_subnet_cidr_all" {
  value = "${var.public_subnet_cidr_all}"
}

output "public_subnet_id_1" {
  value = "${aws_subnet.public_subnet_cidr_1.id}"
}

output "public_subnet_id_2" {
  value = "${aws_subnet.public_subnet_cidr_2.id}"
}

output "private_subnet_cidr_all" {
  value = "${var.private_subnet_cidr_all}"
}

output "private_subnet_id_1" {
  value = "${aws_subnet.private_subnet_cidr_1.id}"
}

output "private_subnet_id_2" {
  value = "${aws_subnet.private_subnet_cidr_2.id}"
}
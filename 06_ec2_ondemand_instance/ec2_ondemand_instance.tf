/*
# Create a on-demand EC2 instance in VPC public subnet
*/
resource "aws_security_group" "ec2_ondemand_instance_sg" {
    name        = "${var.aws_instance_sg}"
    description = "Allow SSH from anywhere (terraform-managed)"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id   = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

    tags {
        Name = "${var.aws_instance_sg}"
    }
}

resource "aws_instance" "ec2_ondemand_instance" {
    ami                     = "${data.aws_ami.ec2_ondemand_instance.id}"
    availability_zone       = "${var.availability_zone["availability_zone_a"]}"
    instance_type           = "${var.aws_instance_type}"
    key_name                = "${var.aws_key_name}"
    vpc_security_group_ids  = ["${aws_security_group.ec2_ondemand_instance_sg.id}"]
    subnet_id               = "${data.terraform_remote_state.01_vpc.public_subnet_id_1}"
    associate_public_ip_address = true

    tags {
        Name = "ec2_ondemand_instance"
    }
}

resource "aws_eip" "ec2_ondemand_instance_eip" {
    instance = "${aws_instance.ec2_ondemand_instance.id}"
    vpc = true
}
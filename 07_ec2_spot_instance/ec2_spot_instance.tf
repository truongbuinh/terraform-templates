/*
# Create a on-demand EC2 instance in VPC public subnet
*/
resource "aws_security_group" "ec2_spot_instance_sg" {
    name        = "${var.aws_instance_sg}"
    description = "Allow SSH from VPC public subnets (terraform-managed)"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${data.terraform_remote_state.01_vpc.public_subnet_cidr_all}"]
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

resource "aws_spot_instance_request" "ec2_spot_instance" {
    ami                     = "${data.aws_ami.ec2_spot_instance.id}"
    availability_zone       = "${var.availability_zone["availability_zone_a"]}"
    # availability_zone       = "${element(data.aws_availability_zones.aws_az_all.names, count.index)}"
    instance_type           = "${var.aws_instance_type}"
    spot_price              = "${var.aws_ec2_spot_price}"
    spot_type               = "one-time"
    count                   = "${var.number_of_server}"
    key_name                = "${var.aws_key_name}"
    vpc_security_group_ids  = ["${aws_security_group.ec2_spot_instance_sg.id}"]
    user_data               = "${file("sample-user-data.sh")}"
    subnet_id               = "${data.terraform_remote_state.01_vpc.private_subnet_id_1}"
    # subnet_id               = "${element(data.terraform_remote_state.01_vpc.private_subnet_id_1, count.index)}"
    wait_for_fulfillment    = "true"
    # ebs_optimized           = "true"

    root_block_device {
      volume_size = 30
      volume_type = "gp2"
    }

    tags {
        Name = "ec2_spot_instance-${count.index}"
    }
}
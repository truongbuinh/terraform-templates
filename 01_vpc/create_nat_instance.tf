/*
  NAT Instance
*/
resource "aws_security_group" "vpc_nat_sg" {
    name = "vpc_nat_sg"
    description = "Allow traffic from the private subnets to the Internet (terraform-managed)"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "${var.private_subnet_cidr_all}"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = "${var.private_subnet_cidr_all}"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    tags {
        Name = "VPC_NAT_SG"
    }
}

resource "aws_instance" "vpc_nat_instance" {
    ami = "${data.aws_ami.aws_nat_ami.id}"
    availability_zone = "${var.availability_zone["availability_zone_a"]}"
    instance_type = "${var.aws_nat_instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.vpc_nat_sg.id}"]
    subnet_id = "${aws_subnet.public_subnet_cidr_1.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "VPC_NAT_Instance"
    }
}

resource "aws_eip" "vpc_nat_eip" {
    instance = "${aws_instance.vpc_nat_instance.id}"
    vpc = true
}


/*
# Add Route table for Private subnets. More options in https://www.terraform.io/docs/providers/aws/r/route_table.html
*/
resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.vpc_nat_instance.id}"
    }

    tags {
        Name = "private_route_table"
    }
}


/*
# Add Route table association for Public subnets. More options in https://www.terraform.io/docs/providers/aws/r/route_table_association.html
*/
resource "aws_route_table_association" "private_route_table_a" {
    subnet_id = "${aws_subnet.private_subnet_cidr_1.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "private_route_table_b" {
    subnet_id = "${aws_subnet.private_subnet_cidr_2.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "private_route_table_c" {
    subnet_id = "${aws_subnet.private_subnet_cidr_3.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
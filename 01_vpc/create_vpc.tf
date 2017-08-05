/*
# Create S3 bucket to store the Terraform state
*/
resource "aws_s3_bucket" "terraform_state_s3" {
    bucket = "${var.aws_s3_bucket_statelock}"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = false
    }
}


/*
# Create a DynamoDB table to lock Terraform states
*/
resource "aws_dynamodb_table" "terraform_statelock" {
    name           = "${var.aws_dynamodb_table_name}"
    read_capacity  = 10
    write_capacity = 10
    hash_key       = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }

    lifecycle {
      prevent_destroy = false
    }

}


/*
# Create basic AWS VPC usage. More options in https://www.terraform.io/docs/providers/aws/d/vpc.html
*/
resource "aws_vpc" "your_test_terraform_vpc" {
    cidr_block       = "${var.vpc_cidr}"
    instance_tenancy = "default"

    tags {
      Name = "${var.vpc_name}"
    }
}


/*
# Create AWS Internate gateway.
*/
resource "aws_internet_gateway" "aws_internet_gateway" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    tags {
      Name = "${var.vpc_name}"
    }
}


/*
# Public Subnets in AZs. More options in https://www.terraform.io/docs/providers/aws/d/subnet.html
*/
resource "aws_subnet" "public_subnet_cidr_1" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    cidr_block = "${var.public_subnet_cidr["public_subnet_cidr_1"]}"
    availability_zone = "${var.availability_zone["availability_zone_a"]}"

    tags {
        Name = "public_subnet_az_a"
    }
}

resource "aws_subnet" "public_subnet_cidr_2" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    cidr_block = "${var.public_subnet_cidr["public_subnet_cidr_2"]}"
    availability_zone = "${var.availability_zone["availability_zone_b"]}"

    tags {
        Name = "public_subnet_az_b"
    }
}


/*
# Add Route table for Public subnets. More options in https://www.terraform.io/docs/providers/aws/r/route_table.html
*/
resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.aws_internet_gateway.id}"
    }

    tags {
        Name = "public_route_table"
    }
}


/*
# Add Route table association for Public subnets. More options in https://www.terraform.io/docs/providers/aws/r/route_table_association.html
*/
resource "aws_route_table_association" "public_route_table_a" {
    subnet_id = "${aws_subnet.public_subnet_cidr_1.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "public_route_table_b" {
    subnet_id = "${aws_subnet.public_subnet_cidr_2.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}


/*
# Private Subnets in AZs
*/
resource "aws_subnet" "private_subnet_cidr_1" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    cidr_block = "${var.private_subnet_cidr["private_subnet_cidr_1"]}"
    availability_zone = "${var.availability_zone["availability_zone_a"]}"

    tags {
        Name = "private_subnet_az_a"
    }
}

resource "aws_subnet" "private_subnet_cidr_2" {
    vpc_id = "${aws_vpc.your_test_terraform_vpc.id}"

    cidr_block = "${var.private_subnet_cidr["private_subnet_cidr_2"]}"
    availability_zone = "${var.availability_zone["availability_zone_b"]}"

    tags {
        Name = "private_subnet_az_b"
    }
}
/*
# Create security group to allow MySQL access from private subnets
*/

resource "aws_security_group" "aws_database_sg" {
    name = "${var.aws_database_sg}"
    description = "Allow access from private subnets (terraform-managed)"

    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["${data.terraform_remote_state.01_vpc.private_subnet_cidr_all}"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

    tags {
        Name = "${var.aws_database_sg}"
    }
}


/*
# Create a subnet group in private subnet
*/
resource "aws_db_subnet_group" "main_db_subnet_group" {
  name        = "${var.main_db_subnet_group}"
  description = "RDS private subnets group (terraform-managed)"
  subnet_ids  = ["${data.terraform_remote_state.01_vpc.private_subnet_id_1}", "${data.terraform_remote_state.01_vpc.private_subnet_id_2}"]

  tags {
    Name      = "${var.main_db_subnet_group}"
  }
}


/*
# Create a simple MySQL in private subnet
*/
resource "aws_db_instance" "simple_rds_mysql" {
  allocated_storage        = "${var.aws_db_allocated_storage}"
  storage_type             = "gp2"
  engine                   = "mysql"
  engine_version           = "5.7.17"
  instance_class           = "${var.aws_db_instance_class}"
  name                     = "${var.aws_rds_mysql_dbname}"
  identifier               = "${var.aws_rds_mysql_identifier}"
  username                 = "${var.aws_rds_mysql_admin}"
  password                 = "${var.aws_rds_mysql_password}"
  final_snapshot_identifier = "${var.aws_rds_mysql_dbname}"
  skip_final_snapshot      = true
  backup_retention_period  = 7   # in days
  copy_tags_to_snapshot    = true
  db_subnet_group_name     = "${aws_db_subnet_group.main_db_subnet_group.id}"
  multi_az                 = false # True if you want to enable Multi AZs support
  availability_zone        = "${var.availability_zone["availability_zone_a"]}"
  parameter_group_name     = "default.mysql5.7"
  publicly_accessible      = false
  vpc_security_group_ids   = ["${aws_security_group.aws_database_sg.id}"]

  tags {
    Name      = "${var.aws_rds_mysql_identifier}"
  }
}
/*
# Create a replica MySQL in private subnet
*/
resource "aws_db_instance" "replica_rds_mysql" {
  allocated_storage           = "${var.aws_db_allocated_storage}"
  engine                      = "${data.terraform_remote_state.02_simple_rds_mysql.simple_rds_mysql_engine}"
  engine_version              = "${data.terraform_remote_state.02_simple_rds_mysql.simple_rds_mysql_engine_version}"
  instance_class              = "${var.aws_db_instance_class}"
  username                    = "${var.aws_rds_mysql_admin}"
  identifier                  = "${var.aws_rds_mysql_identifier}"
  # final_snapshot_identifier   = "${var.aws_rds_mysql_dbname}" # Final Snapshots are not available for Read Replica DB Instances when destroy the server
  skip_final_snapshot         = true
  copy_tags_to_snapshot       = true
  security_group_names        = [
    "${data.terraform_remote_state.02_simple_rds_mysql.simple_rds_mysql_db_security_group}"
  ]

  replicate_source_db         = "${data.terraform_remote_state.02_simple_rds_mysql.simple_rds_mysql_identifier}"
  parameter_group_name        = "${data.terraform_remote_state.02_simple_rds_mysql.simple_rds_mysql_parameter_group_name}"
  storage_type                = "gp2"
  multi_az                    = false
  availability_zone           = "${var.availability_zone["availability_zone_b"]}"
  publicly_accessible         = false
  storage_encrypted           = false
  auto_minor_version_upgrade  = false
  allow_major_version_upgrade = false
  backup_retention_period     = 7
  apply_immediately           = ""

  tags {
    Name      = "${var.aws_rds_mysql_identifier}"
  }

}
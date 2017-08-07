output "simple_rds_mysql_address" {
  value = "${aws_db_instance.simple_rds_mysql.address}"
}

output "simple_rds_mysql_port" {
  value = "${aws_db_instance.simple_rds_mysql.port}"
}

output "simple_rds_mysql_identifier" {
  value = "${aws_db_instance.simple_rds_mysql.identifier}"
}

output "simple_rds_mysql_engine" {
  value = "${aws_db_instance.simple_rds_mysql.engine}"
}

output "simple_rds_mysql_engine_version" {
  value = "${aws_db_instance.simple_rds_mysql.engine_version}"
}

output "simple_rds_mysql_parameter_group_name" {
  value = "${aws_db_instance.simple_rds_mysql.parameter_group_name}"
}

output "simple_rds_mysql_db_security_group" {
  value = "${aws_security_group.aws_database_sg.id}"
}

output "simple_rds_mysql_db_subnetgrp_name" {
  value = "${aws_db_subnet_group.main_db_subnet_group.name}"
}

output "simple_rds_mysql_db_subnetgrp_arn" {
  value = "${aws_db_subnet_group.main_db_subnet_group.arn}"
}
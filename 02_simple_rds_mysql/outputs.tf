output "simple_rds_mysql_address" {
  value = "${aws_db_instance.simple_rds_mysql.address}"
}

output "simple_rds_mysql_port" {
  value = "${aws_db_instance.simple_rds_mysql.port}"
}
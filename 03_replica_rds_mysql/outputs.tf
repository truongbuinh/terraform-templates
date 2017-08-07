output "replica_rds_mysql_address" {
  value = "${aws_db_instance.replica_rds_mysql.address}"
}

output "replica_rds_mysql_port" {
  value = "${aws_db_instance.replica_rds_mysql.port}"
}

output "replica_rds_mysql_identifier" {
  value = "${aws_db_instance.replica_rds_mysql.identifier}"
}

output "replica_rds_mysql_engine" {
  value = "${aws_db_instance.replica_rds_mysql.engine}"
}

output "replica_rds_mysql_engine_version" {
  value = "${aws_db_instance.replica_rds_mysql.engine_version}"
}
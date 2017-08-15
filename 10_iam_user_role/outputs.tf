output "all_iam_users_arns" {
  value = ["${aws_iam_user.example_iam_user_role.*.arn}"]
}

output "ec2_read_only_policy_arn" {
  value = ["${aws_iam_policy.ec2_read_only_policy.arn}"]
}
/*
# Create a AWS IAM Users
*/
resource "aws_iam_user" "example_iam_user_role" {
  count       = "${length(var.aws_user_names)}"
  name        = "${element(var.aws_user_names, count.index)}"
}


/*
# Create a JSON file to describe EC2 instances
*/
data "aws_iam_policy_document" "ec2_read_only_json" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}


/*
# Create an IAM policy with the above JSON data
*/
resource "aws_iam_policy" "ec2_read_only_policy" {
  name        = "ec2-read-only"
  description = "Sample EC2 Read-Only Policy (terraform-managed)"

  policy      = "${data.aws_iam_policy_document.ec2_read_only_json.json}"

 # policy      = "${file("sample-json.json")}"

#   policy    = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "ec2:Describe*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
}


/*
# Attach the IAM policy with IAM users created above
*/
resource "aws_iam_user_policy_attachment" "ec2_access_policy_attachment" {
  count       = "${length(var.aws_user_names)}"
  user        = "${element(aws_iam_user.example_iam_user_role.*.name, count.index)}"
  policy_arn  = "${aws_iam_policy.ec2_read_only_policy.arn}"
}
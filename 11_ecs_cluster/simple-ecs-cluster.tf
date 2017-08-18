/*
# Create simple AWS ECS cluster
*/
resource "aws_ecs_cluster" "ecs_simple_cluster" {
  name = "${var.ecs_simple_cluster_name}"
}


/*
# Create AWS security group
*/
resource "aws_security_group" "ecs_simple_cluster_sg" {
  name        = "${var.ecs_simple_cluster_name}-sg"
  description = "${var.ecs_simple_cluster_name} security group (terraform-managed)"
  vpc_id      = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.terraform_remote_state.01_vpc.private_subnet_cidr_all}"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.ecs_simple_cluster_name}-sg"
  }
}

data "template_file" "ecs_user_data" {
  template       = "${file("${path.module}/sample-user-data.sh")}"

  vars {
    cluster_name = "${var.ecs_simple_cluster_name}"
  }
}


/*
# Create container Instance IAM resources
*/
data "aws_iam_policy_document" "container_instance_ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ecs_instance_profile_role" {
  name               = "ECSInstanceProfileRole"
  description        = "Role for ECS Instance Profile (terraform-managed)"
  assume_role_policy = "${data.aws_iam_policy_document.container_instance_ec2_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_service_role" {
  role       = "${aws_iam_role.ecs_instance_profile_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


/*
# Create AWS EC2 instance and register it to ECS Cluster
*/
resource "aws_instance" "ecs_simple_instance" {
  count                       = "${var.ecs_cluster_size}"

  key_name                    = "${var.aws_key_name}"
  ami                         = "${data.aws_ami.aws_ecs_ami_latest.id}"
  instance_type               = "${var.ecs_instance_type}"
  subnet_id                   = "${element(var.vpc_list_private_subnets_id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.ecs_simple_cluster_sg.id}"]
  user_data                   = "${data.template_file.ecs_user_data.rendered}"
  iam_instance_profile        = "${aws_iam_role.ecs_instance_profile_role.name}" #IAM instance profile not created fast enough to modify EC2 instance
  availability_zone           = "${element(var.availability_zone, count.index)}"

  root_block_device {
    volume_size = "${var.root_block_device_size}"
    volume_type = "${var.root_block_device_type}"
  }

  tags {
    # Name        = "${format("%s-%s-ecs-simple-slave-%d", var.project, var.environment, count.index + 1)}"
    Name        = "${format("ecs-simple-cluster-%d", count.index + 1)}"
  }

}
/*
# Create a security group for Application Load Balancer
*/
resource "aws_security_group" "alb_sg" {
    name        = "${var.aws_alb_sg}"
    description = "Security group for ALB (terraform-managed)"
    vpc_id      = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
      Name = "${var.aws_alb_sg}"
    }
}


resource "aws_alb" "alb" {
  subnets         = ["${var.vpc_list_public_subnets_id}"]
  security_groups = ["${aws_security_group.alb_sg.id}"]
  # internal        = "${var.internal_alb}"

  tags {
    name = "${var.aws_alb_name}"
  }
}

# alb_listener creates the listener that is then attached to the ALB supplied by the alb resource.
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  ssl_policy        = "${lookup(map("HTTP", ""), var.listener_protocol, "ELBSecurityPolicy-2015-05")}"
  certificate_arn   = "${var.listener_certificate_arn}"

  default_action     = {
    target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
    type             = "forward"
  }
}


resource "aws_alb_target_group" "alb_default_target_group" {
  name     = "default-target-${replace(aws_alb.alb.arn_suffix, "/.*\\/([a-z0-9]+)$/", "$1")}"
  port     = "${var.default_target_group_port}"
  protocol = "${var.default_target_group_protocol}"
  vpc_id   = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

  tags {
    name = "${var.aws_alb_name}-target-group"
  }
}

resource "aws_security_group_rule" "alb_listener_security_group_rule" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  from_port         = "${var.listener_port}"
  to_port           = "${var.listener_port}"
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
}
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
  name            = "${var.aws_alb_name}"
  subnets         = ["${var.vpc_list_public_subnets_id}"]
  security_groups = ["${aws_security_group.alb_sg.id}"]
  internal        = false

  enable_deletion_protection = false

  # access_logs {
  #   bucket = "YOUR_BUCKET_NAME"
  #   prefix = "test-alb"
  # }

  tags {
    name = "${var.aws_alb_name}"
  }
}

# Create Listeners for HTTP protocol
resource "aws_alb_listener" "alb_http_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action     = {
    target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
    type             = "forward"
  }
}

# Create Listeners for HTTPS protocol
resource "aws_alb_listener" "alb_https_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.listener_certificate_arn}"

  default_action     = {
    target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
    type             = "forward"
  }
}

# Create the default target group
resource "aws_alb_target_group" "alb_default_target_group" {
  name     = "default-target-${replace(aws_alb.alb.arn_suffix, "/.*\\/([a-z0-9]+)$/", "$1")}"
  port     = "${var.default_target_group_port}"
  protocol = "${var.default_target_group_protocol}"
  vpc_id   = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

  tags {
    name = "${var.aws_alb_name}-default-target-grp"
  }
}

# resource "aws_security_group_rule" "alb_listener_security_group_rule" {
#   security_group_id = "${aws_security_group.alb_sg.id}"
#   from_port         = "${var.listener_port}"
#   to_port           = "${var.listener_port}"
#   type              = "ingress"
#   protocol          = "tcp"
#   cidr_blocks       = ["10.0.0.0/16"]
# }

/*
# In case you're using the same domain for multiple services, e.g: www.example.com/app1 and www.example.com/app2, you will need to create 2 other target groups for /app1 and /app2
*/
# Create /app1 target group
resource "aws_alb_target_group" "alb_app1_target_group" {
  name     = "app1-target-grp-${replace(aws_alb.alb.arn_suffix, "/.*\\/([a-z0-9]+)$/", "$1")}"
  port     = "${var.default_target_group_port}"
  protocol = "${var.default_target_group_protocol}"
  vpc_id   = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/app1/index.html"
    interval            = 30
    protocol            = "HTTP"
  }

  tags {
    name = "${var.aws_alb_name}-app1-target-grp"
  }
}

# Create /app2 target group
resource "aws_alb_target_group" "alb_app2_target_group" {
  name     = "app2-target-grp-${replace(aws_alb.alb.arn_suffix, "/.*\\/([a-z0-9]+)$/", "$1")}"
  port     = "${var.default_target_group_port}"
  protocol = "${var.default_target_group_protocol}"
  vpc_id   = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/app2/index.html"
    interval            = 30
    protocol            = "HTTP"
  }

  tags {
    name = "${var.aws_alb_name}-app2-target-grp"
  }
}

/*
# Then you will also need to add new rules on Listeners
*/

# Path-based Routing for app1 HTTP
resource "aws_alb_listener_rule" "alb_app1_http_path_route" {
  listener_arn = "${aws_alb_listener.alb_http_listener.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_app1_target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app1/*"]
  }
}

# Path-based Routing for app2 HTTP
resource "aws_alb_listener_rule" "alb_app2_http_path_route" {
  listener_arn = "${aws_alb_listener.alb_http_listener.arn}"
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_app2_target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app2/*"]
  }
}

# Path-based Routing for app1 HTTPS
resource "aws_alb_listener_rule" "alb_app1_https_path_route" {
  listener_arn = "${aws_alb_listener.alb_https_listener.arn}"
  priority     = 97

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_app1_target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app1/*"]
  }
}

# Path-based Routing for app2 HTTPS
resource "aws_alb_listener_rule" "alb_app2_https_path_route" {
  listener_arn = "${aws_alb_listener.alb_https_listener.arn}"
  priority     = 96

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_app2_target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/app2/*"]
  }
}


# Host-based Routing for your server
# resource "aws_alb_listener_rule" "host_based_routing" {
#   listener_arn = "${aws_alb_listener.xxxxxx.arn}"
#   priority     = 98
#
#   action {
#     type             = "forward"
#     target_group_arn = "${aws_alb_target_group.xxxxxx.arn}"
#   }
#
#   condition {
#     field  = "host-header"
#     values = ["my-service.*.terraform.io"]
#   }
# }
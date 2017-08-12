/*
# Create a security group for Elastic Load Balancer
*/
resource "aws_security_group" "aws_elb_sg" {
    name        = "${var.aws_elb_sg}"
    description = "Security group for ELB (terraform-managed)"
    vpc_id      = "${data.terraform_remote_state.01_vpc.test_terraform_vpc_id}"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ingress {
    #     from_port   = 443
    #     to_port     = 443
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


/*
# Create an Elastic Load Balancer
*/
resource "aws_elb" "simple_elb" {
    name            = "${var.aws_elb_name}"
    subnets         = ["${data.terraform_remote_state.01_vpc.private_subnet_id_1}", "${data.terraform_remote_state.01_vpc.private_subnet_id_2}", "${data.terraform_remote_state.01_vpc.private_subnet_id_3}"]
    security_groups = ["${aws_security_group.aws_elb_sg.id}"]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }
    # listener {
    #     instance_port       = 80
    #     instance_protocol   = "http"
    #     lb_port             = 443
    #     lb_protocol         = "https"
    #     ssl_certificate_id  = "${var.aws_ssl_cert}"
    # }
    health_check {
        healthy_threshold   = 6
        unhealthy_threshold = 4
        interval            = 30
        timeout             = 5
        target              = "TCP:80"
    }

    tags {
        Name = "${var.aws_elb_name}"
    }
}

/*
# Create a Launch configuration and an Auto Scaling Group with spot EC2 instances
*/
resource "aws_launch_configuration" "simple_launch_conf_asg" {
  name_prefix           = "${var.aws_launch_conf_name}"
  image_id              = "${data.aws_ami.ec2_spot_instance.id}"
  instance_type         = "${var.aws_instance_type}"
  spot_price            = "${var.aws_ec2_spot_price}"
  key_name              = "${var.aws_key_name}"
  security_groups       = ["${aws_security_group.aws_elb_sg.id}"]
  user_data             = "${file("sample-user-data.sh")}"

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "simple_asg" {
  name                 = "${var.aws_asg_name}"
  availability_zones   = ["${data.aws_availability_zones.aws_az_all.names}"]
  launch_configuration = "${aws_launch_configuration.simple_launch_conf_asg.name}"
  min_size             = "${var.asg_min_size}"
  max_size             = "${var.asg_max_size}"
  desired_capacity     = "${var.asg_min_size}"
  health_check_grace_period = 300
  health_check_type    = "EC2"
  termination_policies = ["NewestInstance"]
  load_balancers       = ["${aws_elb.simple_elb.name}"]
  vpc_zone_identifier  = ["${data.terraform_remote_state.01_vpc.private_subnet_id_1}", "${data.terraform_remote_state.01_vpc.private_subnet_id_2}", "${data.terraform_remote_state.01_vpc.private_subnet_id_3}"]

  tag = {
      key                 = "Name"
      value               = "${var.aws_asg_name}"
      propagate_at_launch = true
    }

  lifecycle {
    create_before_destroy = true
  }

}
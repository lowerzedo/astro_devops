resource "aws_launch_configuration" "web_lc" {
  name_prefix   = "${var.app_name}-web-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_pair

  user_data = <<-EOF
              #!/bin/bash
              # Commands to initialize the web server (IF NEEDED)
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                      = "${var.app_name}-web-asg"
  vpc_zone_identifier       = [for subnet in aws_subnet.public : subnet.id]
  launch_configuration      = aws_launch_configuration.web_lc.name
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  health_check_type         = "ELB"
  health_check_grace_period = 300

  target_group_arns = [aws_lb_target_group.web_tg.arn]
}

resource "aws_launch_configuration" "app_lc" {
  name_prefix   = "${var.app_name}-app-"
  image_id      = var.ami_id 
  instance_type = var.instance_type
  security_groups = [aws_security_group.app_sg.id]
  key_name        = var.key_pair
  iam_instance_profile = aws_iam_instance_profile.app_instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              # Commands to initialize the application server (IF NEEDED)
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.app_name}-app-asg"
  vpc_zone_identifier       = [for subnet in aws_subnet.private : subnet.id]
  launch_configuration      = aws_launch_configuration.app_lc.name
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300

  target_group_arns = [aws_lb_target_group.app_tg.arn]
}
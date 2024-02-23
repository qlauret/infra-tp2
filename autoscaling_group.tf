# Variable juste pour dire
variable "nom_prenom" {
  type    = string
  default = "quentinlauret"
}
resource "aws_autoscaling_group" "app_servers" {
  name = "autoscalingGroup_${var.nom_prenom}"

  max_size = 2
  min_size = 2

  desired_capacity = 2

  launch_template {
    id = aws_launch_template.mon_launch_template.id
  }

  target_group_arns = [aws_target_group.mon_target_group.arn]

  health_check_type = "EC2"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_target_group" "mon_target_group" {
  name = "app-servers-tg_${var.nom_prenom}"

  protocol = "HTTP"
  port = 80

  health_check {
    interval = 10
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

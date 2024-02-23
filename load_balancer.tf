
# Définition du security group pour le load balancer
resource "aws_security_group" "lb_sg" {
  name = "sg-lb-quentinlauret"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Définition du target group
resource "aws_lb_target_group" "mon_tg" {
  name     = "tg-quentinlauret"
  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {
    path = "/"
  }
}

# Définition du load balancer applicatif
resource "aws_elastic_load_balancer" "mon_elb" {
  name             = "elb-quentinlauret"
  subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  security_groups  = [aws_security_group.lb_sg.id]

  enable_deletion_protection = false

  listener {
    protocol = "TCP"
    port     = 80

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.mon_tg.arn
    }
  }
}
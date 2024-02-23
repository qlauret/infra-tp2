# Variable juste pour dire
variable "nom_prenom" {
  type    = string
  default = "quentinlauret"
}

resource "aws_launch_template" "mon_launch_template" {
  name = "launchTemplate-${var.nom_prenom}"

  image_id      = "ami-012ba92271e91512d"
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
        #!/bin/bash
        cd /home/ubuntu/app/
        sudo docker compose up --build -d
        EOF
  )
  placement {
    availability_zone = "eu-west-1a"
  }

  network_interfaces {
    associate_public_ip_address = true
  }
  
}


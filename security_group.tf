# Variable juste pour dire
variable "nom_prenom" {
  type    = string
  default = "quentinlauret"
}

# Définition de la VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc-${var.nom_prenom}"
  }
}

# Définition du security group 
resource "aws_security_group" "mon_groupe_de_secu" {
  name = "securityGroup-${var.nom_prenom}"
  description = "Security Group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
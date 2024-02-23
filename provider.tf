
# Sélection du provider souhaité et de sa version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuration du provider qui correspond au fichiers dans ~/.aws/
provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}
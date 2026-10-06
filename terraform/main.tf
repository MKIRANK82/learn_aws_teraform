terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "learn-aws-terraform-state-kiran1"
    key          = "employee-api/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "employee_data" {
  bucket = "learn-aws-terraform-employee-data"
}

resource "aws_ecr_repository" "learn_employee_api" {
  name = "learn-employee-api"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "employee_api_ecr_url" {
  value = aws_ecr_repository.learn_employee_api.repository_url
}
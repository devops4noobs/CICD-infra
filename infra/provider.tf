provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "s3-lock-devops4noobs"
    region         = "eu-central-1"
    key            = "state/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
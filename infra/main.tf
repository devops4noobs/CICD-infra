provider "aws" {
  region = var.region
}

module "ec2" {
  source                 = "../modules/ec2"
  region                 = var.region
  key_name               = var.key_name
  instance_count         = var.instance_count
  instance-name          = var.instance-name
  subnet_id              = module.vpc.public-subnet
  #vpc_security_group_ids = module.aws_security_group.vpc_security_group_ids.id
  vpc_security_group_id = module.security-group.security_group_id
  vpc_id = module.vpc.vpc_id
  #subnet_id              = module.security_group.aws_subnet.public-subnet.id
}

module "security-group" {
  source                   = "../modules/security-group"

  vpc_id = module.vpc.vpc_id
  ingress_cidr_from_port   = var.ingress_cidr_from_port
  ingress_cidr_to_port     = var.ingress_cidr_to_port
  ingress_cidr_protocol    = var.ingress_cidr_protocol
  ingress_cidr_block       = var.ingress_cidr_block
  ingress_cidr_description = var.ingress_cidr_description
  create_ingress_cidr      = var.create_ingress_cidr
  egress_cidr_from_port = var.egress_cidr_from_port
  egress_cidr_to_port   = var.egress_cidr_to_port
  egress_cidr_protocol  = var.egress_cidr_protocol
  egress_cidr_block     = var.egress_cidr_block
  create_egress_cidr    = var.create_egress_cidr

}

module "vpc" {
  source = "../modules/vpc"
  vpc_id = module.vpc.vpc_id
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

module "iam" {
  source   = "../modules/iam"
  iam-role = var.iam-role
}
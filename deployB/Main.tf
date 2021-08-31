terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.6.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source    = "./modules/VPC"
  namespace = var.namespace
}

module "ec2" {
  source     = "./modules/ec2"
  namespace  = var.namespace
  vpc        = module.vpc.vpc
}
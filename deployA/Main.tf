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

module "vpc_example_simple-vpc" {
  source  = "./modules/terraform-aws-vpc/examples/simple-vpc"
}

module "ec2" {
    source = "./modules/EC2"
    vpc_subnet_id = module.vpc_example_simple-vpc.public_subnets[0]
}
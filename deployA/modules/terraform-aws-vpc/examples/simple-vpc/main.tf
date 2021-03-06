provider "aws" {
  region = local.region
}

locals {
  region = "us-west-2"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../../"

  name = "simple-example-cr"
  cidr = "60.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["60.0.1.0/24", "60.0.2.0/24", "60.0.3.0/24"]
  public_subnets  = ["60.0.101.0/24", "60.0.102.0/24", "60.0.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "simple-example-cr-public"
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-cr"
  }
}

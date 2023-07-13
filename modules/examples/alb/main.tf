provider "aws" {
  region = "us-east-2"
}

module "alb" {
  source = "../../../modules/networking/alb"

  alb_name = "${var.cluster_name}-ALB"
 
  subnet_ids = data.aws_subnets.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

provider "aws" {
  region = "us-east-2"
}

module "app" {
  source = "../../../modules/services/hello-world-app"

  db_remote_state_bucket = "terraform-up-and-running-state-sct6443"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  environment = "stage"
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  server_port = 8080
  server_text = "This is an update"
  min_size = 1
  max_size = 1
  enable_autoscaling = false
  cluster_name = "Test-Cluster"
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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]  # Canonical

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
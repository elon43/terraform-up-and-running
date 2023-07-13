provider "aws" {
  region = "us-east-2"
}

module "asg" {
  source = "../../../../modules/cluster/asg-rolling-deploy"

  cluster_name = "stage"
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  min_size = 1
  max_size = 1
  enable_autoscaling = false

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  subnet_ids = data.aws_subnets.default.ids

  server_port = 8080
  custom_tags = { 
    Owner = "team-foo"
    ManagedBy = "terraform"
  }    
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
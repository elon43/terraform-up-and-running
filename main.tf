# Configure the AWS Provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

provider "aws" {
  region = "us-east-2"
}

# Create EC2 Instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "example" {
  ami           = "ami-0430580de6244e02e"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}

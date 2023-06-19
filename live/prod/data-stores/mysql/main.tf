# Configure the AWS Provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

provider "aws" {
  region = "us-east-2"
}

# Create Terraform Backend using S3
# https://developer.hashicorp.com/terraform/language/settings/backends/s3
terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-sct6443"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"


    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
# Create MYSQL Database
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = "prod_database"

  username = var.db_username
  password = var.db_password
}
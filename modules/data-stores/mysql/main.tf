# Configure the Required Providers Block
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.4.0"
    }
  }
}

/*
# Configure the AWS Provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = "us-east-2"
  alias = "primary"
}

provider "aws" {
  region = "us-west-2"
  alias = "replica"
}
*/

# Create MYSQL Database
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  
  # Enable backups
  backup_retention_period = var.backup_retention_period
  
  # If specified, this DB will be a replica
  replicate_source_db = var.replicate_source_db

  #Only set these params if replicate_source_db is not set
  engine              = var.replicate_source_db == null ? "mysql" : null
  db_name             = var.replicate_source_db == null ? var.db_name : null
  username            = var.replicate_source_db == null ? var.db_username : null
  password            = var.replicate_source_db == null ? var.db_password : null
}




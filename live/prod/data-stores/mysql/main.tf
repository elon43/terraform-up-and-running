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

# Create Terraform Backend using S3
# https://developer.hashicorp.com/terraform/language/settings/backends/s3
terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-sct6443"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"


    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

# Configure the AWS Provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"
  
  providers = {
    aws = aws.primary
  }

  # Configure AWS Providers
  # https://developer.hashicorp.com/terraform/language/modules/develop/providers
  db_name  = "prod_db"
  db_username = var.db_username
  db_password = var.db_password

  # Must be enable to support replication
  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"

  # Configure AWS Providers
  # https://developer.hashicorp.com/terraform/language/modules/develop/providers

  providers = {
    aws = aws.replica
  }
  

  # Must be enable to support replication
  replicate_source_db = module.mysql_primary.arn
}
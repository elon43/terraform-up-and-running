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
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"


    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


module "webserver_cluster" {
  source                 = "github.com/elon43/terraform-up-and-running-modules//services/webserver-cluster?ref=v0.0.1"
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-sct6443"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}

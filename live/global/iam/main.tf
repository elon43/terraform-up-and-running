# Configure the AWS Provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

provider "aws" {
  region = "us-east-2"
}

# Create IAM users
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "example" {
  for_each = toset(var.user-names)
  name  = each.value
}

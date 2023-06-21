output "all_users" {
  value       = values(aws_iam_user.example)[*].arn
  description = "The name of all user"
}


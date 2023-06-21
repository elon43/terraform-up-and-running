variable "user-names" {
  description = "Creates IAM users with these names"
  type        = list(string)
  default     = ["neo", "morpheus"]
}
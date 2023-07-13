variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}


variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}








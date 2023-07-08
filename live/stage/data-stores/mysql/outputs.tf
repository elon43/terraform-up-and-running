output "address" {
  value       = module.mysql_primary.address
  description = "Connect to the primary database at this endpoint"
}

output "port" {
  value       = module.mysql_primary.port
  description = "the port the primary database is listening on"
}
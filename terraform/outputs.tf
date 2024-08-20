output "webserver_ips" {
  description = "IP addresses of web server instances"
  value       = yandex_compute_instance.web[*].network_interface[0].nat_ip_address
}

output "web_vpc_id" {
  description = "ID of the VPC Network"
  value       = yandex_vpc_network.vpc.id
}

output "web_subnet_id" {
  description = "ID of the VPC Subnet"
  value       = yandex_vpc_subnet.subnet.id
}

output "db_username" {
  description = "Database administrator username"
  value       = yandex_mdb_postgresql_user.dbuser.name
  sensitive   = true
}

output "db_name" {
  description = "Database administrator username"
  value       = yandex_mdb_postgresql_database.db.name
  sensitive   = true
}

output "db_password" {
  description = "Database administrator username"
  value       = yandex_mdb_postgresql_user.dbuser.password
  sensitive   = true
}

output "db_cluster_id" {
  description = "Database administrator username"
  value       = yandex_mdb_postgresql_cluster.project-db.id
  #sensitive   = true
}

output "db_host" {
  description = "Database administrator username"
  value       = yandex_mdb_postgresql_cluster.project-db.host.0.fqdn
  #sensitive   = true
}
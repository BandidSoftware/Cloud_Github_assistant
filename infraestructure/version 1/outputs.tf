output "buckets_names" {
  value = module.buckets.bucket_names
}

output "datamart_table_name" {
  value = module.databases.datamart_table_name
}

output "clients_table_name" {
  value = module.databases.clients_table_name
}
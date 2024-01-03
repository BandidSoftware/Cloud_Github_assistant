module "buckets" {
    source = "./modules/buckets"
    bucket_prefix = "git-radar"
    environment = "dev"
}

module "databases" {
  source              = "./modules/databases"
  datamart_table_name = "git-radar-datamart"
  clients_table_name  = "git-radar-clients"
}

#Definir resto de infraestructura
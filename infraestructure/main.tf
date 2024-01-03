module "buckets" {
    source = "./modules/buckets"
    bucket_prefix = "git-radar"
    environment = "dev"
}
#Definir resto de infraestructura
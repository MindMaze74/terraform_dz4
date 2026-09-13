# ================dz1========================
# Сеть
# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }

# Подсеть
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = ["10.0.1.0/24"]
# }
# ================dz1========================

# ================dz2========================
#module "vpc_dev" {
#  source   = "./modules/vpc"
#  env_name = "develop"
#  zone     = var.default_zone
#  cidr     = "10.0.1.0/24"
#}
# ================dz2=========================

# ================dz4*========================
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" }
  ]
}

module "vpc_prod" {
  source   = "./modules/vpc"
  env_name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}
# ================dz4*========================

# SSH-ключ
locals {
  ssh_public_key = var.ssh_public_key != "" ? var.ssh_public_key : file("~/.ssh/id_rsa.pub")
}

# ВМ marketing
module "marketing_vm" {
  source         = "./modules/vm"
  env_name       = "marketing"
  zone           = var.default_zone
  subnet_id      = values(module.vpc_dev.subnet_ids)[0]   
  ssh_public_key = local.ssh_public_key
  labels = {
    project = "marketing"
  }
  cloud_init = templatefile("${path.module}/cloud-init.yml", {
    ssh_public_key = local.ssh_public_key
  })
}

# ВМ analytics
module "analytics_vm" {
  source         = "./modules/vm"
  env_name       = "analytics"
  zone           = var.default_zone
  subnet_id      = values(module.vpc_dev.subnet_ids)[0]  
  ssh_public_key = local.ssh_public_key
  labels = {
    project = "analytics"
  }
  cloud_init = templatefile("${path.module}/cloud-init.yml", {
    ssh_public_key = local.ssh_public_key
  })
}

# ================dz5*========================
# module "mysql_cluster" {
#   source       = "./modules/mysql"
#   cluster_name = "example"
#   network_id   = module.vpc_dev.network_id
#   subnet_id    = values(module.vpc_dev.subnet_ids)[0]
#   zone         = "ru-central1-a"
#   ha           = true
# }
#
# module "mysql_db" {
#   source        = "./modules/mysql_db"
#   cluster_id    = module.mysql_cluster.cluster_id
#   db_name       = "test"
#   user_name     = "app"
#   user_password = "SecurePassword123!"
# }
# ================dz5*========================
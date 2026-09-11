terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_mdb_mysql_cluster" "test" {
  name        = var.cluster_name
  environment = "PRESTABLE"
  network_id  = var.network_id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  dynamic "host" {
    for_each = var.ha ? [1, 2] : [1]
    content {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }
}

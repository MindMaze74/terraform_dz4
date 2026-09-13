terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.226.0"
    }
  }
  required_version = "~>1.12.0"

  backend "s3" {
    bucket  = "terraform-dz5-state-1789286165"
    key     = "src_dz1/terraform.tfstate"
    region  = "ru-central1"

    use_lockfile = true

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    access_key                  = "YC......." #бакет сикрет
    secret_key                  = "YCP...." #бакет сикрет
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = "/home/user/authorized_key.json"
  zone                     = "ru-central1-a"
}
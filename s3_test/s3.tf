provider "aws" {
  region                      = "us-east-1"
  access_key                  = var.s3_access_key
  secret_key                  = var.s3_secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "https://storage.yandexcloud.net"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

module "s3_bucket" {
  source = "github.com/terraform-yc-modules/terraform-yc-s3"

  bucket_name = "terraform-dz4-bucket-${random_string.bucket_suffix.result}"
  folder_id   = var.folder_id
  max_size    = 1
}

output "s3_bucket_name" {
  value       = module.s3_bucket.bucket_name
  description = "Имя созданного S3 бакета"
}

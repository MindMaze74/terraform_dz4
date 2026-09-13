variable "folder_id" {
  type        = string
  description = "ID каталога Yandex Cloud"
}

variable "s3_access_key" {
  type        = string
  description = "Static access key для S3"
  sensitive   = true
}

variable "s3_secret_key" {
  type        = string
  description = "Static secret key для S3"
  sensitive   = true
}
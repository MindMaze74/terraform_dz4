variable "cluster_name" {
  type        = string
  description = "Имя кластера MySQL"
}

variable "network_id" {
  type        = string
  description = "ID сети VPC для размещения кластера"
}

variable "subnet_id" {
  type        = string
  description = "ID подсети для хоста БД"
}

variable "zone" {
  type        = string
  description = "Зона доступности для хоста БД"
}

variable "ha" {
  type        = bool
  default     = false
  description = "Включить High Availability (2 хоста вместо 1)"
}
variable "cluster_id" {
  type        = string
  description = "ID кластера MySQL"
}

variable "db_name" {
  type        = string
  description = "Имя создаваемой базы данных"
}

variable "user_name" {
  type        = string
  description = "Имя пользователя БД"
}

variable "user_password" {
  type        = string
  description = "Пароль пользователя БД"
  sensitive   = true
}
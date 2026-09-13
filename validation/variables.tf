variable "ip" {
  type        = string
  description = "ip-адрес"

  validation {
    condition     = can(cidrhost("${var.ip}/32", 0))
    error_message = "Значение должно быть корректным IP-адресом (например, 192.168.0.1)."
  }
}

variable "ip_list" {
  type        = list(string)
  description = "список ip-адресов"

  validation {
    condition = alltrue([
      for ip in var.ip_list : can(cidrhost("${ip}/32", 0))
    ])
    error_message = "Все элементы списка должны быть корректными IP-адресами."
  }
}
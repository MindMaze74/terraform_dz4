variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "develop"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" }
  ]
}


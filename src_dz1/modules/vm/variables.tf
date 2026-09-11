variable "env_name" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "cloud_init" {
  type = string
}
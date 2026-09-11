data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc/terraform.tfstate"
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
  subnet_id      = values(data.terraform_remote_state.vpc.outputs.subnet_ids)[0]
}
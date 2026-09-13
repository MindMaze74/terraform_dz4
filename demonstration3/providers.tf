terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "~> 4.0"
    }
  }
  required_version = "~>1.12.0"
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  #checkov:skip=CKV_SECRET_6:education is a well-known dev token, not a real secret
  token = "education"
}

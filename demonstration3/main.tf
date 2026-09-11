data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

output "vault_test_value" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data["test"])
}

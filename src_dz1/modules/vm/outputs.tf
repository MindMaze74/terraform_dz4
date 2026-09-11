output "instance_id" {
  value = yandex_compute_instance.test.id
}

output "instance_name" {
  value = yandex_compute_instance.test.name
}

output "external_ip" {
  value = yandex_compute_instance.test.network_interface[0].nat_ip_address
}


resource "yandex_compute_instance" "test" {
  name        = "vm-from-remote-state"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = local.subnet_id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}

output "vm_external_ip" {
  value = yandex_compute_instance.test.network_interface[0].nat_ip_address
}
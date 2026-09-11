resource "yandex_vpc_network" "test" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "test" {
  for_each = { for s in var.subnets : "${s.zone}-${s.cidr}" => s }

  name           = "${var.vpc_name}-subnet-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.test.id
  v4_cidr_blocks = [each.value.cidr]
}

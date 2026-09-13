# Домашнее задание к занятию «Использование Terraform в команде» - Старцев Данила Антонович

### Цели задания

1. Научиться использовать remote state с блокировками.
2. Освоить приёмы командной работы.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.12.0
Пишем красивый код, хардкод значения не допустимы!

------
### Задание 0
1. Прочтите статью: https://neprivet.com/
2. Пожалуйста, распространите данную идею в своем коллективе.

------

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).

### Ответ:

Проверены папки: `src/`, `src_dz1/`, `demonstration1/`, `demonstration3/`, `s3_test/`.

### tflint — типы ошибок (без дублей)

1. **`terraform_required_providers`**  не указана версия провайдера в `required_providers`.
2. **`terraform_unused_declarations`**  переменная объявлена, но не используется.
3. **`terraform_module_pinned_source`**  модуль подключён без версии/хеша. 

### checkov — типы ошибок

1. **`CKV_TF_1`**  модули подключены без хеша коммита.
2. **`CKV_TF_2`**  модули подключены без версии/тега.
3. **`CKV_YC_1`**  не назначена security group для MySQL-кластера.
4. **`CKV_YC_2`**  у ВМ есть публичный IP.
5. **`CKV_YC_4`**  включён serial-port (serial console).
6. **`CKV_YC_11`** не назначена security group на сетевой интерфейс ВМ.
7. **`CKV_SECRET_6`** найден токен `education` в `providers.tf`.

<details>
  <summary>Нажмите, чтобы увидеть листинг по Задаче 1</summary>

``` bash

user@ubuntu24:~/git/terraform_dz4$ tflint --version
TFLint version 0.64.0
+ ruleset.terraform (0.15.0-bundled)
user@ubuntu24:~/git/terraform_dz4$ rm tflint tflint_linux_amd64.zip
echo "tflint" >> .gitignore
echo "*.zip" >> .gitignore
user@ubuntu24:~/git/terraform_dz4$ cd ~/git/terraform_dz4/
user@ubuntu24:~/git/terraform_dz4$ cd src
user@ubuntu24:~/git/terraform_dz4/src$ tflint --init
All plugins are already installed
user@ubuntu24:~/git/terraform_dz4/src$ tflint -f compact
4 issue(s) found:

providers.tf:3:14: Warning - Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)
variables.tf:36:1: Warning - variable "vms_ssh_root_key" is declared but not used (terraform_unused_declarations)
variables.tf:43:1: Warning - variable "vm_web_name" is declared but not used (terraform_unused_declarations)
variables.tf:50:1: Warning - variable "vm_db_name" is declared but not used (terraform_unused_declarations)
user@ubuntu24:~/git/terraform_dz4/src$ cd ..
user@ubuntu24:~/git/terraform_dz4$ cd demonstration1
user@ubuntu24:~/git/terraform_dz4/demonstration1$ tflint --init
All plugins are already installed
user@ubuntu24:~/git/terraform_dz4/demonstration1$ tflint -f compact
user@ubuntu24:~/git/terraform_dz4/demonstration1$ cd ..
user@ubuntu24:~/git/terraform_dz4$ cd demonstration3
user@ubuntu24:~/git/terraform_dz4/demonstration3$ tflint -f compact
1 issue(s) found:

providers.tf:3:13: Warning - Missing version constraint for provider "vault" in `required_providers` (terraform_required_providers)
user@ubuntu24:~/git/terraform_dz4/demonstration3$ cd ..
user@ubuntu24:~/git/terraform_dz4$ cd src_dz1/
user@ubuntu24:~/git/terraform_dz4/src_dz1$ tflint -f compact
2 issue(s) found:

providers.tf:3:14: Warning - Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)
variables.tf:19:1: Warning - variable "vpc_name" is declared but not used (terraform_unused_declarations)
user@ubuntu24:~/git/terraform_dz4/src_dz1$ cd ..
user@ubuntu24:~/git/terraform_dz4$ cd s3_test/
user@ubuntu24:~/git/terraform_dz4/s3_test$ tflint -f compact
7 issue(s) found:

s3.tf:22:12: Warning - Module source "github.com/terraform-yc-modules/terraform-yc-s3" is not pinned (terraform_module_pinned_source)
providers.tf:3:13: Warning - Missing version constraint for provider "vault" in `required_providers` (terraform_required_providers)
s3.tf:1:1: Warning - Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)
s3.tf:14:1: Warning - Missing version constraint for provider "random" in `required_providers` (terraform_required_providers)
variables.tf:3:1: Warning - variable "cloud_id" is declared but not used (terraform_unused_declarations)
variables.tf:13:1: Warning - variable "default_zone" is declared but not used (terraform_unused_declarations)
variables.tf:19:1: Warning - variable "vpc_name" is declared but not used (terraform_unused_declarations)
user@ubuntu24:~/git/terraform_dz4/s3_test$ 

user@ubuntu24:~/git/terraform_dz4$ docker run --rm -v $(pwd):/tf bridgecrew/checkov -d /tf
Unable to find image 'bridgecrew/checkov:latest' locally
latest: Pulling from bridgecrew/checkov
ac5e0885917e: Pull complete 
3678bb828654: Pull complete 
af26e1c278ee: Pull complete 
207879fcdc92: Pull complete 
171a8eaf7a10: Pull complete 
6310eb16bf42: Pull complete 
f9efa1b83d06: Pull complete 
bf2b86b29845: Pull complete 
db840d086b65: Pull complete 
44136fa355b3: Already exists 
e7bdba6d5688: Download complete 
Digest: sha256:41c4701c6a56d8952e5aba7a420f871c8b70b57da94eb4f142dcdf7295bb0be3
Status: Downloaded newer image for bridgecrew/checkov:latest
2026-09-13 07:10:17,430 [MainThread  ] [WARNI]  Failed to get the checkov mappings and guidelines from https://api0.prismacloud.io/bridgecrew/api/v2/guidelines. Skips using BC_* IDs will not work.
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/urllib3/connection.py", line 196, in _new_conn
    sock = connection.create_connection(
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/util/connection.py", line 85, in create_connection
    raise err
  File "/usr/local/lib/python3.11/site-packages/urllib3/util/connection.py", line 73, in create_connection
    sock.connect(sa)
TimeoutError: timed out

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 789, in urlopen
    response = self._make_request(
               ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 490, in _make_request
    raise new_e
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 466, in _make_request
    self._validate_conn(conn)
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 1095, in _validate_conn
    conn.connect()
  File "/usr/local/lib/python3.11/site-packages/urllib3/connection.py", line 615, in connect
    self.sock = sock = self._new_conn()
                       ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/connection.py", line 205, in _new_conn
    raise ConnectTimeoutError(
urllib3.exceptions.ConnectTimeoutError: (<urllib3.connection.HTTPSConnection object at 0x770b6c21ed90>, 'Connection to api0.prismacloud.io timed out. (connect timeout=3.1)')

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/checkov/common/bridgecrew/platform_integration.py", line 1276, in get_public_run_config
    request = self.http.request("GET", self.guidelines_api_url, headers=headers)  # type:ignore[no-untyped-call]
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/_request_methods.py", line 136, in request
    return self.request_encode_url(
           ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/_request_methods.py", line 183, in request_encode_url
    return self.urlopen(method, url, **extra_kw)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/poolmanager.py", line 443, in urlopen
    response = conn.urlopen(method, u.request_uri, **kw)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 873, in urlopen
    return self.urlopen(
           ^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 873, in urlopen
    return self.urlopen(
           ^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 873, in urlopen
    return self.urlopen(
           ^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py", line 843, in urlopen
    retries = retries.increment(
              ^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/urllib3/util/retry.py", line 519, in increment
    raise MaxRetryError(_pool, url, reason) from reason  # type: ignore[arg-type]
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
urllib3.exceptions.MaxRetryError: HTTPSConnectionPool(host='api0.prismacloud.io', port=443): Max retries exceeded with url: /bridgecrew/api/v2/guidelines (Caused by ConnectTimeoutError(<urllib3.connection.HTTPSConnection object at 0x770b6c21ed90>, 'Connection to api0.prismacloud.io timed out. (connect timeout=3.1)'))
2026-09-13 07:10:18,400 [MainThread  ] [WARNI]  Failed to download module git::https://github.com/udjin10/yandex_compute_instance.git?ref=main (for external modules, the --download-external-modules flag is required)
2026-09-13 07:10:18,400 [MainThread  ] [WARNI]  Unable to load module (github.com/terraform-yc-modules/terraform-yc-s3): list index out of range

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.3.17 

terraform scan results:

Passed checks: 4, Failed checks: 14, Skipped checks: 0

Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
        PASSED for resource: aws.default
        File: /s3_test/s3.tf:1-12
Check: CKV_YC_12: "Ensure public IP is not assigned to database cluster."
        PASSED for resource: module.mysql_cluster.yandex_mdb_mysql_cluster.test
        File: /src_dz1/modules/mysql/main.tf:9-28
        Calling File: /src_dz1/main.tf:82-89
Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."
        PASSED for resource: module.analytics_vm.yandex_compute_instance.test
        File: /src_dz1/modules/vm/main.tf:9-40
        Calling File: /src_dz1/main.tf:66-78
Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."
        PASSED for resource: module.marketing_vm.yandex_compute_instance.test
        File: /src_dz1/modules/vm/main.tf:9-40
        Calling File: /src_dz1/main.tf:51-63
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /demonstration1/vms/main.tf:22-43

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: test-vm
        File: /demonstration1/vms/main.tf:22-43

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: example-vm
        File: /demonstration1/vms/main.tf:45-61

                45 | module "example-vm" {
                46 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                47 |   env_name       = "stage"
                48 |   network_id     = yandex_vpc_network.develop.id
                49 |   subnet_zones   = ["ru-central1-a"]
                50 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id]
                51 |   instance_name  = "web-stage"
                52 |   instance_count = 1
                53 |   image_family   = "ubuntu-2004-lts"
                54 |   public_ip      = true
                55 | 
                56 |   metadata = {
                57 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                58 |     serial-port-enable = 1
                59 |   }
                60 | 
                61 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: example-vm
        File: /demonstration1/vms/main.tf:45-61

                45 | module "example-vm" {
                46 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                47 |   env_name       = "stage"
                48 |   network_id     = yandex_vpc_network.develop.id
                49 |   subnet_zones   = ["ru-central1-a"]
                50 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id]
                51 |   instance_name  = "web-stage"
                52 |   instance_count = 1
                53 |   image_family   = "ubuntu-2004-lts"
                54 |   public_ip      = true
                55 | 
                56 |   metadata = {
                57 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                58 |     serial-port-enable = 1
                59 |   }
                60 | 
                61 | }

Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."
        FAILED for resource: yandex_compute_instance.test
        File: /remote_state/vm/main.tf:1-31

                1  | resource "yandex_compute_instance" "test" {
                2  |   name        = "vm-from-remote-state"
                3  |   platform_id = "standard-v2"
                4  |   zone        = "ru-central1-a"
                5  | 
                6  |   resources {
                7  |     cores         = 2
                8  |     memory        = 1
                9  |     core_fraction = 5
                10 |   }
                11 | 
                12 |   boot_disk {
                13 |     initialize_params {
                14 |       image_id = data.yandex_compute_image.ubuntu.image_id
                15 |     }
                16 |   }
                17 | 
                18 |   scheduling_policy {
                19 |     preemptible = true
                20 |   }
                21 | 
                22 |   network_interface {
                23 |     subnet_id = local.subnet_id
                24 |     nat       = true
                25 |   }
                26 | 
                27 |   metadata = {
                28 |     serial-port-enable = 1
                29 |     ssh-keys           = "ubuntu:${local.ssh_public_key}"
                30 |   }
                31 | }

Check: CKV_YC_11: "Ensure security group is assigned to network interface."
        FAILED for resource: yandex_compute_instance.test
        File: /remote_state/vm/main.tf:1-31

                1  | resource "yandex_compute_instance" "test" {
                2  |   name        = "vm-from-remote-state"
                3  |   platform_id = "standard-v2"
                4  |   zone        = "ru-central1-a"
                5  | 
                6  |   resources {
                7  |     cores         = 2
                8  |     memory        = 1
                9  |     core_fraction = 5
                10 |   }
                11 | 
                12 |   boot_disk {
                13 |     initialize_params {
                14 |       image_id = data.yandex_compute_image.ubuntu.image_id
                15 |     }
                16 |   }
                17 | 
                18 |   scheduling_policy {
                19 |     preemptible = true
                20 |   }
                21 | 
                22 |   network_interface {
                23 |     subnet_id = local.subnet_id
                24 |     nat       = true
                25 |   }
                26 | 
                27 |   metadata = {
                28 |     serial-port-enable = 1
                29 |     ssh-keys           = "ubuntu:${local.ssh_public_key}"
                30 |   }
                31 | }

Check: CKV_YC_2: "Ensure compute instance does not have public IP."
        FAILED for resource: yandex_compute_instance.test
        File: /remote_state/vm/main.tf:1-31

                1  | resource "yandex_compute_instance" "test" {
                2  |   name        = "vm-from-remote-state"
                3  |   platform_id = "standard-v2"
                4  |   zone        = "ru-central1-a"
                5  | 
                6  |   resources {
                7  |     cores         = 2
                8  |     memory        = 1
                9  |     core_fraction = 5
                10 |   }
                11 | 
                12 |   boot_disk {
                13 |     initialize_params {
                14 |       image_id = data.yandex_compute_image.ubuntu.image_id
                15 |     }
                16 |   }
                17 | 
                18 |   scheduling_policy {
                19 |     preemptible = true
                20 |   }
                21 | 
                22 |   network_interface {
                23 |     subnet_id = local.subnet_id
                24 |     nat       = true
                25 |   }
                26 | 
                27 |   metadata = {
                28 |     serial-port-enable = 1
                29 |     ssh-keys           = "ubuntu:${local.ssh_public_key}"
                30 |   }
                31 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: s3_bucket
        File: /s3_test/s3.tf:21-27

                21 | module "s3_bucket" {
                22 |   source = "github.com/terraform-yc-modules/terraform-yc-s3"
                23 | 
                24 |   bucket_name = "terraform-dz4-bucket-${random_string.bucket_suffix.result}"
                25 |   folder_id   = var.folder_id
                26 |   max_size    = 1
                27 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: s3_bucket
        File: /s3_test/s3.tf:21-27

                21 | module "s3_bucket" {
                22 |   source = "github.com/terraform-yc-modules/terraform-yc-s3"
                23 | 
                24 |   bucket_name = "terraform-dz4-bucket-${random_string.bucket_suffix.result}"
                25 |   folder_id   = var.folder_id
                26 |   max_size    = 1
                27 | }

Check: CKV_YC_1: "Ensure security group is assigned to database cluster."
        FAILED for resource: module.mysql_cluster.yandex_mdb_mysql_cluster.test
        File: /src_dz1/modules/mysql/main.tf:9-28
        Calling File: /src_dz1/main.tf:82-89

                9  | resource "yandex_mdb_mysql_cluster" "test" {
                10 |   name        = var.cluster_name
                11 |   environment = "PRESTABLE"
                12 |   network_id  = var.network_id
                13 |   version     = "8.0"
                14 | 
                15 |   resources {
                16 |     resource_preset_id = "s2.micro"
                17 |     disk_type_id       = "network-ssd"
                18 |     disk_size          = 10
                19 |   }
                20 | 
                21 |   dynamic "host" {
                22 |     for_each = var.ha ? [1, 2] : [1]
                23 |     content {
                24 |       zone      = var.zone
                25 |       subnet_id = var.subnet_id
                26 |     }
                27 |   }
                28 | }

Check: CKV_YC_11: "Ensure security group is assigned to network interface."
        FAILED for resource: module.analytics_vm.yandex_compute_instance.test
        File: /src_dz1/modules/vm/main.tf:9-40
        Calling File: /src_dz1/main.tf:66-78

                9  | resource "yandex_compute_instance" "test" {
                10 |   name        = "${var.env_name}-vm"
                11 |   platform_id = "standard-v2"
                12 |   zone        = var.zone
                13 | 
                14 |   resources {
                15 |     cores         = 2
                16 |     memory        = 2
                17 |     core_fraction = 5
                18 |   }
                19 | 
                20 |   boot_disk {
                21 |     initialize_params {
                22 |       image_id = "fd827b91d99psvq5fjit"
                23 |     }
                24 |   }
                25 | 
                26 |   scheduling_policy {
                27 |     preemptible = true
                28 |   }
                29 | 
                30 |   network_interface {
                31 |     subnet_id = var.subnet_id
                32 |     nat       = true
                33 |   }
                34 | 
                35 |   metadata = {
                36 |     user-data = var.cloud_init
                37 |   }
                38 | 
                39 |   labels = var.labels
                40 | }

Check: CKV_YC_2: "Ensure compute instance does not have public IP."
        FAILED for resource: module.analytics_vm.yandex_compute_instance.test
        File: /src_dz1/modules/vm/main.tf:9-40
        Calling File: /src_dz1/main.tf:66-78

                9  | resource "yandex_compute_instance" "test" {
                10 |   name        = "${var.env_name}-vm"
                11 |   platform_id = "standard-v2"
                12 |   zone        = var.zone
                13 | 
                14 |   resources {
                15 |     cores         = 2
                16 |     memory        = 2
                17 |     core_fraction = 5
                18 |   }
                19 | 
                20 |   boot_disk {
                21 |     initialize_params {
                22 |       image_id = "fd827b91d99psvq5fjit"
                23 |     }
                24 |   }
                25 | 
                26 |   scheduling_policy {
                27 |     preemptible = true
                28 |   }
                29 | 
                30 |   network_interface {
                31 |     subnet_id = var.subnet_id
                32 |     nat       = true
                33 |   }
                34 | 
                35 |   metadata = {
                36 |     user-data = var.cloud_init
                37 |   }
                38 | 
                39 |   labels = var.labels
                40 | }

Check: CKV_YC_11: "Ensure security group is assigned to network interface."
        FAILED for resource: module.marketing_vm.yandex_compute_instance.test
        File: /src_dz1/modules/vm/main.tf:9-40
        Calling File: /src_dz1/main.tf:51-63

                9  | resource "yandex_compute_instance" "test" {
                10 |   name        = "${var.env_name}-vm"
                11 |   platform_id = "standard-v2"
                12 |   zone        = var.zone
                13 | 
                14 |   resources {
                15 |     cores         = 2
                16 |     memory        = 2
                17 |     core_fraction = 5
                18 |   }
                19 | 
                20 |   boot_disk {
                21 |     initialize_params {
                22 |       image_id = "fd827b91d99psvq5fjit"
                23 |     }
                24 |   }
                25 | 
                26 |   scheduling_policy {
                27 |     preemptible = true
                28 |   }
                29 | 
                30 |   network_interface {
                31 |     subnet_id = var.subnet_id
                32 |     nat       = true
                33 |   }
                34 | 
                35 |   metadata = {
                36 |     user-data = var.cloud_init
                37 |   }
                38 | 
                39 |   labels = var.labels
                40 | }

Check: CKV_YC_2: "Ensure compute instance does not have public IP."
        FAILED for resource: module.marketing_vm.yandex_compute_instance.test
        File: /src_dz1/modules/vm/main.tf:9-40
        Calling File: /src_dz1/main.tf:51-63

                9  | resource "yandex_compute_instance" "test" {
                10 |   name        = "${var.env_name}-vm"
                11 |   platform_id = "standard-v2"
                12 |   zone        = var.zone
                13 | 
                14 |   resources {
                15 |     cores         = 2
                16 |     memory        = 2
                17 |     core_fraction = 5
                18 |   }
                19 | 
                20 |   boot_disk {
                21 |     initialize_params {
                22 |       image_id = "fd827b91d99psvq5fjit"
                23 |     }
                24 |   }
                25 | 
                26 |   scheduling_policy {
                27 |     preemptible = true
                28 |   }
                29 | 
                30 |   network_interface {
                31 |     subnet_id = var.subnet_id
                32 |     nat       = true
                33 |   }
                34 | 
                35 |   metadata = {
                36 |     user-data = var.cloud_init
                37 |   }
                38 | 
                39 |   labels = var.labels
                40 | }

secrets scan results:

Passed checks: 0, Failed checks: 2, Skipped checks: 0

Check: CKV_SECRET_6: "Base64 High Entropy String"
        FAILED for resource: 24e7451df05ed5cd4cf1041be67c68f8d89d087a
        File: /demonstration3/providers.tf:13-14

                13 |   token           = "ed**********"

Check: CKV_SECRET_6: "Base64 High Entropy String"
        FAILED for resource: 24e7451df05ed5cd4cf1041be67c68f8d89d087a
        File: /s3_test/providers.tf:13-14

                13 |   token           = "ed**********"

```
</details>

------

### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Настройте remote state с встроенными блокировками:
   - Создайте S3 bucket в Yandex Cloud для хранения state (если еще не создан)
   - Создайте service account с правами на чтение/запись в bucket
   - Настройте backend в providers.tf с использованием нового механизма блокировок:
     ```hcl
     terraform {
       required_version = "~>1.12.0"
       
       backend "s3" {
         bucket  = "ваш-bucket-name"
         key     = "terraform.tfstate"
         region  = "ru-central1"
         
         # Встроенный механизм блокировок (Terraform >= 1.6)
         # Не требует отдельной базы данных!
         use_lockfile = true
         
         endpoints = {
           s3 = "https://storage.yandexcloud.net"
         }
         
         skip_region_validation      = true
         skip_credentials_validation = true
         skip_requesting_account_id  = true
         skip_s3_checksum            = true
       }
     }
     ```
   - Выполните `terraform init -migrate-state` для миграции state в S3
   - Предоставьте скриншоты процесса настройки и миграции
3. Закоммитьте в ветку 'terraform-05' все изменения.
4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к state (блокировка должна сработать автоматически).
6. Принудительно разблокируйте state командой `terraform force-unlock <LOCK_ID>`. Пришлите команду и вывод.

**Примечание:** В Terraform >= 1.6 появился встроенный механизм блокировок через `use_lockfile = true`. 
Это упрощает настройку - больше не нужно создавать отдельную базу данных (YDB в режиме DynamoDB) для хранения блокировок.
Lock-файл создается автоматически в том же S3 bucket рядом с state-файлом с именем `<key>.lock.info`.

### Ответ:
1. Создан **S3 bucket** `terraform-dz5-state-1789286165` для хранения state.
2. Создан **service account** `terraform-dz5` с ролями `editor` и `storage.editor`.
3. Создан **статический ключ доступа** для сервисного аккаунта.
4. В `src_dz1/providers.tf` настроен backend `s3` с `use_lockfile = true`.
5. Выполнена **миграция state** в S3: `terraform init -migrate-state`.
6. Проверена **автоматическая блокировка** — при попытке `terraform apply` в другом окне
   возникла ошибка доступа к state.
7. State **разблокирован** командой `terraform force-unlock <LOCK_ID>`.
#### Команды
```bash

# 1. Создание S3 bucket
yc storage bucket create --name terraform-dz5-state-$(date +%s)
# 2. Миграция state
# 3. Применение (создаст state в S3)
terraform apply -auto-approve

# 4. Проверка, что state в S3
yc storage s3api list-objects --bucket terraform-dz5-state-1789286165 --prefix src_dz1/

# 5. Проверка блокировки (в другом окне с открытым terraform console)
terraform apply -auto-approve

# 6. Разблокировка
terraform force-unlock 8de53fc7-d744-ed45-9eb0-85492479c86e

```

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/1.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/2.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/3.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/4.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/5.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/6.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/7.png)

![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/terraform-05/img/dz5/8.png)

<details>
  <summary>Нажмите, чтобы увидеть листинг по Задаче 2</summary>

``` bash
user@ubuntu24:~/git/terraform_dz4$ yc storage bucket create --name terraform-dz5-state-$(date +%s)
name: terraform-dz5-state-1789286165
folder_id: b1g4blc2guo29mqbh6bp
anonymous_access_flags: {}
default_storage_class: STANDARD
versioning: VERSIONING_DISABLED
created_at: "2026-09-13T07:56:06.965892Z"
resource_id: e3ej7cag34rp1vqu5sh4

There is a new yc version '1.34.0' available. Current version: '1.14.0'.
See release notes at https://yandex.cloud/ru/docs/cli/release-notes
You can install it by running the following command in your shell:
        $ yc components update

user@ubuntu24:~/git/terraform_dz4$ cd ~/git/terraform_dz4/src_dz1
user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform init -migrate-state
Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
Initializing modules...
Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.226.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform init
Initializing the backend...
Initializing modules...
Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.226.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.analytics_vm.yandex_compute_instance.test will be created
  дальше код plan
user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.analytics_vm.yandex_compute_instance.test will be created
  + resource "yandex_compute_instance" "test" {
  дальше код apply
Apply complete! Resources: 11 added, 0 changed, 0 destroyed.
user@ubuntu24:~/git/terraform_dz4/src_dz1$ 
user@ubuntu24:~/git/terraform_dz4/src_dz1$ yc storage s3api list-objects --bucket terraform-dz5-state-1789286165 --prefix src_dz1/
contents:
  - key: src_dz1/terraform.tfstate
    last_modified: "2026-09-13T08:19:24.549Z"
    etag: '"141428e0f420fbde01edb1afdfedc2ab"'
    size: "23099"
    owner:
      id: ajevcajoi6sqvd59cbs9
      display_name: ajevcajoi6sqvd59cbs9
    storage_class: STANDARD
name: terraform-dz5-state-1789286165
prefix: src_dz1/
max_keys: "1000"
key_count: "1"
request_id: 01ce62a20a651263

user@ubuntu24:~/git/terraform_dz4/src_dz1$ 
user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform apply -auto-approve
╷
│ Error: Error acquiring the state lock
│ 
│ Error message: operation error S3: PutObject, https response error StatusCode: 412, RequestID: b19b9a4c3ee9b8d1, HostID: , api error PreconditionFailed: At least one of the pre-conditions you
│ specified did not hold
│ Lock Info:
│   ID:        8de53fc7-d744-ed45-9eb0-85492479c86e
│   Path:      terraform-dz5-state-1789286165/src_dz1/terraform.tfstate
│   Operation: OperationTypeInvalid
│   Who:       user@ubuntu24
│   Version:   1.12.2
│   Created:   2026-09-13 08:21:20.146352169 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
╵
user@ubuntu24:~/git/terraform_dz4/src_dz1$ 
user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform force-unlock 8de53fc7-d744-ed45-9eb0-85492479c86e
Do you really want to force-unlock?
  Terraform will remove the lock on the remote state.
  This will allow local Terraform commands to modify this state, even though it
  may still be in use. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Terraform state has been successfully unlocked!

The state has been unlocked, and Terraform commands should now be able to
obtain a new lock on the remote state.
user@ubuntu24:~/git/terraform_dz4/src_dz1$ 

```
</details>

------
### Задание 3  

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'. 
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.

------
### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 
------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;
- type=object — проверка, что одно из значений равно true, а второе false, т. е. не допускается false false и true true:
```
variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = <проверка>
    }
}
```
------
### Задание 6*

1. Настройте любую известную вам CI/CD-систему. Если вы ещё не знакомы с CI/CD-системами, настоятельно рекомендуем вернуться к этому заданию после изучения Jenkins/Teamcity/Gitlab.
2. Скачайте с её помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
3. Уничтожьте инфраструктуру тем же способом.


------
### Задание 7*
1. Настройте отдельный terraform root модуль, который будет создавать инфраструктуру для remote state:
   - S3 bucket для tfstate с версионированием
   - Сервисный аккаунт с необходимыми правами (storage.editor)
   - Static access key для сервисного аккаунта
2. Output должен содержать:
   - Имя bucket
   - Access key ID и Secret key (sensitive)
   - Пример конфигурации backend для использования
3. После создания инфраструктуры используйте outputs для настройки backend в основном проекте.

**Примечание:** Так как используется `use_lockfile = true`, создавать YDB/DynamoDB больше не требуется.
Блокировки реализованы встроенным механизмом Terraform и хранятся в том же S3 bucket. 

### Правила приёма работы

Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-05.

В качестве результата прикрепите ссылку на ветку terraform-05 в вашем репозитории.

**Важно.** Удалите все созданные ресурсы.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 




# Домашнее задание к занятию «Продвинутые методы работы с Terraform» - Старцев Данила Антонович

### Цели задания

1. Научиться использовать модули.
2. Отработать операции state.
3. Закрепить пройденный материал.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**04/src**](https://github.com/netology-code/ter-homeworks/tree/main/04/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.12.0
Пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности.  В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://oneuptime.com/blog/post/2026-03-02-how-to-use-cloud-init-with-terraform-for-ubuntu-provisioning/view). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm
------
В случае использования MacOS вы получите ошибку "Incompatible provider version" . В этом случае скачайте remote модуль локально и поправьте в нем версию template провайдера на более старую.
------
>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/1.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/2.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/3.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/4.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/5.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/6.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/7.png)

>![задание 1](https://github.com/MindMaze74/terraform_dz4/blob/main/img/8.png)

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Сгенерируйте документацию к модулю с помощью terraform-docs.
 
Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```
>![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/main/img/9.png)

>![задание 2](https://github.com/MindMaze74/terraform_dz4/blob/main/img/10.png)

>![задание 2-README.md-vpc](https://github.com/MindMaze74/terraform_dz4/blob/main/src_dz1/modules/vpc/README.md)

### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

>![задание 3](https://github.com/MindMaze74/terraform_dz4/blob/main/img/11.png)

>![задание 3](https://github.com/MindMaze74/terraform_dz4/blob/main/img/12.png)

>![задание 3](https://github.com/MindMaze74/terraform_dz4/blob/main/img/13.png)

>![задание 3](https://github.com/MindMaze74/terraform_dz4/blob/main/img/14.png)

>![задание 3](https://github.com/MindMaze74/terraform_dz4/blob/main/img/15.png)

>![задание 3](https://github.com/MindMaze74/terraform_dz4/blob/main/img/16.png)

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  
  
Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.
>Ответ:
<details>
  <summary>Нажмите, чтобы увидеть результаты по Задаче 4*</summary>

>![задание 4*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/17.png)

>![задание 4*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/18.png)

> Листинг terraform plan по сети

```bash

  # module.vpc_dev.yandex_vpc_network.test will be created
  + resource "yandex_vpc_network" "test" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "develop"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_dev.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_network.test will be created
  + resource "yandex_vpc_network" "test" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "production"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_prod.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_subnet.test["ru-central1-b-10.0.2.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-b"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.vpc_prod.yandex_vpc_subnet.test["ru-central1-d-10.0.3.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-d"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 8 to add, 0 to change, 0 to destroy.

user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform console
> module.vpc_prod
{
  "network_id" = "enpec2hbjsd9sljtmgsk"
  "subnet_ids" = {
    "ru-central1-a-10.0.1.0/24" = "e9btsfh6chp89pa9i6kr"
    "ru-central1-b-10.0.2.0/24" = "e2l06b34625272tnfv0m"
    "ru-central1-d-10.0.3.0/24" = "fl8vfrghmshja8bhsetp"
  }
  "subnet_zones" = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d",
  ]
}
```
</details>

### Задание 5*

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети.
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля.
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов.
4. Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию.
>Ответ:
<details>
  <summary>Нажмите, чтобы увидеть результаты по Задаче 4*</summary>

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/17.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/18.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/19.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/20.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/21.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/22.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/23.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/24.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/25.png)

>![задание 5*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/26.png)

> Листинг terraform apply при ha = false и ha = true

```bash


  # module.mysql_cluster.yandex_mdb_mysql_cluster.test will be created
  + resource "yandex_mdb_mysql_cluster" "test" {
      + allow_regeneration_host   = false
      + backup_retain_period_days = (known after apply)
      + created_at                = (known after apply)
      + deletion_protection       = (known after apply)
      + disk_encryption_key_id    = (known after apply)
      + environment               = "PRESTABLE"
      + folder_id                 = (known after apply)
      + health                    = (known after apply)
      + host_group_ids            = (known after apply)
      + id                        = (known after apply)
      + mysql_config              = (known after apply)
      + name                      = "example"
      + network_id                = (known after apply)
      + status                    = (known after apply)
      + version                   = "8.0"

      + access (known after apply)

      + backup_window_start (known after apply)

      + disk_size_autoscaling (known after apply)

      + host {
          + assign_public_ip   = false
          + fqdn               = (known after apply)
          + replication_source = (known after apply)
          + subnet_id          = (known after apply)
          + zone               = "ru-central1-a"
        }

      + maintenance_window (known after apply)

      + performance_diagnostics (known after apply)

      + resources {
          + disk_size          = 10
          + disk_type_id       = "network-ssd"
          + resource_preset_id = "s2.micro"
        }
    }

  # module.mysql_db.yandex_mdb_mysql_database.test will be created
  + resource "yandex_mdb_mysql_database" "test" {
      + cluster_id = (known after apply)
      + id         = (known after apply)
      + name       = "test"
    }

  # module.mysql_db.yandex_mdb_mysql_user.test will be created
  + resource "yandex_mdb_mysql_user" "test" {
      + authentication_plugin = (known after apply)
      + cluster_id            = (known after apply)
      + connection_manager    = (known after apply)
      + generate_password     = false
      + id                    = (known after apply)
      + name                  = "app"
      + password              = (sensitive value)
      + password_wo           = (write-only attribute)

      + connection_limits (known after apply)

      + permission {
          + database_name = "test"
          + roles         = [
              + "ALL",
            ]
        }
    }

  # module.vpc_dev.yandex_vpc_network.test will be created
  + resource "yandex_vpc_network" "test" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "develop"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_dev.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_network.test will be created
  + resource "yandex_vpc_network" "test" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "production"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_prod.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_subnet.test["ru-central1-b-10.0.2.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-b"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.vpc_prod.yandex_vpc_subnet.test["ru-central1-d-10.0.3.0/24"] will be created
  + resource "yandex_vpc_subnet" "test" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-subnet-ru-central1-d"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 11 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.vpc_prod.yandex_vpc_network.test: Creating...
module.vpc_dev.yandex_vpc_network.test: Creating...
module.vpc_prod.yandex_vpc_network.test: Creation complete after 3s [id=enp5p5per3arhigqbqgd]
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-b-10.0.2.0/24"]: Creating...
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-d-10.0.3.0/24"]: Creating...
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"]: Creating...
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-b-10.0.2.0/24"]: Creation complete after 0s [id=e2lg9fopii1i11u62od0]
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-d-10.0.3.0/24"]: Creation complete after 0s [id=fl8ldaskea911h4tqaa0]
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"]: Creation complete after 1s [id=e9bqqgi98899t921skf0]
module.vpc_dev.yandex_vpc_network.test: Creation complete after 4s [id=enp244s0mjo1243hnqus]
module.vpc_dev.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"]: Creating...
module.vpc_dev.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"]: Creation complete after 1s [id=e9b3hjk148um4khlm2sv]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Creating...
module.marketing_vm.yandex_compute_instance.test: Creating...
module.analytics_vm.yandex_compute_instance.test: Creating...
module.analytics_vm.yandex_compute_instance.test: Still creating... [00m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [00m10s elapsed]
module.marketing_vm.yandex_compute_instance.test: Still creating... [00m10s elapsed]
module.analytics_vm.yandex_compute_instance.test: Still creating... [00m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [00m20s elapsed]
module.marketing_vm.yandex_compute_instance.test: Still creating... [00m20s elapsed]
module.marketing_vm.yandex_compute_instance.test: Still creating... [00m30s elapsed]
module.analytics_vm.yandex_compute_instance.test: Still creating... [00m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [00m30s elapsed]
module.marketing_vm.yandex_compute_instance.test: Still creating... [00m40s elapsed]
module.analytics_vm.yandex_compute_instance.test: Still creating... [00m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [00m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [00m50s elapsed]
module.analytics_vm.yandex_compute_instance.test: Still creating... [00m50s elapsed]
module.marketing_vm.yandex_compute_instance.test: Still creating... [00m50s elapsed]
module.marketing_vm.yandex_compute_instance.test: Still creating... [01m00s elapsed]
module.analytics_vm.yandex_compute_instance.test: Still creating... [01m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [01m00s elapsed]
module.analytics_vm.yandex_compute_instance.test: Creation complete after 1m3s [id=fhmc9llg8vv3m9bcf9h6]
module.marketing_vm.yandex_compute_instance.test: Creation complete after 1m6s [id=fhmckh2i8vo1so154f3l]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [01m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [01m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [01m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [01m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [01m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [02m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [02m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [02m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [02m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [02m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [02m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [03m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [03m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [03m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [03m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [03m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [03m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [04m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [04m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [04m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [04m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [04m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [04m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [05m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [05m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [05m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [05m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [05m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [05m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [06m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [06m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [06m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [06m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [06m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [06m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [07m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [07m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [07m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [07m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [07m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [07m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [08m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [08m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [08m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still creating... [08m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Creation complete after 8m33s [id=c9q4aq712lge2ja7ki2b]
module.mysql_db.yandex_mdb_mysql_database.test: Creating...
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [00m10s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [00m20s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [00m30s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [00m40s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [00m50s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [01m00s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [01m10s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [01m20s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [01m30s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [01m40s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [01m50s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [02m00s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [02m10s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Still creating... [02m20s elapsed]
module.mysql_db.yandex_mdb_mysql_database.test: Creation complete after 2m24s [id=c9q4aq712lge2ja7ki2b:test]
module.mysql_db.yandex_mdb_mysql_user.test: Creating...
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [00m10s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [00m20s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [00m30s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [00m40s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [00m50s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [01m00s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Still creating... [01m10s elapsed]
module.mysql_db.yandex_mdb_mysql_user.test: Creation complete after 1m13s [id=c9q4aq712lge2ja7ki2b:app]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.
user@ubuntu24:~/git/terraform_dz4/src_dz1$ 

#=========================================================ha= true====================================================================

user@ubuntu24:~/git/terraform_dz4/src_dz1$ terraform apply
module.vpc_prod.yandex_vpc_network.test: Refreshing state... [id=enp5p5per3arhigqbqgd]
module.vpc_dev.yandex_vpc_network.test: Refreshing state... [id=enp244s0mjo1243hnqus]
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-b-10.0.2.0/24"]: Refreshing state... [id=e2lg9fopii1i11u62od0]
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-d-10.0.3.0/24"]: Refreshing state... [id=fl8ldaskea911h4tqaa0]
module.vpc_prod.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"]: Refreshing state... [id=e9bqqgi98899t921skf0]
module.vpc_dev.yandex_vpc_subnet.test["ru-central1-a-10.0.1.0/24"]: Refreshing state... [id=e9b3hjk148um4khlm2sv]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Refreshing state... [id=c9q4aq712lge2ja7ki2b]
module.marketing_vm.yandex_compute_instance.test: Refreshing state... [id=fhmckh2i8vo1so154f3l]
module.analytics_vm.yandex_compute_instance.test: Refreshing state... [id=fhmc9llg8vv3m9bcf9h6]
module.mysql_db.yandex_mdb_mysql_database.test: Refreshing state... [id=c9q4aq712lge2ja7ki2b:test]
module.mysql_db.yandex_mdb_mysql_user.test: Refreshing state... [id=c9q4aq712lge2ja7ki2b:app]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # module.mysql_cluster.yandex_mdb_mysql_cluster.test will be updated in-place
  ~ resource "yandex_mdb_mysql_cluster" "test" {
        id                        = "c9q4aq712lge2ja7ki2b"
        name                      = "example"
        # (15 unchanged attributes hidden)

      + host {
          + assign_public_ip = false
          + subnet_id        = "e9b3hjk148um4khlm2sv"
          + zone             = "ru-central1-a"
        }

        # (7 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.mysql_cluster.yandex_mdb_mysql_cluster.test: Modifying... [id=c9q4aq712lge2ja7ki2b]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 00m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 00m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 00m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 00m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 00m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 01m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 01m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 01m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 01m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 01m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 01m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 02m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 02m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 02m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 02m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 02m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 02m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 03m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 03m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 03m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 03m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 03m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 03m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 04m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 04m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 04m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 04m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 04m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 04m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 05m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 05m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 05m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 05m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 05m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 05m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 06m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 06m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 06m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 06m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 06m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 06m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 07m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 07m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 07m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 07m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 07m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 07m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 08m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 08m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 08m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 08m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 08m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 08m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 09m00s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 09m10s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 09m20s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 09m30s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 09m40s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Still modifying... [id=c9q4aq712lge2ja7ki2b, 09m50s elapsed]
module.mysql_cluster.yandex_mdb_mysql_cluster.test: Modifications complete after 9m51s [id=c9q4aq712lge2ja7ki2b]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
user@ubuntu24:~/git/terraform_dz4/src_dz1$ 

```
</details>


### Задание 6*
1. Используя готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 .
Создайте и не удаляйте для себя s3 бакет размером 1 ГБ(это бесплатно), он пригодится вам в ДЗ к 5 лекции.

>![задание 6*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/27.png)

>![задание 6*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/28.png)

>![задание 6*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/29.png)

### Задание 7*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
Path: example  
secret data key: test 
secret data value: congrats!  
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform. 


>![задание 7*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/30.png)

>![задание 7*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/31.png)

>![задание 7*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/32.png)

>![задание 7*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/33.png)

### Задание 8*
Попробуйте самостоятельно разобраться в документаци и с помощью terraform remote state разделить root модуль на два отдельных root-модуля: создание VPC , создание ВМ . 

>![задание 8*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/34.png)

>![задание 8*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/35.png)

>![задание 8*](https://github.com/MindMaze74/terraform_dz4/blob/main/img/36.png)

### Правила приёма работы

В своём git-репозитории создайте новую ветку terraform-04, закоммитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-04.

В качестве результата прикрепите ссылку на ветку terraform-04 в вашем репозитории.

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




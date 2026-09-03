# Домашнее задание к занятию "Подъем инфраструктуры в облаке" - Васин Станислав


### Задание 1

Проект с Terraform был создан на локальной ВМ, поскольку этот вариант предоставляет больше преимуществ по сравнению с созданием проекта на ВМ в Yandex Cloud.

Порядок действий по развертыванию ресурсов:

1. Проверим версию Terraform с помощью `terraform -v`.
2. Создадим сервисный аккаунт в Yandex Cloud, которому выдадим права editor. Создадим авторизованный ключ для созданного аккаунта.
3. Создадим файл providers.tf, в котором укажем использование провайдера Yandex Cloud. Зададим переменные окружения для Yandex Cloud.
4. Создадим файл cloud-init.yml для добавления пользователя в ОС ВМ в Облаке.
5. Создадим файл networks.tf, в котором опишем создание VPC, подсетей, NAT-шлюза, таблицы маршрутизации и групп безопасности.
6. Создадим файл vms.tf, в котором опишем создание трёх ВМ на основе Ubuntu 24.04. Вместе с этим опишем создание hosts.ini для Ansible.
7. Проверим корректность конфигурации и применим её с помощью `terraform apply`.

![Версия Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img1.png)

![Создание сервисного аккаунта](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img2.png)

![Создание авторизованного ключа](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img3.png)

![Инициализация Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img4.png)

![Проверка конфигурации Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img5.png)

![Проверка конфигурации Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img6.png)

![Применение конфигурации Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img7.png)

![Применение конфигурации Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img8.png)


---

### Задание 2

1. Создадим playbook nginx.yml, который подключается к ВМ web-a и web-d, проверяет, открыт ли порт для SSH, устанавливает на ВМ Nginx.
2. Запустим playbook для установки Nginx. Проверим работу Nginx внутри этих ВМ.

![Применение playbook](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img9.png)

![Созданные ВМ](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img10.png)

![Работа Nginx на ВМ web-d](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img11.png)

![Работа Nginx на ВМ web-a](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img12.png)

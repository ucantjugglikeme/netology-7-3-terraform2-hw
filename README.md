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


---

### Задание 3

1. В файле networks.tf добавим создание группы безопасности для базы данных db-d с правилом для доступа веб-серверов к БД.
2. В файл vms.tf добавим создание ВМ, которая будет использоваться как БД.
3. Проверим корректность новой конфигурации и применим её с помощью `terraform apply`.
4. Создадим playbook postgresql.yml, который подключается к ВМ db-d, проверяет, открыт ли порт для SSH, устанавливает на ВМ PostgreSQL и проверяет запустился ли сервис.
5. Запустим playbook для установки PostgreSQL. Далее нужно настроить в самой ВМ БД: разрешить прослушивание внешних интерфейсов. Инструкции: https://share.google/aimode/qUDUHVl2liYo5ggs9 и https://share.google/aimode/qMVGII0Rb02QE3zU3.
6. Подключимся к БД через веб-сервер используя заданный пароль.

![Проверка конфигурации Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img13.png)

![Применение конфигурации Terraform](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img14.png)

![Применение playbook для БД](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img15.png)

![Созданные ВМ](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img16.png)

![Разрешение на прослушивание внешних интерфейсов](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img17.png)

![Задание пароля для входа через веб-серверы](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img18.png)

![Подключение к БД через веб-сервер](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img19.png)


---

### Задание 4

1. Удалим авторизованный ключ и все переменные окружения.
2. Выполним настройку профиля для yc tools: установим Yandex Cloud CLI, войдем в профиль с помощью `yc init --username`.
3. Используя имперсонацию, добавим аутентификационные данные в переменные окружения, а затем и в .bashrc.
4. Проверим, что можно работать с Terraform и управлять ресурсами. Выполним команду `terraform destroy` для высвобождения ресурсов.

![Установка Yandex Cloud CLI](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img20.png)

![Авторизация в Yandex Cloud CLI](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img21.png)

![Добавление аутентификационных данных в переменные окружения](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img22.png)

![Добавление аутентификационных данных в .bashrc](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img23.png)

![Удаление ресурсов](https://github.com/ucantjugglikeme/netology-7-3-terraform2-hw/blob/main/img/img24.png)

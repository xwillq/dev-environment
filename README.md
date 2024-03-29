# Локальная среда разработки

## Компоненты

#### Реверс-прокси

В качестве реверс-прокси используется Traefik + ACME сервер step-ca для получения
сертификатов. Реверс-прокси принимает все запросы и отправляет их в нужные контейнеры.

Он используется для упрощения настройки, так как Traefik может самостоятельно обнаруживать
нужные контейнеры и правила роутинга, через лейблы докер контейнера, в который нужно
отправлять запрос, а так же получать сертификаты для этих доменов.

#### Базы данных

В среде присутствуют 3 базы данных: MariaDB, Postgres и Redis. У MariaDB и Postgres
открыты порты по умолчанию, чтобы к ним можно было подключиться через сторонние
клиенты, например IDE.

#### Minio

S3 сервер. Используется для разработки сайтов, которые будут использовать
хранилище S3.

#### RabbitMQ

Брокер очередей. Используется, когда Redis недостаточно.

#### Images

Dockerfile'ы и конфиги для образов, которые используются в этом репозитории.

#### Templates

Шаблоны для разворачивания бэкенда и фронтенда.

#### Bin

Вспомогательные скрипты для запуска программ внутри контейнеров.

## Установка

1. Склонировать репозиторий.
2. Установить `make`.
3. Запустить `make` в корне проекта.
4. Установить сертификат `reverse-proxy/ca/certs/root_ca.crt`.

Если нужно поменять пароли, перед запуском `make` необходимо прописать желаемые
значения в `.env` в папках `databases`, `minio`, `rabbitmq` и `reverse-proxy`.
Если этого не сделать, все контейнеры инициализируются с паролем `password`.

Способ установки сертификата зависит от операционной системы и программы, которая
используется для входа на сайт. Программы не всегда доверяют системным сертификатам,
поэтому нужно найти в настройках способ добавить сертификат в их собственное хранилище.

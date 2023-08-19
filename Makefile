.PHONY: all init network volumes up clean

all: init up

init: network
	$(MAKE) --directory databases init
	$(MAKE) --directory minio init
	$(MAKE) --directory rabbitmq init
	$(MAKE) --directory reverse-proxy init

# Создаём сеть, в которой можно будет указать статические ip.
# --subnet - подсеть, в которой будут находиться контейнеры.
# --ip-range - диапазон, из которого докер будет выдавать ip контейнерам. Это нужно, чтобы ip, выданные докером, не конфликтовали со статическими ip.
# --gateway - сетевой шлюз. Указан на всякий случай, чтобы он не конфликтовал с другими статическими ip.
#
# В этой сети докер будет выдавать контейнерам ip в подсети 172.31.xxx.xxx, кроме тех,
# которые входят в подсеть 172.31.128.xxx. Благодаря этому, ip в подсети 172.31.128.xxx
# можно будет выдавать контейнерам вручную
network:
	docker network create --subnet 172.31.0.0/16 --ip-range 172.31.0.0/17 --gateway 172.31.128.1 main || true

# Создаём volume, которые должны существовать всегда
#volumes:
#	docker volume create composer-7.4-cache
#	docker run --rm -v composer-7.4-cache:/composer ghcr.io/xwillq/dev-environment/php/7.4-nginx:latest chmod 777 /composer
#	docker volume create composer-8.1-cache
#	docker run --rm -v composer-8.1-cache:/composer ghcr.io/xwillq/dev-environment/php/8.1-rr:latest chmod 777 /composer

up:
	$(MAKE) --directory databases up
	$(MAKE) --directory reverse-proxy up

clean:
	$(MAKE) --directory databases clean
	$(MAKE) --directory minio clean
	$(MAKE) --directory rabbitmq clean
	$(MAKE) --directory reverse-proxy clean
#	docker volume rm composer-7.4-cache
#	docker volume rm composer-8.1-cache
	docker network rm main

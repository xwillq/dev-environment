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
# --gateway - сетевой шлюз. Указан на всякий случай, чтобы он не был в диапазоне статических ip.
#
# В этой сети докер будет выдавать контейнерам ip, которые начинаются на 172.92.0.xxx, 
# все остальные ip в диапазоне 172.92.xxx.xxx можно делать статическими.
network:
	docker network create --subnet 172.92.0.0/16 --ip-range 172.92.0.0/24 --gateway 172.92.0.1 main || true

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

.PHONY: all init clean network volumes up

all: init up

init: network volumes
	$(MAKE) --directory certificates init
	$(MAKE) --directory databases init
	$(MAKE) --directory minio init
	$(MAKE) --directory rabbitmq init

clean:
	$(MAKE) --directory certificates clean
	$(MAKE) --directory databases clean
	$(MAKE) --directory minio clean
	$(MAKE) --directory rabbitmq clean
	$(MAKE) --directory traefik clean
	docker volume rm certificates
	docker network rm main


# Создаём сеть, в которой можно будет указать статические ip.
# --subnet - подсеть, в которой будут находиться контейнеры.
# --ip-range - диапазон, из которого докер будет выдавать ip контейнерам. Это нужно, чтобы ip, выданные докером, не конфликтовали со статическими ip.
# --gateway - сетевой шлюз. Указан на всякий случай, чтобы он не был в диапазоне статических ip.
#
# В этой сети докер будет выдавать контейнерам ip, которые начинаются на 172.92.0.xxx, 
# все остальные ip в диапазоне 172.92.xxx.xxx можно делать статическими.
network:
	docker network create --subnet 172.92.0.0/16 --ip-range 172.92.0.0/8 --gateway 172.92.0.1 main

# Создаём volume, которые будут использоваться несколькими разными сервисами
volumes:
	docker volume create certificates
	docker volume create composer-cache
	docker run --rm -v composer-cache:/composer ghcr.io/xwillq/dev-environment/php/8.1-rr:latest chmod 777 /composer

up:
	$(MAKE) --directory certificates up
	$(MAKE) --directory databases up
	$(MAKE) --directory traefik up

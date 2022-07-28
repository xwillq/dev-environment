.PHONY: all network volumes certificates images up

all: network volumes certificates up

# Создаём сеть, в которой можно будет указать статические ip.
# --subnet - подсеть, в которой будут находиться контейнеры.
# --ip-range - диапазон, из которого докер будет выдавать ip контейнерам. Это нужно, чтобы ip, выданные докером, не конфликтовали со статическими ip.
# --gateway - сетевой шлюз. Указан на всякий случай, чтобы он не был в диапазоне статических ip.
#
# В этой сети докер будет выдавать контейнерам ip, которые начинаются на 172.19.0.xxx, 
# все остальные ip в диапазоне 172.19.xxx.xxx можно делать статическими.
network:
	docker network create --subnet 172.92.0.0/16 --ip-range 172.92.0.0/8 --gateway 172.92.0.1 main

# Создаём volume, которые будут использоваться несколькими разными сервисами
volumes:
	docker volume create certificates

# Собираем образ и запускаем ACME сервер
certificates:
	$(MAKE) --directory images/step-ca
	$(MAKE) --directory certificates

up:
	$(MAKE) --directory traefik up
	$(MAKE) --directory databases up

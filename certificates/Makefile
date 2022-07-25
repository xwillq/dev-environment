.PHONY: all initialize-env initialize-ca up

all: initialize-env initialize-ca up

initialize-env:
	cp .env.example .env

initialize-ca:
	mutagen-compose up -d
	sleep 1
	mutagen-compose exec step-ca step ca provisioner add acme --type ACME
	mutagen-compose restart step-ca

up:
	mutagen-compose up -d

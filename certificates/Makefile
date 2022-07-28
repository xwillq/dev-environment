.PHONY: all init clean up

all: init up

init: .env certs

clean:
	mutagen-compose down -v
	rm .env || true
	rm -rf certs || true

.env:
	cp .env.example .env

certs: .env
	mutagen-compose up -d
	sleep 2
	mutagen-compose exec step-ca step ca provisioner add acme --type ACME
	mutagen-compose restart step-ca

up: init
	mutagen-compose up -d

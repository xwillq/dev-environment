.PHONY: all init up clean

all: init up

init: .env ca

.env:
	cp .env.example .env

ca: .env
	docker-compose run --rm -T step-ca echo 'Initialized step-ca'
	docker-compose run --rm -T step-ca step ca provisioner add acme --type ACME

up: init
	docker-compose up -d

clean:
	docker-compose down -v
	rm -rf ca || true
	rm .env || true

.PHONY: all init up clean

all: init up

init: .env ca

.env:
	cp .env.example .env

ca: .env
	docker-compose run --rm -T step-ca printf "\n\e[0;32mInitialized step-ca\e[0;37m\n"

up: init
	docker-compose up -d

clean:
	docker-compose down -v
	rm -rf ca || true
	rm .env || true

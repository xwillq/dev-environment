.PHONY: all init up clean

all: init up

init: .env

.env:
	cp .env.example .env

up: init
	docker-compose up -d

clean:
	docker-compose down -v
	rm .env || true

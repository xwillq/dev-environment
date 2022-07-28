.PHONY: all init clean up

all: init up

init: .env

clean:
	docker-compose down -v
	rm .env || true

.env:
	cp .env.example .env

up: init
	docker-compose up -d

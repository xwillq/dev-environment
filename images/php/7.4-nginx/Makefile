.PHONY: build build-multiarch

build: Dockerfile
	docker build -t php:7.4-nginx .

build-multiarch: Dockerfile
	docker buildx build --push --platform linux/amd64,linux/arm64 -t ghcr.io/xwillq/dev-environment/php/7.4-nginx:latest .

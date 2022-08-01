.PHONY: build build-multiarch

build: Dockerfile
	docker build -t node .

build-multiarch: Dockerfile
	docker buildx build --push --platform linux/amd64,linux/arm64 -t ghcr.io/xwillq/dev-environment/node:latest .

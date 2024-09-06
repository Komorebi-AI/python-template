.ONESHELL:
.PHONY: install hooks hooks-update ruff test mypy docker build run debug push

SHELL=/bin/bash
DOCKER_IMG_NAME=ghcr.io/komorebi-ai/python-template
DOCKER_CONTAINER=template
GH_USER=GITHUB_USERNAME
GH_TOKEN_FILE=GITHUB_TOKEN_PATH

# Install pixi, dependencies and pre-commit hooks
install:
	curl -fsSL https://pixi.sh/install.sh | bash
	pixi install
	pixi install -e dev
	pixi run -e dev pre-commit install

hooks:
	pixi run -e dev pre-commit run --all-files

hooks-update:
	pixi run -e dev pre-commit autoupdate

ruff:
	pixi run -e dev ruff format .
	pixi run -e dev ruff check --fix --show-fixes .

test:
	pixi run -e dev pytest

mypy:
	pixi run -e dev mypy --install-types --non-interactive

docker: build run

build:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMG_NAME) .

# https://stackoverflow.com/questions/26564825/what-is-the-meaning-of-a-double-dollar-sign-in-bash-makefile
run:
	[ "$$(docker ps -a | grep $(DOCKER_CONTAINER))" ] && docker stop $(DOCKER_CONTAINER) && docker rm $(DOCKER_CONTAINER)
	docker run -d --restart=unless-stopped --name $(DOCKER_CONTAINER) -p 5000:80 $(DOCKER_IMG_NAME)

debug:
	docker run -it $(DOCKER_IMG_NAME) /bin/bash

push:
	docker login https://ghcr.io/komorebi-ai -u $(GH_USER) --password-stdin < $(GH_TOKEN_FILE)
	docker push $(DOCKER_IMG_NAME):latest

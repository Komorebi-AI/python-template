.ONESHELL:
.PHONY: env install compile sync hooks ruff test mypy docker build run debug push

SHELL=/bin/bash
DOCKER_IMG_NAME=ghcr.io/komorebi-ai/python-template
DOCKER_CONTAINER=template
GH_USER=GITHUB_USERNAME
GH_TOKEN_FILE=GITHUB_TOKEN_PATH

env:
	conda create -n python-template python=3.11

install:
	pip install uv
	uv pip install -r requirements-dev.txt
	uv pip install -e .[dev]

compile:
	pip install uv
	uv pip compile -o requirements.txt requirements.in
	uv pip compile -o requirements-dev.txt -c requirements.txt requirements.in requirements-dev.in

sync:
	pip install uv
	uv pip sync requirements-dev.txt
	uv pip install -e .[dev]

hooks:
	pre-commit install
	pre-commit run --all-files

ruff:
	ruff format .
	ruff check --fix --show-fixes .

test:
	python -m pytest

mypy:
	mypy --install-types --non-interactive

docker: build run

build:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMG_NAME) .

# https://stackoverflow.com/questions/26564825/what-is-the-meaning-of-a-double-dollar-sign-in-bash-makefile
run:
	[ "$$(docker ps -a | grep $(DOCKER_CONTAINER))" ] && docker stop $(DOCKER_CONTAINER) && docker rm $(DOCKER_CONTAINER)
	docker run -d --restart=unless-stopped --name $(DOCKER_CONTAINER) -p 80:80 $(DOCKER_IMG_NAME)

debug:
	docker run -it $(DOCKER_IMG_NAME) /bin/bash

push:
	docker login https://ghcr.io/komorebi-ai -u $(GH_USER) --password-stdin < $(GH_TOKEN_FILE)
	docker push $(DOCKER_IMG_NAME):latest

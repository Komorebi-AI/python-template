.ONESHELL:
.PHONY: all env install compile sync docker build run debug push

SHELL=/bin/bash
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh; conda activate; conda activate
DOCKER_IMG_NAME=ghcr.io/komorebi-ai/python-template
DOCKER_CONTAINER=template
GH_USER=albertotb
GH_TOKEN_FILE=/home/atorres/GITHUB_TOKEN.txt

all: env install

env:
	conda create -n python-template python=3.11

activate: 
	$(CONDA_ACTIVATE) python-template

install:
	pip install -r requirements-dev.txt
	pip install -e .[dev]
	
compile:
	pip-compile
	pip-compile --extra dev -o requirements-dev.txt -c requirements.txt pyproject.toml

sync:
	pip-sync
	pip install -e .[dev]

docker: build run

build:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMG_NAME) .

# https://stackoverflow.com/questions/26564825/what-is-the-meaning-of-a-double-dollar-sign-in-bash-makefile
run:
	[ "$$(docker ps -a | grep $(DOCKER_CONTAINER))" ] && docker stop $(DOCKER_CONTAINER) && docker rm $(DOCKER_CONTAINER)
	docker run -d --restart=unless-stopped --name $(DOCKER_CONTAINER) -p 7654:80 $(DOCKER_IMG_NAME)

debug:
	docker run -it $(DOCKER_IMG_NAME) /bin/bash

push:
	docker login https://ghcr.io/komorebi-ai -u $(GH_USER) --password-stdin < $(GH_TOKEN_FILE)
	docker push $(DOCKER_IMG_NAME):latest
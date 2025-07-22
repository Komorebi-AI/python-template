.ONESHELL:
.PHONY: install hooks hooks-update ruff test test-api docker build run debug attach push

SHELL=/bin/bash
DOCKER_IMG_NAME=ghcr.io/komorebi-ai/python-template
DOCKER_CONTAINER=template
GH_USER=GITHUB_USERNAME
GH_TOKEN_FILE=GITHUB_TOKEN_PATH
RUN=uv run

# Install uv, pre-commit hooks and dependencies
# Note that `$(RUN)` has an implicit `uv sync`, since it will (if necessary):
# - Download an install Python
# - Create a virtual environment
# - Update `uv.lock`
# - Sync the virtual env, installing and removing dependencies as required
install:
	@command -v uv && echo "uv already installed" || curl -LsSf https://astral.sh/uv/install.sh | sh
	$(RUN) pre-commit install

hooks:
	$(RUN) pre-commit run --all-files

hooks-update:
	$(RUN) pre-commit autoupdate

# Specific packages can be upgrade with `--upgrade-package PKG`
upgrade:
	uv lock --upgrade

ruff:
	$(RUN) ruff format .
	$(RUN) ruff check --fix --show-fixes .

test:
	$(RUN) pytest

test-api:
	uvx --from httpie http GET localhost:6000

docker: build run

build:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMG_NAME) .

# https://stackoverflow.com/questions/26564825/what-is-the-meaning-of-a-double-dollar-sign-in-bash-makefile
run:
	[ "$$(docker ps -a | grep $(DOCKER_CONTAINER))" ] && docker stop $(DOCKER_CONTAINER) && docker rm $(DOCKER_CONTAINER)
	docker run -d --restart=unless-stopped --name $(DOCKER_CONTAINER) -p 6000:80 $(DOCKER_IMG_NAME)

debug:
	docker run -it $(DOCKER_IMG_NAME) /bin/bash

attach:
	docker exec -it $(DOCKER_CONTAINER) /bin/bash

push:
	docker login https://ghcr.io/komorebi-ai -u $(GH_USER) --password-stdin < $(GH_TOKEN_FILE)
	docker push $(DOCKER_IMG_NAME):latest
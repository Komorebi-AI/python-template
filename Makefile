.ONESHELL:
.PHONY: install hooks hooks-update ruff ty test test-api docker build run debug attach push

SHELL=/bin/bash
DOCKER_IMG_NAME=ghcr.io/komorebi-ai/python-template
DOCKER_CONTAINER=python-template
GH_USER=GITHUB_USERNAME
GH_TOKEN_FILE=GITHUB_TOKEN_PATH
RUN=uv run

# Install uv, prek hooks and dependencies
# Note that `$(RUN)` has an implicit `uv sync`, since it will (if necessary):
# - Download an install Python
# - Create a virtual environment
# - Update `uv.lock`
# - Sync the virtual env, installing and removing dependencies as required
install:
	@command -v uv && echo "uv already installed" || curl -LsSf https://astral.sh/uv/install.sh | sh
	$(RUN) prek install

hooks:
	$(RUN) prek run --all-files

hooks-update:
	$(RUN) prek autoupdate

# Specific packages can be upgrade with `--upgrade-package PKG`
upgrade:
	uv lock --upgrade

ruff:
	$(RUN) ruff format .
	$(RUN) ruff check --fix --show-fixes .

ty:
	$(RUN) ty check python_template tests

test:
	$(RUN) pytest

test-api:
	uvx --from httpie http localhost:7000

docker: build run

build:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMG_NAME) .

run:
	[ "$$(docker ps -a | grep $(DOCKER_CONTAINER))" ] && docker stop $(DOCKER_CONTAINER) && docker rm $(DOCKER_CONTAINER)
	docker run -d --restart=unless-stopped --name $(DOCKER_CONTAINER) -p 7000:80 $(DOCKER_IMG_NAME)

debug:
	docker run -it $(DOCKER_IMG_NAME) /bin/bash

attach:
	docker exec -it $(DOCKER_CONTAINER) /bin/bash

push:
	docker login https://ghcr.io/komorebi-ai -u $(GH_USER) --password-stdin < $(GH_TOKEN_FILE)
	docker push $(DOCKER_IMG_NAME):latest

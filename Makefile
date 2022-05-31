.ONESHELL:
.PHONY: env install compile sync all

SHELL=/bin/bash
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

all: env activate install

env:
	conda env create -f env.yml

activate: env
	$(CONDA_ACTIVATE) template

install:
	pip install -r requirements.txt
	pip install -e .[dev]
	
compile:
	pip-compile --extra dev

sync:
	pip-sync
	pip install -e .[dev]

mypy:
	mypy --install-types --non-interactive template/

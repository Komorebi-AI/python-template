env:
	conda env create -f env.yml

install:
	pip install -e .[dev]

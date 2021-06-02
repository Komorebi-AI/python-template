# template
A template for python repositories using setup.py, tests and usual workflows

## Install dependencies

- Conda: `conda env create -f env.yml`
- Pip: `pip install -r requirements.txt`

If you already have the dependencies installed, you can update it to reflect the last version of the packages with `pip-sync`. The difference between conda and pip is that conda will create an isolated environment while pip will install all the dependencies in the current Python env. This might be a conda environment or any other Python env created by other tools.

## Add dependencies

- Add abstract dependency to `setup.py`. If neccessary, add version requirements but try to be as flexible as possible
- Update `requirements.txt`: `pip-compile --extra dev > requirements.txt`
- Update environment: `pip-sync`

## Run tests

- Run test: `pytest`



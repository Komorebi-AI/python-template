# Template

![testing workflow](https://github.com/Komorebi-AI/python-template/actions/workflows/test.yml/badge.svg)
[![codecov](https://codecov.io/gh/Komorebi-AI/python-template/branch/main/graph/badge.svg?token=DQXLBOUDPX)](https://codecov.io/gh/Komorebi-AI/python-template)

Template for Python libraries

## Components

The repository is structured into the following directories:

- `/template`: where the python code is.
- `/data`: required data
- `/tests`: python code for testing via `pytest`.

Conveniently, a set of workflows via Github actions are already installed:

- `black`: code formatting
- `pytest`: automatically discover and runs tests in `tests/`
- `mypy`: automatically runs type checking

## Installation

Install a specific version of the package with `pip`

```{bash}
pip install git+ssh://git@github.com/Komorebi-AI/template.git@0.1.0
```

## Contribute

Create isolated environment with required Python version. This can be done with conda or any other number of tools like venv:

```{bash}
conda env create -n template python=3.9
```

Then, activate the environment:

```{bash}
conda activate template
```

Install dependencies:

```{bash}
pip install -r requirements.txt
```

Install package in editable mode:

```{bash}
pip install -e .[dev]
```

### Add new dependencies

The `requirements.txt` is generated automatically with `pip-tools` and it should not be edited manually. Add abstract dependencies to `setup.py`. If neccessary, add version requirements but try to be as flexible as possible. Then, update the `requirements.txt` file with:

```{bash}
pip-compile --extra dev
```

`pip-tools` also has a `pip-sync` command to make sure that the local environment is in sync with the `requirements.txt` file.

## Run tests

- Run tests: `pytest`

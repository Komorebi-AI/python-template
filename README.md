# Template

![testing workflow](https://github.com/Komorebi-AI/python-template/actions/workflows/test.yml/badge.svg)
[![codecov](https://codecov.io/gh/Komorebi-AI/python-template/branch/main/graph/badge.svg?token=DQXLBOUDPX)](https://codecov.io/gh/Komorebi-AI/python-template)

Template for Python libraries

## Components

The repository is structured into the following directories:

- `/template`: where the python code is.
- `/data`: required data
- `/tests`: python code for testing via `pytest`.

Conveniently, a set of workflows via Github Actions are already installed:

- `black`: code formatting
- `pytest`: automatically discover and runs tests in `tests/`
- `mypy`: automatically runs type checking

Tools:
 - [black](https://github.com/psf/black)
 - [ruff](https://docs.astral.sh/ruff/)
 - [mypy](https://mypy.readthedocs.io/)
 - [pytest](https://docs.pytest.org/en/)
 - [pip-tools](https://github.com/jazzband/pip-tools)

## Installation

Install a specific version of the package with `pip`

```{bash}
pip install git+ssh://git@github.com/Komorebi-AI/template.git@0.1.0
```

## Contribute

Create isolated environment with required Python version. This can be done with conda or any other number of tools like venv:

```{bash}
conda env create -n python-template python=3.9
```

Then, activate the environment:

```{bash}
conda activate python-template
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

The `requirements.txt` is generated automatically with `pip-tools` and it should not be edited manually. Add abstract dependencies to `requirements.in` and `requirements-dev.in`. If neccessary, add version requirements but try to be as flexible as possible. Then, update the `requirements.txt` file with:

```{bash}
pip-compile --extra dev pyproject.toml
```

If you want to pin separately production and dev dependencies you can use instead:

```{bash}
pip-compile
```

And:

```{bash}
pip-compile --extra dev -o requirements-dev.txt -c requirements.txt pyproject.toml
```

Flag `-c` constraints the `dev` dependencies to be the same exact versions as the production dependencies. `pip-tools` also has a `pip-sync` command to make sure that the local environment is in sync with the `requirements.txt` file.

## Run tests

- Run tests: `pytest`

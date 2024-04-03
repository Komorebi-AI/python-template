# Template

![testing workflow](https://github.com/Komorebi-AI/python-template/actions/workflows/pytest.yml/badge.svg)
[![codecov](https://codecov.io/gh/Komorebi-AI/python-template/branch/main/graph/badge.svg?token=DQXLBOUDPX)](https://codecov.io/gh/Komorebi-AI/python-template)
[![Checked with mypy](http://www.mypy-lang.org/static/mypy_badge.svg)](http://mypy-lang.org/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Template for Python libraries. The associated development guide can be found [here](https://github.com/Komorebi-AI/docs/blob/main/python_dev.md).

## Components

The repository is structured into the following directories:

- `/template`: Python source code
- `/tests`: Python code for testing via pytest
- `/data`: data folder

Conveniently, a set of workflows via Github Actions are already installed:

- `pre-commit`: run pre-commit hooks
- `pytest`: automatically discover and runs tests in `tests/`

Tools:

- [ruff](https://docs.astral.sh/ruff/)
- [mypy](https://mypy.readthedocs.io/)
- [pytest](https://docs.pytest.org/en/)
- [uv](https://github.com/astral-sh/uv)
- [pre-commit](https://pre-commit.com/)
- [prettier](https://prettier.io/)
- [codespell](https://github.com/codespell-project/codespell)

## Installation

Install a specific version of the package with `pip`

```{bash}
pip install git+ssh://git@github.com/Komorebi-AI/template.git@0.1.0
```

## Setup development environment

Create isolated environment with required Python version. This assumes that you have `conda` installed ([see instructions](https://github.com/Komorebi-AI/docs/blob/main/install_conda.md)):

```{bash}
make env
```

Then, activate the environment:

```{bash}
conda activate python-template
```

Install dependencies:

```{bash}
make install
```

Install and run pre-commit hooks:

```{bash}
make hooks
```

### Adding new dependencies

The `requirements.txt` is generated automatically with `pip-tools` and it should not be edited manually. Add abstract dependencies to `requirements.in` and `requirements-dev.in`. If necessary, add version requirements but try to be as flexible as possible. Then, update the `requirements.txt` file with:

```{bash}
make compile
```

Sync the local environment with the `requirements-dev.txt` file:

```{bash}
make sync
```

## Run linter and formatter

```{bash}
make ruff
```

## Run tests

```{bash}
make test
```

## Run type checker

```{bash}
make mypy
```

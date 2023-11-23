# Template

![testing workflow](https://github.com/Komorebi-AI/python-template/actions/workflows/pytest.yml/badge.svg)
[![codecov](https://codecov.io/gh/Komorebi-AI/python-template/branch/main/graph/badge.svg?token=DQXLBOUDPX)](https://codecov.io/gh/Komorebi-AI/python-template)

Template for Python libraries. The associated development guide can be found [here](https://github.com/Komorebi-AI/docs/blob/main/python_dev.md).

## Components

The repository is structured into the following directories:

 - `/doraemon`: Python source code
 - `/tests`: Python code for testing via pytest
 - `/data`: data folder

Conveniently, a set of workflows via Github Actions are already installed:

- `pre-commit`: run pre-commit hooks
- `pytest`: automatically discover and runs tests in `tests/`

Tools:

- [black](https://github.com/psf/black)
- [ruff](https://docs.astral.sh/ruff/)
- [mypy](https://mypy.readthedocs.io/)
- [pytest](https://docs.pytest.org/en/)
- [pip-tools](https://github.com/jazzband/pip-tools)
- [pre-commit](https://pre-commit.com/)
- [prettier](https://prettier.io/)
- [codespell](https://github.com/codespell-project/codespell)

## Installation

Install a specific version of the package with `pip`

```{bash}
pip install git+ssh://git@github.com/Komorebi-AI/template.git@0.1.0
```

## Install dependencies

Create isolated environment with required Python version. This can be done with tools like venv or conda:

```{bash}
conda create -n python-template python=3.9
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

Install and run pre-commit hooks:

```{bash}
pre-commit install
pre-commit run --all-files
```

Alternatively, you can use the included `env.yml` file that performs all the previous steps (except the pre-commit hooks):

```{bash}
conda env create -f env.yml
```

or `make`

```{bash}
make env
conda activate python-template
make install
make hooks
```

### Adding new dependencies

The `requirements.txt` is generated automatically with `pip-tools` and it should not be edited manually. Add abstract dependencies to `requirements.in` and `requirements-dev.in`. If necessary, add version requirements but try to be as flexible as possible. Then, update the `requirements.txt` file with:

```{bash}
pip-compile --extra dev pyproject.toml
```

If you want to pin separately production and dev dependencies you can use instead:

```{bash}
pip-compile pyproject.toml
```

And:

```{bash}
pip-compile --extra dev -o requirements-dev.txt -c requirements.txt pyproject.toml
```

Or simply:

```{bash}
make compile
```

Flag `-c` constrains the `dev` dependencies to be the same exact versions as the production dependencies. `pip-tools` also has a `pip-sync` command to make sure that the local environment is in sync with the `requirements.txt` or `requirements-dev.txt` file:

```{bash}
make sync
```

## Run tests

- Run tests: `python -m pytest`

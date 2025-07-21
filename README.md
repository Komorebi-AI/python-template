<!-- markdownlint-disable MD059 -->

# Template

![testing workflow](https://github.com/Komorebi-AI/python-template/actions/workflows/pytest.yml/badge.svg)
[![Checked with mypy](http://www.mypy-lang.org/static/mypy_badge.svg)](http://mypy-lang.org/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Template for Python libraries and applications with Docker packaging. The associated development guide can be found [here](https://github.com/Komorebi-AI/docs/blob/main/python_dev.md).

## Structure

The repository is structured into the following directories:

- `/template`: Python source code
- `/tests`: Python code for testing via pytest
- `/data`: data folder

Conveniently, a set of workflows via Github Actions are already installed:

- `pre-commit`: run pre-commit hooks
- `pytest`: automatically discover and runs tests in `tests/`

Tools:

- [uv](https://docs.astral.sh/uv/): manage dependencies, Python versions and virtual environments
- [ruff](https://docs.astral.sh/ruff/): lint and format Python code
- [pytest](https://docs.pytest.org/en/): run unit tests
- [pre-commit](https://pre-commit.com/): manage pre-commit hooks
- [prettier](https://prettier.io/): format YAML and Markdown
- [codespell](https://github.com/codespell-project/codespell): check spelling in source code

## Installation

### Application

Install package and pinned dependencies with the [`uv`](https://docs.astral.sh/uv/) package manager:

1. Install `uv`. See instructions for Windows, Linux or MacOS [here](https://docs.astral.sh/uv/getting-started/installation/).

2. Clone repository

3. Install package and dependencies in a virtual environment:

   ```{bash}
   uv sync
   ```

4. Run any command or Python script with `uv run`, for instance:

   ```{bash}
   uv run template/main.py
   ```

   Alternatively, you can also activate the virtual env and run the scripts normally:

   ```{bash}
   source .venv/bin/activate
   ```

### Library

If using `pip` or `uv pip`, a specific version of the package can be installed with:

```{bash}
pip install git+ssh://git@github.com/Komorebi-AI/template.git@0.1.0
```

It can also be added to the `requirements.in` or `pyproject.toml`. If using `uv`, it can be added as a dependency with:

```{bash}
uv add "python-template @ git+https://github.com/Komorebi-AI/python-template@0.1.0"
```

## Setup development environment (Unix)

Install [`uv`](https://docs.astral.sh/uv/getting-started/installation/) and pre-commit hooks:

```{bash}
make install
```

`uv` will automatically create a virtual environment with the specified Python version in `.python-version` and install the dependencies from `uv.lock` (both standard and dev dependencies). It will also install the package in editable mode.

### Adding new dependencies

Add dependencies with:

```{bash}
uv add <PACKAGE>
```

Add dev dependencies with:

```{bash}
uv add --dev <PACKAGE>
```

Remove dependency with:

```{bash}
uv remove <PACKAGE>
```

Upgrade all dependencies:

```{bash}
uv lock --upgrade
```

or a single package:

```{bash}
uv lock --upgrade-package ruff
```

In all cases `uv` will automatically update the `uv.lock` file and sync the virtual environment. This can also be done manually with:

```{bash}
uv sync
```

### Tools

#### Run pre-commit hooks

Hooks are run on modified files before any commit. To run them manually on all files use:

```{bash}
make hooks
```

#### Run linter and formatter

```{bash}
make ruff
```

#### Run tests

```{bash}
make test
```

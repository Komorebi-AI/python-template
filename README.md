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
- [mypy](https://mypy.readthedocs.io/): check types
- [pytest](https://docs.pytest.org/en/): run unit tests
- [pre-commit](https://pre-commit.com/): manage pre-commit hooks
- [prettier](https://prettier.io/): format YAML and Markdown
- [codespell](https://github.com/codespell-project/codespell): check spelling in source code

## Installation

### Application

Install package and pinned dependencies with the [`pixi`](https://docs.astral.sh/uv/) package manager:

1. Install `pixi`. See instructions for Windows, Linux or MacOS [here](https://pixi.sh/dev/).

2. Clone repository

3. Install package and dependencies in a virtual environment:

   ```{bash}
   pixi install
   ```

4. Run any command or Python script with `pixi run`, for instance:

   ```{bash}
   pixi run template/main.py
   ```

   Alternatively, you can also activate the virtual env and run the scripts normally:

   ```{bash}
   pixi shell
   ```

### Library

Install a specific version of the package with `pip` or `uv pip`:

```{bash}
pip install git+ssh://git@github.com/Komorebi-AI/template.git@0.1.0
```

## Setup development environment (Unix)

Install [`pixi`](https://pixi.sh/dev/) and pre-commit hooks:

```{bash}
make install
```

`pixi` will automatically create a virtual environment with the specified Python version in `.python-version` and install the dependencies from `pixi.lock`. It will create two environments, `default` and `dev` with the standard and dev dependencies respectively. It will also install the package in editable mode.

The packages installed in each environment can be listed with `pixi list` or `pixi tree`:

```{bash}
pixi list
pixi list -e dev
```

To run commands in the default environment use `pixi run` and to run commands in the `dev` environment use `pixi run -e dev`. You can also activate the environments with `pixi shell` or `pixi shell -e dev`.

More information can be found in the [official documentation](https://pixi.sh/dev/tutorials/python/).

### Adding new dependencies

Add dependencies with:

```{bash}
pixi add <PACKAGE>
```

Add dev dependencies with:

```{bash}
pixi add --feature dev <PACKAGE>
```

Remove dependencies with:

```{bash}
pixi remove <PACKAGE>
```

If the dependency is not available in conda, we can install the pypi version with:

```{bash}
pixi add --pypi <PACKAGE>
```

In all cases `pixi` will automatically update the `pixi.lock` file and sync the virtual environment. This can also be done manually with:

```{bash}
pixi install
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

#### Run type checker

```{bash}
make mypy
```

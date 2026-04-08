<!-- markdownlint-disable MD059 -->

# Python template

![testing workflow](https://github.com/Komorebi-AI/python-template/actions/workflows/pytest.yml/badge.svg)
[![prek](https://img.shields.io/badge/prek-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/j178/prek)

Aplicación Python de ejemplo

## Structure

The repository is structured into the following directories:

- `/python_template`: Python source code
- `/tests`: Python code for testing via pytest
- `/data`: data folder

Conveniently, a set of workflows via Github Actions are already installed:

- `prek`: run prek hooks
- `pytest`: automatically discover and runs tests in `tests/`

Tools:

- [uv](https://docs.astral.sh/uv/): manage dependencies, Python versions and virtual environments
- [ruff](https://docs.astral.sh/ruff/): lint and format Python code
- [pytest](https://docs.pytest.org/en/): run unit tests
- [ty](https://github.com/astral-sh/ty): type check Python code
- [prek](https://github.com/j178/prek): manage pre-commit hooks (fast, Rust-based)
- [prettier](https://prettier.io/): format YAML and Markdown
- [codespell](https://github.com/codespell-project/codespell): check spelling in source code

## Installation

Install package and pinned dependencies with the [`uv`](https://docs.astral.sh/uv/) package manager:

1. Install `uv`. See instructions for Windows, Linux or MacOS [here](https://docs.astral.sh/uv/getting-started/installation/).

2. Clone repository

3. Install package and dependencies in a virtual environment:

   ```bash
   uv sync
   ```

4. Run any command or Python script with `uv run`, for instance:

   ```bash
   uv run python_template/main.py
   ```

   Alternatively, you can also activate the virtual env and run the scripts normally:

   ```bash
   source .venv/bin/activate
   ```

## Setup development environment (Unix)

Install [`uv`](https://docs.astral.sh/uv/getting-started/installation/) and prek hooks:

```bash
make install
```

`uv` will automatically create a virtual environment with the specified Python version in `.python-version` and install the dependencies from `uv.lock` (both standard and dev dependencies). It will also install the package in editable mode.

If this is a fresh project created from the template, upgrade all dependencies to their latest versions and commit the updated lock file:

```bash
make upgrade
```

### Adding new dependencies

Add dependencies with:

```bash
uv add <PACKAGE>
```

Add dev dependencies with:

```bash
uv add --dev <PACKAGE>
```

Remove dependency with:

```bash
uv remove <PACKAGE>
```

Upgrade a package:

```bash
uv lock --upgrade-package ruff
```

In all cases `uv` will automatically update the `uv.lock` file and sync the virtual environment. This can also be done manually with:

```bash
uv sync
```

### Tools

#### Run pre-commit hooks

Hooks are run on modified files before any commit. To run them manually on all files use:

```bash
make hooks
```

#### Run linter and formatter

```bash
make ruff
```

#### Run type checker

```bash
make ty
```

#### Run tests

```bash
make test
```

#### Test API

1. Install `httpie` globally:

   ```bash
   uv tool install httpie
   ```

2. Send GET request:

   ```bash
   http localhost:7000
   ```

3. Send POST request:

   ```bash
   http localhost:7000/predict input=5
   ```

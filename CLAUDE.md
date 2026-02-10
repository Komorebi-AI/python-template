# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Python template for libraries and applications with Docker packaging. Uses `uv` for dependency management, `ruff` for linting/formatting, and `pytest` for testing.

## Common Commands

```bash
# Install uv and dependencies
make install

# Run tests
make test

# Run tests with optional markers
uv run pytest --optional

# Run a single test file
uv run pytest tests/test_trivial.py

# Run a single test
uv run pytest tests/test_trivial.py::test_print_version

# Lint and format
make ruff

# Run pre-commit hooks on all files
make hooks

# Run the API locally (port 7000)
uv run python template/api.py

# Build and run Docker container
make docker
```

## Architecture

- `/template`: Main Python package
  - `main.py`: CLI entry point using Typer, exposes version via `main` console script
  - `api.py`: FastAPI application with `/` (version check) and `/predict` endpoints
- `/tests`: Pytest test suite
  - `conftest.py`: Custom `--optional` flag for marking optional tests with `@pytest.mark.optional`

## Code Style

- Python 3.9-3.12 compatible
- Use `from __future__ import annotations` for union type syntax (`A | B`)
- Docstrings follow NumPy convention
- Ruff rules: pycodestyle (E), Pyflakes (F), pyupgrade (UP), flake8-bugbear (B), flake8-simplify (SIM), isort (I), pydocstyle (D)
- mypy strict mode enabled for the `template` package

## Dependencies

- Add dependencies: `uv add <package>`
- Add dev dependencies: `uv add --dev <package>`
- Upgrade all: `uv lock --upgrade`

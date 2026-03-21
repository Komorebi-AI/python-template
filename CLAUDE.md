# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Development Commands

```bash
make install      # Install uv and prek hooks
make test         # Run pytest
make ruff         # Format and lint with ruff
make hooks        # Run prek on all files
make upgrade      # Upgrade all dependencies
```

Run a single test:
```bash
uv run pytest tests/test_file.py::test_name -v
```

Run tests with optional marker:
```bash
uv run pytest --optional
```

### API Commands

Run the API locally:
```bash
uv run python template/api.py
```

Test API endpoint:
```bash
make test-api  # or: http localhost:7000
```

### Docker Commands

```bash
make docker       # Build and run container
make build        # Build image only
make debug        # Run container interactively
```

## Code Architecture

- `/template` - Main Python package
  - `main.py` - Entry point with version handling
  - `api.py` - FastAPI application with `/` and `/predict` endpoints
- `/tests` - Pytest test files
- `/data` - Data directory

## Conventions

- Uses `uv` for dependency management (not pip)
- Run any command with `uv run <command>`
- Add dependencies: `uv add <package>` or `uv add --dev <package>`
- Docstrings follow NumPy convention
- Ruff handles both linting and formatting

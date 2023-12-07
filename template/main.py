#!/usr/bin/env python
from importlib.metadata import PackageNotFoundError, version

import typer

try:
    __version__: str | None = version("template")
except PackageNotFoundError:
    # package is not installed
    __version__ = None
    pass


def print_version() -> None:
    """Print package version."""
    print(f"Template version {__version__}")


if __name__ == "__main__":
    typer.run(print_version)

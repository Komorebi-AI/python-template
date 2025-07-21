#!/usr/bin/env python
from __future__ import annotations  # noqa: I001

from importlib.metadata import PackageNotFoundError, version

import typer  # type: ignore

try:
    __version__: str | None = version("template")
except PackageNotFoundError:
    # package is not installed
    __version__ = None
    pass


def print_version() -> None:
    """Print package version."""
    print(f"Template version {__version__}")


def main() -> None:
    """Run typer and exit."""
    typer.run(print_version)


if __name__ == "__main__":
    main()

#!/usr/bin/env python
from importlib.metadata import PackageNotFoundError, version
from typing import Optional

import typer

try:
    __version__: Optional[str] = version("template")
except PackageNotFoundError:
    # package is not installed
    __version__ = None
    pass


def print_version():
    print(f"Template version {__version__}")


if __name__ == "__main__":
    typer.run(print_version)

#!/usr/bin/env python
from importlib.metadata import PackageNotFoundError, version

import typer

try:
    __version__ = version("template")
except PackageNotFoundError:
    # package is not installed
    pass


def print_version():
    print(f"Template version {__version__}")


if __name__ == "__main__":
    typer.run(print_version)
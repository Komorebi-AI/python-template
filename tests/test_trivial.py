import pytest

from template.main import print_version


def test_print_version():
    print_version()


@pytest.mark.optional
def test_optional():
    """Remove me when instantiating this template for another repo"""
    assert 2 + 2 == 4

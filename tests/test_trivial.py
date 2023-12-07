import pytest

from template.main import print_version


def test_print_version():
    print_version()


@pytest.mark.optional
def test_optional():
    assert 2 + 2 == 4

import pytest


def pytest_addoption(parser):
    parser.addoption(
        "--optional", action="store_true", default=False, help="run optional tests"
    )


def pytest_configure(config):
    config.addinivalue_line("markers", "optional: mark optional tests")


def pytest_collection_modifyitems(config, items):
    if config.getoption("--optional"):
        # --runslow given in cli: do not skip slow tests
        pass
    else:
        skip = pytest.mark.skip(reason="need --optional option to run")
        for item in items:
            if "optional" in item.keywords:
                item.add_marker(skip)

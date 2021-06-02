from setuptools import setup, find_packages

setup(
    name="template",
    version="0.0.0",
    packages=find_packages(),
    python_requires=">=3.9",
    setup_requires=["setuptools_scm"],
    install_requires=[
        "pandas",
        "numpy",
        "typer",
    ],
    extras_require={
        "dev": [
            "pip-tools",
            "pytest==6.2.3",
            "black==20.8b1",
        ]
    },
)

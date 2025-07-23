# First, build the application in the `/app` directory.
FROM ghcr.io/astral-sh/uv:0.8.0-python3.12-bookworm-slim AS builder
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

# Disable Python downloads, because we want to use the system interpreter
# across both images. If using a managed Python version, it needs to be
# copied from the build image into the final image
ENV UV_PYTHON_DOWNLOADS=0

# Required for setuptools_scm: https://setuptools-scm.readthedocs.io/en/stable/usage/
ARG SETUPTOOLS_SCM_PRETEND_VERSION=1

WORKDIR /app
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev

ADD . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev


# Then, use a final image without uv
FROM python:3.12-slim-bookworm
# It is important to use the image that matches the builder, as the path to the
# Python executable must be the same, e.g., using `python:3.11-slim-bookworm`
# will fail.

# Copy the application from the builder
COPY --from=builder --chown=app:app /app /app

# Place executables in the environment at the front of the path
ENV PATH="/app/.venv/bin:$PATH"

WORKDIR /app

# Run the FastAPI application by default
CMD ["uvicorn", "template.api:app", "--host", "0.0.0.0", "--port", "80", "--log-config", "log_conf.yaml"]
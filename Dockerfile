# From https://docs.astral.sh/uv/guides/integration/docker/
FROM python:3.11-slim

# uv installer requires curl (and certificates) to download the release archive
# ssh and git are required by setuptools_scm for automatic versioning using git
RUN  apt-get -yq update && apt-get -yqq install --no-install-recommends ssh git curl ca-certificates

# Download the latest installer
ADD https://astral.sh/uv/0.4.3/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.cargo/bin/:$PATH"

# Change the working directory to the `app` directory
WORKDIR /app

# Copy the lockfile and `pyproject.toml` into the image
COPY uv.lock /app/uv.lock
COPY pyproject.toml /app/pyproject.toml

# Install dependencies
RUN uv sync --frozen --no-cache --no-dev --no-install-project

# Copy the project into the image
COPY . /app

# Sync the project into a new environment
# Mounting the git directory is required by setuptools_scm: https://setuptools-scm.readthedocs.io/en/stable/usage/
RUN --mount=source=.git,target=.git,type=bind \
    uv sync --frozen --no-cache --no-dev

CMD ["uv", "run", "uvicorn", "template.api:app", "--host", "0.0.0.0", "--port", "80"]
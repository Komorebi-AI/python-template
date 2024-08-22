FROM python:3.11-slim

RUN  apt-get -yq update && apt-get -yqq install ssh git

# From https://docs.astral.sh/uv/guides/integration/docker/
COPY --from=ghcr.io/astral-sh/uv:0.3.1 /uv /bin/uv

# Copy the project into the image
ADD . /app
WORKDIR /app

# Sync the project into a new environment
RUN --mount=source=.git,target=.git,type=bind uv sync --no-dev --no-cache

CMD ["uv", "run", "uvicorn", "template.api:app", "--host", "0.0.0.0", "--port", "80"]
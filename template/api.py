# Use A | B syntax for Union types in Python 3.9
from __future__ import annotations

import logging

from fastapi import FastAPI
from pydantic import BaseModel

from template.main import __version__

logger = logging.getLogger(__name__)

# Overwrite root log level from `log_conf.yaml`
logger.setLevel(logging.DEBUG)

app = FastAPI()


class Request(BaseModel):
    """Data model for the request body."""

    input: int


class Response(BaseModel):
    """Data model for the response body."""

    output: int


@app.get("/")
def read_root() -> dict[str, str]:
    """Check API version."""
    logger.debug("DEBUG")
    logger.warning("WARNING")
    logger.info("INFO")
    logger.error("ERROR")
    logger.critical("CRITICAL")

    return {"template-api": f"version {__version__}"}


@app.post("/predict")
def predict(request: Request) -> Response:
    """Mock prediction endpoint."""
    return {"output": request.input}


if __name__ == "__main__":
    import sys

    import uvicorn

    port = 7000 if len(sys.argv) < 2 else int(sys.argv[1])
    host = "127.0.0.1" if len(sys.argv) < 3 else sys.argv[2]
    uvicorn.run(
        "api:app", host=host, port=port, reload=True, log_config="log_conf.yaml"
    )

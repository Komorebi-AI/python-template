from fastapi import FastAPI

from template.main import __version__

app = FastAPI()


@app.get("/")  # type:ignore[misc]
def read_root() -> dict[str, str]:
    """Check API version."""
    return {"template-api": f"version {__version__}"}


if __name__ == "__main__":
    import sys

    import uvicorn

    port = 7654 if len(sys.argv) < 2 else int(sys.argv[1])
    host = "127.0.0.1" if len(sys.argv) < 3 else sys.argv[2]
    uvicorn.run("api:app", host=host, port=port, reload=True)

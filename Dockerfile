# From https://fastapi.tiangolo.com/deployment/docker/
FROM python:3.9-slim

#RUN  apt-get -yq update && apt-get -yqq install ssh git

WORKDIR /code
COPY ./requirements.txt /code/requirements.txt

ENV PIP_ROOT_USER_ACTION=ignore \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1

RUN pip install -r /code/requirements.txt

COPY ./template /code/template
COPY ./pyproject.toml /code/pyproject.toml

# Solo necesario si queremos instalar la librería y obtener la version
# automaticamente. Ver: https://pypi.org/project/setuptools-scm/
#RUN --mount=source=.git,target=.git,type=bind \
#    pip install -e .

CMD ["uvicorn", "template.api:app", "--host", "0.0.0.0", "--port", "80"]
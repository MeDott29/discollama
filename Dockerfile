FROM python:3.11.6-alpine

RUN apk add --no-cache build-base libffi-dev curl iputils

RUN pip install poetry

WORKDIR /mnt
COPY pyproject.toml poetry.lock .
RUN poetry install --no-root --only main

COPY . .
ENTRYPOINT ["sh", "-c", "ping -c 4 ollama && curl -v http://ollama:11434/api/tags && poetry run python discollama.py"]
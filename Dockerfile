FROM python:3.11-buster as builder

RUN pip install poetry

#ENV POETRY_NO_INTERACTION=1 \
#    POETRY_VIRTUALENVS_IN_PROJECT=1 \
#    POETRY_VIRTUALENVS_CREATE=1 \
#    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

COPY . ./


RUN poetry build

FROM python:3.11-slim-buster as runtime

#ENV VIRTUAL_ENV=/app/.venv \
#    PATH="/app/.venv/bin:$PATH"

#COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY --from=builder /app/dist/getfr-0.1.1.tar.gz /getfr-0.1.1.tar.gz
RUN pip install getfr-0.1.1.tar.gz
#ENTRYPOINT ["getfr"]
ENTRYPOINT ["bash"]

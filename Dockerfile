FROM cgr.dev/chainguard/python:latest-dev AS builder

WORKDIR /app
COPY pyproject.toml README.md ./
COPY src/ src/
RUN python -m venv .venv
RUN .venv/bin/pip install --no-cache-dir .

FROM cgr.dev/chainguard/python:latest

COPY --from=builder /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH"
WORKDIR /scan

ENTRYPOINT ["skillspector"]

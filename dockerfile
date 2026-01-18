# Use the official Python image as the base image
FROM python:3.12.9-bookworm

# Metadata labels
LABEL maintainer="jadesonbruno.a@outlook.com"

# Setting environment variables to optimize Python behavior
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

ENV POETRY_VERSION=2.0.1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false

WORKDIR /data-projects/ai-for-stock-exchange

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install "poetry==${POETRY_VERSION}"

COPY pyproject.toml poetry.lock ./

RUN poetry install --no-root --only main --no-ansi

COPY app ./app
COPY src ./src

EXPOSE 8501

# Command to run the Streamlit application
CMD ["streamlit", "run", "app/app.py", "--server.address=0.0.0.0", "--server.port=8501"]

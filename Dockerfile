# ---------- base ----------
FROM python:3.12-slim

# security: run as non-root
RUN adduser --disabled-password --gecos '' django

WORKDIR /app

# system libs for psycopg2
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# deps first (better cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy project
COPY backend /app/backend

# env defaults (can be overridden by compose)
ENV PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=backend.settings \
    PYTHONPATH=/app/backend

EXPOSE 8000

# run dev server (auto-reload works when code is volume-mounted)
CMD ["python", "/app/backend/manage.py", "runserver", "0.0.0.0:8000"]

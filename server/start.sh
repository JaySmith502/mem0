#!/bin/sh
set -e
python - <<'EOF'
import os, psycopg
conn = psycopg.connect(
    host=os.environ.get("POSTGRES_HOST", "postgres"),
    user=os.environ.get("POSTGRES_USER", "postgres"),
    password=os.environ["POSTGRES_PASSWORD"],
    dbname="postgres",
    autocommit=True,
)
cur = conn.cursor()
cur.execute("SELECT 1 FROM pg_database WHERE datname = 'mem0_app'")
if not cur.fetchone():
    cur.execute("CREATE DATABASE mem0_app")
    print("created mem0_app database")
EOF
alembic upgrade head
exec uvicorn main:app --host 0.0.0.0 --port 8000

FROM pgvector/pgvector:pg17
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh

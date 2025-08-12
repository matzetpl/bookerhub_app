#!/bin/sh
set -e

# Nazwa serwisu z docker-compose.yml
SERVICE_NAME="web"

echo "==> Running rake db:seed in $SERVICE_NAME"
docker compose exec "$SERVICE_NAME" bash -lc "bin/rails db:seed"


echo "==> Done."

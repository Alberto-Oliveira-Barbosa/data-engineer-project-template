#!/bin/bash

set -a
. ./.env
set +a

echo "🚀 Starting project: ${COMPOSE_PROJECT_NAME}..."

# Check docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first"
    exit 1
fi

# Start containers
docker compose up -d --build

echo -e "\n⏳ Waiting for services to initialize (30 seconds)..."
sleep 30 

# Check status
echo -e "\n\n🔍 Services status:"
docker compose ps

# Show URLs
echo -e "\n🔗 Access URLs:"
echo "- Airflow: http://localhost:8080 (USER: ${POSTGRES_USER} - PASSWORD: ${POSTGRES_PASSWORD})"
echo "- MinIO: http://localhost:9001 (USER: ${MINIO_ROOT_USER} - PASSWORD: ${MINIO_ROOT_PASSWORD})"

echo -e "\n✅ Use './check_services.sh' to check the status of services"
echo -e "📝 Use 'docker compose logs -f' to view logs in real time"

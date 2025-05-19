#!/bin/bash

services=("postgres" "minio" "airflow-webserver")

for service in "${services[@]}"; do
  container_id=$(docker ps -qf "name=${PROJECT_NAME}-${service}-1")
  
  if [ -z "$container_id" ]; then
    echo "⚠️ Container $service is not running. Restarting..."
    docker compose up -d $service
    sleep 10
  else
    echo "✅ $service is running (ID: $container_id)"
  fi
done

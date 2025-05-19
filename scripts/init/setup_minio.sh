#!/bin/bash
set -ex

echo "⚙️ Setting up MinIO..."

echo "🔍 Variables:"
echo "MINIO_ROOT_USER=${MINIO_ROOT_USER}"
echo "BUCKETS_LIST=${BUCKETS_LIST}"

echo "🕒 Waiting for MinIO to be available..."
while ! curl -f http://minio:9000/minio/health/live; do
  echo "⏳ Connecting to MinIO..."
  sleep 5
done

echo "🔌 Add alias to MinIO..."
mc alias set minio http://minio:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD} --api S3v4

echo "🪣 Creating buckets..."
IFS=" " read -ra buckets <<< "${BUCKETS_LIST}"
for bucket in "${buckets[@]}"; do
  echo "Creating buckets: ${bucket}"
  mc mb minio/${bucket} || echo "⚠️ Bucket ${bucket} already exists or an error occurred during creation"
  mc policy set public minio/${bucket} || echo "⚠️ Failed to set policy"
done

echo "✅ MinIO successfully configured!"
mc ls minio/

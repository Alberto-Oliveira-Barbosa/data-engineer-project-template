#!/bin/bash
set -ex

echo "⚙️ Starting Airflow configuration..."

export AIRFLOW_HOME=/opt/airflow
export PATH="/home/airflow/.local/bin:/home/alberto/.pyenv/plugins/pyenv-virtualenv/shims:/home/alberto/.pyenv/shims:/home/alberto/.pyenv/bin:/home/alberto/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/alberto/.local/bin"

echo "🔧 Installing dependencies..."
pip install --no-cache-dir cryptography==44.0.0

echo "🔑 Generating a Fernet Key..."
FERNET_KEY=$(python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())")
export AIRFLOW__CORE__FERNET_KEY=$FERNET_KEY

echo "🕒 Waiting for PostgreSQL..."
until pg_isready -h postgres -U airflow -d airflow -t 1 &>/dev/null; do
  echo "⏳ Attempting connection to PostgreSQL..."
  sleep 5
done
echo "✅ PostgreSQL available"

echo "⚙️ Configuring MinIO..."
if [ -f "/scripts/setup_minio.sh" ]; then
    echo "✅ Script found, executing setup_minio.sh..."
    chmod +x /scripts/setup_minio.sh
    /scripts/setup_minio.sh || echo "⚠️ Falha ao executar setup_minio.sh"
else
    echo "❌ ERRO: /scripts/setup_minio.sh not found"
    ls -la /scripts/
    exit 1
fi

echo "🛠️ Starting Airflow DB..."
airflow db migrate

echo "👤 Creating a Airflow user admin..."
airflow users create   --username airflow   --password airflow   --firstname Admin   --lastname User   --role Admin   --email admin@example.com

echo "🚀 Start services on port 8080..."
airflow webserver --port 8080 --daemon &
exec airflow scheduler

FROM apache/airflow:2.10.5-python3.11

USER root

# Installs system dependencies
RUN apt-get update &&     apt-get install -y --no-install-recommends         build-essential         python3-dev         libffi-dev         openssl         curl         jq         && rm -rf /var/lib/apt/lists/*

# Install MinIO client
RUN curl -o /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/mc &&     chmod +x /usr/local/bin/mc

RUN mkdir -p /scripts &&     chown -R airflow:root /scripts &&     chmod -R 775 /scripts

COPY ./airflow/requirements.txt .
COPY ./scripts/init/setup_minio.sh /scripts/init/
COPY ./scripts/init/setup_airflow.sh /scripts/init/
COPY ./airflow/config/ /opt/airflow/config/

RUN chmod +x /scripts/init/*.sh &&     chown -R airflow:root /opt/airflow/config

# Python dependencies
USER airflow
RUN pip install --no-cache-dir --upgrade pip &&     pip install --no-cache-dir cryptography==44.0.0 &&     pip install --no-cache-dir -r requirements.txt

CMD ["bash", "/scripts/setup_airflow.sh"]


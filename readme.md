# Data Engineering Project Template

![Data Pipeline](https://img.shields.io/badge/Data-Pipeline-blue)
![Apache Airflow](https://img.shields.io/badge/Apache-Airflow-orange)
![MinIO](https://img.shields.io/badge/MinIO-Object%20Storage-yellow)
![Docker](https://img.shields.io/badge/Docker-Containers-blue)

A complete local development environment for data engineering workflows featuring Airflow orchestration, MinIO object storage, and PostgreSQL.

## 🚀 Quick Start

1. **Prerequisites**:
   - Docker and Docker Compose
   - Bash shell (Linux/Mac/WSL2 on Windows)

2. **Clone and initialize**:
   ```bash
   git clone https://github.com/Alberto-Oliveira-Barbosa/data-engineer-project-template.git
   cd data-engineer-project-template
   
   # (Optional) Customize environment variables before starting
   nano .env  # or edit with your preferred text editor
   
   ./start_project.sh

## 🌟 Core Components

### 🛠️ Technology Stack
- **Orchestration**: Apache Airflow 2.10.5
- **Storage**: MinIO (S3-compatible)
- **Database**: PostgreSQL 15
- **Processing**: Python/PySpark/Pandas/Selenium

### 📂 Project Structure
```
├── airflow/
│   ├── dags/              # Workflow definitions
│   ├── plugins/           # Custom plugins
│   ├── config/            # Configuration files
│   └── Dockerfile         # Custom Airflow image
├── minio/                 # Object storage
├── postgres/              # Metadata database
├── scripts/               # Initialization scripts
├── .env                   # Environment configuration
└── compose.yaml           # Docker services
```

## 🔌 Access Points (Default credentials)
- **Airflow UI**: http://localhost:8080  
  (User: `airflow` | Pass: `airflow`)
- **MinIO Console**: http://localhost:9001  
  (User: `minioadmin` | Pass: `minioadmin`)

## 🛠️ Management Scripts
| Script | Purpose |
|--------|---------|
| `start_project.sh` | Starts all services |
| `stop_project.sh` | Stops all services |
| `check_services.sh` | Verifies service health |

## 🧩 Key Features
- Pre-configured data lake buckets (bronze/silver/gold)
- Example DAGs for MinIO operations
- Automatic service health checks
- Persistent storage volumes
- Customizable through `.env` file

## 📚 Learning Resources
- [Airflow Documentation](https://airflow.apache.org/docs/)
- [MinIO Python SDK](https://min.io/docs/minio/linux/developers/python/API.html)
- [PySpark Guide](https://spark.apache.org/docs/latest/api/python/)

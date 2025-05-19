#!/bin/bash

echo "🛑 Stopping project: data-engineer-project-template..."

docker compose down

echo "✅ Project stopped. Use './start_project.sh' for restart."

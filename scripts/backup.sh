#!/bin/bash

echo "Creating PostgreSQL backup..."

mkdir -p backups

docker exec postgres-container pg_dump -U postgres smartims > backups/smartims_backup_$(date +%F_%H-%M-%S).sql

echo "Backup completed."
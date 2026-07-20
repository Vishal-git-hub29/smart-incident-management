#!/bin/bash

echo "======================================"
echo "Deploying Smart IMS"
echo "======================================"

echo "Pulling latest Docker images..."

docker pull vishal29docker/smartims-backend:v1
docker pull vishal29docker/smartims-frontend:v3

echo "Stopping old containers..."

docker stop smartims-backend 2>/dev/null
docker rm smartims-backend 2>/dev/null

docker stop smartims-frontend 2>/dev/null
docker rm smartims-frontend 2>/dev/null

echo "Starting backend..."

docker run -d \
  --name smartims-backend \
  --network smartims-compose_smartims-network \
  -p 8080:8080 \
  -e DB_URL=jdbc:postgresql://postgres-container:5432/smartims \
  -e DB_USERNAME=postgres \
  -e DB_PASSWORD=postgres \
  -e JWT_SECRET=ThisIsASecretKeyForJwtSigningMustBeAtLeast32Chars \
  vishal29docker/smartims-backend:v1

echo "Starting frontend..."

docker run -d \
  --name smartims-frontend \
  -p 80:80 \
  vishal29docker/smartims-frontend:v3

echo ""
echo "Deployment completed successfully."
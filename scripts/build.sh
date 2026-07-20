#!/bin/bash

echo "======================================"
echo "Building Smart IMS Docker Images"
echo "======================================"

docker build -t vishal29docker/smartims-backend:v1 ./backend

docker build -t vishal29docker/smartims-frontend:v3 ./frontend

echo ""
echo "Docker images built successfully."
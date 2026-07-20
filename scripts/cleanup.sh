#!/bin/bash

echo "Cleaning Docker resources..."

docker system prune -af

docker volume prune -f

echo "Cleanup completed."
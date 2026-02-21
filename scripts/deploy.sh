#!/usr/bin/env bash
set -e

# Dynamically find the image name in lowercase
IMAGE_URL="ghcr.io/$(echo "${GITHUB_REPOSITORY}" | tr '[A-Z]' '[a-z]'):latest"
APP_NAME="test-node"

echo "📥 Fetching latest image: $IMAGE_URL"
docker pull "$IMAGE_URL"

echo "🛑 Cleaning up old containers..."
docker stop "$APP_NAME" || true
docker rm "$APP_NAME" || true

echo "🚢 Starting new container..."
docker run -d --name "$APP_NAME" -p 3000:3000 "$IMAGE_URL"
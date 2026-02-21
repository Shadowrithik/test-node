#!/usr/bin/env bash
# set -e ensures the script fails-fast if a command breaks
set -e

APP_NAME="{{APP_NAME}}"
PORT="{{PORT}}"

# Generate the same registry URL used in the build step
IMAGE_URL="ghcr.io/$(echo ${GITHUB_REPOSITORY} | tr '[A-Z]' '[a-z]'):latest"

echo "🚀 Starting Deployment for $APP_NAME..."

echo "📥 Fetching latest image from Registry: $IMAGE_URL"
docker pull "$IMAGE_URL"

echo "🛑 Cleaning up existing containers..."
docker stop "$APP_NAME" || true
docker rm "$APP_NAME" || true

echo "🚢 Running new container..."
docker run -d \
  --name "$APP_NAME" \
  -p "$PORT:$PORT" \
  "$IMAGE_URL"

echo "✅ New version successfully started for $APP_NAME"
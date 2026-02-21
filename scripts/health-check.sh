#!/usr/bin/env bash
# set -e makes the script "Self-Heal" by failing if the app never wakes up
set -e

PORT="3000"
# Using 127.0.0.1 for better reliability in cloud runners
HEALTH_URL="http://127.0.0.1:$PORT/health"

echo "🩺 Running health check at $HEALTH_URL ..."

# Try for up to 30 seconds (10 attempts * 3 seconds)
for i in {1..10}; do
  if curl -fsS "$HEALTH_URL" > /dev/null; then
    echo "✅ Health check passed: App is responsive on port $PORT"
    exit 0
  fi
  echo "⏳ Attempt $i: Waiting for app to become healthy..."
  sleep 3
done

echo "❌ Health check failed after 30 seconds"
exit 1
#!/bin/bash

set -e

echo "🚀 Starting ctr binary build and extraction..."

# Build the container image
docker build -t ctr-builder .

echo "🏗️ Extracting built ctr binary..."
# Create a temporary container
container_id=$(docker create ctr-builder)

# Copy the ctr binary out
docker cp "$container_id:/ctr" ./ctr

# Cleanup the temp container
echo "🧹 Removing temporary container..."
docker rm "$container_id"

# Cleanup the image
echo "🧹 Removing temporary builder image..."
docker rmi ctr-builder

# Move to /usr/local/bin (requires sudo)
echo "🔧 Installing ctr to /usr/local/bin (sudo may prompt you)..."
sudo mv ./ctr /usr/local/bin/
sudo chmod +x /usr/local/bin/ctr

echo "✅ Done! ctr is now available at /usr/local/bin/ctr 🎉"

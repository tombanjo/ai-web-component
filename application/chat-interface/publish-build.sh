#!/bin/bash

# Variables
PROJECT_ID=${1:-"ai-web-component-00"}
REGION=${2:-"us-central1"}
SERVICE_NAME=${3:-"chat-service"}
IMAGE_NAME="${REGION}-docker.pkg.dev/${PROJECT_ID}/${SERVICE_NAME}/${SERVICE_NAME}"

# Step 1: Build the container image using the Cloud Native Buildpacks
echo "Building the container image using buildpacks..."
pack build "${SERVICE_NAME}-image" \
  --builder gcr.io/buildpacks/builder:v1 \
  --path . \
  --publish \
  --tag "$IMAGE_NAME"

if [ $? -ne 0 ]; then
    echo "Failed to build or publish the container image."
    exit 1
fi

echo "Successfully built and published image: $IMAGE_NAME"
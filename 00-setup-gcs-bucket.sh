#!/bin/bash

# Variables
PROJECT_ID="ai-web-component-00"
BUCKET_NAME="gs://terraform-remote-state-$PROJECT_ID"
REGION="us-central1"
STAGES=("dev" "staging" "prod")

# Enable required services
gcloud services enable storage.googleapis.com

# Create the bucket
gcloud storage buckets create $BUCKET_NAME \
  --project=$PROJECT_ID \
  --location=$REGION \
  --uniform-bucket-level-access

# Create folders for each stage
for STAGE in "${STAGES[@]}"; do
  echo "Creating folder for stage: $STAGE"
  echo "Placeholder file for $STAGE stage" | gsutil cp - $BUCKET_NAME/$STAGE/.keep
done

echo "Google Cloud Storage bucket setup complete: $BUCKET_NAME"

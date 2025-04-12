#!/bin/bash

# Input attributes with default values
PROJECT_ID=${1:-"ai-web-component-00"}
REGION=${2:-"us-central1"}

# Variables
BUCKET_NAME="gs://terraform-remote-state-$PROJECT_ID"
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

echo "Enabling Necessary APIs..."
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
gcloud services enable iamcredentials.googleapis.com --project=$PROJECT_NUMBER
gcloud services enable cloudresourcemanager.googleapis.com --project=$PROJECT_NUMBER
echo "Enabling IAM Credentials API complete."

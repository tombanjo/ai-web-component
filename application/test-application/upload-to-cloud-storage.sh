#!/bin/bash

# Set variables
BUCKET_NAME=${1:-ai-web-component}

# Upload the directory to the bucket
echo "Uploading current directory to bucket $BUCKET_NAME..."
gcloud storage cp -r . "gs://$BUCKET_NAME/" || { echo "Upload failed"; exit 1; }

echo "Upload completed successfully."

#!/bin/bash

# Set variables
BUCKET_NAME=${1:-ai-web-component}

# Upload all files recursively with no-cache headers
echo "Uploading current directory to bucket $BUCKET_NAME with cache-control headers..."

find . -type f | while read -r file; do
  if [[ "$file" != "." ]]; then
    echo "Uploading: $file"
    gcloud storage cp "$file" "gs://$BUCKET_NAME/$file" \
      --cache-control="public, max-age=0" || { echo "Failed to upload $file"; exit 1; }
  fi
done

echo "Upload completed successfully."

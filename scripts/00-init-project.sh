#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: 00-init-project.sh
# Description: This script initializes a Google Cloud project by setting up 
#              a Google Cloud Storage bucket for Terraform remote state and 
#              enabling necessary APIs. It also creates folders for different 
#              deployment stages within the bucket.
#
# Usage:
#   ./00-init-project.sh [PROJECT_ID] [REGION]
#
# Arguments:
#   PROJECT_ID (optional): The ID of the Google Cloud project. Defaults to 
#                          "ai-web-component-00" if not provided.
#   REGION (optional): The region where the storage bucket will be created. 
#                      Defaults to "us-central1" if not provided.
#
# Features:
#   - Creates a Google Cloud Storage bucket with uniform bucket-level access.
#   - Sets up folders for different deployment stages (dev, staging, prod) 
#     within the bucket.
#   - Enables required Google Cloud APIs for the project.
#
# Prerequisites:
#   - The user must have the Google Cloud SDK installed and authenticated.
#   - The user must have appropriate permissions to create buckets and enable 
#     APIs in the specified Google Cloud project.
#
# Variables:
#   PROJECT_ID: The ID of the Google Cloud project.
#   REGION: The region where the bucket will be created.
#   BUCKET_NAME: The name of the Google Cloud Storage bucket.
#   STAGES: An array of deployment stages for which folders will be created 
#           in the bucket.
#
# Steps:
#   1. Enable the `storage.googleapis.com` API for the project.
#   2. Create a Google Cloud Storage bucket with the specified name and region.
#   3. Create folders for each deployment stage (dev, staging, prod) in the 
#      bucket and add a placeholder `.keep` file to each folder.
#   4. Enable additional APIs (`iamcredentials.googleapis.com` and 
#      `cloudresourcemanager.googleapis.com`) required for managing IAM 
#      credentials and cloud resources.
#
# Outputs:
#   - A Google Cloud Storage bucket with the specified name and region.
#   - Folders for each deployment stage within the bucket.
#   - Confirmation messages indicating the completion of each step.
#
# Notes:
#   - The script uses default values for PROJECT_ID and REGION if they are not 
#     provided as arguments.
#   - The `.keep` file is a placeholder to ensure the folder structure is 
#     maintained in the bucket.
#   - The script retrieves the project number dynamically to enable APIs.
#
# Example:
#   ./00-init-project.sh my-project-id us-east1
# -----------------------------------------------------------------------------

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

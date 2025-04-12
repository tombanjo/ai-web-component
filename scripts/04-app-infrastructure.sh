#!/bin/bash

WORKING_DIR="terraform/stages/prototype"

# Change to the desired working directory
cd $WORKING_DIR || { echo "Directory $WORKING_DIR not found."; exit 1; }

export TF_VAR_project_id=${1:-"ai-web-component-00"}
export TF_VAR_region=${2:-"us-central1"}
export TF_VAR_cors-origin=${3:-"https://storage.googleapis.com/ai-web-component"}
export TF_VAR_service_name=${4:-"chat-service"}


# Run Terraform commands
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false -auto-approve tfplan
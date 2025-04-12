#!/bin/bash

# Change to the desired working directory
cd terraform/stages/core-services || { echo "Directory 'terraform/stages/core-services' not found."; exit 1; }

export TF_VAR_project_id=${1:-"ai-web-component-00"}

# Run Terraform commands
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false -auto-approve tfplan
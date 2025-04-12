#!/bin/bash

# Change to the desired working directory
cd terraform/stages/github-provider || { echo "Directory 'terraform/stages/github-provider' not found."; exit 1; }

# Run Terraform commands
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false -auto-approve tfplan
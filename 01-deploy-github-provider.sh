#!/bin/bash

# Change to the desired working directory
cd github-provider || { echo "Directory 'github-provider' not found."; exit 1; }

# Run Terraform commands
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false -auto-approve tfplan
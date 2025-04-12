#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: 01-deploy-github-provider.sh
# Description: This script automates the deployment of a GitHub provider 
#              configuration using Terraform. It initializes Terraform, 
#              generates a plan, and applies the configuration.
#
# Usage: ./01-deploy-github-provider.sh [PROJECT_ID] [REGION] [GITHUB_REPOSITORY]
#
# Arguments:
#   PROJECT_ID        (Optional) The Google Cloud project ID. Defaults to "ai-web-component-00".
#   REGION            (Optional) The region for deployment. Defaults to "us-central1".
#   GITHUB_REPOSITORY (Optional) The GitHub repository in the format "owner/repo". 
#                     Defaults to "tombanjo/ai-web-component".
#
# Prerequisites:
#   - Ensure Terraform is installed and available in the system PATH.
#   - The script must be executed from a directory containing the Terraform 
#     configuration files under "terraform/stages/github-provider".
#
# Behavior:
#   1. Navigates to the Terraform configuration directory.
#   2. Initializes Terraform with the `terraform init` command.
#   3. Creates a Terraform execution plan using `terraform plan`.
#   4. Applies the Terraform configuration using `terraform apply`.
#
# Exit Codes:
#   0 - Success
#   1 - Failure (e.g., directory not found, Terraform errors).
#
# Example:
#   ./01-deploy-github-provider.sh my-project us-east1 myuser/myrepo
# -----------------------------------------------------------------------------
export TF_VAR_project_id=${1:-"ai-web-component-00"}
export TF_VAR_github_repository=${2:-"tombanjo/ai-web-component"}

# Change to the desired working directory
cd terraform/stages/github-provider || { echo "Directory 'terraform/stages/github-provider' not found."; exit 1; }

# Run Terraform commands
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false -auto-approve tfplan
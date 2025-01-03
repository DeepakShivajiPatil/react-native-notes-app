# React Native Notes App Deployment to Azure

This repository automates the deployment of a React Native Notes app to an Azure VM using CI/CD pipelines, Terraform for infrastructure provisioning, and GitOps workflows.

---
Project Structure:
.
├── azure-pipelines.yml       # Azure DevOps pipeline configuration
├── Dockerfile                # Dockerfile to containerize the app
├── main.tf                   # Terraform configuration for Azure infrastructure
├── terraform.tfvars          # Terraform variables (excluded from version control)
├── README.md                 # Project documentation

## Prerequisites

1. **Azure Account**: Ensure you have an active Azure subscription.
2. **GitHub Account**: Fork the repository to your GitHub account.
3. **Azure CLI**: Installed and authenticated. [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
4. **Terraform**: Installed on your local machine. [Install Terraform](https://www.terraform.io/downloads.html)
5. **Node.js and npm**: Ensure you have Node.js (16.x) and npm installed.
6. **SSH Keys**: Generate an SSH key pair for secure access to the Azure VM.


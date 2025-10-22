E-Commerce Three-Tier Application Deployment on AKS

This project automates the provisioning and deployment of a three-tier e-commerce application (Frontend, Backend, Azure SQL Database) onto Azure Kubernetes Service (AKS) using Terraform for Infrastructure as Code (IaC) and GitHub Actions for Continuous Integration/Continuous Deployment (CI/CD).

Key Project Goals Achieved

Infrastructure as Code (IaC): All Azure resources are provisioned and managed via Terraform.

Security Enforcement: Azure SQL Database public access is disabled, with connectivity enforced via Azure Private Endpoint.

Continuous Integration (CI): Automated Docker image build and push to Docker Hub.

Continuous Deployment (CD): Automatic deployment of updated Kubernetes manifests to the AKS cluster.

Networking: NGINX Ingress Controller manages external traffic routing.

 Project Structure

repo-root/
├── .github/
│   └── workflows/
│       ├── ci-build-push.yml  # Builds and pushes images to Docker Hub
│       └── cd-deploy-aks.yml  # Deploys manifests to AKS
├── ecommerce-app-backend/
├── ecommerce-app-frontend/
├── infra/                  # Terraform configuration files
└── kube/                   # Kubernetes Manifests


🛠️ Prerequisites

Azure Subscription: An active Azure subscription.

GitHub Repository: This repository hosted on GitHub.

Docker Hub Account: An account for storing and pulling container images.

⚙️ Step-by-Step Guide

1. Provision Infrastructure (Terraform)

Navigate to the infra/ directory and run the standard Terraform workflow:

terraform init

terraform plan

terraform apply



2. Configure & Deploy Kubernetes Manifests

This step defines the three-tier application structure within the AKS Cluster using the YAML files located in the kube/ directory.

Deployment Components:

Configuration Management:

kube/backend/configmap.yml: Defines non-sensitive environment variables, such as the private database server name (Private FQDN) and CORS origin.

kube/backend/secret.yml: Securely stores sensitive credentials (DB_USER and DB_PASSWORD).

Backend Service (API):

kube/backend/deployment.yml and kube/backend/service.yml: Deploys the Node.js API (image from Docker Hub) and exposes it internally via ClusterIP.

Frontend Service (UI):

kube/frontend/deployment.yml and kube/frontend/service.yml: Deploys the Node.js UI (image from Docker Hub) and exposes it internally via ClusterIP.

External Routing (Ingress):

kube/ingress.yml: Configures NGINX Ingress rules to direct external traffic: the /api path to the Backend Service and the / path to the Frontend Service.



3. Trigger the Pipeline (CI/CD)

CI (Build and Push): Triggered by a push to the main branch. It uses the ecommerce-app-backend/Dockerfile and ecommerce-app-frontend/Dockerfile to build images and push them to Docker Hub with the :latest tag.

CD (Deployment): Triggered upon successful CI completion. It connects to the AKS cluster using the Service Principal and applies the manifests located in the kube/ directory.

Verification: The application should be fully functional and accessible via the Public IP address of the NGINX Ingress Controller.
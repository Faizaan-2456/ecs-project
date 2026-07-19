# ecs-project

## Overview
This project deploys a Dockerised application to AWS ECS Fargate using Terraform. The infrastructure includes an Application Load Balancer, Route 53 DNS, an ACM SSL certificate, Amazon ECR for container images, and GitHub Actions for automated deployments.

## Architecture

## Key Features
- Light weight Docker image 
- tf state backend ensuring access across teams
- CI/CD pipeline to automate docker image push
- Serverless tasks definition using Fargate

Docker
AWS ECS Fargate
Amazon ECR
Applicaiton Load Balancer
Route 53
AWS Certificate Manager
Terraform
GitHub Actions

## Project Structure

```text
.
├── main.tf
├── modules
│   ├── alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecs
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── route53
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── provider.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```



## Docker - Multi-stage docker file used to create a lightweight image

Terraform - Private VPC created with 2 public subnets configured in 2 different AZs for high availablility.
ECS cluster deployed and task definition created to define how container should be run with fargate service for no server management.
Docker image stored in ECR repository and pulled once container gets built
ALB configured with security groups acting as a public entry point.
Listener listens for incoming HTTPS requests on port 443 and forwards requests to target group.
Target group routes this traffic to healthy ECS Fargate tasks and performs health checks
Route 53 hosts the domain and routes traffic to the Application Load Balancer.
AWS Certificate Manager (ACM) provides and manages the SSL/TLS certificate, enabling secure HTTPS connections.

CI/CD - GitHub Actions configured to ensure the lastest docker image gets pushed into the ECR repository. ECS service gets updated to deploy the lastest container
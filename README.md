# ecs-project

## Overview
This project deploys a Dockerised application to AWS ECS Fargate using Terraform. The infrastructure includes an Application Load Balancer, Route 53 DNS, an ACM SSL certificate, Amazon ECR for container images, and GitHub Actions for automated deployments.

![alt text](<Screenshot 2026-07-23 at 18.36.14-2.png>)

## Architecture
![alt text](<Screenshot 2026-07-23 at 13.42.26.png>)

## Key Features
- Lightweight Docker image
- tf state backend ensuring access across teams
- Utilised Terraform to automate the deployment of AWS infrastructure
- CI/CD pipeline to automate docker image push
- Serverless tasks definition using Fargate
- Utilised Amazon Route 53 to manage DNS records and route traffic from a custom domain to the Application Load Balancer.
- Configured an Application Load Balancer to route incoming HTTPS requests to healthy ECS tasks using target groups and health checks.
- AWS Certificate Manager to provision and manage an SSL/TLS certificate, enabling secure HTTPS communication for the application.

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

## Docker 
- Multi-stage docker file reducing image size by more than 80%
- Non root user preventing root access mitigating any security risks

## Terraform 
- Private VPC created with 2 public subnets configured in 2 different AZs for high availablility
- Utilised modules for reusability and better organisation
- State stored in S3
- Used variables to abide by the DRY principle

## Infrastructure
- Docker image stored in ECR repository and pulled once container gets built
- ALB configured with security groups acting as a public entry point
- Listener listens for incoming HTTPS requests on port 443 and forwards requests to target group
- Target group routes traffic to healthy ECS Fargate tasks and performs health checks on /health
- Route 53 hosts the domain and routes traffic to the Application Load Balancer
- AWS Certificate Manager (ACM) provides and manages the SSL/TLS certificate, enabling secure HTTPS connections

## CI/CD 
- Uses OIDC over hardcoded access keys for short lived credentials
- Automates the deployment of the docker image to ECR
- Manual workflows to prevent unecessary changes
![alt text](<Screenshot 2026-07-23 at 18.45.00.png>)

## Local Setup
```
yarn install
yarn build
yarn global add serve
serve -s build

#yarn start
http://localhost:3000/workspaces/default/dashboard

## or
yarn global add serve
serve -s build
```
Welcome to My Project Repo 🚀
Projects Overview
This repository showcases a variety of projects, each demonstrating unique use cases and tools. 

**1. NetflixCloneDevSecOps-PJ3** 
A fun and interesting project designed to teach and learn about multiple tools and how to securely deploy an application on Kubernetes.

Tools Used:

GitHub: Source code version control
Jenkins: CI/CD pipeline automation
SonarQube: Code quality checks
OWASP: Software security improvement
Docker: Image creation
Trivy: File system and image scanning
Kubernetes: Container deployment, version updates, and load balancing
Prometheus & Grafana: Monitoring
Helm: Installing Node Exporter on Kubernetes Cluster to expose metrics
**2. AWS Infrastructure using IaC (Terraform)**
Step into the world of Infrastructure as Code (IaC) with this project that automates a 3-tier web application, based on a design provided by AWS in one of their workshops.

AWS Services Used:

VPC, Subnet, Security Groups, EC2 Instances
Aurora MySQL Database, S3 Bucket, Load Balancers, Auto Scaling, IAM
Using Terraform, I deployed a 3-tier web application on AWS Cloud, modularizing each component for reusability.



**3. Azure Infrastructure using IaC (Terraform)**
Manage infrastructure in Azure Cloud using Terraform. This sample project deploys a VM and file share in a Resource Group and secures the data with a backup configuration.

Azure Services Used:

Resource Group, Linux Virtual Machines, VNet, Subnet
Network Security Group, Storage Account with Static Website Enabled
Recovery Services Vault, Backup Policies
**4. Azure YAML Pipeline for Infra Automation**
Tired of manually deploying infrastructure on the cloud? Use this YAML pipeline to automate the process with ease.

A code commit to a specific branch triggers the pipeline in an Azure DevOps hosted agent (Linux VM). 

The pipeline includes three stages:

I have 3 stages

stage1 = Terraform plan
Multiple tasks within Stage 1 =

. Code checkout
. terraform install
. terraform init
. terraform validate
. terraform fmt
. terraform plan
. archiving the plan
. publishing artifact

stage2 = terraform deploy
Multiple tasks within Stage 2  ( depends upon stage 1 and start only if succeeded )

terraform install
download build artifact
extract the plan
init
apply 


stage3  ( approval process to complete this stage) 
terraform destroy

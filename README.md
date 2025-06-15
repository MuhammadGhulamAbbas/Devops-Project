# Devops-Project
# 🌐 Scalable AWS Infrastructure with Terraform – DevOps Final Project

## 📖 Introduction

This repository showcases a **complete DevOps infrastructure project** that provisions a highly **scalable**, **secure**, and **containerized AWS environment** using **Terraform**. Designed with production-level best practices, this infrastructure automates the deployment of:

- Dockerized  applications
- **Private RDS** databases (MySQL and PostgreSQL)
- Auto Scaling **EC2 instances** with NGINX and Docker
- **HTTPS-secured** Application Load Balancers (ALB)
- **Metabase BI tool** hosted on a separate EC2 instance
- **Domain management** and SSL via Route 53 and AWS ACM
- **SSH tunneling** to enable secure, controlled database access

This project represents the culmination of real-world DevOps practices including **Infrastructure as Code (IaC)**, **cloud security**, **container orchestration**, and **continuous monitoring**.

---

## 🎯 Project Goals

- ✅ Build a fully automated and modular infrastructure with **Terraform**
- ✅ Deploy applications using **multi-stage Docker containers**
- ✅ Enforce **network-level security** and encryption for all traffic
- ✅ Enable **dynamic scaling** using EC2 Auto Scaling Groups
- ✅ Visualize live data using **Metabase dashboards**
- ✅ Set up **custom domains** and **SSL certificates** using AWS ACM & Route 53
- ✅ Use **SSH tunneling** to securely access private RDS instances

---

## 🛠️ Technology Stack

| Category              | Tool/Service                     | Purpose                                              |
|-----------------------|----------------------------------|------------------------------------------------------|
| Infrastructure        | **Terraform**                    | Provisioning and managing cloud resources            |
| Cloud Provider        | **AWS**                          | Hosting infrastructure and services                  |
| Compute               | **EC2 (Auto Scaling)**           | Running containerized apps                           |
| Databases             | **MySQL & PostgreSQL (RDS)**     | Backend and analytics data storage                   |
| Load Balancing        | **Application Load Balancer**    | Routing traffic with HTTPS and auto-scaling support  |
| Security              | **AWS ACM**                      | SSL/TLS certificate provisioning                     |
| Networking            | **AWS Route 53**                 | Domain and DNS management                            |
| Containers            | **Docker**                       | App containerization and isolation                   |
| Web Server            | **NGINX**                        | Reverse proxy to serve frontend                      |
| BI & Visualization    | **Metabase**                     | Real-time dashboards and analytics                   |
| DB Client             | **DBeaver**                      | GUI-based SQL client with SSH tunneling              |

---

## 🧱 Project Architecture

The infrastructure is broken down into modular Terraform components for reusability, maintainability, and scalability.

Project/
├── main.tf # Root Terraform file importing all modules

├── providers.tf # AWS provider and region configuration

├── variables.tf # Input variable declarations

├── terraform.tfvars # Input values (domain, RDS creds, certs)

├── outputs.tf # Outputs like ALB DNS names, DB endpoints

├── README.md # This documentation file

├── modules/ # Modularized Terraform resources

│ ├── network/ # VPC, subnets, internet gateway, routing

│ ├── security_groups/ # Ingress/egress rules for EC2, RDS, ALB

│ ├── ec2/ # Auto Scaling Group for app servers

│ ├── ec2-bi/ # EC2 instance for Metabase BI tool

│ ├── rds/ # MySQL & PostgreSQL databases in private subnets

│ ├── alb/ # ALB 

│ ├── alb-bi/ # ALB for Metabase BI instance

│ ├── target_group/ # ALB target groups for EC2 routing

│ └── route53/ # DNS records for application & BI tool

├── userdata/ # Bash scripts for EC2 initialization

│ ├── userdata-app.sh # Installs Docker, NGINX, Node.js, and apps

│ └── userdata-bi.sh # Installs and runs Metabase in Docker

├── docker/ # (Optional) Dockerfiles or Compose configs


---

## 🌟 Features & Implementation Details

### 1. 🖥️ EC2 Auto Scaling Group for Applications
- Uses Launch Template with user-data script to install:
  - **NGINX**
  - **Docker**
  - **Node.js 20**
- Each instance runs:
  - A **React frontend** container on port `80`
  - A **Node.js backend API** container on port `3000`
- Instances scale automatically based on demand and health checks.

### 2. 🗄️ RDS Databases (MySQL & PostgreSQL)
- MySQL is used by the application backend.
- PostgreSQL is used by the Metabase BI tool.
- Both RDS instances are deployed in **private subnets**, unreachable from the public internet.
- Access is restricted to specific security groups and **SSH tunneling**.

### 3. 🌐 Application Load Balancer (ALB)
- Two ALBs are provisioned:
  - `application.nendo.fun` – for React/Node.js app
  - `bi.nendo.fun` – for Metabase
- Listeners:
  - **HTTP listener** redirects traffic to HTTPS
  - **HTTPS listener** with **ACM SSL certificates**
- Health checks and path-based routing are enabled.

### 4. 📊 Business Intelligence with Metabase
- A dedicated EC2 instance runs **Metabase** inside a Docker container.
- Accessible via: [`https://bi.nendo.fun`](https://bi.nendo.fun)
- Connects securely to **PostgreSQL** hosted in a private subnet.
- Visualizes **real-time sales data** using dashboards and charts.

### 5. 🌍 Domain & SSL Configuration
- Domain registered: `nendo.fun`
- Subdomains:
  - `application.nendo.fun` – Application frontend/backend
  - `bi.nendo.fun` – Metabase dashboard
- **Route 53** handles DNS record creation.
- **AWS ACM** issues and validates SSL certificates for both subdomains.

### 6. 🔐 Secure Database Access via SSH Tunneling
- A bastion EC2 host is used for tunneling into the private RDS network.
- SQL clients like **DBeaver** can connect to MySQL and PostgreSQL through SSH.
- Ensures zero public exposure of sensitive database endpoints.

---

## 📊 Live Dashboard Example (Metabase)

- **URL:** `https://metabase.nendo.fun`
- **Data Source:** PostgreSQL RDS
- **Dashboard Features:**
  - Line charts, bar charts, tables
  - Queries updated as new dummy data is inserted
  - Real-time synchronization

---

## 🔎 Testing & Validation

| Test Area         | Result                          |
|-------------------|----------------------------------|
| EC2 Auto Scaling  | ✅ Successfully launches 2–3 instances |
| Load Balancer     | ✅ Redirects HTTP to HTTPS         |
| App Containers    | ✅ React & Node apps run on Docker |
| RDS Connectivity  | ✅ Verified via SSH tunnel (DBeaver) |
| BI Tool Access    | ✅ Metabase accessible & responsive |
| SSL Certificates  | ✅ Valid and auto-renewed via ACM |



## 👨‍🎓 Project Details

- **Student Name:** Muhammad Ghulam Abbas  
- **ERP ID:** 29417  
- **Course:** DevOps – Final Year Project  
- **Instructor:** Sir Hafeez Khwaja  

---

## 📌 Final Thoughts

This project bridges the gap between theory and practical DevOps deployment. From infrastructure provisioning and secure networking to real-time BI and scalable containerized apps, it reflects modern cloud-native architectures.



## 📎 License

This project is for educational purposes and demonstrations only. All code is open-source under the [MIT License](LICENSE).




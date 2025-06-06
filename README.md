# Cloud Resume Challenge (Azure HA + AWS DR) 

Welcome to my **Cloud Resume Challenge** project, inspired by [Forrest Brazeal's](https://cloudresumechallenge.dev/) initiative. This is a **work in progress** that demonstrates deploying a static resume website using **Azure** as the primary infrastructure, with **AWS** configured for disaster recovery (DR).

---

## Project Goals

- Treat this like a **real-world, production** cloud system — not just a portfolio
- Build a **multi-environment (dev, stage, prod)** and **multi-cloud** deployment
- Stay within a **$10/month** budget while maximizing value and realism
- Integrate **CI/CD**, modular Terraform, monitoring, and secure practices

---

## What I'm Hoping to Learn

- Real-world **cloud architecture design and constraints**
- Modular and DRY **Terraform** across multiple environments
- Building for **cost-efficiency and maintainability**
- Azure: Storage, Static Sites, RBAC, Pipelines, DNS
- AWS: Static backup storage and fallback routing for DR
- CI/CD with GitHub Actions for automatic validation/deploys
- Observability and security hardening

---

## Current Progress (by Phase)

| Phase                            | Status        | Notes                                                                |
|----------------------------------|---------------|----------------------------------------------------------------------|
| 1. Frontend static site          | 🟨 In Progress | HTML complete, resume embedded, pending styling & final assets       |
| 2. Azure Infra (Dev/Stage/Prod)  | ✅ Complete    | Multi-env setup with modular Terraform and tfvars                    |
| 3. DR Planning in AWS            | 🔜 Not Started | Will mirror static site with route failover and S3 backup            |
| 4. GitHub Actions CI/CD          | 🔜 Not Started | Plan to auto-deploy on merge per environment                         |
| 5. Cost Monitoring & Optimization| 🔜 Not Started | Will integrate Azure Cost Alerts and budget enforcement              |

---

## Architecture Diagram

![General-Manager-Diagaram drawio](https://github.com/user-attachments/assets/2945ab43-8740-4203-8627-fced4884bc30)

> _General layout of Azure frontend with future AWS DR_

## Project Structure

```text
infra/
├── environments/
│   ├── dev/
│   ├── stage/
│   └── prod/
├── modules/
│   └── storage_static_site/
├── shared/
└── aws-dr/               # DR resources in AWS
frontend/                 # Static frontend (HTML/CSS/JS)
diagram/                  # Architecture diagrams and notes
```  

---

Let me know:
- If there is anything else I should be considering, that I haven't yet
- This has actually ben a really fun project so far.

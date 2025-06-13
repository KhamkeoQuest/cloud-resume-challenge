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
| 1. Frontend static site          | ✅ Basic Setup | HTML complete, placeholder content in place; styling WIP             |
| 2. Azure Infra (Dev/Stage/Prod)  | ✅ Complete    | Deployed via modular Terraform; resources verified in Azure          |
| 3. DR Planning in AWS            | 🔜 Not Started | Will mirror static site with route failover and S3 backup            |
| 4. GitHub Actions CI/CD          | 🟨 In Progress | Infra CI for dev being developed; frontend deploy automation planned |
| 5. Cost Monitoring & Optimization| 🔜 Not Started | Budget enforced (~$10/mo); alerts and tracking to be added soon      |


---

## Architecture Diagram

![General-Manager-Diagaram drawio](https://github.com/user-attachments/assets/2945ab43-8740-4203-8627-fced4884bc30)

> _General layout of Azure frontend with future AWS DR_

## Project Structure

```text
repo-root/
├── .github/
│   └── workflows/
│       ├── backend-deploy.yml         <-- Cosmos-powered multi-env backend deploy
│       ├── frontend-deploy.yml        <-- Static website deploy
│       ├── terraform-dev.yml          <-- Terraform dev infra deploy
│       ├── terraform-stage.yml        <-- Terraform stage infra deploy
│       ├── terraform-prod.yml         <-- Terraform prod infra deploy
│       └── (optional) terraform-cloudflare.yml <-- DNS mgmt (if you're doing full SaaS DNS mgmt)
│
├── infra/
│   ├── shared/
│   │   ├── variables.tf
│   │   ├── providers.tf              <-- ✅ Now includes version pinning + subscription_id variable
│   │   └── location_normalizer/      <-- ✅ Location mapping helper module
│   │
│   ├── modules/
│   │   ├── resource_group/
│   │   ├── storage_account/          <-- For static website
│   │   ├── cosmosdb/                 <-- ✅ Cosmos DB Serverless module
│   │   ├── function_app/             <-- ✅ Function App module wired to Cosmos
│   │   └── (optional) dns/           <-- If you build full SaaS DNS mgmt
│   │
│   └── environments/
│       ├── dev/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── dev.tfvars            <-- ✅ Contains only: environment="dev" and subscription_id
│       │   └── backend.tf            <-- ✅ Hardcoded backend state config (acceptable for SaaS v1)
│       │
│       ├── stage/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── stage.tfvars
│       │   └── backend.tf
│       │
│       └── prod/
│           ├── main.tf
│           ├── variables.tf
│           ├── prod.tfvars
│           └── backend.tf
│
├── api/
│   └── visitor_counter/
│       ├── __init__.py               <-- Cosmos visitor counter function
│       ├── function.json
│       └── requirements.txt
│
└── frontend/
    ├── index.html
    └── (your other static website assets)
└── aws-dr/                   # DR resources in AWS
└── diagram/                  # Architecture diagrams and notes
```  

---

## Project decisions and other options

**Budget**
- like real world, most companies dont have unlimited funds and you'll have to make decision based on a set budget.  Shoot you might not even get a budget but a cut cost mandate.
- for the Project I've set a **$10/month** budget

**Terraform State Backend Architecture**
- Backend Alternatives (For Future Scaling)
| Option                                   | Pros                                                                   | Cons                                                             | Cost                                                 |
| ---------------------------------------- | ---------------------------------------------------------------------- | ---------------------------------------------------------------- | ---------------------------------------------------- |
| ✅ `azurerm` backend (current)            | Simple, native, cheap                                                  | Occasional stability quirks                                      | \~\$0.01/month                                       |
| ✅ Terraform Cloud                        | SaaS-managed, team collaboration, state drift detection, great locking | Additional cost (after free tier), SaaS dependency               | Free for personal orgs; Paid tiers \~\$20/user/month |
| ✅ Azure Managed Terraform (if available) | Fully Azure-native SaaS state                                          | Limited rollout, not always available for non-enterprise tenants | Same Azure Storage cost                              |
| ✅ Terragrunt / Atlantis                  | Full IaC orchestration, advanced workflows                             | Adds complexity, requires ops ownership                          | Mostly free (infra only)                             |

- When to consider upgrading backend
| Situation                                   | Consider Moving                          |
| ------------------------------------------- | ---------------------------------------- |
| Multiple engineers contributing             | Terraform Cloud SaaS                     |
| Frequent state lock conflicts               | Terraform Cloud or Azure Managed Backend |
| SaaS product scaling across multiple clouds | Terraform Cloud or orchestration layers  |
| Current backend generally stable            | Stay on `azurerm` backend                |


---

## Let me know
- If there is anything else I should be considering, that I haven't yet
- This has actually ben a really fun project so far.

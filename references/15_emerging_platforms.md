# Reference: Emerging & Modern PaaS Platforms (2026)

> Last research update: 2026-07-09
> Always verify pricing and limits at official docs.

---

## Official Source Targets

| Platform | Docs | Pricing / status |
|---|---|---|
| Northflank | https://northflank.com/docs | https://northflank.com/pricing |
| Zerops | https://docs.zerops.io | https://zerops.io/pricing |
| Sliplane | https://docs.sliplane.io | https://sliplane.io/pricing |
| Qovery | https://hub.qovery.com/docs | https://www.qovery.com/pricing |
| Bunnyshell | https://documentation.bunnyshell.com | https://www.bunnyshell.com/pricing |
| Tiiny Host | https://tiiny.host/help | https://tiiny.host/pricing |

---

## 1. Northflank

**Category:** Polyglot container PaaS / BYOC Kubernetes Engine  
**Website:** northflank.com  
**Best for:** Teams needing combined frontend, backend, managed databases, cron jobs, and optional GPU workloads or BYOC support.

### Pricing (2026)
Northflank bills based on raw compute consumption prorated to the second:

| Component / Tier | Price | Limits / Specs |
|---|---|---|
| **Developer Sandbox** | Free | 2 services, 1 database, 2 cron jobs (Requires card verification) |
| **Pay-as-you-grow Compute** | ~$2.70 / container / month | 0.1 vCPU, 256MB RAM base |
| **NVIDIA L4 GPU** | ~$0.80 / hour | 24GB VRAM |
| **Bandwidth (Egress)** | $0.10 / GB | First 100GB/month free |
| **BYOC Cluster Fee** | Flat monthly subscription | Plus standard cloud provider costs (AWS/GCP/Azure) |

### Capabilities
- **Multi-Cloud / BYOC:** Deploy the Northflank control plane on AWS (EKS), GCP (GKE), Azure (AKS), Civo, CoreWeave, or Oracle Cloud.
- **Managed Databases:** Automatic provisioning, scaling, and backups of PostgreSQL, MySQL, MongoDB, and Redis.
- **GPU Orchestration:** Direct integration for machine learning model serving, training, and AI agent workloads.
- **CI/CD & Ephemeral Environments:** Auto-deploys on Git commits; spins up full-stack preview environments (including isolated databases) per pull request.
- **Security:** Inherent network isolation, secrets mapping, RBAC, and audit log exporting.

### Limitations & Gotchas
- **Identity Verification:** The Free sandbox requires a credit card to prevent platform abuse.
- **BYOC Cost Overhead:** Running BYOC requires paying the Northflank flat control plane fee *plus* the raw instance charges billed by your cloud provider (e.g. AWS EKS base fee of ~$73/mo).

---

## 2. Zerops.io

**Category:** Developer-first platform (minute-based PaaS)  
**Website:** zerops.io  
**Best for:** Highly customized runtimes, managed complex databases, and strict cost-to-the-minute control.

### Pricing (2026)
Zero seat fees. Transparent, minute-based resource billing:

| Service Component | Price (per 30 days) | Billing Increment |
|---|---|---|
| **Lightweight Core** | Free | Base load balancer, 15 hrs build time, 100GB egress |
| **Serious Core (Prod)** | $10 | 150 hrs build time, 3TB egress, 25GB backup storage |
| **Shared CPU** | $0.60 / CPU | Billed per minute |
| **Dedicated CPU** | $6.00 / CPU | Billed per minute |
| **RAM** | $0.75 / 250MB | Billed per minute |

### Capabilities
- **Supported Runtimes:** Node.js, Python, Go, Rust, PHP, Java, .NET, Deno, Bun, Elixir, Gleam, Nginx.
- **Fully Managed Infrastructure Services:** Clickhouse, Kafka, NATS, Meilisearch, Elasticsearch, Typesense, Qdrant Vector DB, PostgreSQL, and MariaDB.
- **Custom Runtimes:** Deploys raw Linux containers or standard Docker images.
- **Customizable Build Pipeline:** Handled via a `zerops.yaml` file in the root repository.

### Limitations & Gotchas
- **Configuration Overhead:** Requires maintaining a detailed `zerops.yaml` file to define build/run pipelines.
- **Spend limits:** Ensure you set a "Daily Spending Limit" in the dashboard to avoid runaway minute-billing bills.

---

## 3. Sliplane.io

**Category:** Pay-per-server PaaS (Docker hosting)  
**Website:** sliplane.io  
**Best for:** Solo developers and small teams looking for fixed, predictable pricing without egress overages or autoscaling surprises.

### Pricing (2026)
Sliplane charges per-server, allowing you to deploy as many containers as fit onto the machine.

| Server Plan | Price (Monthly) | Hardware Specs |
|---|---|---|
| **Starter** | ~9.00 € | 1 vCPU, 1 GB RAM, NVMe Storage |
| **Base** | ~17.80 € | 2 vCPU, 2 GB RAM, NVMe Storage |
| **Medium** | ~28.80 € | 3 vCPU, 4 GB RAM, NVMe Storage |
| **Large** | ~45.00 € | 4 vCPU, 8 GB RAM, NVMe Storage |

### Capabilities
- **Docker Centric:** If your app runs in Docker, it runs on Sliplane.
- **GDPR Compliance:** Servers are located inside Germany and Finland, meeting strict EU privacy regulations.
- **Fair Use Egress:** Egress bandwidth is included in the flat server pricing tier (no overage bills).
- **Managed databases:** Built-in PostgreSQL setup and S3-compatible file storage.

### Limitations & Gotchas
- **No Autoscaling:** Scaling is vertical (upgrading the server tier). If memory limit is hit, containers will crash with OOM errors.
- **No Multi-region edge:** Geographically limited to European data centers.

---

## 4. Qovery

**Category:** Enterprise BYOC Orchestrator  
**Website:** qovery.com  
**Best for:** Mid-to-large size teams who want a Heroku-like developer experience on their own AWS/GCP accounts.

### Pricing (2026)
Qovery charges a subscription fee for its control plane. Raw infrastructure cost is paid directly to AWS/GCP.

| Plan | Price (Monthly) | Limits |
|---|---|---|
| **Team** | $899 | 10 users, 2 managed clusters, 100 environments |
| **Business** | $1,999 | 30 users, 3 managed clusters, 250 environments, SSO, 99.9% SLA |
| **Enterprise** | Custom | Unlimited users and clusters |

### Capabilities
- **Complete BYOC:** Deploys EKS/GKE clusters inside your AWS/GCP VPCs automatically.
- **Environment Cloning:** Clones production database and microservice configurations to isolated preview branches.
- **Zero Lock-in:** If Qovery is disconnected, the generated Kubernetes configurations and running servers remain fully functional inside your cloud account.

---

## 5. Bunnyshell

**Category:** Ephemeral Environment-as-a-Service (EaaS)  
**Website:** bunnyshell.com  
**Best for:** Sales demo environments, QA testing, and ephemeral staging pipelines.

### Pricing (2026)
- **Startup Plan (Pay-as-you-go):** **$0.007 per minute** per active environment.
- **Billing Rule:** Billed only when the environment is active; charges stop when environment is stopped.
- **14-day Free Trial:** Full feature access, no credit card required.

### Capabilities
- **Environment Cloning:** Automatic generation of production-like staging systems on every GitHub Pull Request.
- **Kubernetes Integration:** Direct visualization of pods, events, and manifests in the Bunnyshell UI.
- **Broad Stack Support:** Deploys via Docker Compose, Helm, Terraform, or standard Kubernetes manifests.

---

## 6. Tiiny Host

**Category:** Static Prototyping Host  
**Website:** tiiny.host  
**Best for:** Instantly uploading static sites, slide decks, PDFs, or prototype files for quick sharing.

### Pricing (2026)
- **Free:** 1 active site, tiiny.site subdomain, 3MB file size limit.
- **Pro ($18/mo):** 5 active sites, custom domains, password protection, edit files online.

### Capabilities
- Drag-and-drop ZIP file, HTML file, or PDF files.
- Integration API for programmatic uploads.

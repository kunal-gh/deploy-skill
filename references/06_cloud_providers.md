# Reference: Major Cloud Providers (AWS, GCP, Azure, DO, Hetzner) (2026)

> Last research update: 2026-07-09
> Cloud pricing is complex. Always check the official pricing calculator for estimates.

---

## Official Source Targets

| Provider | Docs | Pricing calculator / status |
|---|---|---|
| AWS | https://docs.aws.amazon.com | https://calculator.aws |
| Google Cloud | https://cloud.google.com/docs | https://cloud.google.com/products/calculator |
| Azure | https://learn.microsoft.com/azure | https://azure.microsoft.com/pricing/calculator |
| DigitalOcean | https://docs.digitalocean.com | https://www.digitalocean.com/pricing |
| Hetzner Cloud | https://docs.hetzner.com/cloud | https://www.hetzner.com/cloud |
| Vultr | https://docs.vultr.com | https://www.vultr.com/pricing |
| Akamai/Linode | https://techdocs.akamai.com/cloud-computing | https://www.linode.com/pricing |
| Oracle Cloud | https://docs.oracle.com/en-us/iaas | https://www.oracle.com/cloud/free |

---

## Overview: Hyperscalers vs Developer-Friendly Clouds

| Category | Providers | Audience |
|----------|-----------|---------|
| Hyperscalers | AWS, GCP, Azure | Enterprise, large-scale, complex architectures |
| Developer-Friendly VPS | DigitalOcean, Linode/Akamai, Vultr, Hetzner | Startups, developers, cost-conscious teams |
| Ultra-Affordable | Hetzner, Contabo, Netcup, Oracle Cloud | Budget-maximizers, EU-hosted |
| Specialty | Scaleway (EU), OVHcloud (EU), Alibaba Cloud (Asia) | Regional-specific |

**General Rule:**
- AWS/GCP/Azure: Most features, highest complexity, highest cost, best compliance support
- DigitalOcean/Vultr: Middle ground — managed services + simplicity + reasonable cost
- Hetzner: Best raw price-to-performance (especially EU), minimal managed services

---

## SECTION A: Amazon Web Services (AWS)

**Market leader — 33% cloud market share in 2026**

### Key Deployment Services

| Service | What it is | Starting Price |
|---------|-----------|---------------|
| EC2 | Virtual machines (full control) | $0.0042/hr (t4g.nano) |
| Lightsail | Simple VPS (Heroku-like) | $3.50/month (1GB RAM) |
| ECS Fargate | Managed containers (no K8s) | $0.04048/vCPU-hr + RAM |
| EKS | Managed Kubernetes | $0.10/hr cluster + EC2 costs |
| Lambda | Serverless functions | 1M free req/month, then $0.20/million |
| App Runner | Auto-scaling container (simplest) | $0.064/vCPU-hr active |
| Amplify | Full-stack frontend hosting | 15GB bandwidth free/mo |
| Elastic Beanstalk | PaaS on EC2 (legacy) | EC2 costs only |
| S3 | Object storage | $0.023/GB + egress |
| CloudFront | CDN | 1TB free/month |
| RDS | Managed relational DB (Postgres/MySQL/etc.) | $0.016/hr (db.t4g.micro) |
| Aurora Serverless v2 | Serverless relational DB | $0.12/ACU-hour |
| DynamoDB | NoSQL | 25GB free, then $0.25/million reads |

### AWS Compute Tiers for Web Apps

**Simple apps (team < 5, budget-conscious):**
→ Lightsail ($3.50–$160/month) — fixed pricing, VPS-like experience

**Scalable containerized apps:**
→ ECS Fargate — no EC2 management, scale to zero possible

**Kubernetes-native teams:**
→ EKS — most powerful, highest operational overhead

**Serverless / event-driven:**
→ Lambda + API Gateway — pay only for execution

**Fastest path (managed, less config than ECS):**
→ App Runner — deploy container from ECR, auto-scales, no cluster management

### AWS Free Tier (12 months + always-free)
| Service | Free Amount |
|---------|-------------|
| EC2 | 750 hrs/month t2.micro |
| S3 | 5GB storage |
| RDS | 750 hrs db.t2.micro |
| Lambda | 1M requests/month (always free) |
| DynamoDB | 25GB (always free) |
| CloudFront | 1TB bandwidth/month |
| SES | 62K emails/month |

### AWS Gotchas
- **Egress costs are massive** ($0.09/GB out to internet) — bills can spike unexpectedly
- IAM permissions are complex and error-prone
- The AWS console is overwhelming for beginners
- Many services billed separately (API Gateway + Lambda + DynamoDB = 3 separate bills)
- Reserved instances required for ~30-40% savings at steady-state

---

## SECTION B: Google Cloud Platform (GCP)

**#3 hyperscaler — strong in data, AI/ML, and Kubernetes**

### Key Deployment Services

| Service | What it is | Starting Price |
|---------|-----------|---------------|
| Cloud Run | Serverless containers, scale-to-zero | 2M req free/month |
| GKE | Managed Kubernetes | $0.10/hr cluster + node costs |
| Compute Engine | VMs | $0.006/hr (e2-micro, always-free) |
| App Engine | PaaS (managed runtimes) | Usage-based |
| Cloud Functions | Serverless functions | 2M req free/month |
| Firebase Hosting | Static hosting | Usage-based |
| Cloud SQL | Managed PostgreSQL/MySQL | $0.0105/hr (db-f1-micro) |
| Firestore | NoSQL | 1GB free |
| Cloud Storage | Object storage | $0.020/GB (Standard) |
| Cloud CDN | CDN | $0.08/GB |
| Vertex AI | AI/ML platform | Usage-based |

### Cloud Run — GCP's Best Service for Most Developers

**Why Cloud Run is excellent:**
- Deploy any Docker container in seconds
- Scales to zero (pay nothing when idle)
- Scales to hundreds of instances automatically
- Built-in HTTPS, load balancing, custom domains
- Concurrency: Each instance handles multiple requests simultaneously (unlike Lambda)
- CPU always allocated (option added 2024) — for background tasks
- Minimum instances: Set >0 to eliminate cold starts
- Global HTTP load balancing (multi-region deployments)

| Cloud Run Free Tier | Amount |
|--------------------|--------|
| CPU | 180K vCPU-seconds/month |
| Memory | 360K GB-seconds/month |
| Requests | 2M requests/month |

### GCP Always Free Tier
| Service | Free Amount |
|---------|-------------|
| Compute Engine (e2-micro) | 1 instance in US region |
| Cloud Storage | 5GB US regional |
| Cloud Functions | 2M invocations/month |
| Cloud Run | 2M requests/month |
| Firestore | 1GB storage, 50K reads/day |
| BigQuery | 1TB queries/month (great for analytics) |

### GCP Gotchas
- Fewer services than AWS (but growing)
- Egress costs present (but slightly lower than AWS)
- GCP services have historically been deprecated more than AWS
- GKE Autopilot is excellent but can be more expensive than standard GKE

---

## SECTION C: Microsoft Azure

**#2 hyperscaler — dominant in enterprise, Microsoft ecosystem**

### Key Deployment Services

| Service | What it is | Starting Price |
|---------|-----------|---------------|
| App Service | PaaS for web apps | $0 (Free tier, F1) |
| Container Apps | Serverless containers | 180K vCPU-seconds free |
| AKS | Managed Kubernetes | $0 (pay only for nodes) |
| Azure Functions | Serverless functions | 1M executions free |
| Static Web Apps | Static hosting + APIs | Free tier available |
| Container Instances | Simple container hosting | $0.000014/vCPU-second |
| CosmosDB | Global NoSQL | 1000 RU/s + 25GB free |
| Azure SQL | Managed SQL Server | $5/month (serverless) |
| Blob Storage | Object storage | $0.018/GB |
| Azure CDN | CDN | $0.087/GB |

### Azure App Service Plans
| Plan | Price | Resources |
|------|-------|-----------|
| Free (F1) | $0 | 1GB RAM, 60min/day CPU |
| Basic (B1) | $13.14/month | 1.75GB RAM, 1 core |
| Standard (S1) | $73/month | 1.75GB RAM, 1 core, autoscale |
| Premium v3 (P1mv3) | $82/month | 4GB RAM, 2 vCPU |

### Azure Container Apps (Best for Microservices)
- Built on Kubernetes + KEDA (event-driven autoscaling)
- Dapr integration for microservice patterns
- Scale to zero
- Free: 180K vCPU-seconds/month, 360K GB-seconds/month
- Best for: Event-driven microservices in Azure ecosystem

### Azure Strengths
- **Microsoft ecosystem:** .NET, Active Directory, Office 365 integration
- **Hybrid cloud:** Azure Arc for on-premises + cloud
- **Enterprise compliance:** 90+ compliance certifications
- **GitHub integration:** GitHub Actions + Azure for seamless CI/CD

---

## SECTION D: DigitalOcean

**Best developer-friendly cloud with managed services**

### Products Overview

| Product | Starting Price | Notes |
|---------|---------------|-------|
| Droplets (VPS) | $4/month | 512MB RAM, 10GB SSD |
| App Platform | $3/month | PaaS, static sites free |
| Managed Kubernetes (DOKS) | $12/month (1 node) | |
| Managed PostgreSQL | $15/month | 1GB RAM, 10GB storage |
| Managed MySQL | $15/month | |
| Managed MongoDB | $15/month | |
| Managed Redis | $15/month | |
| Spaces (S3-compatible) | $21/month (250GB) | Includes 1TB CDN |
| Load Balancers | $12/month | |

### Droplet Pricing (VPS)
| Plan | RAM | CPU | SSD | Price |
|------|-----|-----|-----|-------|
| Basic | 512MB | 1 vCPU | 10GB | $4/mo |
| Basic | 1GB | 1 vCPU | 25GB | $6/mo |
| Basic | 2GB | 1 vCPU | 50GB | $12/mo |
| General Purpose | 8GB | 2 vCPU | 50GB | $63/mo |

### App Platform (PaaS)
| Tier | Price | Notes |
|------|-------|-------|
| Static Sites | Free | |
| Basic (0.5 vCPU, 512MB) | $3/month | Sleeps after inactivity |
| Professional (1 vCPU, 1GB) | $12/month | Always-on |
| Pro (4 vCPU, 8GB) | $85/month | High performance |

### DigitalOcean Strengths
- Best documentation + tutorials of any cloud provider
- Simple, predictable pricing (no surprise bills)
- All-in-one managed ecosystem (DB + K8s + Spaces + CDN)
- $200 free credit for new users
- Great developer experience

### DigitalOcean Gotchas
- Fewer regions than AWS/GCP (15 regions in 2026)
- More expensive than Hetzner for raw compute
- Less capable than AWS/GCP for enterprise-scale

---

## SECTION E: Hetzner Cloud

**Best price-to-performance, especially in Europe**

### VPS Pricing (2026 — after April price update)
| Instance | vCPU | RAM | Storage | Price/mo |
|----------|------|-----|---------|----------|
| CX22 | 2 (shared) | 4GB | 40GB NVMe | ~$4.50 |
| CX32 | 4 (shared) | 8GB | 80GB NVMe | ~$8.50 |
| CX42 | 8 (shared) | 16GB | 160GB NVMe | ~$17 |
| CCX13 | 2 (dedicated) | 8GB | 80GB NVMe | ~$15 |
| CCX23 | 4 (dedicated) | 16GB | 160GB NVMe | ~$28 |

**Bandwidth:** 20TB/month included with most servers (vs AWS/DigitalOcean charging per GB)

### Hetzner Strengths
- **Cheapest serious cloud provider** by far for EU workloads
- NVMe SSDs across the board
- Generous bandwidth (20TB free egress)
- Helsinki, Nuremberg, Falkenstein (Germany) data centers
- US East/West added recently
- IPv6 free, IPv4 available
- Simple block storage add-on

### Hetzner Weaknesses
- **Very limited managed services** — no managed DBs, Kubernetes is basic (Hetzner K8s works but less polished than DOKS/GKE)
- Smaller global footprint than DigitalOcean
- Less polished UI/UX than DigitalOcean
- No native App Platform equivalent

### Ideal Hetzner Stack
```
VPS: Hetzner CX32 (4 vCPU, 8GB = ~$8.50/mo)
Self-hosted PaaS: Coolify or Dokploy
Database: PostgreSQL (self-managed on same server or Supabase for managed)
Object Storage: Hetzner Object Storage or Cloudflare R2
CDN: Cloudflare free CDN in front of Hetzner
CI/CD: GitHub Actions

Total cost: ~$8.50–$20/month for a complete production stack
```

---

## SECTION F: Other VPS/Cloud Providers

### Vultr
| Plan | RAM | CPU | Storage | Price |
|------|-----|-----|---------|-------|
| Cloud Compute | 512MB | 1 vCPU | 10GB SSD | $2.50/mo |
| High Performance | 1GB | 1 vCPU | 25GB NVMe | $6/mo |
| Bare Metal | Varies | Varies | Varies | From $120/mo |

**Strengths:** 32+ global regions, bare metal, GPU instances, hourly billing
**Weaknesses:** More expensive than Hetzner for EU, less curated than DigitalOcean

---

### Linode (now Akamai Cloud)
- Acquired by Akamai in 2022
- 11+ data centers
- $5/month for 1GB RAM VPS
- Good CDN integration via Akamai network
- Kubernetes service: LKE

---

### Oracle Cloud Free Tier (Always Free — Exceptional Value)
**The most generous always-free cloud tier in existence:**

| Resource | Always Free Amount |
|----------|------------------|
| Compute (ARM) | 4 OCPU + 24GB RAM (Ampere A1) |
| Compute (AMD) | 2x AMD VMs (1 OCPU, 1GB RAM each) |
| Block Storage | 200GB |
| Object Storage | 20GB |
| Load Balancer | 1x 10Mbps |
| Database | 2x Autonomous DB (20GB each) |
| Monitoring | 500M metrics |
| Outbound Bandwidth | 10TB/month |

**Note:** ARM instances are very capable — run Docker containers, host databases, everything.
Oracle requires a credit card but does NOT charge anything for Always Free resources.
**Gotcha:** Oracle Cloud UI is complex, and their paid services are expensive.

---

## Cloud Provider Decision Matrix

| Need | Best Choice | Why |
|------|-------------|-----|
| Absolute cheapest EU hosting | Hetzner | 4x cheaper than DigitalOcean per vCPU |
| Best developer experience | DigitalOcean | Best docs, clean UI, all-in-one |
| Simplest serverless containers | GCP Cloud Run | Scale-to-zero, fastest path |
| Enterprise AWS workloads | AWS ECS Fargate | Deepest ecosystem |
| Microsoft/.NET enterprise | Azure App Service | Best .NET support |
| Free always-on server (ARM) | Oracle Cloud | 4 OCPU + 24GB free forever |
| Multi-region low-latency | Cloudflare Workers | 300+ edge locations |
| Maximum managed services | AWS | Most services of any cloud |

---

## Cost Reality Check (Same App Deployed Everywhere)

**Example:** Simple Node.js API + PostgreSQL + 100GB bandwidth/month

| Platform | Monthly Cost |
|----------|-------------|
| Hetzner (CX22 + self-managed PG) | ~$4.50 |
| DigitalOcean (1GB Droplet + Managed PG) | $6 + $15 = $21 |
| Railway (usage-based) | ~$10–$20 |
| Render (Starter + PostgreSQL) | $7 + $7 = $14 |
| GCP Cloud Run + Cloud SQL | ~$7–$15 |
| AWS Lightsail (1GB + MySQL) | $3.50 + $15 = $18.50 |
| AWS EC2+RDS (t3.micro + t3.micro) | ~$10 + $15 = $25 |

**Verdict:** Hetzner wins on raw cost. DigitalOcean wins on DX+managed services.

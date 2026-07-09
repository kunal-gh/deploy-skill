# Reference: Backend, Container & PaaS Deployment Platforms (2026)

> Last research update: 2026-07-09
> Always verify pricing at official pages before quoting to users.

---

## Official Source Targets

| Platform | Docs | Pricing / limits |
|---|---|---|
| Railway | https://docs.railway.com | https://railway.com/pricing |
| Fly.io | https://fly.io/docs | https://fly.io/docs/about/pricing |
| Render | https://docs.render.com | https://render.com/pricing |
| Heroku | https://devcenter.heroku.com | https://www.heroku.com/pricing |
| Northflank | https://northflank.com/docs | https://northflank.com/pricing |
| Koyeb | https://www.koyeb.com/docs | https://www.koyeb.com/pricing |
| Zerops | https://docs.zerops.io | https://zerops.io/pricing |
| Sliplane | https://docs.sliplane.io | https://sliplane.io/pricing |
| Qovery | https://hub.qovery.com/docs | https://www.qovery.com/pricing |
| Bunnyshell | https://documentation.bunnyshell.com | https://www.bunnyshell.com/pricing |

---

## Platform Categories

1. **Managed PaaS** — Heroku-style, abstract away servers (Railway, Render, Koyeb, Heroku)
2. **Container PaaS** — Deploy Docker containers with more control (Fly.io, Northflank, Zerops)
3. **BYOC Platforms** — Deploy to your own cloud account (Qovery, Flightcontrol, Porter, Northflank)
4. **BaaS** — Backend-as-a-Service, built-in auth/storage/DB (Supabase, Appwrite, PocketBase)
5. **Self-Hosted PaaS** — Run your own platform on a VPS (Coolify, Dokploy, CapRover, Dokku)
6. **Enterprise K8s Platforms** — Full Kubernetes orchestration (Bunnyshell, Northflank, Qovery)

---

## 1. Railway

**Category:** Managed PaaS (container-based)  
**Website:** railway.app  
**Best for:** Rapid iteration, great DX, startups, solo devs

### What it is
Railway is consistently rated #1 for developer experience in 2026. It deploys Docker
containers or buildpack-based apps from Git. Known for its beautiful dashboard and
fast deployment workflow.

### Pricing (2026)
| Tier | Price | Key Limits |
|------|-------|-----------|
| Trial | Free (one-time $5 credit) | No recurring free tier |
| Hobby | $5/month base + usage | $5 of usage included, then per-second metering |
| Pro | $20/month base + usage | $20 of usage included, per-second metering |
| Enterprise | Custom | BYOC available |

**Usage pricing (Hobby + Pro):**
- vCPU: $0.000463/vCPU-minute
- RAM: $0.000231/GB-minute
- Storage: $0.000321/GB-month
- Egress: $0.10/GB (after 100GB free on Pro)

**Key insight:** Railway has NO permanent free tier (as of 2026). New users get a $5 trial credit.

### Capabilities
- **Languages/Runtimes:** Any (via Docker or Nixpacks auto-detection)
- **Supported frameworks:** Node.js, Python, Go, Rust, Ruby, PHP, Java, .NET — auto-detected
- **Databases built-in:** PostgreSQL, MySQL, Redis, MongoDB (one-click)
- **Scaling:** Manual scaling + auto-scaling on Pro
- **Private networking:** Yes, internal service networking
- **Custom domains:** Yes, free SSL
- **CI/CD:** GitHub integration, automatic deploys
- **Preview environments:** Via environment system (not per-PR auto, requires setup)
- **Regions:** US West, US East, EU West (more planned)
- **Cron jobs:** Built-in cron job support
- **Volume storage:** Persistent volumes supported
- **MCP Server:** Available for AI agent integration (Claude Code, etc.)
- **Monorepo support:** Yes

### Key Limitations
- No true free tier (only trial credit)
- Preview environments require manual setup vs Vercel/Netlify auto-PR previews
- Per-second billing can be unpredictable for teams new to usage-based pricing
- BYOC only on Enterprise plan (expensive)
- Limited region choice vs Fly.io
- No built-in GPU support

### Best For
- Node.js/Python/Go/Rust APIs with PostgreSQL
- Full-stack apps that need both frontend + backend + database
- Rapid prototyping and MVP development
- Teams who prioritize beautiful DX over cost optimization
- AI-assisted development workflows (MCP server support)

### NOT Suitable For
- Budget-zero projects (no free tier)
- Compliance/BYOC requirements (Enterprise only)
- Multi-region global edge deployments

---

## 2. Fly.io

**Category:** Container PaaS (Micro-VM based, edge)  
**Website:** fly.io  
**Best for:** Low-latency apps, global edge deployment, experienced developers

### What it is
Fly.io runs Docker containers as lightweight Firecracker microVMs. Unique in that
it deploys your app physically close to users across 30+ regions simultaneously.
More infrastructure-oriented than Railway.

### Pricing (2026)
**Pure pay-as-you-go, no base fee:**
- Shared CPU VM: $0.0001022/second (~$8.79/mo for 256MB always-on)
- Dedicated CPU: $0.0002612/second (~$22.55/mo for 2GB)
- Storage: $0.15/GB/month
- Bandwidth: Free up to 160GB/month, then $0.02/GB
- Postgres: Managed via Fly Postgres (self-managed on their infra)
- Redis: Via Upstash integration

**No free tier for new accounts** (legacy free machines removed)

### Capabilities
- **Runtimes:** Any Docker container
- **Regions:** 30+ regions globally (best geographic spread of any PaaS)
- **Networking:** Each machine gets dedicated IPv6, shared IPv4
- **Private networking:** WireGuard-based private networking between apps
- **Persistent storage:** Fly Volumes (1GB minimum)
- **Scaling:** Scale to zero (if configured), horizontal scaling
- **Postgres:** Fly Postgres (managed by Fly, but you manage upgrades)
- **GPU:** GPU machines available (A10, L40S, A100)
- **Health checks:** TCP and HTTP health checks
- **Custom domains:** Yes
- **CI/CD:** flyctl, GitHub Actions integration

### Key Limitations
- **No true preview environments** — Must build your own tooling
- **No managed database** (Fly Postgres is self-managed — you own upgrades/backups)
- **Higher operational complexity** than Railway/Render
- **No BYOC** — Fly.io managed infrastructure only
- **Networking complexity** — WireGuard private networking requires knowledge

### Best For
- **Global, low-latency APIs** (multi-region is Fly's superpower)
- Real-time apps needing physical proximity to users worldwide
- Rails, Laravel, Django, Node.js apps with global user base
- Developers comfortable with infrastructure
- GPU workloads (available A10, L40S, A100)

### NOT Suitable For
- Teams wanting managed databases (use Neon or Supabase instead)
- Developers wanting simple "it just works" PaaS
- Preview environment heavy workflows

---

## 3. Render

**Category:** Managed PaaS  
**Website:** render.com  
**Best for:** Predictable pricing, simple Heroku replacement

### What it is
Render is the closest thing to a "modern Heroku." Simple, predictable fixed-price
tiers for web services. Great for teams that want to know exactly what they'll pay.

### Pricing (2026)
| Service Type | Free Tier | Starter Paid |
|-------------|-----------|--------------|
| Web Services | Yes (sleeps after 15 min) | $7/month |
| Static Sites | Yes (unlimited) | N/A |
| Background Workers | No free | $7/month |
| Cron Jobs | No free | $1/month |
| PostgreSQL | Yes (90-day trial, 1GB) | $7/month |
| Redis | No free | $10/month |

**Key:** Paid web services start at $7/month (512MB RAM, 0.5 CPU shared). Scales to $85/month (4GB RAM, 2 CPU dedicated).

### Capabilities
- **Runtimes:** Docker or buildpacks (Node.js, Python, Ruby, Go, Rust, Elixir, PHP)
- **Databases:** Managed PostgreSQL + Redis (native)
- **Scaling:** Autoscaling on paid plans
- **Private networking:** Internal services on same account
- **Persistent disk:** Available on paid plans
- **Custom domains:** Yes, free SSL
- **CI/CD:** GitHub + GitLab integration
- **Preview environments:** Per-PR preview environments (paid plans)
- **Cron jobs:** Built-in
- **Regions:** US Oregon, US Ohio, EU Frankfurt, Singapore (2026)
- **Build cache:** Layer caching for Docker builds

### Key Limitations
- **Free tier sleeps** after 15 minutes of inactivity (cold start ~30–60 seconds)
- No Kubernetes support
- No BYOC
- PostgreSQL free tier is only a 90-day trial
- Limited region choice

### Best For
- Full-stack apps with predictable billing
- Teams moving off Heroku (very similar workflow)
- PostgreSQL-based applications
- Background workers + cron jobs

### NOT Suitable For
- Multi-region global apps
- Large-scale enterprise
- Compliance/BYOC requirements

---

## 4. Heroku

**Category:** Legacy Managed PaaS  
**Website:** heroku.com  
**Best for:** Existing Heroku users, mature Ruby/Node.js applications

### Status (2026)
Heroku removed its free tier in 2022. In early 2026, Heroku's parent (Salesforce)
moved it to a "sustaining engineering" model — essentially maintenance mode.
Many teams have migrated to Railway, Render, or Fly.io.

### Pricing (2026)
- Basic Dyno: $7/month (512MB RAM)
- Standard-1X: $25/month (512MB RAM)
- Performance-M: $250/month (2.5GB RAM)
- Eco Dynos: $5/month for 1000 dyno hours

### Key Facts
- Multi-language via buildpacks
- Mature add-on ecosystem (databases, caching, monitoring)
- Git push workflow
- Review Apps for PR previews (paid plans)
- No Kubernetes, no BYOC
- Salesforce-owned infrastructure

### Recommendation
**For new projects: Use Railway, Render, or Fly.io instead.**
For existing Heroku apps: Consider migrating. Heroku is stable but not evolving.

---

## 5. Northflank

**Category:** Enterprise Container PaaS + BYOC  
**Website:** northflank.com  
**Best for:** Enterprise teams, full-stack + BYOC + GPU + managed DBs

### What it is
Northflank is a full-featured developer platform with CI/CD, managed databases,
preview environments, GPU workloads, and BYOC across 5 cloud providers.
It's positioned between Railway (simple) and AWS (complex).

### Pricing (2026)
- **Sandbox:** Free (for testing, limited resources)
- **Developer:** $10/month
- **Production:** Pay-as-you-go for compute + storage
- **Enterprise:** Custom (BYOC, SLA, SSO)
- BYOC available across: AWS, GCP, Azure, Oracle, Civo, CoreWeave

### Capabilities
- Any Docker container deployment
- Managed databases: PostgreSQL, MySQL, MongoDB, Redis
- GPU workloads: H100, B200, A100 (via CoreWeave integration)
- Preview environments including databases and microservices
- Secure sandboxes and microVMs
- RBAC, secrets management, audit logging
- 99.99% historical uptime SLA (enterprise)

### Best For
- Teams needing full-stack + BYOC from one platform
- GPU/AI workloads alongside web services
- Enterprise with data residency requirements
- Complex microservices with preview environments

---

## 6. Koyeb

**Category:** Managed Container PaaS (global)  
**Website:** koyeb.com  
**Best for:** Simple container deployments, free tier for hobby projects

### Pricing (2026)
- **Free tier:** 1 instance (512MB RAM, 0.1 vCPU), 0 sleep (always on!)
- **Paid:** Nano ($2.90/mo for 512MB), Micro ($5.16/mo for 1GB), up to Standard ($41.28/mo for 8GB)

### Key Facts
- Always-on free tier (unlike Render which sleeps)
- Deploy from Git or Docker Hub
- 3 regions: Washington DC, Frankfurt, Singapore
- PostgreSQL managed add-on available
- CI/CD via GitHub integration
- No persistent volumes on free tier

### Best For
- Hobby projects needing always-on free tier
- Simple APIs and microservices
- Teams wanting EU hosting (Frankfurt)

---

## 7. Zerops

**Category:** Managed Container PaaS  
**Website:** zerops.io  
**Best for:** Full-stack applications, affordable pricing

### Pricing (2026)
- Core Plan: $6/month for dev projects
- Usage-based for production

### Key Facts
- Import from Docker Compose
- Built-in CI/CD
- Managed services: PostgreSQL, MySQL, MariaDB, MongoDB, Redis, RabbitMQ, Elasticsearch, S3-compatible storage
- Static file hosting
- Very competitive pricing
- Less known but growing community

---

## 8. Sliplane

**Category:** Simple Container Hosting  
**Website:** sliplane.io  
**Best for:** Simple Docker deployments with minimal config

### Key Facts
- Deploy any Docker container
- SSL + custom domains
- Very simple dashboard
- Based in EU (GDPR-friendly)
- Affordable pricing

---

## 9. Qovery

**Category:** BYOC Kubernetes PaaS  
**Website:** qovery.com  
**Best for:** Teams wanting Vercel-DX on their own AWS/GCP/Azure

### What it is
Qovery provides Kubernetes-backed deployments to your own cloud account.
"Heroku DX meets your own cloud." SOC 2 and HIPAA compliant.

### Pricing (2026)
- **Free tier:** Available for testing
- **Teams:** $299/month/organization + cloud costs
- Very expensive per-seat model

### Capabilities
- BYOC: AWS, GCP, Azure
- Ephemeral environments (auto-sleep)
- AI Copilot with 5 agents (deploy, observe, optimize, secure, provision)
- SOC 2, HIPAA compliance
- Kubernetes-backed with auto-scaling

### Key Limitations
- $299/month minimum is expensive for small teams
- No Docker Compose support (Kubernetes only)
- Per-seat pricing model

---

## 10. Bunnyshell

**Category:** Kubernetes Environment-as-a-Service  
**Website:** bunnyshell.com  
**Best for:** Complex Kubernetes preview environments, enterprise DevOps

### Pricing
- Pay-per-minute: $0.007/min for active environments
- Sleeping environments: $0 (auto-sleep support)

### Key Facts
- Full-stack preview environments per PR (including databases)
- BYOC on your own Kubernetes clusters
- Docker Compose + Helm + Terraform support
- AI Sandboxes via Firecracker isolation
- DORA metrics built-in
- MCP Server for AI agent integration
- Remote development with IDE sync

### Best For
- Enterprise teams with 60+ microservices
- Teams needing production-like PR preview environments
- Organizations already running Kubernetes

---

## 11. Emerging BYOC Platforms (2026)

### Flightcontrol
- "Heroku on AWS" — Deploy to your own AWS account via beautiful dashboard
- Best for: Teams wanting AWS reliability with PaaS simplicity
- Under the hood: ECS/Fargate + RDS
- Pricing: Platform fee + your AWS costs

### Porter
- Kubernetes PaaS on your own AWS/GCP/Azure
- More complex than Flightcontrol but more flexible
- Good for compliance-heavy environments
- Pricing: Platform fee + your cloud costs

### Encore
- Infrastructure-from-code platform for Go + TypeScript
- Define databases, queues, caches IN your application code
- Encore provisions actual AWS/GCP resources
- Best for: AI-assisted development workflows, microservices
- Unique: Works with Claude Code, Cursor natively

### Zeabur
- AI-powered zero-config PaaS
- `zbpack` auto-detects framework and builds
- AI agent can execute infrastructure actions via natural language
- Good for rapid deployment of standard stacks
- Pricing: Usage-based

---

## 12. BaaS (Backend as a Service)

### Supabase
**The dominant open-source Firebase alternative.**

| Tier | Price | Key Limits |
|------|-------|-----------|
| Free | $0 | 500MB DB, 5GB bandwidth, 50MB file storage, 50K MAU auth |
| Pro | $25/month | 8GB DB, 250GB bandwidth, 100GB storage, unlimited auth |
| Team | $599/month | SOC 2, HIPAA, advanced features |

Features:
- PostgreSQL database (fully managed)
- Real-time subscriptions
- Authentication (email, social, phone, SAML)
- Storage (S3-compatible, image transforms)
- Edge Functions (Deno-based)
- Vector/AI: pgvector built-in
- Dashboard + SQL editor
- Self-hostable (Docker Compose)

**Best for:** Mobile apps, SaaS apps, projects needing auth + DB + storage in one

### Appwrite

| Tier | Price | Key Limits |
|------|-------|-----------|
| Free | $0 | Unlimited projects, 10GB storage, 10K executions |
| Pro | $15/month | 100GB storage, unlimited executions, custom domains |

Features:
- Databases (NoSQL document model)
- Authentication (30+ providers)
- Storage
- Functions (Node.js, Python, PHP, Dart, Ruby, etc.)
- Real-time
- Self-hostable

**Best for:** Mobile/web app backend, teams wanting Firebase alternative with more control

### PocketBase
- Single binary backend (Go)
- SQLite database
- Authentication, file storage, real-time subscriptions
- Deploy on any $5 VPS
- No managed cloud version — self-hosted only
- Best for: Solo devs wanting simple self-hosted backend

### Nhost
- Hasura (GraphQL) + PostgreSQL + Storage + Auth
- Free tier available
- Best for: GraphQL-heavy apps needing instant API from PostgreSQL schema

---

## Platform Comparison Matrix

| Platform | Free Tier | Best For | BYOC | Managed DB | Docker | K8s |
|----------|-----------|----------|------|-----------|--------|-----|
| Railway | Trial only | Best DX, rapid dev | Enterprise | Yes (built-in) | Yes | No |
| Fly.io | No | Global edge, low-latency | No | Self-managed | Yes | No |
| Render | Yes (sleeps) | Predictable pricing | No | Yes (built-in) | Yes | No |
| Heroku | No | Legacy Ruby/Node | No | Via add-ons | No | No |
| Northflank | Sandbox | Enterprise, GPU | Yes | Yes (built-in) | Yes | Yes |
| Koyeb | Yes (always-on) | Simple containers | No | Add-on | Yes | No |
| Zerops | Limited | Full-stack affordable | No | Yes | Yes | No |
| Qovery | Yes | BYOC Kubernetes PaaS | Yes | Yes | Yes | Yes |
| Bunnyshell | Trial | Enterprise K8s envs | Yes | Yes | Yes | Yes |
| Supabase | Yes | Mobile/SaaS backend | Self-host | PostgreSQL | - | - |
| Appwrite | Yes | Mobile backend | Self-host | NoSQL | - | - |
| Flightcontrol | No | AWS simplification | AWS only | Via AWS | Yes | No |
| Encore | Free | Distributed systems | AWS/GCP | Via code | Yes | No |

---

## Decision Guide

**"I need a backend for my SaaS app"**
→ Railway (best DX, has PostgreSQL, Redis built-in)
→ Render (if you need predictable fixed pricing)
→ Supabase (if you also need auth + storage)

**"I need global low-latency"**
→ Fly.io (30+ regions, run code close to users)

**"I need enterprise grade with compliance"**
→ Northflank (BYOC, SLA, GPU, managed DBs)
→ Qovery (BYOC, SOC2, HIPAA, Kubernetes)

**"I want self-hosted with a nice UI"**
→ See references/07_self_hosted.md

**"I need instant backend without writing server code"**
→ Supabase (most complete BaaS)
→ Appwrite (more self-hosting friendly)
→ PocketBase (single binary, deploy anywhere)

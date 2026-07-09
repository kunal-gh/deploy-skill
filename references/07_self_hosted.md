# Reference: Self-Hosted Deployment Platforms & VPS Setup (2026)

> Last research update: 2026-07-09

---

## Why Self-Host?

**Pros:**
- **Cost:** A $5–$10/month VPS can replace $50–$200/month of managed PaaS
- **Control:** Full root access, any software, any configuration
- **Privacy:** Your data stays on YOUR server
- **No vendor lock-in:** Own your infrastructure forever
- **Learning:** Understand how the internet actually works

**Cons:**
- **Maintenance burden:** You handle OS updates, backups, monitoring
- **DevOps knowledge required:** Linux, Docker, networking
- **No SLA:** If your VPS dies, you handle it
- **Time cost:** Setup time vs just deploying to Railway

**When to self-host:**
- Budget is the primary constraint
- You have DevOps knowledge (or willingness to learn)
- Data sovereignty/compliance requires self-hosting
- You're running many services (self-host becomes very cost-effective)
- Hobby projects / homelab

**When NOT to self-host:**
- You need 99.99% uptime with SLA
- Your team lacks DevOps knowledge
- Time-to-market is critical
- Compliance requires managed services with certifications

---

## SECTION A: Self-Hosted PaaS Tools

These tools run on your VPS and provide a Heroku/Vercel-like UI for deploying apps.

### 1. Coolify (Recommended)

**Website:** coolify.io  
**GitHub:** coollabsio/coolify  
**License:** Apache 2.0  
**Stars:** 40K+ (2026)

**What it is:**
Coolify is the most feature-rich open-source self-hosted PaaS. Deploy apps, databases,
and services via a beautiful web UI. Often described as "a self-hosted Heroku + Vercel + Netlify."

**System Requirements:**
- Minimum: 2 vCPU + 2GB RAM + 30GB storage
- Recommended: 4 vCPU + 4GB RAM + 50GB storage (for reliable operation)
- OS: Any Linux (Ubuntu 22.04 LTS recommended)

**Supported Deployments:**
- Docker Compose
- Dockerfile
- Nixpacks (auto-detection, like Railway)
- Git repositories (GitHub, GitLab, Bitbucket, self-hosted Gitea)
- Docker images from any registry

**280+ One-Click Services:**
| Category | Examples |
|----------|---------|
| Databases | PostgreSQL, MySQL, MariaDB, MongoDB, Redis, InfluxDB, CockroachDB |
| Monitoring | Grafana, Prometheus, Uptime Kuma, Netdata |
| CMS | WordPress, Ghost, Strapi, Directus |
| Dev tools | Gitea, GitLab, Plausible, Umami |
| AI/LLM | Ollama, LocalAI, Open WebUI, LangFuse |
| Email | Mailpit, Stalwart, Postal |
| Storage | MinIO (S3-compatible), Meilisearch |

**Key Features:**
- Automatic SSL (Let's Encrypt)
- Real-time deployment logs
- Environment variables management
- Preview deployments (experimental)
- Multiple servers from single dashboard
- Backups to S3/R2
- Webhooks / auto-deploy on Git push
- Team access control
- Mobile-friendly dashboard

**Pricing:** Free and open source (cloud-hosted managed Coolify.io available too)

**Gotchas:**
- Requires 2GB+ RAM — can struggle on tiny servers
- Kubernetes support: "coming soon" (not yet available)
- Less enterprise-ready than commercial alternatives

---

### 2. Dokploy

**Website:** dokploy.com  
**GitHub:** dokploy/dokploy  
**License:** Open source  
**Stars:** 20K+ (2026)

**What it is:**
Lighter-weight alternative to Coolify. Optimized for smaller servers. Growing rapidly.

**System Requirements:**
- Minimum: 1 vCPU + 512MB RAM (can work on tiny servers!)
- Recommended: 2 vCPU + 2GB RAM

**Key Differences from Coolify:**
- **Lighter weight** — runs on 512MB RAM servers
- Docker Compose focused
- Traefik-based reverse proxy (like Coolify)
- Simpler UI but fewer one-click services
- Better suited for: Teams that want minimal overhead

**Features:**
- Docker Compose, Dockerfile, Nixpacks support
- Managed databases (PostgreSQL, MySQL, MongoDB, Redis, MariaDB)
- Git integration (GitHub, GitLab, Bitbucket)
- Automatic SSL
- Domain management
- Environment variables
- Real-time logs

---

### 3. CapRover

**Website:** caprover.com  
**GitHub:** caprover/caprover  
**License:** Apache 2.0  
**Stars:** 13K+

**What it is:**
One of the most battle-tested self-hosted PaaS tools. Proven in production for years.
Older UI than Coolify/Dokploy but extremely reliable.

**System Requirements:**
- Minimum: 1 vCPU + 1GB RAM
- Ubuntu 20.04+ recommended

**Key Features:**
- 100+ one-click apps
- Captain CLI for terminal management
- Multi-node (Docker Swarm cluster)
- Nginx reverse proxy
- Automatic SSL
- Deploy from Docker image, Dockerfile, or Tarball

**Best for:** Teams wanting maximum stability and battle-tested self-hosting

---

### 4. Dokku

**Website:** dokku.com  
**License:** MIT  
**Stars:** 27K+

**What it is:**
"The smallest PaaS implementation you've ever seen." Heroku-compatible CLI.
Deploy apps with `git push dokku main` — exactly like Heroku.

**System Requirements:**
- Minimum: 1GB RAM, 1 vCPU

**Key Features:**
- Heroku buildpack compatible
- Plugin system (PostgreSQL, MySQL, Redis, MongoDB, Let's Encrypt)
- git-push deployment workflow
- Single server focused (no multi-node)
- Nginx reverse proxy

**Best for:** Solo developers who want Heroku-like experience on own VPS

**Gotchas:**
- CLI-only (no web UI by default — plugins add basic UI)
- Single-server only (no clustering)

---

## SECTION B: Reverse Proxy / Routing

When self-hosting, you need a reverse proxy to route traffic and handle SSL.

### 1. Caddy (Recommended for Simplicity)

- Automatic HTTPS via Let's Encrypt — ZERO config needed
- Simple Caddyfile configuration
- Used by Coolify and Dokploy internally
- Hot-reload config without restart
- Built-in load balancing

```caddyfile
api.example.com {
    reverse_proxy localhost:3000
}

app.example.com {
    reverse_proxy localhost:8080
}
```

### 2. Traefik

- Docker-native reverse proxy
- Automatic service discovery from Docker labels
- Used by most self-hosted PaaS tools
- Excellent for microservices

### 3. Nginx

- Industry standard
- Maximum control and performance
- Steeper configuration learning curve
- Manual SSL renewal (or use Certbot)

---

## SECTION C: VPS Provider Recommendations for Self-Hosting

### Best Self-Hosting VPS Options (2026)

| Provider | Best For | Starting Price | Bandwidth |
|----------|----------|---------------|-----------|
| Hetzner | EU, best price/performance | $4.50/mo | 20TB free |
| Oracle Cloud | Zero cost (Always Free ARM) | $0 | 10TB free |
| Contabo | Maximum resources per dollar | $4.99/mo | 32TB free |
| Netcup | EU budget hosting | ~$3/mo | Varies |
| BuyVM | US/EU, budget + storage | $3.50/mo | 1TB |
| Vultr | Global regions | $2.50/mo (512MB) | 500GB |
| DigitalOcean | Best DX | $4/mo | 1TB |

### My Recommended Server Choices

**Absolute cheapest (EU):**
→ Hetzner CX22 (4 vCPU, 4GB RAM): ~$4.50/mo + Coolify

**Free forever (ARM):**
→ Oracle Always Free (4 OCPU, 24GB RAM, 200GB disk) + Dokploy

**Best for beginners (best documentation):**
→ DigitalOcean $6/mo Droplet + Coolify or CapRover

**Budget EU with maximum storage:**
→ Contabo VPS S ($4.99/mo, 4 vCPU, 8GB RAM, 100GB SSD)

---

## SECTION D: Complete Self-Hosting Stacks

### Stack 1: The "Replace Railway" Stack
**Goal:** Run 3–10 apps + databases for ~$10/month total

```
Server: Hetzner CX32 ($8.50/mo, 4 vCPU, 8GB RAM)
PaaS: Coolify (free, manages everything)
Apps: Deploy as Docker containers
Database: Coolify-managed PostgreSQL (on same server)
Cache: Coolify-managed Redis (on same server)
Reverse Proxy: Caddy (automatic HTTPS)
Storage: Hetzner Volumes ($0.05/GB/mo) or Cloudflare R2 (free tier)
CDN: Cloudflare free CDN in front
Monitoring: Uptime Kuma (one-click from Coolify)
CI/CD: GitHub Actions → SSH deploy or webhook

Total: ~$8.50–$15/month
Equivalent managed cost: $60–$150/month on Railway/Render
```

### Stack 2: The "Homelab Production" Stack
**Goal:** Powerful self-hosted infrastructure for multiple projects

```
Server: Hetzner CX42 ($17/mo, 8 vCPU, 16GB) or Oracle Free (4 OCPU, 24GB)
PaaS: Coolify
Databases: PostgreSQL, MySQL, MongoDB, Redis (all managed by Coolify)
Reverse Proxy: Traefik (built into Coolify)
Storage: MinIO (S3-compatible, self-hosted, free)
Email: Postal or Stalwart (self-hosted, free)
Monitoring: Grafana + Prometheus + Loki (all free, in Coolify)
Backup: Coolify → Cloudflare R2 or Backblaze B2
CI/CD: Gitea (self-hosted, in Coolify) + Gitea Actions
DNS: Cloudflare (free)

Total: ~$17/month (or $0 on Oracle Free)
```

### Stack 3: The "Docker Compose" Minimalist Stack
**Goal:** Simple self-hosting without a PaaS layer

```bash
# On Ubuntu 22.04 VPS:
# 1. Install Docker + Docker Compose
curl -fsSL https://get.docker.com | sh

# 2. Install Caddy
apt install caddy

# 3. Deploy your app with docker-compose.yml
docker compose up -d

# 4. Caddy handles HTTPS automatically
```

---

## SECTION E: Managed vs Self-Hosted Decision

```
Is budget the primary concern?
├── YES: Self-host on Hetzner + Coolify
└── NO: Continue to next question

Do you have DevOps knowledge?
├── YES: Self-host (Hetzner/Oracle + Coolify)
└── NO: Use managed PaaS (Railway/Render)

How many apps do you run?
├── 1-2 apps: Railway/Render (PaaS wins on time efficiency)
└── 5+ apps: Self-host (economics strongly favor self-hosting)

Do you need compliance (SOC2, HIPAA)?
├── YES: Use certified PaaS (Northflank/Qovery) or certified cloud (AWS/Azure)
└── NO: Self-host is fine

How critical is uptime?
├── 99.9%+ SLA required: Use managed cloud with SLA
└── Best-effort OK: Self-host is fine (add monitoring)
```

---

## Self-Hosting Cost Reality Check

**For a startup running 5 services:**

| Approach | Monthly Cost |
|----------|-------------|
| Railway (5 services, usage-based) | ~$50–$100 |
| Render (5 web services, Starter) | ~$35 |
| Hetzner CX32 + Coolify (5 apps) | ~$8.50 |
| Oracle Cloud Always Free + Coolify | $0 |

**The self-hosting savings are enormous — but factor in your time.**
If DevOps takes 5 hours/month and your time is worth $50/hour,
that's $250 in implicit cost vs $91.50 saved. Managed wins for your time.

If DevOps takes 1 hour/month (Coolify makes it simple),
the math flips strongly in self-hosting's favor.

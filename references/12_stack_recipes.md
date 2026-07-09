# Reference: Proven Stack Recipes for Common Project Types (2026)

> Last research update: 2026-07-09
> These are battle-tested combinations used by real teams.

---

## How to Use This File

Each recipe includes:
- **Who it's for** (team size, budget, expertise)
- **Stack** (all services involved)
- **Estimated monthly cost**
- **Setup steps**
- **Scaling path** (what to change as you grow)
- **Honest tradeoffs**

---

## Recipe 1: Personal Blog / Portfolio

**Who:** Solo developer, no budget, just wants to be online

**Stack:**
```
Framework: Astro (SSG) or Hugo
Hosting: Cloudflare Pages (free)
Domain: Cloudflare Registrar (~$8-12/year)
CMS: Obsidian/MDX files in Git (no CMS needed)
Analytics: Cloudflare Web Analytics (free, privacy-friendly)
Comments: giscus (GitHub Discussions-based, free)
```

**Monthly cost:** $0 (domain ~$1/month amortized)

**Setup:**
1. `npm create astro@latest my-blog`
2. Connect repo to Cloudflare Pages
3. Push to deploy, get custom domain

**Scaling path:** N/A (this scales to millions of readers on free tier)

**Why not Vercel/Netlify?** Cloudflare Pages has unlimited bandwidth. Vercel free tier bans commercial use.

---

## Recipe 2: Next.js SaaS Startup

**Who:** Startup founder or small team (1-5 devs), $20-50/month budget, Next.js

**Stack:**
```
Frontend: Next.js (SSR + API routes)
Hosting: Vercel Pro ($20/month)
Database: Supabase Pro ($25/month, PostgreSQL + Auth + Storage)
Cache/Queue: Upstash Redis (free → pay-as-you-grow)
Email: Resend (free → $20/month at scale)
Monitoring: Sentry free + UptimeRobot free
Payments: Stripe
CI/CD: GitHub Actions (free for public)
Secrets: Vercel Environment Variables (built-in)
```

**Monthly cost:** ~$45-55/month (Vercel + Supabase)

**Setup:**
1. `npx create-next-app@latest --typescript`
2. Connect to Vercel via GitHub
3. Create Supabase project, connect via environment variables
4. Set up Stripe webhooks

**What you get:**
- PostgreSQL + Auth + Storage + Realtime in Supabase
- Automatic SSR + Edge caching via Vercel
- Preview deployments on every PR
- 50K MAU on Supabase free (upgrade to Pro at $25/month)

**Scaling path:**
- Traffic spike → Vercel auto-scales (just watch bandwidth costs)
- DB growing → Supabase Pro → Supabase Enterprise
- Need dedicated backend → Extract API to Railway or Fly.io

**Honest tradeoffs:**
- Vercel vendor lock-in: ISR and Next.js optimizations tied to Vercel
- Supabase is excellent but has pausing on free tier

---

## Recipe 3: Next.js SaaS (No Vendor Lock-In)

**Who:** Developer who wants to avoid Vercel lock-in, $20-50/month budget

**Stack:**
```
Frontend: Next.js (SSR)
Hosting: Cloudflare Pages (free, with Workers for API)
OR:      Fly.io ($5-15/month for Next.js container)
Database: Neon (PostgreSQL, $19/month Launch)
ORM: Drizzle ORM (Neon-optimized, serverless-compatible)
Cache: Upstash Redis (free → $0.20/100K ops)
Auth: Auth.js (NextAuth.js) or Better Auth
Email: Resend (free tier)
CI/CD: GitHub Actions
```

**Monthly cost:** ~$20-35/month

**Why this stack:**
- Cloudflare Pages + Workers = globally distributed Next.js at near-zero cost
- Neon = serverless PostgreSQL with branching for staging environments
- Drizzle ORM = TypeScript-first, edge-compatible (works in Workers)

---

## Recipe 4: FastAPI / Django Python Backend

**Who:** Python developer, REST API, PostgreSQL database

**Stack:**
```
Framework: FastAPI (recommended) or Django REST Framework
Hosting: Railway ($5 base/month)
Database: Supabase (free → Pro) or Railway PostgreSQL
Cache: Upstash Redis ($0)
Worker: Railway background worker (Celery or ARQ)
Auth: FastAPI-users or Django allauth
CI/CD: GitHub Actions
Containerization: Docker (or Railway uses Nixpacks)
```

**Monthly cost:** ~$5-35/month

**Setup:**
```bash
# FastAPI on Railway
railway login
railway init
railway up
```

**Scaling path:**
- Need more compute → Railway Pro, scale container
- Need global edge → Move to GCP Cloud Run (serverless containers)
- Need managed DB → Supabase Pro or Railway PostgreSQL

---

## Recipe 5: Go / Rust High-Performance API

**Who:** Performance-critical API, low-latency requirements

**Stack:**
```
Framework: Go (Gin/Chi/Echo) or Rust (Axum/Actix)
Hosting: Fly.io (global edge, 30+ regions)
Database: Neon PostgreSQL (serverless, fast cold-starts)
  OR:     CockroachDB (multi-region distributed)
Cache: Fly Redis (via Upstash) or self-hosted Redis on Fly
CI/CD: GitHub Actions → flyctl deploy
Containerization: Docker (multi-stage build for tiny images)
```

**Monthly cost:** ~$5-30/month

**Why Fly.io for Go/Rust:**
- Multi-region deployment: Run API close to every user
- Go/Rust images are tiny (< 20MB) → fast cold starts
- Per-second billing: Cost-efficient for variable traffic
- Private networking: Services communicate within Fly network

**Dockerfile (Go multi-stage):**
```dockerfile
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main ./cmd/server

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
```

---

## Recipe 6: Full-Stack Laravel / PHP

**Who:** PHP/Laravel developer, traditional web app

**Stack:**
```
Framework: Laravel
Hosting: Laravel Forge + Hetzner/DigitalOcean VPS
  OR:     Railway (Laravel Nixpacks support)
  OR:     Ploi.io + VPS (Forge alternative, cheaper)
Database: MySQL (managed via Forge on VPS)
  OR:     PlanetScale (MySQL serverless)
Queue: Laravel Horizon (Redis-backed)
Cache: Redis
Storage: Laravel Forge manages Nginx + SSL
CI/CD: GitHub Actions + Forge webhooks
```

**Monthly cost:**
- Self-managed (Forge + Hetzner): ~$15/month (Forge $15 + Hetzner $5)
- Managed (Railway): ~$15-25/month

**Laravel Forge vs DIY:**
- Forge: $15/month but handles Nginx, SSL, deployments, queue workers
- Fully managed on Railway: Similar simplicity, no server SSH needed
- DIY on Coolify: Free but more configuration work

---

## Recipe 7: Ruby on Rails

**Who:** Rails developer, standard Rails app

**Stack:**
```
Framework: Ruby on Rails
Hosting: Fly.io (excellent Rails support, Dockerfile)
  OR:     Render (Nixpacks Rails detection)
Database: Neon PostgreSQL or Railway PostgreSQL
Cache/Jobs: Redis + Sidekiq (background jobs)
Storage: Active Storage + Cloudflare R2 (S3-compatible)
CI/CD: GitHub Actions
```

**Monthly cost:** ~$10-25/month

**Why Fly.io for Rails:**
- Fly has excellent Rails documentation and community support
- `fly launch` auto-detects Rails and creates optimal Dockerfile
- Multi-region deployment for global apps
- Built-in PostgreSQL via fly.io postgres or external Neon

---

## Recipe 8: Mobile Backend (BaaS)

**Who:** Mobile app developer (React Native, Flutter, iOS, Android)

### Option A: Supabase (Recommended)

```
Backend: Supabase
  - PostgreSQL database
  - Row-Level Security (per-user data access)
  - REST + GraphQL + Realtime APIs auto-generated
  - Authentication (email, social OAuth, phone OTP)
  - Storage (user avatars, file uploads)
  - Edge Functions (custom business logic, Deno)
Frontend: React Native or Flutter
Push Notifications: Expo Push Notifications or OneSignal (free)
Analytics: PostHog (free), Mixpanel (free 20M events)
```

**Monthly cost:** Free → $25/month (Supabase)

### Option B: Firebase (Google Ecosystem)

```
Database: Firestore
Auth: Firebase Auth
Storage: Firebase Storage
Functions: Cloud Functions
Push: Firebase Cloud Messaging (free)
Analytics: Firebase Analytics (free)
```

**Monthly cost:** Free → Pay-as-you-go

**Supabase vs Firebase:**
- Supabase: PostgreSQL (relational), open source, self-hostable, cheaper at scale
- Firebase: NoSQL, real-time by default, deeper Google/Android integration

---

## Recipe 9: Real-Time Collaborative App

**Who:** Building shared workspaces, live documents, multiplayer features

**Stack:**
```
Frontend: React + Next.js
Hosting: Vercel (free → Pro)
Collaboration layer: Liveblocks (CRDT, cursors, presence, comments)
Database: Supabase (users, documents, metadata)
Auth: Supabase Auth
Real-time (non-CRDT events): Ably or Pusher
Background jobs: Trigger.dev (free tier)
CI/CD: GitHub Actions
```

**Monthly cost:** ~$25-120/month (Supabase + Liveblocks based on MAU)

**Architecture:**
```
User edits document → Liveblocks (CRDT sync, <10ms)
User saves document → Supabase (PostgreSQL persistence)
User gets notification → Ably push
Background: Trigger.dev processes async tasks
```

---

## Recipe 10: AI Application (RAG Chatbot / AI SaaS)

**Who:** Building AI-powered product, LLM integration

**Stack:**
```
Frontend: Next.js on Vercel
AI SDK: Vercel AI SDK (streaming, tool calling)
LLM: OpenAI (GPT-4o) or Together AI (open-source models)
Vector DB: Supabase (pgvector) for small-medium scale
  OR:      Qdrant Cloud for large-scale
Database: Supabase PostgreSQL (user data, chat history)
Auth: Supabase Auth or Clerk
GPU Inference: Modal (for custom models, fine-tuned)
File parsing: Unstructured.io or LlamaParse
Background jobs: Trigger.dev (indexing, processing)
Monitoring: Langfuse (LLM observability, free self-hosted)
```

**Monthly cost:** ~$25-100/month (mostly LLM API costs)

**Architecture:**
```
User uploads PDF → Trigger.dev job
  → Parse with Unstructured/LlamaParse
  → Chunk text
  → Embed with text-embedding-3-small ($0.002/1K tokens)
  → Store vectors in Supabase pgvector

User sends query →
  → Embed query
  → Vector similarity search (pgvector)
  → LLM prompt with retrieved context
  → Stream response to user
```

**Scaling path:**
- pgvector handles up to ~5M vectors well
- At 10M+ vectors → migrate to Qdrant ($9/month)
- At high query volume → dedicated Qdrant cluster or Pinecone

---

## Recipe 11: Data Pipeline / ETL

**Who:** Data engineering, processing large datasets

**Stack:**
```
Orchestration: Modal (Python, serverless, GPU-capable)
  OR:          Prefect Cloud (free 10K tasks/month)
  OR:          Temporal (self-hosted, complex workflows)
Storage: Cloudflare R2 (zero egress) or AWS S3
Database: PostgreSQL on Neon or Supabase
Transformation: dbt (open source)
Warehouse: BigQuery (1TB free queries/month) or ClickHouse Cloud
CI/CD: GitHub Actions
```

**Monthly cost:** ~$0-50/month (depends on data volume)

---

## Recipe 12: Self-Hosted Everything (Minimal Budget)

**Who:** Developer wanting maximum control and zero recurring SaaS costs

**Stack:**
```
Server: Hetzner CX32 ($8.50/month, 4 vCPU, 8GB RAM)
  OR:   Oracle Cloud Always Free (4 OCPU ARM, 24GB RAM, $0)
PaaS: Coolify (free, self-hosted)
Apps: Deploy any Docker container
Database: PostgreSQL managed by Coolify
Cache: Redis managed by Coolify
Monitoring: Uptime Kuma (in Coolify) + Grafana + Loki (in Coolify)
CDN: Cloudflare (free plan in front of Hetzner)
CI/CD: GitHub Actions → Coolify webhook
Object Storage: MinIO (self-hosted, S3-compatible) in Coolify
Email: Postal (self-hosted) or Resend API (3K emails/day free)
Auth: Keycloak (self-hosted) or Authentik
SSL: Caddy (automatic HTTPS, built into Coolify)
DNS: Cloudflare (free)
Domain: Cloudflare Registrar ($8-12/year)
```

**Monthly cost:** ~$8.50/month + ~$1/month domain = **~$9.50/month total**  
*Or $0/month with Oracle Cloud Always Free*

**What you manage:**
- OS updates (run `unattended-upgrades` for automatic)
- Coolify updates (one-click in UI)
- PostgreSQL backups (Coolify → R2/S3 backup)
- SSL renewal (Caddy does this automatically)

**Replaces:**
- Railway ($15+) → Coolify ($0)
- Vercel Pro ($20) → Coolify ($0)
- Supabase Pro ($25) → PostgreSQL on Coolify ($0)
- Grafana Cloud → Self-hosted Grafana ($0)
- UptimeRobot Pro → Uptime Kuma ($0)

---

## Recipe 13: Enterprise Deployment (Large Scale)

**Who:** Enterprise company, 100+ developers, compliance requirements

**Stack:**
```
Cloud: AWS (primary) or GCP
Containers: ECS Fargate or GCP Cloud Run
Orchestration: EKS or GKE (if Kubernetes needed)
Database: RDS Aurora PostgreSQL or Cloud SQL
Cache: ElastiCache Redis
CI/CD: GitHub Actions (enterprise) + ArgoCD (GitOps)
IaC: Terraform (OpenTofu) or AWS CDK
BYOC Platform: Northflank or Qovery (for developer experience)
Secrets: AWS Secrets Manager or HashiCorp Vault
Monitoring: Datadog (full observability)
Security: Snyk + AWS GuardDuty + CloudTrail
Compliance: SOC 2 (Northflank/Qovery can help with this)
CDN: CloudFront or Cloudflare Enterprise
```

**Monthly cost:** $500-$10,000+ (depends on scale)

---

## Quick Recipe Lookup

| Project Type | Go-To Recipe |
|-------------|-------------|
| Blog / portfolio | Recipe 1 (Astro + CF Pages, $0) |
| Next.js SaaS startup | Recipe 2 (Vercel + Supabase, ~$45/mo) |
| Next.js (no lock-in) | Recipe 3 (CF Pages + Neon, ~$20/mo) |
| Python API | Recipe 4 (Railway + Supabase, ~$15/mo) |
| Go/Rust API | Recipe 5 (Fly.io + Neon, ~$15/mo) |
| Laravel/PHP | Recipe 6 (Forge + Hetzner, ~$15/mo) |
| Ruby on Rails | Recipe 7 (Fly.io + Neon, ~$15/mo) |
| Mobile app backend | Recipe 8 (Supabase, ~$0-25/mo) |
| Real-time collaborative | Recipe 9 (Vercel + Liveblocks + Supabase, ~$50/mo) |
| AI / RAG chatbot | Recipe 10 (Vercel + Supabase + OpenAI, ~$50+/mo) |
| Data pipeline | Recipe 11 (Modal + R2 + BigQuery, ~$0-50/mo) |
| Self-hosted everything | Recipe 12 (Hetzner + Coolify, ~$9/mo) |
| Enterprise | Recipe 13 (AWS/GCP + ArgoCD, $500+/mo) |

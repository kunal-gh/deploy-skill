# Reference: Free Tier Summary & Pricing Gotchas (2026)

> Last research update: 2026-07-09
> ⚠️ Always verify pricing at official pages — cloud pricing changes frequently.

---

## SECTION A: Complete Free Tier Summary

### Frontend / Static Hosting

| Platform | Bandwidth | Builds | Functions | Databases | Notes |
|----------|-----------|--------|-----------|-----------|-------|
| Cloudflare Pages | **Unlimited** | 500/mo | Workers 100K req/day | D1 5GB, KV, R2 10GB | Best overall free frontend |
| Vercel | 100GB/mo | ~100/mo | 100K/mo | None | Hobby = no commercial use |
| Netlify | 100GB/mo | 300 min/mo | 125K req/mo | None | Forms 100 sub/mo |
| GitHub Pages | 100GB/mo | Via Actions | None | None | Public repos only (unlimited) |
| Firebase Hosting | 1GB storage | Via Firebase | Via Cloud Functions | Firestore 1GB | 360MB/DAY bandwidth limit |
| Azure Static Web Apps | 100GB/mo | 500 min | Azure Functions | None | Very generous |

**Winner: Cloudflare Pages** — unlimited bandwidth is unmatched

---

### Backend / API Hosting

| Platform | Free Tier | Limitations |
|----------|-----------|-------------|
| Railway | $5 trial credit only | No recurring free tier (2026) |
| Render | 512MB RAM, 0.5 CPU | **Sleeps after 15 min** |
| Koyeb | 1 instance (512MB, 0.1 vCPU) | **Always-on**, 3 regions |
| Fly.io | None | No free tier (2026) |
| Heroku | None | No free tier (2022+) |
| GCP Cloud Run | 2M req/month | 360K GB-seconds |
| AWS Lambda | 1M req/month | Always free |
| Azure Container Apps | 180K vCPU-seconds | Always free |

**Winner: Koyeb** — always-on free tier for backend containers

---

### Databases (Free Tiers)

| Database | Type | Free Storage | Gotcha |
|----------|------|-------------|--------|
| Supabase | PostgreSQL | 500MB | Pauses after 1 week idle |
| Neon | PostgreSQL | 512MB | Limited compute (0.25 vCPU) |
| CockroachDB | PostgreSQL-compat | 10GB | RU limits |
| Turso | SQLite | 9GB (500 DBs) | Very generous |
| PlanetScale | MySQL / PostgreSQL | Free tier available | Check current pricing |
| MongoDB Atlas | Document | 512MB | Shared cluster |
| Firestore | Document | 1GB | 50K reads/day only |
| DynamoDB | Key-value | 25GB | Always free |
| Upstash Redis | Cache/Queue | 256MB | 10K commands/day |
| Upstash Kafka | Streaming | 10K messages/day | - |
| Cloudflare D1 | SQLite edge | 5GB | 5M rows read/day |
| Pinecone | Vector | 2 indexes | Serverless free tier |
| Qdrant Cloud | Vector | 1 cluster (1GB RAM) | 1 free cluster |

**Winner for relational:** Turso (9GB total across 500 databases) + Neon (PostgreSQL)  
**Winner for NoSQL:** DynamoDB (25GB always-free)  
**Winner for cache:** Upstash Redis (serverless, pay-per-use)

---

### CI/CD (Free Tiers)

| Platform | Free Minutes | Parallelism |
|----------|-------------|------------|
| GitHub Actions (public) | Unlimited | 20 parallel jobs |
| GitHub Actions (private) | 2,000/month | 5 parallel jobs |
| GitLab CI | 400 minutes/month | 1 concurrent |
| CircleCI | 30,000 credits (~2500 min) | 1 concurrent |
| Semaphore | 1,300 min/month | 1 concurrent |

**Winner: GitHub Actions** — unlimited for public repos

---

### Monitoring (Free Tiers)

| Service | What | Free Limit |
|---------|------|------------|
| Sentry | Error tracking | 5K errors/month |
| GlitchTip | Error tracking | 1K events/month (cloud), unlimited (self-hosted) |
| Grafana Cloud | Metrics + Logs + Traces | 10K metric series, 50GB logs |
| UptimeRobot | Uptime monitoring | 50 monitors, 5-min intervals |
| BetterStack | Uptime + Logs | 10 monitors, 3-min intervals |
| Axiom | Log analytics | 500GB ingested/month |
| Uptime Kuma | Uptime (self-hosted) | **Free forever** |

---

### Secrets Management (Free Tiers)

| Service | Free | Notes |
|---------|------|-------|
| Doppler | 1 user | Team features require paid |
| Infisical Cloud | 5 developers | Unlimited secrets |
| Infisical Self-hosted | Free | Full features |
| GitHub Secrets | Free | Per-repo, per-org |

---

## SECTION B: Pricing Gotchas & Hidden Costs

### 🚨 The Most Dangerous Pricing Traps

#### 1. AWS Egress Costs
**TRAP:** AWS charges $0.09/GB for outbound internet traffic.
- Transferring 1TB/month out of EC2/S3 = **$92/month** in egress alone
- Even "free tier" S3 includes egress overages after 15GB

**AVOID with:** Cloudflare R2 (zero egress), BunnyCDN, or Cloudflare in front of AWS

---

#### 2. Vercel Bandwidth Overages
**TRAP:** Vercel Pro includes 1TB bandwidth/month. Overage is **$0.40/GB**.
- A viral post that generates 2TB of traffic = **$400 unexpected bill**

**MITIGATION:** Set spending limits in Vercel dashboard. Use Cloudflare in front of Vercel for static assets.

---

#### 3. Vercel Serverless Function Invocations
**TRAP:** Beyond the included invocations, Vercel charges $0.60/million invocations.
- A busy API can generate millions of invocations quickly

**MITIGATION:** Use edge functions (more generous limits) or move heavy computation off-platform

---

#### 4. Railway No Free Tier
**TRAP:** Many tutorials assume Railway has a free tier. It doesn't (since 2024).
- The $5 trial credit depletes quickly during development/testing

**MITIGATION:** Use Koyeb free tier for testing, or Render free tier (note: sleeps)

---

#### 5. Render Free Tier Sleeping
**TRAP:** Render free web services sleep after 15 minutes of inactivity.
- First request after sleeping takes 30–60 seconds
- This means your free Render app will timeout/fail for many users

**MITIGATION:** Upgrade to Render Starter ($7/mo), or use Koyeb free tier (always-on)

---

#### 6. Supabase Project Pausing
**TRAP:** Supabase free tier projects pause after 1 week of inactivity.
- All your data is preserved, but the project is "offline" until you unpause

**MITIGATION:** Visit the Supabase dashboard weekly, or upgrade to Pro ($25/mo)

---

#### 7. Atlas MongoDB Connection Limits
**TRAP:** MongoDB Atlas free tier (M0) has a 500-connection limit shared cluster.
- Production apps with connection pooling can exhaust this

**MITIGATION:** Use M2/M5 dedicated cluster, or switch to MongoDB Serverless

---

#### 8. PlanetScale Sleeping Databases
**TRAP:** PlanetScale's older Hobby plan had database "sleeping" (removed, but some tutorials reference it)
- Check current pricing as PlanetScale has changed pricing multiple times

**MITIGATION:** Always check current pricing page, not tutorials

---

#### 9. Fly.io No Free Tier
**TRAP:** Fly.io removed its free tier in 2023. Must add payment method.
- Many tutorials show creating free Fly.io apps that no longer work without billing

**MITIGATION:** Use Koyeb or Railway for free tiers. Fly.io starts at ~$2-3/month

---

#### 10. DynamoDB Read/Write Capacity Units
**TRAP:** DynamoDB on-demand pricing sounds simple but can be expensive:
- $1.25/million write request units
- Heavy-write apps can quickly surpass Lambda and EC2 costs

**MITIGATION:** Use DynamoDB provisioned capacity for predictable workloads, or switch to PostgreSQL

---

#### 11. Firebase Egress
**TRAP:** Firebase free tier includes only 1GB/day egress.
- A medium-traffic app can easily exceed this, triggering $0.15/GB charges

**MITIGATION:** Use Cloudflare CDN in front, or move static files to R2/BunnyCDN

---

#### 12. Cloudflare Workers CPU Time
**TRAP:** Workers free tier limits to 10ms CPU per request.
- Heavy computational work (image processing, complex parsing) will exceed this

**MITIGATION:** Upgrade to Workers Paid ($5/month) which removes the CPU time limit (but bills by ms beyond 30ms)

---

## SECTION C: True Total Cost of Ownership

### Case Study: Small SaaS App

**Setup:** Next.js frontend + Node.js API + PostgreSQL + Redis + 50K users/month

| Stack | Monthly Cost | Notes |
|-------|-------------|-------|
| Vercel + Railway + Supabase | ~$55 | Vercel Pro $20 + Railway ~$15 + Supabase Pro $25 |
| Cloudflare Pages + Railway + Supabase | ~$40 | Pages free + Railway ~$15 + Supabase $25 |
| Cloudflare Pages + Fly.io + Neon | ~$25 | Pages free + Fly.io ~$5 + Neon $19 + Upstash $0 |
| Hetzner + Coolify (self-hosted) | ~$9 | CX22 $4.50 + everything self-managed |
| Vercel + Supabase only (edge functions) | ~$25 | Vercel Pro $20 + Supabase free → Pro $25 |

---

## SECTION D: The "Oh Shit" Budget Protections

Always implement these when using usage-based pricing:

### AWS
```bash
# Set billing alerts
aws budgets create-budget --account-id $ACCOUNT_ID \
  --budget '{"BudgetName":"monthly-limit","BudgetLimit":{"Amount":"50","Unit":"USD"},"TimeUnit":"MONTHLY","BudgetType":"COST"}'
```

### Vercel
- Dashboard → Settings → Billing → Spending Limits
- Set a hard spending limit to prevent unexpected invoices

### Railway
- Dashboard → Account → Billing → Usage Alerts

### GCP
- Billing → Budgets & Alerts → Create Budget

### Cloudflare Workers
- Workers → Manage Workers → Billing → Set usage limits

### General Principle
> **Never use a cloud service in production without a spending alert set.**
> Set your alert at 50% of your budget so you have time to react before hitting the limit.

---

## SECTION E: The "Free Forever" Stack

**Completely free, always-on stack for hobby/personal projects:**

```
Frontend: Cloudflare Pages (unlimited bandwidth, free)
Backend: Koyeb free tier (always-on, 512MB RAM, 0.1 vCPU)
   OR:  GCP Cloud Run (2M requests/month free)
   OR:  Oracle Cloud Free (4 OCPU, 24GB RAM ARM — run anything)
Database: Supabase (500MB PostgreSQL, wake manually if paused)
   OR:  Turso (9GB SQLite edge, very generous)
   OR:  Neon (512MB PostgreSQL serverless)
Cache: Upstash Redis (10K commands/day free)
CDN: Cloudflare (free plan, unlimited)
Monitoring: UptimeRobot (50 monitors free) + Sentry (5K errors/month free)
CI/CD: GitHub Actions (2K minutes/month private, unlimited public)
Auth: Supabase Auth (50K MAU free)
Email: Resend (3K emails/day free)

TOTAL COST: $0/month
TOTAL: A completely functional production stack for free
```

**Gotchas of the free stack:**
- Supabase pauses after 1 week idle (must manually unpause)
- Koyeb backend limited to 512MB RAM and 0.1 vCPU
- Upstash Redis limited to 10K commands/day
- Sentry limited to 5K errors/month
- This is NOT suitable for production apps expecting real traffic

**When to upgrade:**
- Supabase pausing is annoying → Upgrade to Pro ($25/month)
- Need more backend power → Railway ($5 base) or Render ($7/month)
- Need more Redis → Upstash paid ($0.20/100K commands, very cheap)

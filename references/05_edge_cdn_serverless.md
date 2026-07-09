# Reference: Edge Computing, CDN & Serverless Platforms (2026)

> Last research update: 2026-07-09

---

## Official Source Targets

| Platform | Docs | Pricing / limits |
|---|---|---|
| Cloudflare Workers | https://developers.cloudflare.com/workers | https://developers.cloudflare.com/workers/platform/pricing |
| Cloudflare Pages | https://developers.cloudflare.com/pages | https://developers.cloudflare.com/pages/platform/limits |
| Deno Deploy | https://docs.deno.com/deploy | https://deno.com/deploy/pricing |
| Vercel Edge Functions | https://vercel.com/docs/functions/runtimes/edge | https://vercel.com/pricing |
| Netlify Edge Functions | https://docs.netlify.com/edge-functions/overview | https://www.netlify.com/pricing |
| Fastly Compute | https://www.fastly.com/documentation/guides/compute | https://www.fastly.com/pricing |
| AWS Lambda | https://docs.aws.amazon.com/lambda | https://aws.amazon.com/lambda/pricing |
| Google Cloud Run | https://cloud.google.com/run/docs | https://cloud.google.com/run/pricing |
| Azure Functions | https://learn.microsoft.com/azure/azure-functions | https://azure.microsoft.com/pricing/details/functions |
| Bunny CDN | https://docs.bunny.net | https://bunny.net/pricing |

---

## Overview

Edge computing runs code physically close to users (inside CDN PoPs), reducing
latency to <10ms for globally distributed users. Key distinction:

- **Traditional serverless** (AWS Lambda, Cloud Functions): Single region, 10–100ms cold starts
- **Edge serverless** (Cloudflare Workers, Deno Deploy): Multi-region V8 isolates, <1ms cold starts
- **CDN**: Pure content delivery, no compute (BunnyCDN, Fastly, CloudFront)

---

## SECTION A: Edge Compute Platforms

### 1. Cloudflare Workers (The Leader)

**Best for:** Ultra-low latency, globally distributed compute, largest edge ecosystem

**Network:** 300+ PoPs globally — the largest edge network

| Tier | Price | Limits |
|------|-------|--------|
| Free | $0 | 100K requests/day, 10ms CPU/request |
| Workers Paid | $5/month | 10M requests included, then $0.30/million, no CPU time limit |

**Ecosystem (all included, pay only for usage):**
| Product | What it is | Free Tier |
|---------|-----------|-----------|
| Workers | V8 isolate compute | 100K req/day |
| Pages | JAMstack hosting | Unlimited bandwidth |
| R2 | S3-compatible object storage | 10GB, **zero egress** |
| D1 | SQLite database at edge | 5GB, 5M reads/day |
| KV | Global key-value store | 100K reads/day |
| Durable Objects | Stateful compute/WebSocket servers | $0.15/M requests |
| Queues | Message queue | 1M messages/month free |
| Vectorize | Vector DB for Workers | 30M query vectors/month free |
| AI | Run ML models at edge | 10K neurons/day free |
| Hyperdrive | Connection pooling to remote DBs | 100K queries/month free |
| Email Routing | Email processing | Free |

**Runtime capabilities:**
- V8 JavaScript isolates (not Node.js — Web Standard APIs)
- `nodejs_compat` flag: ~95% Node.js compatible in 2026
- Maximum memory: 128MB
- Script size: 10MB (free), 25MB (paid)
- CPU: 10ms/request (free), unlimited with Workers Paid (billed by CPU-ms)
- Cold starts: <1ms (no cold start — isolates warm up in microseconds)

**What you CAN do:**
- HTTP requests/responses
- Fetch external APIs
- Read/write R2, KV, D1, Durable Objects
- Transform responses (A/B testing, localization, authentication)
- Run WebAssembly
- WebSockets via Durable Objects

**What you CANNOT do:**
- Bind TCP/UDP ports directly (Workers use HTTP only)
- Long-running background tasks (there are Cron Triggers for this)
- Full Node.js APIs (fs, cluster, child_process not available)
- GPU compute

**Best Stack Combination:**
```
Frontend: Cloudflare Pages
API: Cloudflare Workers
Database: D1 (SQLite) + Turso (for migrations)
Cache: KV (global)
Storage: R2 (zero egress, S3-compatible)
Auth: Cloudflare Access or Workers auth
Email: Cloudflare Email Routing
Queue: Cloudflare Queues
```
→ This stack can serve millions of users at essentially zero cost

---

### 2. Deno Deploy

**Best for:** TypeScript-first edge deployment, Web Standards compliance

**Website:** deno.com/deploy

| Tier | Price | Limits |
|------|-------|--------|
| Free | $0 | 1M requests/month, 100GB bandwidth |
| Pro | $20/month | 5M requests, 1TB bandwidth |

**Runtime:**
- Deno runtime (not Node.js)
- Native TypeScript support (no compilation step)
- Web Standard APIs (fetch, Request, Response — 100% compliant)
- Deno KV: Built-in globally distributed key-value store
- Zero config, instant deployment from GitHub
- 35+ regions

**Key differentiator:** The same Deno runtime runs locally AND at the edge — no environment mismatch

**Deno KV (Persistent Storage):**
- Global key-value database built into Deno Deploy
- ACID transactions
- Strong consistency within a region
- Eventual consistency across regions
- Free: 1GB storage, 500K reads/day, 100K writes/day

**Best for:**
- TypeScript-heavy backends (no compilation needed)
- Modern web apps wanting 100% Web Standard APIs
- Projects combining edge compute + KV storage simply

---

### 3. Vercel Edge Functions

**Best for:** Middleware in Next.js applications

- V8 isolate runtime (same as Workers)
- Max 25ms CPU time
- 128MB memory
- Only available with Vercel deployment
- Excellent for: auth checks, geolocation, A/B testing in Next.js
- Not available for standalone use

---

### 4. Netlify Edge Functions

**Best for:** Middleware in Netlify-deployed apps

- Deno runtime (same as Deno Deploy)
- 128MB memory
- 50ms CPU time limit
- Executed per-request before serving static files
- Only available with Netlify deployment

---

### 5. Fastly Compute (Wasm-based)

**Best for:** High-performance, WebAssembly edge compute

- Run WebAssembly at the edge
- Languages: Rust, JavaScript, Go, AssemblyScript, C/C++
- Extremely fast (Wasm isolates, even faster than V8)
- 80+ PoPs globally
- Pricing: $0.05 per 1M requests + $0.005 per 50ms compute
- Higher learning curve than Workers/Deno
- Best for: High-performance edge compute where Rust performance matters

---

### 6. Bun (As Runtime / Serverless Context)

**Note:** Bun is primarily a runtime, not an edge hosting platform.

- Built on JavaScriptCore (Safari's engine)
- 4x faster than Node.js for many workloads
- ~98% npm compatibility (2026)
- All-in-one: package manager + bundler + test runner + runtime
- **Used in:** AWS Lambda (via container), Railway, Render (as Node.js alternative)
- **Not an edge network** — deploy it wherever you deploy containers

**When to use Bun:**
- High-throughput APIs (Node.js API with better performance)
- Fast CI/CD (npm install 10x faster)
- Projects wanting simpler toolchain

---

## SECTION B: Traditional Serverless (Regional)

### 1. AWS Lambda

**The original serverless — 12+ years old, most mature**

| Tier | Price |
|------|-------|
| Free | 1M requests/month, 400K GB-seconds |
| Paid | $0.20/million requests + $0.0000166667/GB-second |

**Runtimes:** Node.js, Python, Java, Go, .NET, Ruby, container images (any language)  
**Max timeout:** 15 minutes  
**Max memory:** 10GB  
**Cold starts:** 100ms–3s (depends on runtime and package size)  
**Regions:** 25+ AWS regions  

**Key advantages:**
- Mature, battle-tested
- Deepest AWS integration (S3, DynamoDB, SQS, SNS triggers)
- Container image support (up to 10GB images)
- Lambda@Edge for CDN-attached functions
- Graviton (ARM) for 20% cost savings
- Lambda Layers for shared dependencies

**Key limitations:**
- Cold starts (mitigate with provisioned concurrency — costs extra)
- 512MB /tmp storage by default (up to 10GB with EFS)
- Complex IAM permissions
- Debugging harder than traditional apps

---

### 2. GCP Cloud Functions / Cloud Run

**Cloud Functions:**
- Event-driven functions (similar to Lambda)
- Node.js, Python, Go, Java, Ruby, PHP, .NET
- Max timeout: 60 minutes (2nd gen)
- 2M free invocations/month

**Cloud Run (recommended over Cloud Functions for new projects):**
- Deploy any Docker container, serverless
- **Scales to zero** — pay nothing when idle
- Automatic HTTPS + custom domains
- Min/max instance configuration
- Cold starts: ~1–3 seconds (mitigated by min instances)
- **Most developer-friendly GCP service**

| Cloud Run Tier | Price |
|----------------|-------|
| Free | 2M requests/month, 360K GB-seconds, 180K vCPU-seconds |
| Paid | $0.024/million requests + compute time |

---

### 3. Azure Functions

- Supports many trigger types (HTTP, Timer, Queue, Blob, etc.)
- Consumption plan (serverless): 1M free executions/month
- Languages: C#, JavaScript, TypeScript, Python, Java, PowerShell
- Durable Functions for stateful orchestration
- Best for Azure-ecosystem teams

---

## SECTION C: CDN (Pure Content Delivery)

### 1. Cloudflare CDN

- **Best CDN overall** — largest network (300+ PoPs), **free plan includes CDN**
- DDoS protection included
- Zero egress on most plans (unlike AWS CloudFront)
- Analytics: Basic (free), detailed (paid)
- Image optimization (Polish, Mirage)
- Rate limiting
- **Free plan:** Unlimited bandwidth for static files!

---

### 2. BunnyCDN (Bunny.net)

**Best for:** Cheapest CDN for storage + delivery

| Product | Price |
|---------|-------|
| CDN | From $0.01/GB bandwidth |
| Storage (BunnyStorage) | $0.01/GB/month |
| Stream (video) | $0.005/min stored, $0.01/GB delivered |
| DNS | Free |

**Key facts:**
- 114+ PoPs globally
- 99.9% SLA
- Very predictable, cheap pricing
- No minimum commitment
- Storage integrated with CDN (BunnyCDN Zones)
- Simple dashboard
- **Best value for video streaming** (significantly cheaper than Cloudflare Stream)

---

### 3. AWS CloudFront

- Global CDN with 450+ PoPs
- Integrates with S3, EC2, Load Balancer, API Gateway
- **Free tier:** 1TB/month, 10M requests
- **Paid:** $0.0085/GB (after free tier) — **egress costs are significant**
- Lambda@Edge and CloudFront Functions for compute at edge
- Best for AWS-native architectures

---

### 4. Fastly CDN

- Real-time purging (near-instant cache invalidation)
- Varnish-based edge (VCL configuration)
- Best for: Media companies, news sites needing instant cache invalidation
- More expensive than Cloudflare
- Strong DDoS protection

---

## Edge vs Traditional Serverless — Decision

```
Do you need:
├── <10ms latency for millions of global users?
│   → Cloudflare Workers (edge serverless)
│
├── Simple backend API, TypeScript-first?
│   → Deno Deploy or Cloudflare Workers
│
├── Deep AWS integration / long timeouts (up to 15min)?
│   → AWS Lambda
│
├── Containerized serverless with scale-to-zero?
│   → GCP Cloud Run (best in class)
│
├── Just static content delivery?
│   ├── Want free (generous) → Cloudflare Pages
│   ├── Want cheapest bandwidth → BunnyCDN
│   └── Already on AWS → CloudFront
│
└── WebSocket / stateful edge?
    → Cloudflare Workers + Durable Objects
```

---

## Cost Comparison: Same Workload on Different Platforms

**Scenario:** 10M requests/month, 50ms average duration, 128MB memory

| Platform | Monthly Cost |
|----------|-------------|
| Cloudflare Workers | $3 ($3/month base, requests included) |
| Vercel Edge Functions | Included in Pro plan (~$20) |
| AWS Lambda | ~$2.50 (free tier covered, minimal pay after) |
| GCP Cloud Run | ~$1–$3 (free tier helps) |
| Traditional VPS | $5–$10/month fixed |

**Verdict:** At 10M requests/month, serverless is cheaper than VPS.
At 100M+ requests/month, compute-heavy workloads may be cheaper on VPS.

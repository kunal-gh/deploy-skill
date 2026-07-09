# Reference: Architecture Patterns for Deployment (2026)

> Last research update: 2026-07-09

---

## Official Source Targets

| Topic | Source |
|---|---|
| AWS Well-Architected | https://docs.aws.amazon.com/wellarchitected |
| Google Cloud Architecture Framework | https://cloud.google.com/architecture/framework |
| Azure Well-Architected Framework | https://learn.microsoft.com/azure/well-architected |
| Kubernetes workloads | https://kubernetes.io/docs/concepts/workloads |
| CNCF landscape | https://landscape.cncf.io |
| OpenTelemetry | https://opentelemetry.io/docs |

---

## Overview: Choosing the Right Architecture

The biggest deployment mistake in 2026: **premature architectural complexity.**

The industry has largely returned to pragmatism after the "microservices for everything" era:
- Start with a **modular monolith**
- Extract to microservices ONLY when you have a specific, demonstrable need
- Use serverless for **specific** event-driven components, not everything

---

## SECTION A: Architecture Patterns

### 1. Modular Monolith (Recommended Starting Point)

**What:** Single deployable unit with well-organized internal modules/domains.
All code in one process, deployed together.

**When to use:**
- Starting a new project
- Team of 1–20 developers
- Domain not well-understood yet
- Deployment simplicity needed

**Deployment:**
```
Single Docker container or buildpack deployment
→ Railway, Render, Fly.io, any VPS
Single PostgreSQL database
Single Redis instance
CI/CD: One pipeline, one deployment
```

**Structure Example:**
```
src/
  users/          # User module (auth, profile, settings)
  orders/         # Order module (cart, checkout, fulfillment)
  products/       # Product module (catalog, search, pricing)
  notifications/  # Notification module (email, SMS, push)
  shared/         # Shared utilities, DTOs, database client
main.ts           # Single entry point
```

**When to SPLIT into microservices:**
- Different teams own different modules and deployment conflicts cause friction
- Specific module needs dramatically different scaling (e.g., ML inference vs. API)
- Module needs different technology (e.g., Go for high-throughput, Python for ML)

---

### 2. Microservices

**What:** Multiple independently deployable services, each owning its own data.

**When to use:**
- Team of 20+ developers
- Clear domain boundaries that map to team ownership
- Different scaling requirements per service
- Need to independently deploy different components

**Deployment complexity:**
```
Each service: Own Docker container
Service discovery: Kubernetes or service mesh
API Gateway: Kong, Traefik, AWS API Gateway
Databases: One per service (own schema)
CI/CD: Per-service pipeline
Communication: HTTP/REST, gRPC, or message queue
Observability: Distributed tracing (required, not optional)
```

**Anti-patterns to avoid:**
- Splitting too early (before you understand the domain)
- Distributed monolith (services that must deploy together)
- Chatty services (100+ RPC calls per request)
- Shared databases between services

**Deployment Platforms:**
- **Simple microservices (2–5 services):** Railway or Render (deploy each as a service)
- **Complex microservices (5–20 services):** Northflank or Fly.io (better networking)
- **Enterprise microservices (20+ services):** Kubernetes (GKE, EKS, AKS) or BYOC (Qovery)

---

### 3. Serverless / Functions

**What:** Stateless functions triggered by events. No servers to manage. Pay per invocation.

**When to use:**
- Event-driven processing (image resizing, webhook handling)
- Unpredictable traffic (sometimes 0 requests, sometimes 10K/minute)
- Scheduled tasks (cron jobs)
- ETL pipelines
- NOT as a primary application architecture for complex apps

**Types:**
| Type | Examples | Use For |
|------|---------|---------|
| HTTP Functions | AWS Lambda + API GW, GCP Cloud Functions | Simple APIs, webhooks |
| Event-triggered | Lambda from S3/SQS, Cloud Functions from Pub/Sub | Async processing |
| Edge Functions | Cloudflare Workers, Vercel Edge | Request manipulation |
| Scheduled | Lambda Cron, Cloud Scheduler | Batch jobs, reports |

**Cold start mitigation:**
- Keep functions small and fast
- Use provisioned concurrency (AWS Lambda)
- Use min instances (GCP Cloud Run)
- Use edge runtimes (Cloudflare Workers — no cold start)

**Gotchas:**
- Local development is harder
- Debugging distributed functions is harder
- Vendor lock-in (Lambda → AWS tightly coupled)
- State management complex (use Durable Objects, Step Functions, Temporal)

---

### 4. JAMstack

**What:** JavaScript (frontend), API (external or serverless), Markup (pre-rendered).
Pre-built HTML served from CDN, APIs called at runtime.

**When to use:**
- Content-heavy websites (blogs, marketing, docs)
- E-commerce frontends (with commerce API)
- Web apps that can tolerate build time for fresh data

**Technologies:**
```
SSG (Static Site Generation): Next.js, Astro, Gatsby, Hugo
SSR (Server-Side Rendering): Next.js, Nuxt, SvelteKit, Remix
ISR (Incremental Static Regen): Next.js on Vercel (updates pages on demand)
```

**Deployment:**
```
Static/SSG: Cloudflare Pages (best), Netlify, Vercel
SSR: Vercel (Next.js), Fly.io, Railway, Cloudflare Workers
API: Supabase, PlanetScale, external APIs
```

---

### 5. Edge-First Architecture

**What:** Business logic runs at CDN edge locations, globally distributed by default.

**When to use:**
- Global user base needing <10ms latency
- API route that must execute close to users
- Auth/middleware that runs before every request

**Platforms:**
- Cloudflare Workers (most complete edge platform)
- Deno Deploy (TypeScript-first)
- Vercel Edge Functions (Next.js middleware)

**Edge Gotchas:**
- Limited to Web Standard APIs (no Node.js APIs)
- Memory limited (128MB)
- Database must be edge-compatible (D1, Turso, Upstash Redis, Hyperdrive)
- Debugging harder than traditional Node.js

---

### 6. Event-Driven Architecture

**What:** Services communicate via events/messages (not direct HTTP calls).
Producer emits events → Queue → Consumer processes asynchronously.

**When to use:**
- Decoupling services (producer doesn't care who consumes)
- Handling traffic spikes (queue absorbs load)
- Long-running background tasks
- Audit trails / event sourcing

**Message Queue Options:**
| Service | Free Tier | Best For |
|---------|-----------|---------|
| Upstash Kafka | 10K messages/day | Serverless event streaming |
| Cloudflare Queues | 1M messages/month | Cloudflare Workers workloads |
| AWS SQS | 1M requests/month | AWS ecosystem |
| GCP Pub/Sub | 10GB/month | GCP ecosystem |
| RabbitMQ (self-hosted) | Free | Traditional message queuing |
| BullMQ (Redis-based) | Free (uses Redis) | Node.js job queues |

**Workflow Orchestration:**
- **Inngest:** TypeScript-native durable workflows, free tier
- **Temporal:** Enterprise-grade workflow orchestration, self-hosted
- **AWS Step Functions:** AWS-native state machines
- **Trigger.dev:** Background jobs for Node.js/TypeScript, simple API

---

## SECTION B: Deployment Strategies

### Blue-Green Deployment

**What:** Two identical production environments. Switch traffic between them for zero-downtime deploys.

```
Traffic → [Blue (v1.0)] [Green (v1.1)] → deploy to Green
                                      → test Green
                                      → switch traffic to Green
                                      → Blue becomes standby
```

**Pros:** Instant rollback (just switch traffic back to Blue)  
**Cons:** Double infrastructure cost during deploy  
**Tools:** AWS CodeDeploy, Kubernetes services, Cloudflare Traffic Manager

---

### Canary Deployment

**What:** Gradually route percentage of traffic to new version.

```
Traffic split:
Day 1: 1% → v1.1, 99% → v1.0
Day 2: 10% → v1.1, 90% → v1.0
Day 3: 50% → v1.1, 50% → v1.0
Day 4: 100% → v1.1 (full rollout)
```

**Pros:** Catch bugs before they affect all users  
**Cons:** Both versions run simultaneously, monitoring complexity  
**Tools:** Kubernetes (with Gateway API), Fly.io (multiple VMs), LaunchDarkly feature flags

---

### Rolling Deployment

**What:** Replace instances one-by-one with new version.

```
[v1.0] [v1.0] [v1.0] [v1.0]
→ [v1.1] [v1.0] [v1.0] [v1.0]
→ [v1.1] [v1.1] [v1.0] [v1.0]
→ [v1.1] [v1.1] [v1.1] [v1.0]
→ [v1.1] [v1.1] [v1.1] [v1.1]
```

**Pros:** No extra infrastructure cost  
**Cons:** Old and new version run simultaneously  
**Used by:** Kubernetes (default), Railway, Render

---

### Immutable Infrastructure

**What:** Never modify servers. Build new server images for each deploy. Replace all instances.

**Pros:** No drift, always reproducible  
**Cons:** Longer deploy time  
**Tools:** Docker + Container Registry, Packer (AMI building)

---

## SECTION C: GitOps Pattern

**What:** Git is the single source of truth for infrastructure AND application state.

```
Developer pushes code → PR → Review → Merge to main
                                        ↓
                              CI: Build + Test + Push image
                                        ↓
                              GitOps: ArgoCD/FluxCD detects change
                                        ↓
                              Kubernetes cluster updated automatically
```

**Benefits:**
- All changes are tracked via Git history
- Easy rollback (revert a Git commit = rollback infrastructure)
- Audit trail for compliance
- Developer-friendly (know Git? Know GitOps)

**Tools:** ArgoCD, FluxCD, Spinnaker

---

## SECTION D: Feature Flags

Feature flags decouple deployment from release:
- Deploy code to production (disabled)
- Enable features for specific users/percentage
- Roll back features without deploying code

| Service | Free Tier | Notes |
|---------|-----------|-------|
| LaunchDarkly | No free | Industry standard |
| PostHog | Free (self-hosted) | Analytics + Feature flags |
| Flagsmith | Free (self-hosted) | Open source |
| Unleash | Free (self-hosted) | Open source, battle-tested |
| GrowthBook | Free (self-hosted) | A/B testing + feature flags |

---

## SECTION E: Architecture Decision Record (ADR)

When advising on architecture, always consider these factors:

### Team Considerations
- Team size: < 5 → monolith; 5–20 → careful; 20+ → can justify microservices
- DevOps maturity: Low → managed PaaS; High → self-hosted or BYOC
- Domain knowledge: New domain → monolith first

### Data Considerations
- Data volume: < 100GB → simple managed DB; > 1TB → multi-node, careful partitioning
- Read/write ratio: Read-heavy → caching + read replicas; Write-heavy → message queues
- Consistency needs: Strong → PostgreSQL; Eventual OK → NoSQL/eventually consistent

### Traffic Considerations
- Average RPM: < 1K → single server; 1K–100K → horizontal scaling; 100K+ → edge/distributed
- Traffic pattern: Steady → VPS/containers; Spiky → serverless/autoscaling
- Latency requirements: < 10ms global → edge; < 100ms → multi-region; < 500ms → single region

### Cost Model
- Budget constrained → optimize for $ per request
- Scale constrained → optimize for complexity per engineer
- Time constrained → optimize for time-to-market (managed PaaS > self-hosted)

---

## Quick Architecture Recommendations

| Project | Recommended Architecture |
|---------|------------------------|
| Landing page / blog | JAMstack (Astro/Next.js + Cloudflare Pages) |
| SaaS MVP | Modular monolith (Railway + PostgreSQL) |
| API-only backend | Single container (Railway/Fly.io + Supabase) |
| High-traffic API | Containerized + autoscaling (GCP Cloud Run or Fly.io) |
| Real-time app | Container + WebSocket support (Fly.io/Railway + Ably/Pusher) |
| AI application | Modal (GPU) + Supabase (pgvector) + Vercel (frontend) |
| Enterprise SaaS | Microservices or modular monolith on Kubernetes (GKE/EKS) |
| Personal project | VPS + Coolify (Hetzner, ~$5/month total) |
| Global edge app | Cloudflare Workers + D1 + R2 |

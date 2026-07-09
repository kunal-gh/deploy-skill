# Reference: Multi-Dimensional Deployment Decision Logic (2026)

> Last research update: 2026-07-09
> Follow this logical workflow step-by-step to compile a final stack.

---

## 1. Step 1: Compute Engine Selector

```
                         [ Tech Stack & Runtime ]
                                    |
            -------------------------------------------------
            |                                               |
     [ Static / JAMstack ]                       [ Dynamic Backend / APIs ]
            |                                               |
     ------------------                     ---------------------------------
     |                |                     |                               |
[ Edge Isolates ] [ Node SSR ]     [ Persistent Process? ]      [ Batch / GPU Workload? ]
     |                |                     |                               |
Cloudflare Pages    Vercel         ------------------                -----------------
Deno Deploy        Netlify         |                |                |               |
                                [ YES ]           [ NO ]        [ GPU/ML ]        [ Jobs ]
                                   |                |                |               |
                            PaaS Container     Serverless      Modal/RunPod     Cloud Run
                            Railway/Fly.io     Cloud Run       Northflank       AWS Batch
```

### Logical Rules
1. **If the project requires WebSockets, active gRPC connections, or background worker loops (>15 minutes):**
   - **MUST NOT** use Vercel, Netlify, or Cloudflare Workers.
   - **MUST** route to PaaS Container hosting (Railway, Fly.io, Render) or raw VMs (Hetzner, DigitalOcean).
2. **If the user has a strict $0 budget:**
   - For static/edge: Cloudflare Pages (Free, unlimited bandwidth).
   - For simple backend: Render Free tier (warn about sleeping dynos) or Fly.io under-resource VM limits.
3. **If the project requires GPU processing:**
   - **MUST** route to Modal, RunPod, or Northflank GPU.
4. **If the team size is >10 and they require infrastructure ownership (BYOC):**
   - **MUST** route to Northflank BYOC or Qovery.

---

## 2. Step 2: Database Selector

```
                          [ Database Class ]
                                  |
         --------------------------------------------------
         |                                                |
    [ Relational ]                                  [ Non-Relational ]
         |                                                |
   --------------                                  ----------------
   |            |                                  |              |
[ Serverless ] [ Dedicated ]                  [ Document ]    [ Key-Value ]
   |            |                                  |              |
 Neon         Supabase                        MongoDB Atlas     Upstash
 Turso (Edge) Railway Postgres                DynamoDB          Upstash Redis
```

### Logical Rules
1. **If using serverless compute (Vercel / Cloudflare Workers):**
   - Prefer a **serverless database** (Neon, Turso, or Upstash) to avoid exhausting Postgres connection limits during serverless spikes.
2. **If using standard container compute (Railway / Render):**
   - Prefer a **dedicated database instance** (Railway managed Postgres, Supabase Pro) utilizing a connection pooler (PgBouncer).
3. **If low latency at the edge is the primary requirement:**
   - Recommened **Turso** (SQLite at the edge) or **Cloudflare D1**.

---

## 3. Step 3: Stack Recipes Matrix

Use this matrix to match budget and project scale directly to a recipe:

| Budget / Scale | Monolith Stack | JAMstack Stack | MicroVM / Global Stack |
|---|---|---|---|
| **$0 (Bootstrap)** | Render Free Web App + Supabase Free DB | Cloudflare Pages + Turso Free + Sentry Free | Fly.io (shared-cpu) + PocketBase local SQLite |
| **$15-$30 (Pro Solo)** | Railway ($5 base + usage) + Neon Pro ($19) | Vercel Pro ($20) + Supabase Pro ($25) | Sliplane Starter (€9) + Hetzner VPS ($5) |
| **$200-$500 (Scaleup)** | Render Web Service + Managed RDS Postgres + Redis | Vercel Enterprise + Supabase Team | Fly.io Multi-region Machines + Neon Scale |
| **$1000+ (Enterprise)** | Northflank BYOC (AWS) + AWS RDS Aurora + Datadog | Vercel Enterprise + Neon Enterprise + Datadog | Qovery (AWS EKS) + AWS DocumentDB + Elastic |

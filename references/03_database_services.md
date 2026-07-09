# Reference: Database Services (2026)

> Last research update: 2026-07-09
> Database pricing changes frequently. Always check official pricing pages.

---

## Official Source Targets

| Platform | Docs | Pricing / limits |
|---|---|---|
| Supabase | https://supabase.com/docs | https://supabase.com/pricing |
| Neon | https://neon.com/docs | https://neon.com/pricing |
| PlanetScale | https://planetscale.com/docs | https://planetscale.com/pricing |
| CockroachDB | https://www.cockroachlabs.com/docs | https://www.cockroachlabs.com/pricing |
| Xata | https://xata.io/docs | https://xata.io/pricing |
| Turso | https://docs.turso.tech | https://turso.tech/pricing |
| MongoDB Atlas | https://www.mongodb.com/docs/atlas | https://www.mongodb.com/pricing |
| Firestore | https://firebase.google.com/docs/firestore | https://firebase.google.com/pricing |
| DynamoDB | https://docs.aws.amazon.com/dynamodb | https://aws.amazon.com/dynamodb/pricing |
| Upstash | https://upstash.com/docs | https://upstash.com/pricing |
| Pinecone | https://docs.pinecone.io | https://www.pinecone.io/pricing |
| Qdrant | https://qdrant.tech/documentation | https://qdrant.tech/pricing |
| Weaviate | https://weaviate.io/developers/weaviate | https://weaviate.io/pricing |

---

## Database Types Quick Reference

| Type | Use When | Examples |
|------|----------|---------|
| Relational (PostgreSQL) | Structured data, complex queries, ACID compliance | Supabase, Neon, PlanetScale, CockroachDB |
| Relational (MySQL) | WordPress, Laravel, high-speed reads | PlanetScale, Aiven MySQL, Railway MySQL |
| Document (NoSQL) | Flexible schema, nested data | MongoDB Atlas, Firestore, DynamoDB |
| Key-Value | Sessions, caching, rate limiting, queues | Upstash Redis, Redis Cloud, DynamoDB |
| Vector | AI/embeddings, semantic search, RAG | Pinecone, Qdrant, Weaviate, pgvector |
| Time Series | IoT, metrics, monitoring data | TimescaleDB, InfluxDB, QuestDB |
| Graph | Social networks, recommendations, knowledge graphs | Neo4j Aura |
| Edge / SQLite | Edge functions, global reads, small data | Cloudflare D1, Turso, Deno KV |

---

## SECTION A: PostgreSQL Services

### 1. Supabase (Database Layer)

**Best for:** Full-stack apps wanting PostgreSQL + auth + storage in one platform

| Tier | Price | DB Storage | Connections | Bandwidth |
|------|-------|-----------|-------------|-----------|
| Free | $0 | 500MB | 60 direct / pooled | 5GB |
| Pro | $25/mo | 8GB (+ $0.125/GB extra) | Pooled unlimited | 250GB |
| Team | $599/mo | Custom | Custom | Custom |

**Features:**
- Full PostgreSQL (not a wrapper — real Postgres with all extensions)
- Connection pooling via PgBouncer (built-in)
- Point-in-time recovery (PITR) on Pro+
- Daily backups (free) / 7-day PITR (Pro)
- Read replicas: Available on Pro
- pgvector: Built-in (AI/vector search)
- PostGIS: Built-in (geospatial)
- Real-time: Supabase Realtime subscriptions on DB changes
- Row-level security (RLS)
- Self-hostable (Docker Compose)
- Prisma, Drizzle, SQLAlchemy, Django ORM compatible

**ORM compatibility:** Prisma, Drizzle ORM, Sequelize, TypeORM, SQLAlchemy, Django ORM

**Gotchas:**
- Free tier pauses after 1 week of inactivity (project sleeps)
- Direct connections limited on free tier (use connection pooler)
- Some advanced PostgreSQL config settings locked

---

### 2. Neon

**Best for:** Serverless PostgreSQL with branching, CI/CD workflows, scale-to-zero

| Tier | Price | DB Storage | Compute |
|------|-------|-----------|---------|
| Free | $0 | 0.5GB | 0.25 vCPU, 1GB RAM, scale-to-zero |
| Launch | $19/mo | 10GB | 0.25–4 vCPU |
| Scale | $69/mo | 50GB | 0.25–8 vCPU |
| Business | $700/mo | Custom | Custom |

**Unique Features:**
- **Database branching** — Git-like branches for each dev/staging environment
- **Scale-to-zero** — Compute pauses when idle (you pay $0 when not in use)
- **Instant branching** — Copy-on-write, creates branch in seconds not minutes
- **Autoscaling** — Compute scales automatically based on load
- Postgres 15, 16 support
- Connection pooling built-in
- PITR on paid plans

**ORM compatibility:** All PostgreSQL ORMs (Prisma, Drizzle, etc.)

**Best for:**
- CI/CD workflows (branch per PR)
- Development environments
- Variable/spiky workloads (pay only when active)
- Cost-conscious production

**Gotchas:**
- Free tier limited to 0.25 vCPU — not suitable for production workloads
- Scale-to-zero means cold starts (1–3 seconds)

---

### 3. PlanetScale

**Best for:** MySQL serverless at scale, high-throughput production

**Note:** PlanetScale now offers **both MySQL and PostgreSQL** products (PostgreSQL added 2025/2026)

| Tier (PostgreSQL) | Price | Notes |
|-------------------|-------|-------|
| Scaler | $39/mo | 10GB storage, 1 billion reads/mo |
| Scaler Pro | $99/mo | 25GB storage, unlimited reads |
| Enterprise | Custom | NVMe-backed, high IOPS |

**Unique Features:**
- **Database deploy requests** — Safer schema migrations (like PRs for database changes)
- **Branching** — Create database branches for testing schema changes
- High-performance NVMe-backed storage on Enterprise
- Vitess under the hood (used by YouTube, GitHub)
- Exceptional read throughput

**Best for:**
- High-traffic production applications
- Applications needing safe schema migrations at scale
- Companies that prioritize raw database performance

**Gotchas:**
- MySQL product: Foreign keys not supported (Vitess limitation) — historically controversial
- PostgreSQL product is newer, less battle-tested than MySQL product

---

### 4. CockroachDB

**Best for:** Multi-region, globally distributed PostgreSQL-compatible database

| Tier | Price | Notes |
|------|-------|-------|
| Serverless | Free up to 50M RUs + 10GB | Request Unit pricing |
| Dedicated | $295/month | Fully managed, single-region |
| Advanced | Custom | Multi-region, higher SLA |

**Unique Features:**
- PostgreSQL-compatible (wire protocol)
- **Multi-region** with automatic data placement
- Horizontal scaling without resharding
- Automatic failover, 99.999% SLA (Advanced)
- ACID compliance across distributed nodes
- Serializable isolation

**Best for:**
- Global applications needing multi-region SQL
- Financial applications (high consistency requirements)
- Applications that need to scale across regions seamlessly

**Gotchas:**
- Expensive for small projects
- Some PostgreSQL features not 100% compatible
- Learning curve for multi-region topology planning

---

### 5. Xata

**Best for:** PostgreSQL with built-in search and analytics, dev-friendly

| Tier | Price | Notes |
|------|-------|-------|
| Free | $0 | 15GB storage, 250 record limit per table |
| Pro | $20/month | 25GB, unlimited records |
| Business | $150/month | 200GB |

**Features:**
- PostgreSQL-based with REST + TypeScript SDK
- Built-in full-text search (Elasticsearch integration)
- Built-in analytics column
- Database branching
- Schema visualization in UI

---

### 6. Turso (SQLite at the Edge)

**Best for:** Edge functions, globally distributed SQLite, Cloudflare Workers

| Tier | Price | Notes |
|------|-------|-------|
| Starter | $0 | 500 databases, 9GB total storage |
| Scaler | $29/month | 10K databases, 100GB |
| Enterprise | Custom | Unlimited |

**Features:**
- **libSQL** — Open-source fork of SQLite
- **Edge replicas** — Replicate your database to 30+ locations worldwide
- <1ms reads from edge replicas
- HTTP API (works in edge runtimes)
- Embedded replicas (in-process SQLite with automatic sync)
- Works perfectly with Cloudflare Workers, Deno Deploy, Vercel Edge

**Best for:**
- Applications with Cloudflare Workers backend
- Globally distributed apps needing low-latency reads
- Multi-tenant apps (one database per customer = 500+ free DBs)

---

### 7. Aiven (Managed Open Source DBs)

**Best for:** Teams wanting managed versions of open-source databases with EU hosting

Manages: PostgreSQL, MySQL, Redis, Kafka, OpenSearch, Cassandra, InfluxDB, Grafana

| Plan | Starting Price |
|------|---------------|
| Startup | ~$15/month |
| Business | ~$50/month |
| Premium | Custom |

**Features:**
- 100% open-source, no proprietary components
- AWS/GCP/Azure/DigitalOcean/Azure regions
- GDPR-compliant EU options
- Automatic backups + PITR
- Multi-cloud and private networking

**Best for:** EU-based projects needing compliance, teams wanting multi-DB provider on one platform

---

### 8. Cloud Provider Managed PostgreSQL

| Provider | Service | Starting Price | Notes |
|----------|---------|---------------|-------|
| AWS | RDS PostgreSQL | ~$20/month (db.t4g.micro) | Enterprise-grade, most features |
| AWS | Aurora Serverless v2 | ~$0.12/ACU-hr | Auto-scales, can be expensive |
| GCP | Cloud SQL | ~$7/month (shared core) | Google ecosystem |
| Azure | Azure PostgreSQL Flexible | ~$12/month | Azure ecosystem |
| DigitalOcean | Managed PostgreSQL | $15/month | Simple, affordable |
| Render | Managed PostgreSQL | $7/month | Simplest setup |
| Railway | PostgreSQL | ~$5/month (usage) | Built-in with Railway services |

---

## SECTION B: NoSQL / Document Databases

### 1. MongoDB Atlas

**Best for:** Document databases, JSON-heavy applications, MongoDB native tooling

| Tier | Price | Notes |
|------|-------|-------|
| Free (M0) | $0 | 512MB storage, shared cluster |
| Serverless | Pay-per-op | $0.10/million reads |
| Dedicated (M10) | $57/month | 2GB RAM, 10GB storage |

**Features:**
- Full MongoDB with all features
- Global clusters (multi-region)
- Atlas Search (built-in Lucene)
- Atlas Vector Search (built-in vector indexing)
- Atlas Triggers (database event functions)
- Charts (built-in data visualization)
- GDPR, SOC 2, HIPAA compliant

**ORM/ODM:** Mongoose (Node.js), Motor (Python), Spring Data MongoDB

---

### 2. Firestore (Google Firebase)

**Best for:** Mobile apps, real-time sync, Google ecosystem

| Tier | Price | Notes |
|------|-------|-------|
| Spark (Free) | $0 | 1GB storage, 50K reads/day, 20K writes/day |
| Blaze (Pay-as-you-go) | Usage-based | $0.06/100K reads, $0.18/100K writes, $0.02/GB/month |

**Features:**
- Real-time sync to connected clients
- Offline support (mobile SDKs)
- Scales automatically
- Strong integration with Firebase Auth, Storage, Functions
- Collection/Document model

**Gotchas:**
- Document size limited to 1MB
- Complex queries require composite indexes
- Reading large datasets expensive

---

### 3. DynamoDB (AWS)

**Best for:** AWS ecosystem, extreme scale, key-value access patterns

| Billing | Price |
|---------|-------|
| On-demand | $1.25/million writes, $0.25/million reads |
| Provisioned | Can be cheaper at predictable scale |
| Free tier | 25GB storage, 25 WCU + 25 RCU (always free) |

**Features:**
- Infinite horizontal scale
- Single-digit millisecond latency
- Multi-region with Global Tables
- Streams for event-driven processing
- DynamoDB Accelerator (DAX) for microsecond caching

**Gotchas:**
- NoSQL — complex queries need careful design
- No joins, limited secondary indexes
- Vendor lock-in to AWS

---

## SECTION C: Cache / Key-Value / Queue

### 1. Upstash (Redis + Kafka + QStash)

**Best for:** Serverless Redis, per-request pricing, edge-compatible

| Product | Free Tier | Paid |
|---------|-----------|------|
| Redis | 10K commands/day, 256MB | $0.20/100K commands |
| Kafka | 10K messages/day, 10GB | $0.60/100K messages |
| QStash | 500 messages/day | $1/100K messages |
| Vector | 10K vectors | Usage-based |

**Why Upstash over standard Redis:**
- **Per-request pricing** — Perfect for serverless (no idle costs)
- **Edge-compatible** — Works in Cloudflare Workers, Vercel Edge, etc.
- **Durable Redis** — Optional persistent storage
- **Global replication** — Multi-region reads available

**Best for:** Serverless applications, edge functions, rate limiting, session storage

---

### 2. Redis Cloud

**Best for:** Full-featured Redis with enterprise support

| Tier | Price | Notes |
|------|-------|-------|
| Free | $0 | 30MB |
| Fixed | From $5/month | Up to 1TB |
| Flexible | Usage-based | Enterprise |

**Features:**
- Redis Modules (RediSearch, RedisJSON, RedisGraph, RedisTimeSeries, RedisAI)
- Active-Active geo-distribution
- Enterprise support options

---

## SECTION D: Vector Databases (AI/ML)

### 1. pgvector (PostgreSQL Extension)

**Best recommendation for most teams starting out.**

Available on: Supabase (built-in), Neon, any PostgreSQL

**Free:** Yes, if using existing PostgreSQL

**Features:**
- Exact nearest neighbor search (IVFFlat, HNSW indexes)
- Cosine, L2, inner product distance
- pgvectorscale (Timescale) for production-scale performance
- Full SQL alongside vector search

**When to use:** Always try pgvector first. Only move to dedicated vector DB when:
- Millions of vectors with very high QPS requirements
- Need hybrid search that pgvector can't handle at your scale

---

### 2. Pinecone

**Best for:** Zero-ops vector database, fastest path to production

| Tier | Price | Notes |
|------|-------|-------|
| Free | $0 | 2 indexes, 1 project |
| Standard | $70/month base | Serverless billing |
| Enterprise | Custom | Custom |

**Features:**
- Fully managed, serverless vector database
- Very fast query times
- Metadata filtering
- Namespaces for multi-tenant
- Hybrid search (sparse + dense)

**Gotchas:** Can become expensive at large scale (proprietary pricing model)

---

### 3. Qdrant

**Best for:** Price-performance leader, production-scale vector search, open source

| Tier | Price | Notes |
|------|-------|-------|
| Cloud Free | $0 | 1 cluster, 1GB RAM |
| Cloud Paid | From $9/month | 0.5GB RAM starter |
| Self-hosted | Free | Run on your own servers |

**Features:**
- Written in Rust — extremely fast and memory efficient
- Advanced quantization (1.5-bit, 2-bit, binary, scalar) = 97% memory savings
- HNSW index
- Payload filtering
- Sparse + dense hybrid search
- Gridstore storage engine (proprietary, very fast)
- Open source (Apache 2.0)

**Best for:** Teams needing high-throughput, large-scale vector search at reasonable cost

---

### 4. Weaviate

**Best for:** Hybrid search (vector + BM25), complex RAG applications

| Tier | Price | Notes |
|------|-------|-------|
| Serverless Free | $0 | Sandbox, 14-day data retention |
| Serverless Standard | Usage-based | Per object stored/queried |
| Dedicated | From ~$100/month | Dedicated clusters |

**Features:**
- Native hybrid search (BM25 + vector in one query)
- Multi-tenancy support
- Built-in vectorization via modules (OpenAI, Cohere, etc.)
- GraphQL API
- Self-hostable (Docker)

**Best for:** RAG systems where keyword precision matters alongside semantic search

---

### 5. Chroma

**Best for:** Local development, prototyping, open source, Python-native

- Open source, runs locally or as a cloud service
- Python-first API
- Very simple to get started
- Not ideal for production at scale

---

## SECTION E: Edge / Distributed Databases

### 1. Cloudflare D1

**Best for:** SQLite at the edge, Cloudflare Workers

| Tier | Price | Notes |
|------|-------|-------|
| Free | $0 | 5GB storage, 5M rows read/day, 100K rows written/day |
| Paid | $0.75/GB-month | $0.001/100K reads, $1/million writes |

**Features:**
- SQLite at the global edge
- Runs alongside Cloudflare Workers (no network hop)
- D1 Batch API for multiple queries
- D1 Sessions API
- Import from SQLite files

**Best for:** Cloudflare Workers backends with structured relational data

---

### 2. Deno KV

**Best for:** Deno Deploy applications, key-value at edge

- Global key-value store for Deno Deploy
- ACID transactions
- Built-in queuing (Deno Queues)
- Free tier: 1GB storage, limited operations
- Paid: Usage-based

---

## SECTION F: Time Series Databases

### 1. TimescaleDB (Timescale Cloud)

| Tier | Price |
|------|-------|
| Free | $0 (limited) |
| Dynamic | From $49/month |
| Performance | Custom |

**Features:**
- PostgreSQL extension — SQL for time series
- Automated partitioning (hypertables)
- Continuous aggregates for fast queries
- pgvector support (AI + time series combined)
- Self-hostable

---

### 2. InfluxDB Cloud

**Best for:** IoT, metrics, monitoring

| Tier | Price |
|------|-------|
| Free | $0 (30-day data retention, 10KB/write, 300MB/5min query) |
| Pay-as-you-go | Usage-based |
| Annual | From $250/month |

---

## SECTION G: Graph Databases

### 1. Neo4j Aura

| Tier | Price |
|------|-------|
| Free | $0 (1 database, 200K nodes, 400K relationships) |
| Professional | From $65/month |
| Enterprise | Custom |

**Best for:** Recommendation engines, knowledge graphs, fraud detection, social networks

---

## Database Selection Decision Tree

```
What type of data are you storing?

├── Structured, relational data (tables, joins, foreign keys)
│   ├── Already on a platform? → Use their built-in PostgreSQL
│   ├── Serverless / variable traffic → Neon (branching, scale-to-zero)
│   ├── Need BaaS features too → Supabase (auth + storage + DB)
│   ├── MySQL specifically → PlanetScale or Aiven MySQL
│   ├── Multi-region, distributed → CockroachDB
│   └── Simple, affordable → Render PostgreSQL or Railway PostgreSQL
│
├── Flexible/nested JSON data
│   ├── MongoDB → MongoDB Atlas
│   ├── Firebase ecosystem → Firestore
│   └── AWS → DynamoDB
│
├── Caching / sessions / rate limiting / queues
│   ├── Serverless (pay-per-request) → Upstash Redis
│   └── Always-on, high-throughput → Redis Cloud
│
├── Vector search / AI / embeddings
│   ├── Already using PostgreSQL → pgvector (start here!)
│   ├── Need zero-ops managed → Pinecone
│   ├── Need hybrid search (BM25+vector) → Weaviate
│   ├── Need price-performance at scale → Qdrant
│   └── Local dev / prototype → Chroma
│
├── Time series (IoT, metrics, events)
│   ├── SQL-familiar → TimescaleDB
│   └── Purpose-built → InfluxDB Cloud
│
├── Graph (social, recommendations, fraud)
│   └── → Neo4j Aura
│
└── Edge / SQLite (at Cloudflare Workers / global edge)
    ├── Cloudflare Workers → D1
    ├── Global distributed SQLite → Turso
    └── Deno Deploy → Deno KV
```

---

## Free Tier Summary Table

| Database | Free Storage | Free Tier Gotcha |
|----------|-------------|-----------------|
| Supabase | 500MB | Pauses after 1 week inactive |
| Neon | 512MB | Compute-limited (0.25 vCPU) |
| CockroachDB | 10GB | Request Unit limits |
| Turso | 9GB total (500 DBs) | Very generous! |
| MongoDB Atlas | 512MB | Shared cluster, limited performance |
| Firestore | 1GB | 50K reads/day only |
| DynamoDB | 25GB | Always free (AWS) |
| Upstash Redis | 256MB | 10K commands/day |
| Pinecone | 2 indexes | Serverless free tier |
| Qdrant Cloud | 1 cluster | 1GB RAM |
| D1 | 5GB | 5M rows read/day |
| Neo4j Aura | 200K nodes | Very limited |

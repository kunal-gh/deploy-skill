# Reference: Backend-as-a-Service (BaaS) Platforms (2026)

> Last research update: 2026-07-09
> Always verify pricing and limits at official docs.

---

## Official Source Targets

| Platform | Docs | Pricing / releases |
|---|---|---|
| Supabase | https://supabase.com/docs | https://supabase.com/pricing |
| Convex | https://docs.convex.dev | https://www.convex.dev/pricing |
| Nhost | https://docs.nhost.io | https://nhost.io/pricing |
| Appwrite | https://appwrite.io/docs | https://appwrite.io/pricing |
| PocketBase | https://pocketbase.io/docs | https://github.com/pocketbase/pocketbase/releases |

---

## 1. Supabase

**Category:** SQL-based open-source Firebase alternative  
**Website:** supabase.com  
**Best for:** Standard relational DB requirements, full Postgres extension capabilities, Auth + Storage integration, low lock-in.

### Pricing (2026)
- **Free:** 500MB database, 50,000 MAUs, 1GB storage, 5GB egress. Pauses after 7 days of inactivity.
- **Pro ($25/month):** 8GB database, 100,000 MAUs, 100GB storage, 50GB egress, daily backups, no pause.
- **Usage-based overages:** Billed per GB of storage, bandwidth, and compute beyond limits.
- **Self-Hosting:** Free and open-source. Runs on Docker on any VPS.

### Capabilities
- **Database:** Full managed PostgreSQL database with raw root access and `pgvector` support for AI workloads.
- **Real-time:** Real-time subscriptions listening to Postgres WAL changes.
- **Auth:** Email, password, magic links, phone (SMS), and standard OAuth providers.
- **Storage:** S3-compatible file storage with built-in CDN.

### Limitations & Gotchas
- **Inactivity Pause:** Free projects pause after 7 days of inactivity (can be manually restarted).
- **Overage bill shock:** Watch egress bandwidth and storage overage costs closely.

---

## 2. Convex

**Category:** Reactive document-relational BaaS  
**Website:** convex.dev  
**Best for:** Highly interactive TypeScript-native apps, real-time dashboards, multiplayer tools.

### Pricing (2026)
- **Free:** Generous hobby limits on database documents and function executions.
- **Pro ($25/dev/month):** seat-based pricing plus pay-per-use on compute minutes and storage.
- **Scaling:** Scales linearly with function execution time.

### Capabilities
- **TypeScript Native:** No SQL, no migrations, no ORMs. Database queries and mutations written entirely in TypeScript.
- **Automatic Reactivity:** Any query can be subscribed to by the frontend, updating in real-time as data changes.
- **Built-in Vector DB:** Integrated search for embeddings without external databases.
- **Deterministic runtime:** Strict consistency checks prevent race conditions.

### Limitations & Gotchas
- **High Vendor Lock-in:** Moving away requires rewriting your entire backend logic and schema since it uses Convex's proprietary runtime.
- **No SQL Access:** Traditional BI tools or SQL clients cannot connect directly to Convex.

---

## 3. Nhost.io

**Category:** Hasura-based GraphQL BaaS  
**Website:** nhost.io  
**Best for:** GraphQL-first applications, rapid API development with PostgreSQL.

### Pricing (2026)
- **Free:** 1 basic project, limited database and storage. Pauses after inactivity.
- **Pro ($25/month):** Automated backups, point-in-time recovery, dedicated compute limits.
- **Self-Hosting:** Fully open-source and deployable via Docker Compose.

### Capabilities
- **GraphQL Engine:** Powered by Hasura, automatically generating a high-performance GraphQL API from your Postgres schema.
- **Role-Based Access (RBAC):** Built-in Hasura permission matrix.
- **Nhost Run:** Custom container deployment option for running server-side workers.
- **Auth & Storage:** Managed user authentication and file CDN.

### Limitations & Gotchas
- **GraphQL Centricity:** If you do not want to use GraphQL, Nhost is overkill.
- **Hasura Lock-in:** Complex SQL schema management requires running Hasura migrations.

---

## 4. Appwrite

**Category:** Multi-tenant, polyglot BaaS  
**Website:** appwrite.io  
**Best for:** Mobile apps, web apps, and self-hosted backend systems needing complete compliance ownership.

### Pricing (2026)
- **Free:** 2 projects, 2GB storage, 5GB bandwidth, 75,000 MAUs.
- **Pro ($25/month):** 150GB storage, 2TB bandwidth, daily backups, unlimited databases.
- **Self-Hosted:** Free and open-source. Runs on single VPS servers using Docker.

### Capabilities
- **Databases:** Schemaless document database with queries and indexes.
- **Auth:** 30+ authentication methods.
- **Functions:** Supports serverless code execution in Node.js, Python, Go, PHP, Ruby, Deno, and Bun.
- **Messaging:** Built-in engine for push notifications (FCM/APNs), emails, and SMS.

### Limitations & Gotchas
- **No Direct SQL:** While it uses MariaDB/PostgreSQL internally, you access it via the Appwrite API, not raw SQL queries.

---

## 5. PocketBase

**Category:** Single-file Go BaaS  
**Website:** pocketbase.io  
**Best for:** Solo developers, simple mobile backends, local internal utilities, and lightweight apps.

### Pricing (2026)
- **100% Free and Open Source.**
- **Cost:** Just the cost of the VPS ($4-10/mo on Hetzner or DigitalOcean).

### Capabilities
- **Embedded Database:** Embedded SQLite database with automatic migrations.
- **Realtime API:** Live subscription updates.
- **S3 Support:** Can store files locally or hook directly into Cloudflare R2 / AWS S3.
- **Admin Dashboard:** Out-of-the-box UI for managing data and users.

### Limitations & Gotchas
- **No Horizontal Scaling:** SQLite is embedded. You cannot scale PocketBase horizontally across multiple servers. If you grow, you must scale vertically (larger VPS).

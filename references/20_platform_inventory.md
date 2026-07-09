# Reference: Platform Inventory and Coverage Map

> Last research update: 2026-07-09
> Purpose: broad market map used before selecting candidate stacks.

This file prevents the skill from overfitting on the same few platforms. It is
an inventory, not a recommendation. Use it to ensure candidate generation is
wide enough before applying constraints and source verification.

## Candidate Generation Rule

For every deployment question, generate candidates from at least three buckets
when they plausibly fit:

1. Managed developer platform.
2. Hyperscaler or cloud-native service.
3. Self-hosted or VPS option.
4. Specialized service, if the workload needs realtime, mobile, AI, IoT, edge,
   compliance, or heavy data processing.

Only after candidate generation should hard filters remove options.

## Coverage Buckets

| Bucket | Platforms to consider |
|---|---|
| Frontend/JAMstack | Vercel, Netlify, Cloudflare Pages, Firebase Hosting, AWS Amplify, Azure Static Web Apps, GitHub Pages, Tiiny Host, Surge, Render Static Sites, YouWare |
| Backend/PaaS | Railway, Render, Fly.io, Heroku, Koyeb, Northflank, Zerops, Sliplane, DigitalOcean App Platform, Google Cloud Run, AWS App Runner, Azure Container Apps, Cloudways, Kinsta application hosting |
| BYOC/Kubernetes developer platforms | Northflank BYOC, Qovery, Flightcontrol, Porter, Bunnyshell, humanitec-style IDP stacks, Argo CD/Flux on managed Kubernetes |
| Self-hosted PaaS | Coolify, Dokploy, CapRover, Dokku, Juno, Kamal, Portainer, Ploi, Laravel Forge, Caddy/Traefik with Docker Compose |
| Relational databases | Supabase Postgres, Neon, PlanetScale, Turso/libSQL, CockroachDB, Xata, Aiven, AWS RDS/Aurora, GCP Cloud SQL, Azure PostgreSQL, DigitalOcean Managed DB |
| NoSQL/document/key-value | MongoDB Atlas, Firestore, DynamoDB, Cosmos DB, Redis Cloud, Upstash Redis, Cloudflare KV, Deno KV |
| Vector/search | pgvector, Qdrant, Pinecone, Weaviate, Chroma, Meilisearch, Typesense, Elasticsearch/OpenSearch |
| Object/file storage | Cloudflare R2, AWS S3, Google Cloud Storage, Azure Blob Storage, DigitalOcean Spaces, Backblaze B2, MinIO, Bunny CDN storage |
| Realtime/collaboration | Ably, Pusher, Liveblocks, PartyKit, LiveKit, PubNub, Firebase Realtime Database, Supabase Realtime, Socket.IO, NATS, Kafka, Redpanda |
| Mobile backends | Firebase, Supabase, Appwrite, Nhost, Convex, AWS Amplify, Expo EAS, OneSignal, RevenueCat |
| AI/GPU/model serving | Modal, RunPod, Replicate, Hugging Face Inference Endpoints, Together AI, Groq, Baseten, BentoCloud, AWS SageMaker, GCP Vertex AI, Azure ML |
| Data/ETL/jobs | Modal, Cloud Run Jobs, AWS Batch, AWS Lambda, GCP Workflows, Temporal, Inngest, Trigger.dev, Prefect, Dagster, Airflow, SST Ion |
| Monitoring/observability | Sentry, Better Stack, Grafana Cloud, Datadog, Axiom, SigNoz, Uptime Kuma, UptimeRobot, Checkly, OpenTelemetry, Cloudflare Application Security and Performance |
| Secrets/security | Doppler, Infisical, Vault/OpenBao, SOPS, AWS Secrets Manager, GCP Secret Manager, Azure Key Vault, Trivy, Snyk, Semgrep, Gitleaks, TruffleHog |
| IoT/edge devices | AWS IoT Core, Azure IoT Hub, ThingsBoard, EMQX, HiveMQ, Balena, Edge Impulse, Cloudflare Pub/Sub/MQTT options where applicable |

## Project Archetype Coverage

| Archetype | Required candidate buckets |
|---|---|
| Static site or portfolio | Frontend/JAMstack, CDN, DNS, analytics |
| Full-stack SaaS MVP | Frontend/JAMstack, Backend/PaaS, relational DB, auth, email, monitoring, secrets |
| Commercial Next.js app | Vercel, Cloudflare/Fly container alternative, database choices, lock-in analysis |
| Backend API | Backend/PaaS, cloud-native container service, VPS/self-hosted, database, observability |
| Realtime collaborative app | Backend/PaaS with WebSockets, realtime/collaboration, database persistence, horizontal scaling story |
| Mobile app | Mobile backend, push notifications, app build/update pipeline, auth, analytics/crash reporting |
| AI app | Frontend/backend, LLM provider, vector store, model serving/GPU, background ingestion jobs, LLM observability |
| IoT app | Device ingress, MQTT/broker, time-series store, edge update pipeline, fleet monitoring, security model |
| Enterprise regulated app | BYOC/Kubernetes, cloud-native managed services, compliance, secrets, audit logging, monitoring, IaC |
| Ultra-low-budget app | Self-hosted PaaS, free managed tiers, explicit ops burden and backup plan |

## Hard Comparison Axes

Every serious recommendation must compare shortlisted options across these axes:

| Axis | Why it matters |
|---|---|
| Runtime model | Determines whether persistent connections, background jobs, native binaries, and Docker work. |
| Data model | Relational, document, key-value, time-series, vector, graph, and object storage have different failure modes. |
| Pricing shape | Free tier, per-seat, usage-based, per-server, bandwidth/egress, build minutes, storage, and overages. |
| Region/data residency | Required for GDPR, latency, sovereignty, and customer contracts. |
| Compliance | SOC 2, HIPAA/BAA, ISO 27001, PCI, audit logs, SSO/SCIM. |
| Team expertise | Solo DX differs from enterprise platform-engineering needs. |
| Scaling path | Vertical only, horizontal autoscale, scale-to-zero, multi-region, BYOC, Kubernetes. |
| Lock-in and portability | Proprietary runtimes, managed database APIs, edge-only APIs, custom build systems. |
| Operational burden | Backups, patching, incident response, observability, security updates, disaster recovery. |
| Failure modes | Sleeping free tiers, connection limits, cold starts, egress bill shock, queue backlogs, regional outages. |

## Known Coverage Gaps To Close

- Add exact official-source evidence notes to every platform summary.
- Add a deeper enterprise compliance matrix for SOC 2, HIPAA/BAA, ISO 27001,
  GDPR regions, SSO, SCIM, RBAC, audit logs, and SLA.
- Add mobile monetization and subscription infrastructure such as RevenueCat.
- Add data warehouse and analytics deployment patterns for BigQuery, ClickHouse,
  Snowflake, DuckDB, MotherDuck, and PostHog.
- Add deeper IoT fleet management, OTA update, MQTT broker, and time-series
  storage comparisons.
- Add agent/runtime sandbox platforms and secure code execution providers.

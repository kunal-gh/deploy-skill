# Reference: Verified Evidence for the Original Prompt Platform Set

> Last research update: 2026-07-09
> Scope: official-source evidence pass for the core deployment platforms named
> or implied by the original Vercel-alternatives prompt.

This file is an evidence register, not a recommendation shortcut. Use it to
override older summaries when a fact below conflicts with another local
reference. Before quoting exact pricing, limits, SLA, compliance, or region
availability to a user, re-check the official source URLs because these facts
change quickly.

## How to Use

1. Start with `00_source_manifest.md` and `20_platform_inventory.md`.
2. Use this file for facts that were checked against official pages during the
   2026-07-09 rebuild.
3. Re-check official pricing/docs/limits pages for every shortlisted platform.
4. Mark any inaccessible, script-rendered, or blocked official page as
   `verification_status: source-target-known`.
5. Treat third-party comparison posts as discovery only.

---

## Vercel

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://vercel.com/pricing
- Function limits: https://vercel.com/docs/functions/limitations
- Changelog: https://vercel.com/changelog

evidence_notes:
- Pricing confirms Hobby at $0, Pro at $20 per month, and custom Enterprise.
- Pricing lists 100 GB monthly fast data transfer on Hobby and 1 TB on Pro,
  with overage starting at $0.15 per GB.
- Pricing lists 1 million monthly Vercel Function invocations included and
  overage starting at $0.60 per million.
- Enterprise lists 99.99% SLA and multi-region compute/failover features.

recommendation_implication:
- Excellent Next.js and frontend DX, but do not recommend it for persistent
  backend services, long jobs, WebSocket servers, or native managed databases
  without a separate backend/data layer.

---

## Netlify

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://www.netlify.com/pricing/
- Functions overview: https://docs.netlify.com/build/functions/overview/
- Changelog: https://www.netlify.com/changelog

evidence_notes:
- Pricing confirms Free at $0, Personal at $9 per month, Pro at $20 per month,
  and Enterprise custom pricing starting from $500 per month.
- Netlify uses a credit-based usage model for included and overage usage.
- Functions are suitable for event/API workloads, not persistent backend
  servers or native managed databases.

recommendation_implication:
- Strong for JAMstack/static sites and frontend workflows. Pair with external
  database/backend services for full-stack systems.

---

## Cloudflare Pages and Workers

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Workers pricing: https://developers.cloudflare.com/workers/platform/pricing/
- Workers limits: https://developers.cloudflare.com/workers/platform/limits/
- Pages limits: https://developers.cloudflare.com/pages/platform/limits/
- Status: https://www.cloudflarestatus.com

evidence_notes:
- Workers pricing and limits must be checked by plan because CPU time,
  invocation, subrequest, and asset/build constraints differ by tier.
- Pages limits should be checked before promising build concurrency, file count,
  or site-count behavior.
- Workers run on an edge/serverless model and are not a drop-in replacement for
  arbitrary long-lived Node.js servers.

recommendation_implication:
- Excellent for edge-first frontends, APIs, middleware, caching, and global low
  latency. Use with care for libraries that assume full Node.js behavior or
  persistent stateful connections.

---

## Railway

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://railway.com/pricing
- Docs: https://docs.railway.com
- Changelog: https://railway.com/changelog

evidence_notes:
- Pricing shows Free at $0 per month, but describes a 30-day trial with $5
  credits that transitions to $1 per month after trial.
- Hobby has a $5 minimum usage level with $5 usage credit included.
- Pro has a $20 minimum usage level with $20 usage credit included.
- Usage pricing includes memory, CPU, and egress lines; verify current numbers
  before quoting a monthly estimate.
- BYOC is shown as an Enterprise capability, not a default low-cost feature.

recommendation_implication:
- Good DX for full-stack MVPs and small production apps, but the skill must not
  present Railway as a permanent no-cost production platform.

---

## Render

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://render.com/pricing
- Docs: https://docs.render.com
- Status: https://status.render.com

evidence_notes:
- Pricing shows workspace plans such as Hobby at $0 plus compute, Pro at $25
  per month plus compute, Scale at $499 per month plus compute, and custom
  Enterprise.
- Static Sites are listed at $0.
- Web/private/background instances include a Free tier and paid instance types
  such as Starter and Standard; check current resource sizes before estimating.
- Render provides native static sites, web services, private services,
  background workers, cron jobs, PostgreSQL, and Redis.

recommendation_implication:
- Strong Heroku-style replacement for predictable full-stack deployments. Do
  not reduce Render to only "$7 starter"; distinguish workspace plan charges
  from per-resource compute charges.

---

## Fly.io

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://fly.io/docs/about/pricing
- Docs: https://fly.io/docs
- Status: https://status.flyio.net

evidence_notes:
- Pricing is usage-based by provisioned resources and varies by machine class,
  RAM, region, and time provisioned.
- Shared CPU machines can be very inexpensive at small RAM sizes, but larger or
  performance-class machines change the cost curve materially.
- Fly has strong global deployment and private networking primitives, but teams
  must own more operational detail than on Render/Railway.

recommendation_implication:
- Prefer for global low-latency containers, realtime backends, and teams
  comfortable with infrastructure. Avoid for users who want the simplest managed
  database and preview-environment workflow.

---

## Northflank

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://northflank.com/pricing
- Docs: https://northflank.com/docs/v1/application/getting-started/introduction
- Status: https://status.northflank.com

evidence_notes:
- Pricing exposes pay-as-you-go compute with separate CPU, memory, egress, disk,
  and GPU price lines.
- Sandbox includes a limited free entry point for services, databases, and cron
  jobs.
- Plans include deployments to Northflank managed cloud and BYOC-style
  deployment into AWS/GCP/Azure accounts.
- The docs position Northflank as a platform for apps, jobs, services, databases,
  pipelines, preview environments, secrets, and access controls.

recommendation_implication:
- Strong candidate when the user needs frontend plus backend plus managed data
  plus preview environments, GPU, BYOC, or enterprise controls in one platform.

---

## DigitalOcean App Platform

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://www.digitalocean.com/pricing/app-platform
- Docs: https://docs.digitalocean.com/products/app-platform/
- Status: https://status.digitalocean.com

evidence_notes:
- Pricing confirms Free static-site hosting for up to 3 apps with 1 GiB outbound
  transfer per month per app; additional static-only apps and overages are paid.
- DigitalOcean removed older Basic and Professional App Platform tiers from the
  pricing model.
- Docs describe App Platform as a managed PaaS that deploys from Git repos or
  container images and can automatically build, deploy, and scale components.
- Docs list request-based autoscaling as generally available on 2026-05-20.

recommendation_implication:
- Useful for straightforward PaaS deployments on DigitalOcean with managed DB
  adjacency. Re-check current component instance pricing instead of using older
  Basic/Professional tier assumptions.

---

## AWS Amplify

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://aws.amazon.com/amplify/pricing/
- Docs: https://docs.aws.amazon.com/amplify
- AWS What's New: https://aws.amazon.com/about-aws/whats-new

evidence_notes:
- Pricing states there is no pay-per-seat charge for Amplify Hosting.
- New AWS customers from 2025-07-15 receive up to $200 in AWS Free Tier credits,
  subject to AWS Free Tier rules.
- Amplify pricing includes separate meters for build minutes, data storage,
  data transfer, SSR requests, SSR compute duration, and optional WAF.

recommendation_implication:
- Strong for AWS-native web/mobile teams, especially when Cognito, AppSync,
  DynamoDB, Lambda, or other AWS services are already part of the design. Warn
  users about multi-service pricing complexity.

---

## Google Cloud Run

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://cloud.google.com/run/pricing
- Docs: https://cloud.google.com/run/docs
- Status: https://status.cloud.google.com

evidence_notes:
- Pricing charges for resource usage rounded to the nearest 100 ms.
- Pricing separates instance-based billing and request-based billing, each with
  its own monthly free tier.
- Request-based billing includes a monthly free tier for requests plus vCPU and
  memory seconds; verify regional rates before cost estimates.

recommendation_implication:
- Strong default for containerized APIs, background-style HTTP workers, and
  workloads that need scale-to-zero without adopting a proprietary frontend PaaS.
  Pair with Cloud SQL, Firestore, Pub/Sub, or Secret Manager as needed.

---

## Heroku

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://www.heroku.com/pricing
- Dev Center: https://devcenter.heroku.com
- Status: https://status.heroku.com

evidence_notes:
- Pricing includes Eco, Basic, Standard, Performance, and Enterprise dyno
  families with materially different always-on, sleep, and resource behavior.
- Eco is a low-cost personal-account option that sleeps after inactivity.
- Basic is always-on, while Standard and Performance tiers are costlier
  production-oriented dynos.

recommendation_implication:
- Still useful for teams already familiar with buildpacks and add-ons, but for
  new low-budget apps compare Render, Railway, Fly.io, Koyeb, and self-hosted
  PaaS before defaulting to Heroku.

---

## Firebase Hosting and Firebase

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://firebase.google.com/pricing
- Hosting docs: https://firebase.google.com/docs/hosting
- Status: https://status.firebase.google.com

evidence_notes:
- Pricing shows Spark as a no-cost plan that does not require a payment method.
- Blaze is pay-as-you-go and includes Spark no-cost usage where applicable.
- Several Firebase products are listed as no-cost products, including Analytics,
  App Check, App Distribution, Cloud Messaging, Crashlytics, In-App Messaging,
  Performance Monitoring, and Remote Config.

recommendation_implication:
- Strong for mobile/client-heavy apps with Firebase Auth, Firestore, Cloud
  Messaging, Crashlytics, and Hosting. For complex backend workloads or SQL-heavy
  requirements, compare Cloud Run plus Cloud SQL, Supabase, Neon, or Appwrite.

---

## Azure Static Web Apps

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://azure.microsoft.com/pricing/details/app-service/static/
- Docs: https://learn.microsoft.com/azure/static-web-apps/overview
- Status: https://azure.status.microsoft

evidence_notes:
- Pricing distinguishes Free for hobby/personal projects from Standard for
  production apps.
- Free includes web hosting, SSL certificate, custom domains, and Azure
  Functions free executions under listed limits.
- Free and Standard both list 100 GB bandwidth per subscription, but Standard
  adds production features and overage behavior that must be verified.

recommendation_implication:
- Strong for Azure-centric static apps with Azure Functions API routes and
  GitHub/Azure DevOps CI. Avoid as a generic full-stack container platform.

---

## Tiiny Host

verification_status: source-target-known  
verified_at: 2026-07-09

official_sources:
- Pricing: https://tiiny.host/pricing
- Help: https://tiiny.host/help
- Blog: https://tiiny.host/blog

evidence_notes:
- Official pricing/help targets were identified and opened during the rebuild,
  but the fetched page text was not extractable enough for reliable exact-limit
  notes in this environment.
- Treat Tiiny Host as a lightweight static publishing/prototype candidate until
  exact current limits are rechecked in a browser.

recommendation_implication:
- Consider for quick static previews, HTML/PDF sharing, prototypes, and tiny
  no-backend sites. Do not recommend for production backends, databases,
  scheduled jobs, or traffic-heavy apps.

---

## Koyeb

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://www.koyeb.com/pricing
- Docs: https://www.koyeb.com/docs
- Changelog: https://www.koyeb.com/changelog

evidence_notes:
- Pricing is usage-based by the second for serverless compute.
- The pricing page shows Pro at $29 per month plus compute, Scale at $299 per
  month plus compute, and custom Enterprise starting at $1000 per month.
- Koyeb lists autoscaling, scale-to-zero, per-second billing, serverless
  Postgres, standard CPU options, and GPU options such as L4, A100, H100, and
  H200 classes.

recommendation_implication:
- Good candidate for autoscaling containers, inference endpoints, and teams that
  want serverless app hosting with GPU options. Re-check plan minimums and
  compute rates before budget-sensitive recommendations.

---

## Zerops

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Docs: https://docs.zerops.io/
- Pricing: https://docs.zerops.io/company/pricing
- Changelog: https://docs.zerops.io/changelog

evidence_notes:
- Pricing uses project core cost plus per-service resource usage.
- Lightweight Core is free for smaller/development workloads and includes build
  time, backup storage, and egress allowances.
- Serious Core is $10 per 30 days and is positioned for production workloads
  with higher availability/failover.
- Resource pricing is billed by minute and includes separate shared CPU,
  dedicated CPU, RAM, disk, dedicated IPv4, object storage, extra egress, backup,
  and build-time lines.
- Docs list runtimes including Node.js, PHP, Python, Go, .NET, Rust, Java, Deno,
  Bun, Elixir, Gleam, Nginx/static, Docker, and managed services including
  PostgreSQL, MariaDB, Valkey, Elasticsearch, Typesense, Meilisearch, Qdrant,
  NATS, Kafka, ClickHouse, KeyDB, and storage.

recommendation_implication:
- Strong for cost-controlled, full-stack deployments needing many managed
  service types. Require careful resource and spending-limit configuration.

---

## Sliplane

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://sliplane.io/pricing
- Docs: https://docs.sliplane.io
- Status: https://sliplane.instatus.com

evidence_notes:
- Pricing is per running server; each server can run as many services as fit.
- App Runtime includes automatic daily volume backups, free SSL, unlimited
  collaborators, free egress subject to fair use, API access, and human support.
- Listed shared-CPU monthly plans include Starter at EUR 9, Base at EUR 17.80,
  Medium at EUR 28.80, and Large at EUR 45, excluding VAT.
- Managed PostgreSQL starts at EUR 19 per month for PG Starter, and object
  storage has first 1 GB free with paid storage blocks after that.
- Regions shown include Germany, US East, US West, Finland, and Singapore.

recommendation_implication:
- Strong for predictable Docker hosting and EU/GDPR-sensitive small teams.
  Avoid when the user needs automatic horizontal autoscaling across many regions.

---

## Qovery

verification_status: official-sources-checked  
verified_at: 2026-07-09

official_sources:
- Pricing: https://www.qovery.com/pricing
- Docs: https://hub.qovery.com/docs
- Status: https://status.qovery.com

evidence_notes:
- Pricing is flat-rate per organization; workloads run in the customer's own
  cloud account.
- Team starts at $899 per month with 10 users, 10 AI agent seats, 2 managed
  clusters, up to 100 environments, and included deployment minutes.
- Business starts at $1,999 per month with 30 users, SSO, 3 managed clusters,
  up to 250 environments, 99.9% SLA, and policy-as-code.
- Enterprise is custom and includes self-hosted/on-premise options and 24/7
  support.
- Pricing page lists AWS, GCP, Azure, Scaleway, and on-premise Kubernetes
  support, plus SOC 2 Type II, HIPAA, GDPR, and DORA badges.

recommendation_implication:
- Strong for enterprise/BYOC/Kubernetes and regulated teams. Do not recommend
  for solo projects or low-budget startups unless the user explicitly needs
  BYOC, governance, or enterprise controls.

---

## Bunnyshell

verification_status: official-docs-checked-pricing-page-unavailable  
verified_at: 2026-07-09

official_sources:
- Docs: https://documentation.bunnyshell.com/
- Pricing: https://www.bunnyshell.com/pricing
- Changelog: https://documentation.bunnyshell.com/changelog

evidence_notes:
- Docs describe Bunnyshell as Environment as a Service for development, staging,
  and production environments.
- Docs list support for Docker Compose, Docker images, Helm, Kubernetes
  manifests, Terraform, static apps, Git providers, Kubernetes clusters, remote
  development, CLI/API/SDK, variables, data seeding, URLs, metrics, and MCP.
- Docs state Bunnyshell can generate environments in the user's own cloud
  accounts and automatically create/update ephemeral environments for pull
  requests.
- Pricing page fetch failed in this environment; do not quote exact Bunnyshell
  pricing without a fresh browser check.

recommendation_implication:
- Strong candidate for teams with complex preview environments, QA/staging
  needs, microservices, and Kubernetes. Do not present as general cheap hosting
  without verifying current pricing.


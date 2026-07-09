# Reference: Monitoring, Observability, Security & Secrets (2026)

> Last research update: 2026-07-09

---

## Overview: Production Readiness Stack

A production deployment needs at minimum:
1. **Error tracking** — Know when your app crashes
2. **Uptime monitoring** — Know when your server is down
3. **Logging** — Structured logs for debugging
4. **Secrets management** — Never hardcode credentials

Full observability also includes:
4. **APM** (Application Performance Monitoring) — Slow queries, bottlenecks
5. **Infrastructure metrics** — CPU, memory, disk trends
6. **Distributed tracing** — Request flow across services

---

## SECTION A: Error Tracking

### 1. Sentry (The Standard)

**Website:** sentry.io  
**Best for:** Application error tracking, developer-focused debugging

| Tier | Price | Monthly Errors |
|------|-------|---------------|
| Developer (Free) | $0 | 5,000 errors |
| Team | $26/month | 50K errors |
| Business | $80/month | 100K errors |
| Enterprise | Custom | Custom |

**Features:**
- Real-time error alerting
- Stack trace with local variables
- Error grouping (thousands of errors → few actionable root causes)
- Session Replay (video replay of user session that caused error)
- Performance monitoring (transaction tracing)
- Release tracking (errors per deployment)
- Integrations: Slack, Jira, GitHub, Linear
- SDKs for: JavaScript, Python, Ruby, Go, Java, PHP, .NET, React Native, Flutter
- Source maps for minified JS

**Best for:** Every production application — this is non-negotiable for production

---

### 2. GlitchTip (Open Source Sentry Alternative)

**Website:** glitchtip.com  
**License:** MIT

- Sentry-compatible (drop-in replacement)
- Self-hostable for free
- Managed cloud: Free tier (1K events/month), $15/month (50K events)
- Good for: Privacy-conscious teams, teams wanting to self-host

---

## SECTION B: Uptime Monitoring

### 1. Uptime Kuma (Self-Hosted, Free)

**Website:** uptime.kuma.pet  
**GitHub:** louislam/uptime-kuma  
**Stars:** 65K+

- Beautiful self-hosted uptime monitoring
- Monitor HTTP(s), TCP, DNS, Docker containers
- Notification channels: Telegram, Discord, Slack, Email, PagerDuty, + 90 more
- Status page (public-facing, like Statuspage.io)
- **Deploy in Coolify with one click — completely free**
- 20-second check intervals (paid Statuspage.io equivalent)

---

### 2. BetterStack (Uptime + Logging + On-call)

**Website:** betterstack.com

| Tier | Price | Features |
|------|-------|---------|
| Free | $0 | 10 monitors, 3-min intervals, 30-day logs |
| Hobby | $24/month | 50 monitors, 1-min intervals, 90-day logs |
| Business | $120/month | 200 monitors, 30-second intervals |

**Products:**
- **Uptime:** HTTP monitoring with beautiful status pages
- **Logs:** Centralized log management (Grafana alternative)
- **On-Call:** PagerDuty alternative
- **Telemetry:** OpenTelemetry-based metrics

**Best for:** Teams wanting a beautiful all-in-one monitoring suite without Datadog's pricing

---

### 3. UptimeRobot

**Website:** uptimerobot.com

| Tier | Price | Monitors |
|------|-------|---------|
| Free | $0 | 50 monitors, 5-min intervals |
| Pro | $7/month | 50 monitors, 1-min intervals |
| Business | $20/month | 100 monitors, 1-min intervals |

**Best for:** Simple uptime monitoring for free (5-min intervals is sufficient for most)

---

### 4. Checkly

**Website:** checklyhq.com  
**Best for:** API monitoring, E2E test monitoring with Playwright/Puppeteer

- Synthetic API checks
- Browser-based Playwright monitors
- Free: 50K check runs/month
- Paid: From $29/month

---

## SECTION C: Full Observability (Metrics, Logs, Traces)

### 1. Grafana Cloud (Best Free Tier for Self-Managed Metrics)

**Website:** grafana.com/products/cloud/

| Tier | Price | Free Limits |
|------|-------|------------|
| Free | $0 | 10K active series, 50GB logs, 50GB traces, 500 screenshots |
| Pro | Usage-based | From ~$8 per additional unit |

**Stack (all open source standards):**
- **Grafana** — Dashboard visualization
- **Prometheus / Mimir** — Metrics storage
- **Loki** — Log aggregation (like Elasticsearch but cheaper)
- **Tempo** — Distributed tracing
- **Pyroscope** — Continuous profiling
- **k6** — Load testing

**Key advantage:** All based on OpenTelemetry and open standards — no vendor lock-in.
Run locally/self-hosted or send data to Grafana Cloud.

**Self-hosted Grafana + Loki + Prometheus = $0 (on existing server)**
→ This is what most mature self-hosting setups use

---

### 2. Datadog (The Enterprise Standard)

**Website:** datadoghq.com

| Product | Starting Price |
|---------|---------------|
| Infrastructure | $15/host/month |
| APM | $31/host/month |
| Logs | From $0.10/GB ingested |
| Synthetics | From $5/month per API test |
| RUM | From $1.50/1K sessions |

**Key facts:**
- No permanent free tier (14-day trial only)
- All-in-one platform — best correlation between metrics/logs/traces
- Industry standard for enterprise cloud operations
- Very expensive at scale

**Best for:** Large enterprises with dedicated SRE teams where observability budget is not a constraint

---

### 3. Better Stack (Already Covered in Uptime)

Additional to uptime monitoring:
- **Logs:** Structured log ingestion, search
- **Telemetry:** OpenTelemetry + Prometheus metrics
- Good alternative to Datadog for small-medium teams

---

### 4. Axiom

**Website:** axiom.co  
**Best for:** Log analytics at scale, very cheap

| Tier | Price | Logs |
|------|-------|------|
| Personal | Free | 500GB ingested/month |
| Team | $25/month | 5TB ingested/month |

**Why Axiom:**
- **500GB free log ingestion/month** — extremely generous
- SQL-like query language
- Low cost for high-volume logging
- Good Vercel and Next.js integration

---

### 5. OpenTelemetry (The Standard Protocol)

**Not a platform — a protocol.**

> "Instrument once, send anywhere."

OpenTelemetry (OTel) is the CNCF standard for telemetry data collection.
When instrumenting your app, always use OTel SDKs so you can switch backends freely.

```javascript
// Node.js example
import { NodeSDK } from '@opentelemetry/sdk-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';

const sdk = new NodeSDK({
  traceExporter: new OTLPTraceExporter({
    url: 'http://otel-collector:4318/v1/traces',
  }),
});
sdk.start();
```

Send to: Grafana Cloud, Datadog, New Relic, Jaeger, Zipkin, SigNoz, or self-hosted collector

---

### 6. SigNoz (Open Source APM)

**Website:** signoz.io  
**License:** MIT  

- OpenTelemetry-native APM
- Self-hostable (Docker Compose or Kubernetes)
- Logs, Metrics, Traces in one tool
- Sentry + Datadog features at $0 (self-hosted)
- Cloud version available: From $199/month

**Best for:** Teams wanting Datadog-like capabilities at zero cost on their own infra

---

## SECTION D: Secrets Management

### 1. Doppler (Best DX for Teams)

**Website:** doppler.com

| Tier | Price | Users |
|------|-------|-------|
| Developer | Free | 1 user |
| Team | $8/user/month | Unlimited projects |
| Enterprise | $20/user/month | SSO, audit logs, SCIM |

**Features:**
- Cloud-only SaaS (no self-hosting)
- Beautiful CLI + dashboard
- Sync secrets to: Vercel, Netlify, GitHub Actions, Fly.io, Railway, Docker, etc.
- Auto-inject secrets into development environment
- Secret rotation support
- Audit log

**Best for:** Teams wanting the fastest path to proper secrets management

---

### 2. Infisical (Open Source Alternative)

**Website:** infisical.com  
**License:** MIT (core)

| Tier | Price | Notes |
|------|-------|-------|
| Free Cloud | $0 | 5 developers, unlimited secrets |
| Pro | $8/user/month | Unlimited everything |
| Enterprise | Custom | SSO, SAML, audit |
| Self-hosted | Free | Full feature set |

**Features:**
- Modern UI (similar to Doppler)
- Self-hostable (Docker Compose)
- Secret versioning + rollback
- Automatic secret rotation
- Native integrations with major platforms
- SDK: Node.js, Python, Go, Java, .NET, Ruby
- Dynamic secrets (generate short-lived credentials)

**Best for:** Teams wanting Doppler-like DX but with self-hosting control

---

### 3. HashiCorp Vault / OpenBao

**Website:** vault.hashicorp.com / openbao.org

- Most powerful secret management platform
- Self-hosted (enterprise-grade)
- Dynamic secrets (on-demand, short-lived credentials)
- PKI certificate management
- Multiple auth methods (JWT, LDAP, AWS IAM, K8s)
- HashiCorp changed license to BSL in 2023 → many teams migrating to **OpenBao** (MIT fork)

**Best for:** Large enterprises with complex security requirements and dedicated platform teams

---

### 4. Platform-Native Secrets

Most platforms have built-in secret management:

| Platform | Secret Storage | Notes |
|----------|---------------|-------|
| GitHub Actions | GitHub Secrets | Per-repo or org, encrypted |
| Railway | Environment Variables | Per-service, encrypted |
| Render | Secret Files + Env Vars | Built-in |
| Fly.io | fly secrets | Encrypted, synced to machines |
| Cloudflare Workers | Wrangler secrets | Encrypted in CF |
| Vercel | Environment Variables | Encrypted, per-project |

**For small/medium projects:** Platform-native secrets are sufficient.
**For teams using multiple platforms:** Doppler or Infisical centralizes secrets across all platforms.

---

## SECTION E: Security Scanning

### 1. Snyk

**Website:** snyk.io

| Tier | Price | Scans |
|------|-------|-------|
| Free | $0 | 200 open source tests/month |
| Team | $57/month/user | Unlimited |

**Features:**
- Dependency vulnerability scanning (npm, pip, cargo, maven, etc.)
- SAST (static code analysis)
- Container scanning
- IaC scanning (Terraform, Helm)
- GitHub Actions integration

---

### 2. Trivy (Open Source Container Scanner)

**Website:** aquasecurity.github.io/trivy

- Scan Docker images for CVEs
- Free, self-hosted
- CI integration: `trivy image myapp:latest`

---

### 3. Dependabot (GitHub Native)

- Free with GitHub
- Automatic PRs for outdated/vulnerable dependencies
- Enable in `.github/dependabot.yml`

---

## Recommended Production Monitoring Stack by Budget

### Free Stack ($0/month)
```
Error Tracking: GlitchTip (self-hosted via Coolify) or Sentry free
Uptime: Uptime Kuma (self-hosted) or UptimeRobot free
Logs: Grafana Loki (self-hosted) or Axiom free (500GB/mo)
Metrics: Prometheus + Grafana (self-hosted)
Secrets: Platform-native (GitHub Secrets + Railway env vars)
```

### Startup Stack (~$30–60/month)
```
Error Tracking: Sentry Team ($26/month)
Uptime: BetterStack ($24/month) OR UptimeRobot Pro ($7)
Logs: BetterStack Logs (included) or Axiom Team ($25)
Secrets: Doppler Team ($8/user) or Infisical free cloud
```

### Scale Stack ($100–300/month)
```
Error Tracking: Sentry Business ($80/month)
Full Observability: Grafana Cloud Pro (usage-based) or Datadog
Uptime: BetterStack Business ($120/month)
Secrets: Doppler Enterprise or Infisical Enterprise
Security: Snyk Team ($57/user)
```

---

## Observability Quick Decision Guide

```
What do you need?

├── "Know when my app crashes"
│   → Sentry (free tier covers most projects)
│
├── "Know when my site is down"
│   → Uptime Kuma (self-hosted, $0) OR UptimeRobot (free, 5-min intervals)
│
├── "See all my logs in one place"
│   → Axiom (500GB free!) or BetterStack Logs
│
├── "Full metrics + dashboards"
│   → Grafana Cloud (10K series free, very generous)
│   → Self-hosted Prometheus + Grafana (completely free on existing server)
│
├── "Datadog but cheaper"
│   → BetterStack (all-in-one, much cheaper)
│   → SigNoz (self-hosted, free)
│
├── "Manage secrets across platforms"
│   → Doppler (best DX) or Infisical (open source)
│
└── "Enterprise-grade secrets"
    → HashiCorp Vault or OpenBao (open source fork)
```

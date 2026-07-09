# Reference: Frontend & Static Hosting Platforms (2026)

> Last research update: 2026-07-09
> Always verify pricing at official pages before quoting to users.

---

## Official Source Targets

| Platform | Docs | Pricing / limits |
|---|---|---|
| Vercel | https://vercel.com/docs | https://vercel.com/pricing |
| Netlify | https://docs.netlify.com | https://www.netlify.com/pricing |
| Cloudflare Pages | https://developers.cloudflare.com/pages | https://developers.cloudflare.com/pages/platform/limits |
| Firebase Hosting | https://firebase.google.com/docs/hosting | https://firebase.google.com/pricing |
| AWS Amplify | https://docs.aws.amazon.com/amplify | https://aws.amazon.com/amplify/pricing |
| Azure Static Web Apps | https://learn.microsoft.com/azure/static-web-apps | https://azure.microsoft.com/pricing/details/app-service/static |
| GitHub Pages | https://docs.github.com/pages | https://docs.github.com/pages/getting-started-with-github-pages/about-github-pages |
| Tiiny Host | https://tiiny.host/help | https://tiiny.host/pricing |

---

## Platform Landscape Overview

Frontend hosting splits into three tiers:
1. **Pure CDN / Static hosts** — Serve pre-built files only (GitHub Pages, Surge)
2. **JAMstack platforms** — Static + serverless functions + edge (Vercel, Netlify, Cloudflare Pages)
3. **Frontend-capable PaaS** — Can serve both frontend and backend (Render, Railway, Fly.io)

---

## 1. Vercel

**Category:** JAMstack / SSR edge platform  
**Website:** vercel.com  
**Best for:** Next.js apps, SSR frontends, teams prioritizing DX

### What it is
Created by the Next.js team. The gold standard for frontend deployment DX.
First-class Next.js hosting with features unavailable elsewhere (ISR, Server Components optimization).

### Pricing (2026)
| Tier | Price | Key Limits |
|------|-------|-----------|
| Hobby | Free | 100GB bandwidth/mo, 6hr build limit, 10 deployments active, no commercial use |
| Pro | $20/user/month | 1TB bandwidth, team features, preview environments |
| Enterprise | Custom | Custom limits, SLA, SSO, advanced security |

**Cost traps:**
- Bandwidth overages are expensive at scale
- Serverless function execution billed per-invocation above free tier
- $20/seat makes team plans expensive at scale
- Edge Middleware can add unexpected costs

### Capabilities
- **Serverless Functions:** Node.js, Python, Go, Ruby — max 15 seconds (Hobby/Pro), 900 sec (Enterprise)
- **Edge Functions:** V8 isolate runtime, max 25ms CPU time, 128MB memory, globally distributed
- **CDN:** Global CDN with 100+ PoPs
- **Preview deployments:** Every branch/PR gets a unique URL
- **Custom domains:** Yes, free SSL
- **Build system:** Git-based (GitHub, GitLab, Bitbucket), Turborepo support
- **Frameworks:** Next.js (1st class), React, Vue, Nuxt, SvelteKit, Astro, Remix, Angular, Gatsby

### Key Limitations
- **No persistent backend support** — Functions are short-lived, no WebSockets
- **No managed databases** — Must use external providers
- **Vendor lock-in** — ISR, Edge Functions, and some Next.js optimizations are Vercel-specific
- **No Docker support** — Cannot deploy arbitrary containers
- **No BYOC** — Code runs on Vercel's infrastructure only
- **Commercial use forbidden on Hobby** — Must upgrade to Pro for business projects

### Best For
- Next.js applications (both startup and enterprise)
- Teams where DX is the top priority
- Projects that are purely frontend with external APIs

### NOT Suitable For
- Projects needing persistent backend processes
- Teams with compliance/data residency requirements
- Budget-sensitive projects at scale (costs spike)
- Projects needing WebSocket servers or long-running tasks

---

## 2. Netlify

**Category:** JAMstack / static hosting  
**Website:** netlify.com  
**Best for:** JAMstack, static sites, teams migrating from Vercel

### What it is
Pioneer of the modern JAMstack movement. Git-based workflow, global CDN, serverless functions.

### Pricing (2026)
| Tier | Price | Key Limits |
|------|-------|-----------|
| Starter | Free | 100GB bandwidth, 300 build minutes/mo, 1 concurrent build |
| Pro | $19/user/month | 1TB bandwidth, 25K serverless function invocations |
| Business | $99/user/month | 1.5TB bandwidth, unlimited invocations, SOC 2 |
| Enterprise | Custom | Custom |

### Capabilities
- **Functions:** AWS Lambda-based, Node.js 18+, 10s timeout (background functions: 15min)
- **Edge Functions:** Deno-based, runs globally
- **CDN:** Global CDN, Netlify Edge Network
- **Deploy Previews:** Per-PR preview URLs with collaborative annotations
- **Forms:** Built-in form handling (100 submissions/mo free)
- **Identity:** Built-in auth service
- **Connect:** Composable content layer for headless CMS integration
- **Large Media:** Git-based file storage

### Key Limitations
- No Docker, Kubernetes, or persistent backend support
- No managed databases
- Background functions timeout at 15 minutes
- Build minutes can run out on free tier

### Best For
- JAMstack sites and SPAs
- Content-heavy sites with CMS integration
- Teams that need PR preview environments without full backend

### NOT Suitable For
- Complex backend APIs
- Persistent compute workloads
- Database-heavy applications

---

## 3. Cloudflare Pages + Workers

**Category:** Edge-first JAMstack + compute  
**Website:** pages.cloudflare.com, developers.cloudflare.com  
**Best for:** Performance-critical frontends, globally distributed apps, near-zero cost at scale

### What it is
Cloudflare Pages hosts static/JAMstack sites on Cloudflare's 300+ PoP global network.
Cloudflare Workers provides serverless compute running in V8 isolates at the edge.
Together they form the most powerful edge-native deployment platform available.

### Pricing (2026)
**Pages:**
| Tier | Price | Key Limits |
|------|-------|-----------|
| Free | $0 | Unlimited bandwidth, 500 builds/month, 100 custom domains |
| Pro | $20/month | 5000 builds/month |

**Workers:**
| Tier | Price | Key Limits |
|------|-------|-----------|
| Free | $0 | 100K requests/day, 10ms CPU time/invocation |
| Paid | $5/month | 10M requests included, then $0.30/million |

**Storage (critical differentiators):**
- **R2:** Object storage at $0.015/GB/mo — **ZERO egress costs** (vs S3's $0.09/GB)
- **D1:** SQLite at the edge — 5GB free, $0.75/GB stored + $0.001/100K reads
- **KV:** Global key-value — 100K reads/day free
- **Durable Objects:** Stateful compute — $0.15/million requests

### Capabilities
- **Workers runtime:** V8 isolates, <1ms cold start, 25MB max memory, 10ms CPU (free) / no limit (paid)
- **Node.js compatibility:** ~95% compatible via `nodejs_compat` flag (2026)
- **Global network:** 300+ PoPs worldwide
- **Custom domains:** Free SSL, custom domains on Pages
- **Preview deployments:** Git integration with preview URLs per branch
- **Email routing:** Free email forwarding

### Key Limitations
- **Workers CPU limit:** 10ms CPU per request on free tier (paid removes CPU limit but charges by duration)
- **No native Node.js** — V8 isolates, not a full Node.js environment
- **Memory limit:** 128MB per isolate
- **No Docker containers** — Cloudflare Workers only, no arbitrary containers
- **Outbound connections:** Can connect to external services but cannot bind ports
- **Complex state** — Durable Objects required for stateful operations (adds complexity)

### Best For
- Globally distributed static/JAMstack sites
- Edge API proxies and middleware
- High-traffic static content (CDN at massive scale for free)
- Projects using R2 storage (zero egress = massive cost savings)
- Auth middleware, A/B testing, geolocation routing
- When building on top of Cloudflare ecosystem (D1 + R2 + KV + Workers)

### NOT Suitable For
- Heavy CPU-bound workloads
- Long-running background processes
- Applications needing full Node.js API compatibility
- Developers unfamiliar with edge computing constraints

---

## 4. Firebase Hosting

**Category:** Static hosting + BaaS integration  
**Website:** firebase.google.com/docs/hosting  
**Best for:** Frontend apps already using Firebase/Google services

### Pricing (2026)
| Tier | Price | Key Limits |
|------|-------|-----------|
| Spark (Free) | $0 | 10GB storage, 360MB/day bandwidth |
| Blaze (Pay-as-you-go) | Usage-based | $0.026/GB storage, $0.15/GB bandwidth |

### Capabilities
- Google CDN delivery
- Custom domains + free SSL
- Preview channels (preview URLs)
- Integrates with Cloud Functions for dynamic content
- Versioning + one-click rollbacks
- Firebase CLI + GitHub Actions integration

### Key Limitations
- Low bandwidth on free tier (360MB/DAY is very little)
- Primarily useful only when using other Firebase services
- More complex pricing than alternatives

### Best For
- Apps using Firebase Auth, Firestore, or Firebase Storage
- Google ecosystem teams
- PWAs and SPAs

### NOT Suitable For
- Projects not using Firebase ecosystem
- High-traffic static sites (bandwidth costs add up)
- Teams wanting to avoid Google lock-in

---

## 5. AWS Amplify Hosting

**Category:** AWS-integrated full-stack hosting  
**Website:** aws.amazon.com/amplify  
**Best for:** AWS-native teams, fullstack apps in AWS ecosystem

### Pricing (2026)
| Tier | Price | Key Limits |
|------|-------|-----------|
| Free Tier | 12 months | 5GB storage, 15GB bandwidth/mo, 1000 build minutes/mo |
| Paid | Usage-based | $0.01/build minute, $0.023/GB stored, $0.15/GB served |

### Capabilities
- SSR support for Next.js, Nuxt
- Git-based CI/CD (GitHub, GitLab, Bitbucket, CodeCommit)
- PR preview environments
- Deep AWS integration: Cognito auth, AppSync GraphQL, Lambda, DynamoDB
- Global CDN via CloudFront
- Custom domains + SSL

### Key Limitations
- AWS-specific — Not portable to other clouds
- Pricing complexity (multiple AWS services billed separately)
- Steeper learning curve for AWS beginners
- Build times can be slow

### Best For
- Full-stack apps in AWS ecosystem
- Teams already using AWS services
- Projects needing deep AWS integration (Cognito, DynamoDB, etc.)

### NOT Suitable For
- Multi-cloud teams
- AWS beginners (complexity is high)
- Budget-conscious teams (AWS pricing can be opaque)

---

## 6. Azure Static Web Apps

**Category:** Azure-integrated static hosting  
**Website:** azure.microsoft.com/products/app-service/static  
**Best for:** Azure-native teams

### Pricing (2026)
| Tier | Price | Key Limits |
|------|-------|-----------|
| Free | $0 | 100GB bandwidth/mo, 0.5GB storage, 2 custom domains |
| Standard | $9/month/app | 100GB bandwidth, 0.5GB storage, unlimited custom domains |

### Capabilities
- Global CDN delivery
- GitHub Actions + Azure DevOps CI/CD
- Integrated Azure Functions for API routes
- PR staging environments
- Custom domains + free SSL
- Authentication providers: AAD, GitHub, Twitter, Google

### Key Limitations
- Azure Functions runtime constraints
- Best only when in Azure ecosystem
- Limited backend capabilities

### Best For
- Microsoft/Azure enterprise environments
- Teams using Azure Active Directory authentication

---

## 7. GitHub Pages

**Category:** Free static hosting  
**Website:** pages.github.com  
**Best for:** Open source projects, documentation, personal portfolios

### Pricing
**Free always** (for public repos) — $0

### Capabilities
- Serves from any GitHub repo
- Custom domains + SSL
- Jekyll (Ruby) built-in SSG support
- GitHub Actions for build automation

### Key Limitations
- 1GB storage limit
- 100GB bandwidth/month
- Build time 10 minutes max
- No server-side code
- No private repo hosting on free tier
- No preview environments per PR (workarounds exist)

### Best For
- Open source project documentation
- Personal portfolios and blogs
- Small static sites

---

## 8. Cloudflare Pages vs Vercel vs Netlify — Decision Matrix

| Factor | Cloudflare Pages | Vercel | Netlify |
|--------|-----------------|--------|---------|
| Free bandwidth | **Unlimited** | 100GB | 100GB |
| Free builds | 500/month | ~100/month | 300 min/month |
| Edge compute | Workers (V8 isolate) | Edge Functions (V8) | Edge Functions (Deno) |
| Next.js optimization | Good | **Best-in-class** | Good |
| Database (built-in) | D1, KV, R2 | None | None |
| Cold starts | **<1ms** | ~50ms | ~50ms |
| Vendor lock-in | Medium | **High** | Low–Medium |
| DX quality | Good | **Excellent** | Very Good |
| Cost at scale | **Cheapest** | Most expensive | Moderate |

**Verdict:**
- **Vercel** = Best DX, especially for Next.js. Pay the premium if Next.js DX matters.
- **Cloudflare Pages** = Best value at scale, best edge compute ecosystem. Use when cost and performance matter.
- **Netlify** = Good middle ground, best for non-Next.js JAMstack.

---

## 9. Other Static Hosts Worth Knowing

### Surge.sh
- Dead simple: `npm install -g surge && surge`
- Free tier: unlimited projects, custom domains
- SSL: Paid ($13/mo for custom domain SSL)
- Zero config, zero CI/CD
- Best for: Quick demos, hackathons

### Tiiny Host
- Drag-and-drop static file hosting
- API/agent support (can deploy programmatically)
- Analytics + password protection built-in
- Free tier: limited
- Best for: Instant prototypes, client demos

### Render Static Sites
- Free tier for static sites (no bandwidth limit specified)
- CI/CD from GitHub
- Custom domains + SSL
- Best for: Teams already using Render for backend

### Fly.io Static Apps
- Can serve static files from Fly machines
- Not optimized for static specifically, but possible
- Use only if already on Fly.io for other services

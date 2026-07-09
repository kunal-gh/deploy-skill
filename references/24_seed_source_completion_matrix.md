# Reference: Seed Source Completion Matrix

> Last research update: 2026-07-09
> Purpose: make the original 10-source research requirement measurable instead
> of relying on a vague "we researched it" claim.

This file tracks the discovery sources from the original prompt and records
which products were extracted, where they are covered locally, and which items
still need deeper official-documentation evidence blocks.

## Completion Semantics

Use these statuses consistently:

| Status | Meaning |
|---|---|
| `official-evidence` | Official docs/pricing/limits/status or official repo were checked and captured in a source/evidence file. |
| `manifest-targeted` | Official source targets exist in `00_source_manifest.md`, but no deep evidence block exists yet. |
| `inventory-covered` | Product is in `20_platform_inventory.md` or a domain file, but still needs an official-source evidence pass. |
| `discovery-only` | Product was found in a seed article or review page and needs official-source triage before recommendation use. |
| `blocked-or-low-signal` | Source was inaccessible, heavily gated, or too low-signal for exact facts; keep as discovery only. |

Never recommend from a `discovery-only` item as if it were verified. Move it
through `manifest-targeted` and then `official-evidence` before quoting exact
facts.

## Seed Source Coverage

| # | Seed source | Source bias / quality | Products extracted | Current local coverage |
|---|---|---|---|---|
| 1 | https://northflank.com/blog/best-vercel-alternatives-for-scalable-deployments | Vendor-authored; high signal for Northflank positioning, discovery-only for competitors | Vercel, Northflank, Netlify, AWS Amplify, Google Cloud Run, Heroku, Render, DigitalOcean App Platform, Cloudflare Pages, Cloudflare Workers, Azure Static Web Apps, Firebase Hosting, Tiiny Host, Supabase | Core set has `official-evidence` in `23_verified_evidence_original_prompt.md`; Supabase covered in `03_database_services.md` and `16_baas_platforms.md`. |
| 2 | https://www.digitalocean.com/resources/articles/vercel-alternatives | Vendor-authored; useful for mainstream PaaS/front-end alternatives | Cloudflare Pages, Netlify, DigitalOcean App Platform, app/container PaaS options, database-adjacent managed cloud choices | Mainstream platforms are covered in manifest/inventory; exact article-specific claims must be rechecked against official vendor docs before quoting. |
| 3 | https://www.qovery.com/blog/vercel-alternatives | Vendor-authored; strong BYOC/control framing | Qovery, Render, Netlify, Fly.io, AWS Amplify, Vercel | Qovery/Render/Netlify/Fly/AWS Amplify/Vercel have source targets; core facts are captured in `23_verified_evidence_original_prompt.md`. |
| 4 | https://www.youware.com/blog/vercel-alternatives | Vendor-authored; useful for AI app-builder category discovery | YouWare, YouBase, Netlify, Cloudflare Pages, Railway, Render, Fly.io, DigitalOcean App Platform, AWS Amplify, Vercel | Main cloud platforms have `official-evidence`; YouWare/YouBase are `discovery-only` and should be evaluated as app-builder/BaaS products before recommendation use. |
| 5 | http://bunnyshell.com/comparisons/vercel-alternatives/ | Seed URL was not reliably extractable in this environment; vendor-authored | Bunnyshell plus likely Vercel alternative competitors | Bunnyshell has docs evidence and pricing-page target in `23_verified_evidence_original_prompt.md`; exact comparison-page product extraction remains `blocked-or-low-signal`. |
| 6 | https://www.kdnuggets.com/top-5-self-hosting-platform-alternative-to-vercel-heroku-netlify | Third-party editorial; useful for self-hosting discovery | Dokploy, Coolify, Appwrite, Dokku, Juno | Dokploy/Coolify/Appwrite/Dokku are covered; Juno is now promoted to manifest/inventory as `manifest-targeted`. |
| 7 | https://sliplane.io/blog/5-awesome-vercel-alternatives | Vendor-authored; useful for EU Docker/PaaS framing | Sliplane, Coolify, Render, Fly.io, AWS, AWS Amplify, AWS App Runner, ECS/Fargate, Lambda, CloudFront, S3, RDS, Lightsail | Sliplane/Render/Fly/AWS services are covered; AWS Lambda and Lightsail source targets are now explicit in the manifest/inventory. |
| 8 | https://use-apify.com/blog/vercel-alternatives-2026 | Affiliate/editorial; useful for self-hosting and AWS-native discovery | Coolify, Dokploy, Kamal, SST Ion, Netlify, Liquid Web VPS, Vercel | Coolify/Dokploy/Netlify are covered; Kamal, SST, and Liquid Web are now promoted to manifest/inventory for official-source follow-up. |
| 9 | https://github.com/dokploy/dokploy | Official repository; high-signal source for Dokploy | Dokploy, Docker Compose, Nixpacks, Traefik, MySQL, PostgreSQL, MongoDB, MariaDB, libSQL, Redis, backups, multi-node Docker Swarm | Dokploy is covered in self-hosted references; official repo remains source of truth for releases and feature claims. |
| 10 | https://www.g2.com/products/vercel/competitors/alternatives | Review/comparison site; broad but low-confidence for specs/pricing | Netlify, Jenkins, AWS Lambda, DigitalOcean, Kinsta, Bunny CDN, Cloudflare Application Security and Performance, Cloudways, CircleCI, Render | Deployment-relevant items are now in inventory. Treat G2 as discovery only; verify all claims from official docs/pricing pages. |

## Newly Promoted Gap Items

These products appeared in the seed sources but were not previously visible
enough in the coverage map. They are now promoted into inventory/manifest so
future agents cannot ignore them.

| Product | Why it matters | Current status | Next official-source task |
|---|---|---|---|
| YouWare / YouBase | AI app builder and hosted React/app workflow category | `discovery-only` | Verify product docs, pricing, export/lock-in behavior, data model, and deployment target. |
| Juno | Self-hostable serverless/WebAssembly-style app platform | `manifest-targeted` | Verify docs, repo/release activity, hosting model, auth/storage/functions model. |
| Kamal | CLI-driven Docker deployment for VPS/cloud servers | `manifest-targeted` | Verify official docs, supported proxy/registry behavior, multi-host strategy, rollback workflow. |
| SST Ion | AWS-native app framework/deployment workflow | `manifest-targeted` | Verify current SST docs, AWS services provisioned, pricing implications, preview environment support. |
| Liquid Web VPS | VPS substrate used in self-hosting comparisons | `manifest-targeted` | Verify VPS pricing, managed vs self-managed support boundary, backup/network limits. |
| Jenkins | CI/CD alternative surfaced by G2 | `manifest-targeted` | Verify official docs, plugin/security model, maintenance burden. |
| AWS Lambda | Serverless compute alternative surfaced by G2 and AWS rows | `manifest-targeted` | Verify pricing, duration, concurrency, runtime, and VPC/network constraints. |
| Kinsta | Managed WordPress/application hosting alternative surfaced by G2 | `manifest-targeted` | Verify whether it fits generic app deployment or should remain WordPress/application-hosting only. |
| Bunny CDN | CDN/edge alternative surfaced by G2 | `manifest-targeted` | Verify CDN/storage/edge-script fit and whether it belongs in CDN rather than full deployment stack. |
| Cloudways | Managed cloud/application hosting surfaced by G2 | `manifest-targeted` | Verify supported clouds, app stacks, pricing, scaling, and lock-in. |
| CircleCI | CI/CD alternative surfaced by G2 | `manifest-targeted` | Already belongs in CI/CD; verify current credits/minutes and runner model. |

## Already-Covered Original Audit Gap Items

The user's original audit also called out missing modern PaaS platforms that
were not necessarily present in every seed article excerpt but were part of the
same Vercel-alternatives research requirement.

| Product | Current status | Local coverage |
|---|---|---|
| Koyeb | `official-evidence` | Covered in `02_backend_platforms.md`, `20_platform_inventory.md`, and `23_verified_evidence_original_prompt.md`. |
| Zerops | `official-evidence` | Covered in `15_emerging_platforms.md`, `20_platform_inventory.md`, and `23_verified_evidence_original_prompt.md`. |

## Completion Gate

Before saying "all 10 seed sources are fully processed", all products above
must satisfy:

1. Official source target exists in `00_source_manifest.md`.
2. Product appears in `20_platform_inventory.md` or a domain reference.
3. A domain reference contains `verified_at: YYYY-MM-DD` for the product or the
   product is explicitly marked `discovery-only` / `blocked-or-low-signal`.
4. `scripts/coverage_report.py .` reports no missing critical seed products.
5. `scripts/freshness_audit.py .` reports no failures.

## Remaining Honest Gaps

- G2 is useful for discovery, but it is not a source of deployment truth. Its
  review rankings should never override official platform docs.
- YouWare/YouBase need a dedicated app-builder/BaaS evidence pass before the
  skill recommends them beyond prototype/app-builder contexts.
- Bunnyshell's seed comparison URL was not extractable here; Bunnyshell's
  official docs are still usable and should remain the source of truth.
- Some newly promoted items are adjacent rather than direct Vercel replacements
  (`Jenkins`, `CircleCI`, `Bunny CDN`, `Kinsta`, `Cloudways`). They should be
  compared only when the user's workload makes that category relevant.

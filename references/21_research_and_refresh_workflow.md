# Reference: Research and Refresh Workflow

> Last research update: 2026-07-09
> Purpose: make freshness and source provenance operational.

The skill's main USP is not that markdown exists. The USP is that every
deployment recommendation is grounded in current official sources and a fair
comparison set. Follow this workflow whenever answering deployment questions or
updating the knowledge base.

## Truth Hierarchy

1. Official pricing and limits pages.
2. Official docs for runtime behavior, regions, APIs, and deployment flow.
3. Official security/compliance pages for SOC 2, HIPAA, ISO, SSO, SCIM, audit
   logging, and SLA claims.
4. Official changelog/status pages for deprecations, incidents, new products,
   and removed free tiers.
5. Official GitHub releases for open-source tools.
6. Third-party comparisons only for discovery and framing.

If a recommendation includes an exact price, limit, compliance claim, or
region claim, cite or name the official source used to verify it.

## Recommendation-Time Freshness Protocol

Before finalizing a recommendation:

1. Read `00_source_manifest.md`.
2. Read the relevant domain files, such as frontend, backend, database,
   realtime, mobile, IoT, security, and cost references.
3. Identify the shortlisted platforms.
4. For each shortlisted platform, run live searches or open official pages for:
   - pricing
   - limits/runtime constraints
   - docs for the feature being relied on
   - status/changelog/deprecation notices
5. If live results conflict with local references, treat live official docs as
   source of truth and say the local reference may be stale.
6. Include a "Verification" note in the answer with the source pages checked.

Do not make a confident recommendation if the needed sources cannot be checked.
Instead say what is unverified and give the user the safest decision boundary.

## Update-Time Research Protocol

When improving the knowledge base:

1. Start with discovery pages from the original prompt.
2. Extract every platform/product name mentioned.
3. Add missing products to `20_platform_inventory.md`.
4. For each platform, open official docs, pricing, limits, changelog/status, and
   compliance pages.
5. Update the relevant reference file with:
   - short platform description
   - workload fit
   - pricing shape
   - hard limits
   - supported runtimes/databases/regions
   - lock-in and operational gotchas
   - source block using the template in `00_source_manifest.md`
6. Run `scripts/freshness_audit.py`.
7. Fix missing source coverage or stale verification dates before publishing.

## Source Block Template

Use this inside platform sections after researching:

```text
verification_status: official-sources-checked
verified_at: YYYY-MM-DD
official_sources:
  pricing: URL
  docs: URL
  limits: URL
  changelog_or_status: URL
evidence_notes:
  - Confirmed exact fact from source.
  - Confirmed limitation or removed free tier.
```

For open-source tools:

```text
verification_status: official-repo-checked
verified_at: YYYY-MM-DD
official_sources:
  docs: URL
  repo: URL
  releases: URL
evidence_notes:
  - Confirmed installation method and release activity.
```

## Fairness Guardrails

- Prefer the simplest stack that meets the constraints.
- Do not default to Vercel, Railway, or Supabase without comparing against at
  least two viable alternatives.
- If a third-party blog is vendor-authored, label its bias.
- If a free tier has commercial restrictions, sleeping behavior, usage cliffs,
  or credit-card requirements, call that out.
- If a platform is excellent but creates lock-in, say what migration would
  require.
- If self-hosting saves money but increases operational risk, include the time
  cost and backup burden.

## Maintenance Cadence

| Data type | Max age before recheck |
|---|---|
| Pricing and free tiers | 30 days |
| Runtime limits and quotas | 45 days |
| Compliance/SLA/security claims | 90 days |
| Open-source release activity | 90 days |
| General architecture advice | 180 days |

Run `scripts/freshness_audit.py --max-age-days 30` before calling the skill
"fresh" for pricing-heavy work.

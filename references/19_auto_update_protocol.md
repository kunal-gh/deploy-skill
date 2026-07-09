# Reference: Auto-Update & Pricing Freshness Protocol (2026)

> Last research update: 2026-07-09
> Legacy freshness node. For the full workflow, also read:
> `00_source_manifest.md`, `20_platform_inventory.md`, and
> `21_research_and_refresh_workflow.md`.

---

## 1. Why Freshness Matters
Hosting companies regularly pivot their pricing structures, remove free tiers, or introduce bandwidth changes.
- In 2022: Heroku removed its free dyno plans.
- In 2023: Railway replaced its developer free tier with a one-time trial credit.
- In 2025: Netlify restructured its functions limits.
- In 2026: Koyeb shifted its core focus to AI-native compute, and Supabase altered its logs pricing model.

To prevent giving users outdated information, you **MUST** follow this verification protocol.

---

## 2. Mandatory Source Checks
Before outputting any recommendation that involves pricing, limits, regions,
runtime constraints, compliance, or SLA, check the official source targets in
`00_source_manifest.md` for each platform in the proposed stack.

### Search Templates
When direct official pages are not already known, use these search terms:
1. `"[Platform Name] official pricing"`
2. `"[Platform Name] docs limits"`
3. `"[Platform Name] changelog 2026"`
4. `"[Platform Name] status"`
5. `"[Platform Name] SOC 2 HIPAA SLA docs"` if compliance matters.

### Example Search Actions
- If recommending Railway: `search_web(query="Railway pricing plans 2026 changes")`
- If recommending Supabase: `search_web(query="Supabase free tier limits 2026 changes")`
- If recommending Northflank: `search_web(query="Northflank pricing calculator changes 2026")`

---

## 3. Discrepancy Resolution Rules
If live official sources contradict any numbers listed in the reference files:

1. **Use Official Live Data:** Official docs/pricing/changelog/status pages are the source of truth.
2. **Explicitly State the Discrepancy:** Inform the user in your response:
   > *"Note: My reference database states [Old Pricing], but a live check confirms that as of [Current Date], [Platform] has changed this limit/price to [New Pricing]. I have adjusted my calculations accordingly."*
3. **Log the Update:** Make a note of the outdated reference file so it can be updated in a future commit.
4. **Add a Source Block:** When updating a reference, add `verified_at`, official source URLs, and evidence notes using the template in `00_source_manifest.md`.

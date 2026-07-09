# Reference: Auto-Update & Pricing Freshness Protocol (2026)

> Last research update: 2026-07-09
> Mandatory instructions for checking live platform data.

---

## 1. Why Freshness Matters
Hosting companies regularly pivot their pricing structures, remove free tiers, or introduce bandwidth changes.
- In 2022: Heroku removed its free dyno plans.
- In 2023: Railway replaced its developer free tier with a one-time trial credit.
- In 2025: Netlify restructured its functions limits.
- In 2026: Koyeb shifted its core focus to AI-native compute, and Supabase altered its logs pricing model.

To prevent giving users outdated information, you **MUST** follow this verification protocol.

---

## 2. Mandatory Search Queries
Before outputting any recommendation that involves pricing, run a web search for each platform in your proposed stack.

### Search Templates
Use these exact search terms:
1. `"[Platform Name] pricing changes 2026"`
2. `"[Platform Name] free tier limits 2026"`
3. `"[Platform Name] deprecation notices 2026"`

### Example Search Actions
- If recommending Railway: `search_web(query="Railway pricing plans 2026 changes")`
- If recommending Supabase: `search_web(query="Supabase free tier limits 2026 changes")`
- If recommending Northflank: `search_web(query="Northflank pricing calculator changes 2026")`

---

## 3. Discrepancy Resolution Rules
If the live web search results contradict any numbers listed in the reference files (`references/01_frontend_platforms.md` through `references/18_decision_tree.md`):

1. **Use the Live Search Data:** The search result is the source of truth.
2. **Explicitly State the Discrepancy:** Inform the user in your response:
   > *"Note: My reference database states [Old Pricing], but a live check confirms that as of [Current Date], [Platform] has changed this limit/price to [New Pricing]. I have adjusted my calculations accordingly."*
3. **Log the Update:** Make a note of the outdated reference file so it can be updated in a future commit.

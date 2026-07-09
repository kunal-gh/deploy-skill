# Reference: Source Manifest and Verification Targets

> Last research update: 2026-07-09
> Purpose: canonical source map for the deployment knowledge base.

This file is not a recommendation file. It is the source-of-truth index the
skill must consult when a recommendation depends on pricing, limits, compliance,
runtime behavior, regions, or deprecation status.

## Evidence Standard

Use this hierarchy when facts conflict:

1. Official pricing, limits, docs, security, SLA, status, and changelog pages.
2. Official GitHub repositories for open-source deployment tools.
3. Official blog/changelog posts from the vendor.
4. User-provided case studies or public benchmark posts.
5. Third-party comparison blogs and review sites.

Never let a third-party comparison page override an official pricing, limits,
or compliance page. Use third-party pages only for discovery and market mapping.

## Seed Sources From The Original Prompt

| Source | Use |
|---|---|
| https://northflank.com/blog/best-vercel-alternatives-for-scalable-deployments | Discovery of Vercel alternatives; vendor-biased toward Northflank. |
| https://www.digitalocean.com/resources/articles/vercel-alternatives | Discovery of mainstream Vercel alternatives. |
| https://www.qovery.com/blog/vercel-alternatives | Discovery of BYOC/Kubernetes-oriented alternatives; vendor-biased toward Qovery. |
| https://www.youware.com/blog/vercel-alternatives | Discovery of website/app-builder alternatives. |
| http://bunnyshell.com/comparisons/vercel-alternatives/ | Discovery of ephemeral environment and Kubernetes workflow alternatives. |
| https://www.kdnuggets.com/top-5-self-hosting-platform-alternative-to-vercel-heroku-netlify | Discovery of self-hosted alternatives. |
| https://sliplane.io/blog/5-awesome-vercel-alternatives | Discovery of EU Docker/PaaS alternatives; vendor-biased toward Sliplane. |
| https://use-apify.com/blog/vercel-alternatives-2026 | Discovery of scraping/automation adjacent deployment alternatives. |
| https://github.com/dokploy/dokploy | Official repository for Dokploy. |
| https://www.g2.com/products/vercel/competitors/alternatives | Broad competitor discovery; low confidence for exact specs/pricing. |

## Official Verification Targets

Each platform row should be verified against its official docs before exact
pricing or hard limits are quoted. Add `verified_at: YYYY-MM-DD` notes in the
platform reference file after verification.

### Frontend, JAMstack, and Edge

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| Vercel | https://vercel.com/docs | https://vercel.com/pricing | https://vercel.com/changelog | 01_frontend_platforms.md |
| Netlify | https://docs.netlify.com | https://www.netlify.com/pricing | https://www.netlify.com/changelog | 01_frontend_platforms.md |
| Cloudflare Pages | https://developers.cloudflare.com/pages | https://developers.cloudflare.com/pages/platform/limits | https://www.cloudflarestatus.com | 01_frontend_platforms.md |
| Cloudflare Workers | https://developers.cloudflare.com/workers | https://developers.cloudflare.com/workers/platform/pricing | https://developers.cloudflare.com/workers/platform/limits | 05_edge_cdn_serverless.md |
| Firebase Hosting | https://firebase.google.com/docs/hosting | https://firebase.google.com/pricing | https://status.firebase.google.com | 01_frontend_platforms.md |
| AWS Amplify | https://docs.aws.amazon.com/amplify | https://aws.amazon.com/amplify/pricing | https://aws.amazon.com/about-aws/whats-new | 01_frontend_platforms.md |
| Azure Static Web Apps | https://learn.microsoft.com/azure/static-web-apps | https://azure.microsoft.com/pricing/details/app-service/static | https://azure.status.microsoft | 01_frontend_platforms.md |
| Tiiny Host | https://tiiny.host/help | https://tiiny.host/pricing | https://tiiny.host/blog | 01_frontend_platforms.md |

### Backend, Containers, PaaS, and BYOC

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| Railway | https://docs.railway.com | https://railway.com/pricing | https://railway.com/changelog | 02_backend_platforms.md |
| Render | https://docs.render.com | https://render.com/pricing | https://status.render.com | 02_backend_platforms.md |
| Fly.io | https://fly.io/docs | https://fly.io/docs/about/pricing | https://status.flyio.net | 02_backend_platforms.md |
| Heroku | https://devcenter.heroku.com | https://www.heroku.com/pricing | https://status.heroku.com | 02_backend_platforms.md |
| Koyeb | https://www.koyeb.com/docs | https://www.koyeb.com/pricing | https://www.koyeb.com/changelog | 02_backend_platforms.md |
| Northflank | https://northflank.com/docs | https://northflank.com/pricing | https://status.northflank.com | 15_emerging_platforms.md |
| Zerops | https://docs.zerops.io | https://zerops.io/pricing | https://docs.zerops.io/changelog | 15_emerging_platforms.md |
| Sliplane | https://docs.sliplane.io | https://sliplane.io/pricing | https://sliplane.io/changelog | 15_emerging_platforms.md |
| Qovery | https://hub.qovery.com/docs | https://www.qovery.com/pricing | https://status.qovery.com | 15_emerging_platforms.md |
| Bunnyshell | https://documentation.bunnyshell.com | https://www.bunnyshell.com/pricing | https://status.bunnyshell.com | 15_emerging_platforms.md |
| Google Cloud Run | https://cloud.google.com/run/docs | https://cloud.google.com/run/pricing | https://status.cloud.google.com | 05_edge_cdn_serverless.md |
| AWS App Runner | https://docs.aws.amazon.com/apprunner | https://aws.amazon.com/apprunner/pricing | https://aws.amazon.com/about-aws/whats-new | 06_cloud_providers.md |
| Azure Container Apps | https://learn.microsoft.com/azure/container-apps | https://azure.microsoft.com/pricing/details/container-apps | https://azure.status.microsoft | 06_cloud_providers.md |

### Self-Hosted PaaS and VPS Control Planes

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| Coolify | https://coolify.io/docs | https://coolify.io/pricing | https://github.com/coollabsio/coolify/releases | 07_self_hosted.md |
| Dokploy | https://docs.dokploy.com | https://github.com/dokploy/dokploy | https://github.com/dokploy/dokploy/releases | 07_self_hosted.md |
| CapRover | https://caprover.com/docs | https://github.com/caprover/caprover | https://github.com/caprover/caprover/releases | 07_self_hosted.md |
| Dokku | https://dokku.com/docs | https://github.com/dokku/dokku | https://github.com/dokku/dokku/releases | 07_self_hosted.md |
| Juno | https://juno.build/docs | https://github.com/junobuild/juno | https://github.com/junobuild/juno/releases | 07_self_hosted.md |
| Kamal | https://kamal-deploy.org/docs | https://github.com/basecamp/kamal | https://github.com/basecamp/kamal/releases | 07_self_hosted.md |
| SST | https://sst.dev/docs | https://sst.dev | https://github.com/sst/sst/releases | 06_cloud_providers.md |
| Liquid Web VPS | https://www.liquidweb.com/help-docs | https://www.liquidweb.com/vps-hosting | https://www.liquidweb.com/blog | 06_cloud_providers.md |
| Hetzner Cloud | https://docs.hetzner.com/cloud | https://www.hetzner.com/cloud | https://status.hetzner.com | 06_cloud_providers.md |
| DigitalOcean | https://docs.digitalocean.com | https://www.digitalocean.com/pricing | https://status.digitalocean.com | 06_cloud_providers.md |
| Oracle Cloud Free Tier | https://docs.oracle.com/en-us/iaas | https://www.oracle.com/cloud/free | https://ocistatus.oraclecloud.com | 06_cloud_providers.md |

### Databases, BaaS, Storage, and Data APIs

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| Supabase | https://supabase.com/docs | https://supabase.com/pricing | https://supabase.com/changelog | 03_database_services.md |
| Neon | https://neon.com/docs | https://neon.com/pricing | https://neon.com/docs/changelog | 03_database_services.md |
| PlanetScale | https://planetscale.com/docs | https://planetscale.com/pricing | https://planetscale.com/changelog | 03_database_services.md |
| Turso | https://docs.turso.tech | https://turso.tech/pricing | https://turso.tech/changelog | 03_database_services.md |
| Convex | https://docs.convex.dev | https://www.convex.dev/pricing | https://news.convex.dev | 16_baas_platforms.md |
| Nhost | https://docs.nhost.io | https://nhost.io/pricing | https://nhost.io/blog | 16_baas_platforms.md |
| Appwrite | https://appwrite.io/docs | https://appwrite.io/pricing | https://github.com/appwrite/appwrite/releases | 16_baas_platforms.md |
| PocketBase | https://pocketbase.io/docs | https://github.com/pocketbase/pocketbase | https://github.com/pocketbase/pocketbase/releases | 16_baas_platforms.md |
| MongoDB Atlas | https://www.mongodb.com/docs/atlas | https://www.mongodb.com/pricing | https://status.cloud.mongodb.com | 03_database_services.md |
| Firebase | https://firebase.google.com/docs | https://firebase.google.com/pricing | https://status.firebase.google.com | 17_mobile_backends.md |
| Upstash | https://upstash.com/docs | https://upstash.com/pricing | https://status.upstash.com | 03_database_services.md |
| Cloudflare R2/D1/KV | https://developers.cloudflare.com | https://developers.cloudflare.com/r2/pricing | https://www.cloudflarestatus.com | 03_database_services.md |

### AI, GPU, Realtime, and Mobile Services

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| Modal | https://modal.com/docs | https://modal.com/pricing | https://modal.com/changelog | 09_ai_ml_specialized.md |
| RunPod | https://docs.runpod.io | https://www.runpod.io/pricing | https://status.runpod.io | 09_ai_ml_specialized.md |
| Replicate | https://replicate.com/docs | https://replicate.com/pricing | https://replicate.com/changelog | 09_ai_ml_specialized.md |
| Hugging Face Inference | https://huggingface.co/docs/inference-endpoints | https://huggingface.co/pricing | https://status.huggingface.co | 09_ai_ml_specialized.md |
| Ably | https://ably.com/docs | https://ably.com/pricing | https://status.ably.com | 13_realtime_networking.md |
| Pusher | https://pusher.com/docs | https://pusher.com/channels/pricing | https://status.pusher.com | 13_realtime_networking.md |
| Liveblocks | https://liveblocks.io/docs | https://liveblocks.io/pricing | https://liveblocks.io/changelog | 13_realtime_networking.md |
| LiveKit | https://docs.livekit.io | https://livekit.io/pricing | https://status.livekit.io | 13_realtime_networking.md |
| Expo EAS | https://docs.expo.dev/eas | https://expo.dev/pricing | https://expo.dev/changelog | 17_mobile_backends.md |
| OneSignal | https://documentation.onesignal.com | https://onesignal.com/pricing | https://status.onesignal.com | 17_mobile_backends.md |

### Seed-Source Adjacent Products Requiring Triage

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| YouWare | https://www.youware.com | https://www.youware.com/pricing | https://www.youware.com/blog | 20_platform_inventory.md |
| AWS Lambda | https://docs.aws.amazon.com/lambda | https://aws.amazon.com/lambda/pricing | https://aws.amazon.com/about-aws/whats-new | 05_edge_cdn_serverless.md |
| Jenkins | https://www.jenkins.io/doc | https://www.jenkins.io | https://www.jenkins.io/changelog | 04_cicd_devops.md |
| Kinsta | https://docs.kinsta.com | https://kinsta.com/pricing | https://status.kinsta.com | 06_cloud_providers.md |
| Bunny CDN | https://docs.bunny.net | https://bunny.net/pricing | https://status.bunny.net | 05_edge_cdn_serverless.md |
| Cloudways | https://support.cloudways.com | https://www.cloudways.com/en/pricing.php | https://status.cloudways.com | 06_cloud_providers.md |
| CircleCI | https://circleci.com/docs | https://circleci.com/pricing | https://status.circleci.com | 04_cicd_devops.md |

### IoT and Edge Device Deployment

| Platform | Official docs | Pricing | Changelog/status | Reference |
|---|---|---|---|---|
| AWS IoT Core | https://docs.aws.amazon.com/iot | https://aws.amazon.com/iot-core/pricing | https://aws.amazon.com/about-aws/whats-new | 22_iot_edge_deployments.md |
| Azure IoT Hub | https://learn.microsoft.com/azure/iot-hub | https://azure.microsoft.com/pricing/details/iot-hub | https://azure.status.microsoft | 22_iot_edge_deployments.md |
| Google Cloud IoT Core | https://cloud.google.com/iot-core | https://cloud.google.com/iot-core/docs/resources | https://cloud.google.com/iot-core/docs/release-notes | 22_iot_edge_deployments.md |
| ThingsBoard | https://thingsboard.io/docs | https://thingsboard.io/pricing | https://github.com/thingsboard/thingsboard/releases | 22_iot_edge_deployments.md |
| EMQX | https://docs.emqx.com | https://www.emqx.com/en/pricing | https://github.com/emqx/emqx/releases | 22_iot_edge_deployments.md |
| HiveMQ | https://docs.hivemq.com | https://www.hivemq.com/pricing | https://www.hivemq.com/changelog | 22_iot_edge_deployments.md |
| Balena | https://docs.balena.io | https://www.balena.io/pricing | https://github.com/balena-io/balena-cloud/releases | 22_iot_edge_deployments.md |

## Research Log Template

When updating a reference file, append a note in this form near the platform:

```text
verified_at: YYYY-MM-DD
official_sources:
  - pricing: URL
  - docs: URL
  - changelog/status: URL
evidence_notes:
  - Short factual note about what changed or was confirmed.
```

If a platform cannot be verified from official sources, mark it:

```text
verification_status: unverified
reason: Official pricing/docs page unavailable or blocked.
```

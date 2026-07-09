# Real-Time, WebSocket & Collaborative Infrastructure + Networking — Research (July 2026)

> Last research update: 2026-07-09
> Always verify pricing and limits at official docs.

## Official Source Targets

| Platform | Docs | Pricing / limits |
|---|---|---|
| Ably | https://ably.com/docs | https://ably.com/pricing |
| Pusher Channels | https://pusher.com/docs/channels | https://pusher.com/channels/pricing |
| Liveblocks | https://liveblocks.io/docs | https://liveblocks.io/pricing |
| PartyKit | https://docs.partykit.io | https://developers.cloudflare.com/durable-objects/platform/pricing |
| Cloudflare Durable Objects | https://developers.cloudflare.com/durable-objects | https://developers.cloudflare.com/durable-objects/platform/pricing |
| Upstash QStash/Kafka | https://upstash.com/docs | https://upstash.com/pricing |
| LiveKit | https://docs.livekit.io | https://livekit.io/pricing |
| NATS | https://docs.nats.io | https://github.com/nats-io/nats-server/releases |
| RabbitMQ | https://www.rabbitmq.com/docs | https://github.com/rabbitmq/rabbitmq-server/releases |
| Apache Kafka | https://kafka.apache.org/documentation | https://kafka.apache.org/downloads |

## ABLY

### Free Tier
- 6,000,000 messages/month
- 200 peak concurrent connections
- 200 peak concurrent channels
- 1-day message history
- 64 KiB max message size
- No CC required, indefinite

### Paid Pricing
- Standard: $29/month base — 10K connections, 10K channels, 2,500 msg/sec
  - Usage: $2.50/M messages + $1.00/M connection-minutes + $1.00/M channel-minutes
- Pro: $399/month base — 50K connections, 10K msg/sec, 99.999% SLA
- Enterprise: Custom (custom limits, dedicated infra, 1–365 day history, BYOC)
- Alternative MAU billing available for consumer apps

### Latency
- 310+ edge PoPs worldwide
- Sub-50ms in most regions; 11–25ms in major metros
- Multi-region active-active, no single SPOF, automatic failover + geo-routing

### SDK Support: JS/TS, React hooks (@ably/react), iOS, Android, Flutter, .NET, Java, Python, Ruby, PHP, Go, Rust, REST API

### Self-Hosted: NO. SaaS only. Pusher-compatible alternative: Laravel Reverb.

### PRICING GOTCHAS
1. Connection-minutes bill even when idle — 1,000 idle WS connections = $1.44/day on Standard
2. Channel-minutes also billed separately
3. System messages (presence enter/leave, heartbeats) count toward message quota
4. 200-connection free tier is tiny — exceeded immediately in real apps
5. Pro plan jump from $29 → $399 is steep for 10K→50K connections

---

## PUSHER CHANNELS

### Free Tier (Sandbox)
- 100 concurrent connections
- 200,000 messages/DAY (not month — this is ~6M/month)
- SSL included

### Paid Pricing (monthly, quota-based — NOT overage)
| Plan | $/mo | Messages/day | Connections |
|---|---|---|---|
| Startup | $49 | 1M | 500 |
| Pro | $99 | 4M | 2,000 |
| Business | $299 | 10M | 5,000 |
| Premium | $499 | 20M | 10,000 |
| Growth | $699 | 40M | 15,000 |
| Plus | $899 | 60M | 20,000 |
| Growth Plus | $1,199 | 90M | 30,000 |

### CRITICAL: Quota hard limits — no overage billing. Hit the ceiling = connections dropped. Cliff-edge failure.

### Message counting: ALL messages count — server-to-client + client-to-server + presence messages

### SDK Support: JS, React (community hooks), iOS, Android, Python, Ruby, PHP, .NET, Go, Java, REST API
### Self-Hosted: NO official. Pusher protocol compatible alternatives: Laravel Reverb (PHP, active 2025), Soketi ABANDONED/ARCHIVED — DO NOT USE.

### LATENCY: Runs on AWS infra, regional clusters (US-east, EU-west, AP-south etc.), 50–150ms typical. NO auto geo-routing between clusters.

### GOTCHAS
1. Quota hard limits = cliff-edge failure mode. Must pre-upgrade before hitting cap.
2. All message types count toward daily limit
3. Daily reset, not monthly (200k/day sounds generous but single active user = 14,400 events/day at 10 events/min)
4. Cluster selection is permanent per connection — no failover
5. Pusher Startup $49/mo vs Ably Standard $29/mo — Pusher more expensive for similar capacity

---

## LIVEBLOCKS

### What It Is
Purpose-built collaborative application infrastructure — NOT generic WebSocket. Features: CRDT data types (LiveMap/LiveList/LiveObject), Presence (cursors), Comments system, Notifications, Text editor sync (Yjs/Tiptap/Lexical), AI Copilot, Version history.

### Free Tier
- 10 simultaneous connections PER ROOM
- 10 projects, 3 team seats
- 3,000 monthly anonymous connections
- 10 MB data per room
- 24h version history
- "Powered by Liveblocks" badge required

### "First Day Free" policy: Users only count toward billing if they return on a different calendar day.

### Paid Pricing
- Pro: $30/month (or $25/month annual) — 20 connections/room, 30-day history, no badge
- Team: ~$150/month — higher connection limits, SAML SSO, analytics
- Enterprise: Custom — unlimited connections/room, data residency, 99.99% SLA

### SDK Support: React (first-class), Next.js, vanilla JS. NO native mobile SDKs — React Native possible but not official.
### Self-Hosted: NO. For self-hosted: Hocuspocus (Y.js server) or PartyKit (Cloudflare DO)

### GOTCHAS
1. 20 simultaneous connections PER ROOM on Pro — 21st person is rejected. Enterprise for larger rooms.
2. Free tier badge cannot be removed without paid plan
3. "Unlimited" MAU/rooms has hidden credit caps — know expected usage
4. 10 MB room data limit hit faster than expected with rich collaboration history
5. React-centric — non-React codebases require significant extra work

---

## PARTYKIT (Cloudflare-acquired 2024)

### What It Is
Edge-native programmable real-time backend on Cloudflare Durable Objects. Write custom TypeScript server logic per "party" (room). Deploys to 300+ Cloudflare PoPs. Integrates natively with Y.js, Automerge, Replicache, tldraw.

### Pricing
NO separate PartyKit subscription. Bills through Cloudflare:
- Workers Free: 100K requests/day, 10ms CPU/invocation
- Workers Paid ($5/mo): 10M requests/month, 30ms CPU/invocation
- Durable Objects: separate billing on top
- Small app with < 1M WS messages/month likely costs < $5/month total

### Latency: WebSocket connections terminate geographically close to users (300+ PoPs). Sub-10ms within same region.

### Self-Hosted: Open-source. Run locally for dev. Production is Cloudflare-infrastructure only — no "deploy to your own server."

### GOTCHAS
1. Costs are indirect (Cloudflare bills, no single "PartyKit invoice")
2. Durable Object SQLite storage $0.20/GB-month — room state persists
3. CPU 10ms limit per invocation can be hit by complex server logic on free tier
4. Cloudflare account required

---

## CLOUDFLARE DURABLE OBJECTS

### Pricing (Workers Paid $5/mo required)
- 1M requests/month included, then $0.15/million
- 400K GB-sec/month included, then $12.50/million GB-sec
- SQLite rows: $0.001/M reads, $1.00/M writes
- SQLite storage: $0.20/GB-month
- WebSocket Hibernation API: when object idle, compute billing pauses — CRITICAL for cost efficiency
- Incoming WS messages billed at 20:1 ratio

### MUST USE WebSockets Hibernation API for long-lived connections. Non-hibernating = billing runs continuously.

### GOTCHAS
1. Duration billed wall-clock, not CPU — use Hibernation API
2. Storage writes expensive at $1/M rows written
3. Single-threaded per object — can become bottleneck for high-message rooms
4. First request to new object: 50–200ms instantiation
5. $5/mo Workers Paid required before any Durable Objects paid features

---

## UPSTASH KAFKA + QSTASH

### Kafka Free Tier: 1 cluster, prototype-level limits (verify current at upstash.com)
### QStash Free Tier: ~500 messages/day free

### QStash Paid
- Pay-as-you-go: $1/100K messages
- Retries count as messages
- Fixed plans from ~$180/month for high-volume

### Upstash vs Managed Kafka
| | Upstash | MSK/Confluent |
|---|---|---|
| Pricing | Pay-per-request, scale-to-zero | Flat monthly (provisioned) |
| Ops | Zero | Moderate-High |
| Best for | Spiky, sporadic, low-medium volume | Sustained, high, predictable |
| Break-even | >50M msgs/month managed Kafka cheaper | Always paying at zero usage |

### GOTCHAS
1. Retries bill as messages — endpoint fails 5x = 6 messages billed
2. >100M messages/month: managed Kafka at flat rate may be cheaper
3. Upstash changes pricing frequently — verify before building financial projections
4. No Kafka Streams — stream processing needs external (Flink, Spark)
5. Upstash Redis pricing changed significantly March 2025

---

## LIVEKIT (Video/Audio/AI Voice)

### Free Tier (Build Plan)
- 5,000 WebRTC minutes/month
- 100 concurrent connections
- 1,000 AI agent minutes

### Paid Pricing
| Plan | $/mo | WebRTC min | Connections |
|---|---|---|---|
| Ship | $50 | 150,000 | 1,000 |
| Scale | $500 | 1,500,000 | 5,000 |
| Enterprise | Custom | Custom | Custom |

### Self-Hosted: YES — Apache 2.0. Self-hosting becomes cheaper than Cloud around 500+ concurrent sessions.

### LiveKit vs Agora vs Twilio Video
| | LiveKit | Agora | Twilio |
|---|---|---|---|
| Open source | YES | NO | NO |
| Self-hosted | YES | NO | NO |
| AI agents | First-class | Limited | Limited |
| Pricing | Subscription+usage | Per-minute PAYG | Per-minute PAYG |

### GOTCHAS
1. Agent minutes billed separately from WebRTC minutes
2. AI inference costs are additive (LLM tokens + STT audio + TTS characters)
3. Self-hosting at scale = Kubernetes + TURN + SFU complex DevOps
4. Recording/egress has per-minute transcoding fees

---

## NATS vs RabbitMQ vs Apache Kafka

| | NATS+JetStream | RabbitMQ | Kafka |
|---|---|---|---|
| Model | Pub/sub + stream | AMQP broker | Distributed log |
| Throughput | Very high | Moderate | Extreme (millions/sec) |
| Latency | Sub-ms to 5ms | 5-20ms | 5-15ms (consumer lag variable) |
| Replay | JetStream only | NO | YES (core feature) |
| Memory footprint | Tiny (~20MB) | Medium (~200MB) | Large (JVM, GB+ brokers) |
| Ops complexity | Very low (single binary) | Moderate | Very high (ZooKeeper/KRaft, JVM) |

### Choose NATS: Microservices, IoT, edge, want 80% Kafka features at 10% complexity
### Choose RabbitMQ: Complex routing (AMQP), traditional task queue, multi-protocol (MQTT+AMQP+STOMP)
### Choose Kafka: High-throughput data pipelines, event sourcing, need replay from any point, enterprise data backbone

### Modern Alternatives 2026
- Redpanda: Kafka-compatible, C++, 10x lower resource usage, no ZooKeeper
- WarpStream: Kafka-compatible, S3-backed, extremely low cost at scale
- AutoMQ: S3-native Kafka replacement

---

## WEBSOCKET SELF-HOSTING

### Socket.IO
- Provides WebSocket + HTTP long-poll fallback
- Room management, namespaces, middleware built-in
- Requires Redis or NATS adapter for multi-node
- Higher overhead than raw WS (~25-30% more memory per connection)
- Best for: rapid dev, Node.js teams, auto-reconnection needed

### Soketi — ⚠️ ABANDONED/ARCHIVED — DO NOT USE for new projects
### Laravel Reverb — Active 2025, PHP ecosystem, Pusher-protocol compatible self-hosted

### Best Platforms for Self-Hosted WebSocket
| Platform | WS Support | Notes |
|---|---|---|
| Fly.io | Excellent | Global edge, Anycast, best for low-latency WS |
| Railway | Good | Simple billing, no egress fees |
| Render | Good | Can sleep on free tier |
| Any VPS | Full control | Tune file descriptors, use nginx upstream |

---

## DNS & NETWORKING

### Cloudflare DNS
- Free, unlimited queries, DNSSEC one-click, fastest globally (#1 on DNSPerf.com ~11ms avg)
- Anycast across 310+ cities
- Pro $25/mo: advanced analytics, custom WAF; Business $200-250/mo: custom nameservers, 100% SLA
- Cloudflare Registrar: wholesale pricing ($8.57/yr .com, no markup)

### AWS Route 53
- $0.50/zone/month (first 25 zones), $0.10/zone/month additional
- DNS queries: ~$0.40/M standard; $0.60/M latency-based; $0.70/M geo
- Alias records to AWS services: FREE (always use Alias, never CNAME for AWS endpoints)
- Health checks: first 50 AWS endpoint checks FREE; non-AWS $0.50/check/month
- Best for: AWS-native infra, complex traffic routing, multi-region failover with health checks

### Cloudflare Tunnel
- Free for personal/self-hosted (Cloudflare account required)
- Outbound-only encrypted tunnel — no inbound ports needed, no NAT traversal
- Permanent setup with custom domain
- Zero Trust auth built-in
- vs Ngrok: Cloudflare wins on price (free BW), custom domain, production use; Ngrok wins on request inspection, webhook replay, debug UX

### Tailscale
- Free: 3 users, 100 devices, WireGuard-based mesh VPN
- Team: $6/user/month
- Zero-config private mesh network between devices/servers
- Best for: secure access to private infrastructure, site-to-site networking, dev environments accessing production resources

### Ngrok
- Free: 1 active tunnel, 1GB/month BW, 2-hour session limits, random URLs (+ 1 static ngrok-free.app domain), interstitial warning page on browser HTML
- Personal: ~$10/mo — removes interstitial, persistent URLs, custom domains
- Pro: ~$20/mo — more endpoints
- Best for: Webhook debugging, request inspection, quick demos, OAuth callback URLs during dev

---

## DECISION FRAMEWORK: REAL-TIME PLATFORM SELECTION

```
Need VIDEO/AUDIO?
  YES → LiveKit (self-host if HIPAA/scale, Cloud if managed)

Need COLLABORATIVE EDITING (cursors, CRDT, shared state)?
  YES → Liveblocks (React, managed, out-of-box)
         PartyKit (custom logic + edge)
         Hocuspocus (self-hosted Y.js)

Need SIMPLE PUB/SUB (notifications, chat, dashboards)?
  Small / prototype → Pusher Sandbox (100 connections free)
  Production / reliability → Ably Standard ($29/mo, 6M msg free to start)
  Serverless / edge → PartyKit or Upstash QStash
  High-throughput broadcast → Ably (guaranteed delivery)

Need MESSAGE QUEUING (background jobs, scheduling)?
  Serverless / bursty → Upstash QStash ($1/100K msgs)
  High-throughput sustained → Kafka (Confluent/MSK/Redpanda)
  Low-latency microservices → NATS JetStream

Need WebSocket self-hosting?
  Node.js teams → Socket.IO + Redis adapter on Fly.io or Railway
  Maximum performance → raw ws library on Fly.io
  PHP → Laravel Reverb
```

## FREE TIER CHEAT SHEET

| Service | Free Limit | What Breaks at Limit |
|---|---|---|
| Ably | 200 concurrent connections, 6M msg/mo | Connections rejected |
| Pusher | 100 concurrent + 200k msg/DAY | Connections dropped (hard quota) |
| Liveblocks | 10 simultaneous connections/room | Users can't join rooms |
| LiveKit Cloud | 5,000 WebRTC min + 1K agent min/mo | Plan upgrade required |
| Cloudflare Workers | 100k requests/day | Returns 1015 error |
| Cloudflare DO | 100k req/day | Rate limited |
| Cloudflare Zero Trust | 50 users | Access denied to new users |
| Cloudflare Tunnel | Unlimited BW | N/A (account required) |
| Upstash QStash | ~500 msg/day | Pay-per-use kicks in |
| Cloudflare DNS | Unlimited queries | N/A |
| Ngrok Free | 1GB/mo, 2hr sessions | Session terminated |
| Route 53 | 50 health checks free | $0.50/zone/month |

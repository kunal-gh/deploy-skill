# Reference: AI/ML Specialized Platforms & Real-Time Services (2026)

> Last research update: 2026-07-09

---

## SECTION A: AI/ML Model Serving & GPU Compute

### Why Specialized AI Hosting?

Standard cloud providers (AWS Lambda, GCP Cloud Run) don't support GPU compute.
For AI/ML workloads, you need GPU-enabled infrastructure:

| Option | When to Use |
|--------|------------|
| Modal | Python ML functions, serverless GPU, best DX |
| RunPod | Balanced cost + reliability for GPU |
| Vast.ai | Cheapest GPU (marketplace, variable reliability) |
| HuggingFace Inference | Pre-built model hosting, no GPU management |
| Replicate | Easy model API deployment |
| AWS SageMaker | Enterprise ML on AWS |
| GCP Vertex AI | Enterprise ML on GCP |
| Together AI | LLM inference at scale |

---

### 1. Modal (Best DX for Python ML)

**Website:** modal.com  
**Best for:** Python-native serverless GPU functions, data pipelines, LLM inference

**Pricing (2026):**
| Resource | Price |
|----------|-------|
| A10G GPU | $0.00014/second (~$0.50/hr) |
| A100 (40GB) | $0.00028/second (~$1.00/hr) |
| H100 | ~$3.00/hr |
| CPU | $0.000014/second (~$0.05/hr) |
| Memory | $0.000007/GB-second |
| Free tier | $30/month credits |

**Key Features:**
```python
import modal

app = modal.App()

@app.function(gpu="A10G")
def run_inference(text: str) -> str:
    from transformers import pipeline
    pipe = pipeline("text-generation", model="gpt2")
    return pipe(text)[0]["generated_text"]
```
- Define GPU requirements as Python decorators
- Auto-scales to zero when idle (pay nothing when not running)
- Hot module reloading for fast iteration
- Distributed compute: map/parallel execution
- Persistent storage volumes
- Cron jobs and webhooks
- Web endpoints (deploy FastAPI in one line)
- Container snapshots (fast cold starts for large models)

**Best for:**
- Data scientists deploying ML models
- ETL pipelines with GPU acceleration
- LLM fine-tuning and inference APIs
- Batch processing jobs

**Gotchas:**
- Python-only (no Node.js/Go/etc. native support)
- Learning the Modal paradigm requires time
- Cold starts for large models (mitigated by container snapshots)

---

### 2. RunPod

**Website:** runpod.io  
**Best for:** Balanced GPU compute, reliable marketplace pricing

**Pricing (2026):**
| GPU | Secure Cloud | Community Cloud |
|-----|-------------|----------------|
| RTX 4090 | ~$0.54/hr | ~$0.34/hr |
| A100 (80GB) | ~$2.69/hr | ~$1.89/hr |
| H100 (80GB) | ~$4.69/hr | ~$3.49/hr |
| L40S | ~$1.44/hr | ~$0.92/hr |

**Products:**
- **Serverless (Recommended for production):** Auto-scaling GPU workers, pay per execution
  - Workers scale 0→N based on queue depth
  - Priced per-second of GPU use
  - Cold starts: 10–60 seconds (depends on image size)
- **Pods:** Persistent GPU rental (hourly)
- **Storage:** Network volumes ($0.07/GB/month)

**Serverless Pricing:**
- $0.00023/second for RTX 4090 worker
- Minimum 2-second billing per execution
- No charge when idle (scale-to-zero)

**Best for:**
- LLM inference APIs (Llama, Mistral, etc.)
- Image generation (Stable Diffusion, FLUX)
- ML model serving with auto-scaling
- Long-running GPU training jobs (Pods)

---

### 3. Vast.ai

**Website:** vast.ai  
**Best for:** Cheapest possible GPU (auction/marketplace model)

**Key Facts:**
- Marketplace of community-provided GPUs
- Prices can be 50–80% cheaper than cloud providers
- **Variable reliability** — community hosts are NOT enterprise-grade

**Pricing:** Highly variable, often $0.10–$0.50/hr for RTX 3090/4090

**When to Use:**
- Experiments and research (not production)
- Training runs where reliability is less critical
- When budget is absolute top priority

**When NOT to Use:**
- Production inference API (use RunPod Serverless or Modal)
- When uptime guarantees are needed

---

### 4. HuggingFace Inference Endpoints

**Website:** huggingface.co/inference-endpoints  
**Best for:** Deploying HuggingFace models with no infrastructure knowledge

**Pricing:**
- CPU instances: From $0.06/hr
- GPU (T4): $0.60/hr
- GPU (A100): $4.00/hr
- Dedicated endpoints (always-on)

**Key Features:**
- Deploy any HuggingFace model in minutes
- Auto-scale from 0 replicas
- Private endpoints (not public)
- VPC integration
- Best for: Teams wanting to use HuggingFace ecosystem models

---

### 5. Replicate

**Website:** replicate.com  
**Best for:** Easy model deployment via API, no infrastructure management

**Key Facts:**
- Public and private model hosting
- Pay per prediction (varies by model)
- Popular models: Llama, SDXL, Whisper, CodeLlama, FLUX
- API-based: `curl https://api.replicate.com/v1/predictions`
- Cold starts present (models loaded on demand)

**Pricing:** Model-specific, typically $0.001–$0.05 per prediction

---

### 6. Together AI

**Website:** together.ai  
**Best for:** LLM inference at scale, OpenAI-compatible API

**Pricing (LLM inference):**
| Model | Input | Output |
|-------|-------|--------|
| Llama 3.1 8B | $0.18/million tokens | $0.18/million tokens |
| Llama 3.1 70B | $0.88/million tokens | $0.88/million tokens |
| Mixtral 8x22B | $1.20/million tokens | $1.20/million tokens |

**Key Features:**
- OpenAI-compatible API (drop-in replacement)
- Fine-tuning support
- Embedding models

---

### 7. Enterprise ML Platforms

| Platform | Provider | Best For |
|----------|---------|---------|
| SageMaker | AWS | End-to-end ML on AWS |
| Vertex AI | GCP | End-to-end ML on GCP |
| Azure ML | Azure | End-to-end ML on Azure |
| Databricks | Multi-cloud | Big data + ML at enterprise scale |

**Note:** These are all significantly more expensive and complex than Modal/RunPod.
Only use for enterprise teams with dedicated MLOps engineers.

---

### AI Compute Decision Tree

```
What type of AI workload?

├── Run Python ML functions (inference/fine-tuning)
│   → Modal (best DX, serverless GPU)
│
├── Deploy open-source LLM as API (Llama, Mistral, etc.)
│   ├── Need OpenAI-compatible API → Together AI or Groq
│   ├── Need own infra → RunPod Serverless
│   └── Need full control → Modal
│
├── Deploy image generation (Stable Diffusion / FLUX)
│   → RunPod Serverless or Replicate
│
├── Use existing HuggingFace model
│   → HuggingFace Inference Endpoints (simplest)
│
├── Need cheapest possible GPU (experiments)
│   → Vast.ai (least reliable, cheapest)
│
├── Production inference at scale + enterprise
│   → AWS SageMaker or GCP Vertex AI
│
└── Add AI to existing app (no GPU needed)
    → Use OpenAI API or Together AI (just API calls, no GPU management)
```

---

## SECTION B: Real-Time & WebSocket Platforms

### 1. Ably (Enterprise Real-Time)

**Website:** ably.com  
**Best for:** Mission-critical real-time messaging at scale

| Tier | Price | Messages |
|------|-------|---------|
| Free | $0 | 6M messages/month, 200 peak connections |
| Standard | $39/month | 25M messages, 5K peak connections |
| Pro | $149/month | 100M messages, 20K peak connections |
| Enterprise | Custom | Custom |

**Key Features:**
- **Exactly-once delivery** guarantee (unique in the industry)
- Connection state recovery (no missed messages on reconnect)
- 16+ global data centers
- 99.999% uptime SLA (Enterprise)
- Sub-100ms global latency
- Protocols: WebSocket, SSE, MQTT, HTTP
- Presence (know who's online)
- History (retrieve missed messages)
- Push notifications (APN, FCM)

**Best for:**
- Financial data feeds (stock prices, live scores)
- Live inventory / e-commerce
- IoT data streaming
- Multiplayer games requiring strict ordering

---

### 2. Pusher Channels (Simple Real-Time)

**Website:** pusher.com/channels  
**Best for:** Simple real-time features with fastest time-to-implement

| Tier | Price | Connections |
|------|-------|------------|
| Sandbox | Free | 100 simultaneous, 200K messages/day |
| Starter | $49/month | 500 simultaneous, 5M messages/day |
| Pro | $99/month | 2000 simultaneous, 10M messages/day |

**Key Features:**
- Very simple API (15 min to get WebSockets running)
- Channels: Public, Private, Presence
- Client events (client-to-client messaging)
- Webhooks on events
- Available in every major SDK

**Best for:**
- Adding basic real-time to any app quickly
- Notifications, live counters, chat MVP
- Teams new to WebSockets

**Limitations:**
- Single regional cluster (higher latency for global users vs Ably)
- No guaranteed message ordering or delivery
- No message history by default

---

### 3. Liveblocks (Collaborative Multiplayer)

**Website:** liveblocks.io  
**Best for:** Building Google Docs-like collaborative features

| Tier | Price | MAU |
|------|-------|-----|
| Starter | Free | 100 MAU, 100 rooms |
| Starter | $99/month | 1K MAU |
| Business | $399/month | 5K MAU |
| Enterprise | Custom | Custom |

**Key Features:**
- **Room-based collaboration** — each document/resource has a room
- Presence API (live cursors, awareness)
- Storage (shared, conflict-free CRDT data)
- LiveList, LiveMap, LiveObject (conflict-free data structures)
- Yjs integration (for rich text editors: Tiptap, Slate, CodeMirror)
- Comments API (threaded comments on any element)
- AI features: Thread summaries, context-aware suggestions
- Notifications (in-app notification feed)

**Best for:**
- Collaborative design tools (Figma-like)
- Document editors with simultaneous editing
- Whiteboard applications
- Code editors with collaboration
- Any app with "multiplayer" requirements

---

### 4. PartyKit (Durable WebSockets)

**Website:** partykit.io  
**Best for:** Real-time apps on Cloudflare Workers + Durable Objects

- Built on Cloudflare Workers Durable Objects
- Room-based WebSocket server (like Liveblocks but programmable)
- TypeScript-native
- Deployed to Cloudflare edge (global, fast)
- Open source

```typescript
// PartyKit server
export default class MyParty implements Party.Server {
  onMessage(message: string, sender: Party.Connection) {
    this.room.broadcast(message, [sender.id]); // broadcast to all except sender
  }
}
```

**Best for:** Developers who want full control over real-time logic + edge deployment

---

### 5. Socket.io (Self-Hosted WebSockets)

- Most popular WebSocket library
- Self-hosted on your own server
- Works with: Railway, Fly.io, Render, any VPS
- Free (open source)
- Requires sticky sessions or Redis adapter for multi-instance scaling

---

### 6. Real-Time Databases

| Service | Protocol | Best For |
|---------|---------|---------|
| Supabase Realtime | WebSocket | PostgreSQL change subscriptions |
| Firebase Realtime DB | WebSocket | Mobile apps, simple shared state |
| PubNub | WebSocket/SSE | Global messaging infrastructure |
| Convex | WebSocket | Reactive backend for web apps |

---

### Real-Time Decision Guide

```
What type of real-time feature?

├── Simple notifications / chat / live counters
│   → Pusher (fastest to implement, very cheap for small apps)
│
├── Mission-critical messaging (finance, live scores, IoT)
│   → Ably (exactly-once delivery, SLA, global)
│
├── Collaborative document editing (Notion-like)
│   → Liveblocks (CRDT + Yjs + Presence + Comments = all you need)
│
├── Custom real-time logic at Cloudflare edge
│   → PartyKit (Durable Objects + TypeScript)
│
├── Subscribing to database changes
│   → Supabase Realtime (free with Supabase)
│
├── Self-hosted WebSockets (already have a server)
│   → Socket.io on Railway/Fly.io/VPS
│
└── Mobile app with real-time state
    → Firebase Realtime DB or Supabase Realtime
```

---

## SECTION C: Authentication as a Service

Many deployment decisions involve choosing an auth provider.
Quick reference:

| Service | Free Tier | Notes |
|---------|-----------|-------|
| Supabase Auth | 50K MAU free | PostgreSQL-backed, open source |
| Clerk | 10K MAU free | Best DX, Next.js native |
| Auth0 | 7.5K MAU free | Most enterprise features |
| Lucia (self-hosted) | Free | Open source, full control |
| NextAuth.js | Free | DIY auth for Next.js |
| Better Auth | Free | Modern open source auth library |
| Keycloak | Free | Enterprise self-hosted auth |
| AWS Cognito | 50K MAU free (12 mo) | AWS native |
| Firebase Auth | 50K MAU free | Google, easy mobile integration |

**Quick Guide:**
- Next.js app → **Clerk** (best DX, superb Next.js integration)
- Full-stack with Supabase → **Supabase Auth** (built-in)
- Mobile app (Flutter/React Native) → **Firebase Auth** or **Supabase Auth**
- Enterprise SSO/SAML → **Auth0** or **Keycloak** (self-hosted)
- Need full control → **Better Auth** (modern) or **Lucia** (auth logic framework)

---

## SECTION D: Email Infrastructure

| Service | Free Tier | Best For |
|---------|-----------|---------|
| Resend | 3K emails/day free | Modern API, React Email integration |
| Postmark | 100 emails/month free | High deliverability, transactional |
| SendGrid | 100 emails/day free | High volume, marketing + transactional |
| Brevo (Sendinblue) | 300 emails/day free | EU, GDPR, combined marketing |
| AWS SES | $0.10/1K emails | Cheapest at scale, complex setup |
| Mailgun | 1K emails/month free | Developer-friendly API |
| Self-hosted (Postal) | Free | Maximum control, complex setup |

**Quick Guide:**
- Modern React/Next.js apps → **Resend** (React Email templates, beautiful DX)
- High deliverability transactional → **Postmark**
- Scale with minimal cost → **AWS SES**
- EU compliance → **Brevo**

# Reference: CI/CD, DevOps & Infrastructure Tools (2026)

> Last research update: 2026-07-09

---

## Overview

The CI/CD landscape in 2026 has consolidated around a few key tools:
- **GitHub Actions** dominates for hosted CI (most repos are on GitHub)
- **GitLab CI** for teams on GitLab or wanting full DevOps in one tool
- **ArgoCD / FluxCD** for Kubernetes-native GitOps
- **Terraform / OpenTofu** for Infrastructure as Code
- **Woodpecker CI** as the best self-hosted lightweight option

---

## SECTION A: Cloud CI/CD Platforms

### 1. GitHub Actions

**Best for:** Teams using GitHub (default choice for most projects)

| Tier | Price | Minutes/month |
|------|-------|--------------|
| Free (public repos) | $0 | **Unlimited** |
| Free (private repos) | $0 | 2,000 minutes/month |
| Team | $4/user/month | 3,000 minutes/month |
| Enterprise | $21/user/month | 50,000 minutes/month |

**Additional:** $0.008/minute for Linux (after included), $0.016/minute for Windows, $0.064/minute for macOS

**Features:**
- YAML-based workflow definitions (`.github/workflows/`)
- 20,000+ reusable Actions in marketplace
- Matrix builds (test across multiple OS/version combinations)
- Self-hosted runners (run your own runners for free)
- GitHub-hosted runners: Ubuntu, Windows, macOS
- Artifacts storage (500MB free, then $0.25/GB/month)
- Container registry (GitHub Container Registry — GHCR, free for public)
- Secrets management via GitHub Secrets
- Environments + required reviewers for deployment gates
- Caching (5GB per repo)
- Concurrency controls

**Key Gotchas:**
- macOS runners are 10x more expensive than Linux
- Large teams can burn through minutes quickly
- Docker layer caching requires workarounds (no native layer cache like CircleCI)
- Workflow YAML can become complex for sophisticated pipelines

**Best for:**
- Teams on GitHub (90%+ of open-source and most SaaS companies)
- Open-source projects (unlimited free minutes on public repos)
- Teams wanting the largest ecosystem of pre-built workflow actions

---

### 2. GitLab CI/CD

**Best for:** Teams on GitLab or wanting all-in-one DevSecOps

| Tier | Price | CI Minutes |
|------|-------|-----------|
| Free | $0 | 400 minutes/month |
| Premium | $29/user/month | 10,000 minutes |
| Ultimate | $99/user/month | 50,000 minutes |

**Features:**
- Integrated directly with GitLab repos
- `.gitlab-ci.yml` pipeline definition
- Built-in container registry
- SAST, DAST, dependency scanning (security built-in)
- Kubernetes executor (run jobs inside K8s pods)
- Self-hosted GitLab runners
- Environments and deployments tracking
- Review Apps (per-MR preview environments)
- Infrastructure as Code (Terraform/Pulumi integration)
- GitLab Agent for Kubernetes (cluster management)
- Comprehensive environment management

**Key Differentiators vs GitHub Actions:**
- More powerful complex pipelines (rules, needs, DAG pipelines)
- Better Kubernetes integration
- Built-in security scanning
- All-in-one DevOps platform (no external tools needed)

**Best for:**
- Enterprise teams needing unified platform (code + CI + security + deploy)
- Teams running self-managed GitLab on-premises
- Complex pipeline workflows

---

### 3. CircleCI

**Best for:** Teams prioritizing raw build speed

| Tier | Price | Credits/month |
|------|-------|--------------|
| Free | $0 | 30,000 credits (~2500 min) |
| Performance | $15/month/seat + compute | Based on usage |
| Scale | Custom | Custom |

**Features:**
- Native Docker layer caching (fastest for Docker builds)
- Parallelism splitting (split test files across parallel containers)
- Orbs (reusable pipeline packages)
- SSH debugging into failed builds
- Machine executor (full VM) or Docker
- macOS support
- Test intelligence (automatically identifies slow/flaky tests)

**Best for:**
- Teams where build speed is critical
- High-parallelism test suites
- Teams that prioritize cache efficiency

---

### 4. Other Cloud CI Platforms

| Platform | Starting Price | Key Differentiator |
|----------|---------------|-------------------|
| Semaphore CI | $0 free tier (1300 min/mo) | Fast, good caching |
| Drone CI | Open source (self-hosted) | Simple YAML, Docker-native |
| Buildkite | $450/month | Hybrid (your runners, their UI) |
| Travis CI | Paid only (legacy) | Legacy, largely superseded |
| TeamCity | Free (100 builds/day) | JetBrains ecosystem, powerful |

---

## SECTION B: Self-Hosted CI/CD

### 1. Woodpecker CI

**Best for:** Lightweight self-hosted CI, open source

- Fork of Drone CI (go fork, active development)
- YAML pipeline definition (Drone-compatible)
- Very lightweight (runs on 512MB RAM)
- Supports: GitHub, GitLab, Gitea, Forgejo
- Docker-based runners
- Community-driven, FOSS
- **Self-hosted on your VPS or Kubernetes**
- No license cost

---

### 2. Jenkins

**Best for:** Enterprise self-hosted CI with maximum flexibility

- Most mature self-hosted CI
- 1800+ plugins
- Complex pipelines (Declarative Jenkinsfile or Scripted)
- High operational overhead (requires maintenance)
- No SaaS version
- Best for: Existing Jenkins shops, complex on-premises requirements

---

### 3. Gitea + Gitea Actions

**Best for:** Fully self-hosted Git + CI in one (GitHub-compatible)

- GitHub Actions-compatible YAML
- Gitea is a lightweight self-hosted Git service
- Gitea Actions supports GitHub Actions runners
- Very popular in China and privacy-focused organizations

---

### 4. Concourse CI

**Best for:** Declarative, testable CI pipelines

- Pure declarative YAML pipelines
- Every pipeline step is a container
- Strong isolation model
- Harder to learn than Jenkins or GitHub Actions

---

## SECTION C: GitOps / Kubernetes CD

### 1. ArgoCD

**Best for:** Kubernetes GitOps continuous delivery

- Sync Kubernetes manifests from Git to cluster
- Web UI with diff visualization
- Automated or manual sync
- Multi-cluster support
- Health status monitoring
- RBAC for deployment permissions
- **Self-hosted on your cluster (free)**
- Supports Helm, Kustomize, Jsonnet
- CNCF project, industry standard

---

### 2. FluxCD

**Best for:** GitOps for Kubernetes (alternative to ArgoCD)

- Pull-based GitOps (cluster pulls from Git)
- Lighter weight than ArgoCD
- Supports Helm, Kustomize
- Image automation (auto-update container image references)
- CNCF project

**ArgoCD vs FluxCD:**
- ArgoCD: Better UI, more features, push/pull hybrid
- FluxCD: Lighter weight, simpler, pure pull model

---

### 3. Spinnaker

**Best for:** Multi-cloud deployment pipelines (Netflix-originated)

- Complex multi-cloud deployment strategies (blue-green, canary, rolling)
- Pipeline templates
- Kubernetes and VM support
- Heavy operational overhead — not for small teams

---

## SECTION D: Infrastructure as Code (IaC)

### 1. Terraform (HashiCorp)

**The industry standard for IaC.**

| Tool | License | Notes |
|------|---------|-------|
| Terraform | BSL (non-open) | Used by most teams |
| OpenTofu | MPL 2.0 (truly open) | Drop-in fork, actively maintained |

**Features:**
- Declarative HCL configuration
- Provider ecosystem: AWS, GCP, Azure, Cloudflare, Vercel, Railway, Fly.io, etc.
- State management (local or remote in Terraform Cloud/Spacelift/etc.)
- Plan/Apply workflow (dry-run before applying)
- Import existing resources
- Module system for reusability

**When to use:** When you need to provision cloud infrastructure (VPCs, managed DBs, serverless functions, etc.) as code

**Note:** HashiCorp changed Terraform to BSL license in 2023. Many teams now prefer **OpenTofu** as a drop-in replacement.

---

### 2. OpenTofu

**Best for:** Drop-in Terraform replacement with truly open-source license

- Fork of Terraform under Linux Foundation
- MPL 2.0 license
- 100% backwards compatible with Terraform
- State encryption (ahead of Terraform in features)
- Growing adoption (recommended for new projects)

---

### 3. Pulumi

**Best for:** Teams wanting IaC in real programming languages

| Tier | Price |
|------|-------|
| Individual | Free |
| Team | $50/month |
| Enterprise | Custom |

**Features:**
- Write IaC in TypeScript, Python, Go, Java, C#, YAML
- Same providers as Terraform
- Pulumi Cloud for state management
- Testing with real test frameworks
- Strong for teams already writing in those languages

**When to prefer Pulumi over Terraform:** When your team is more comfortable with general-purpose code than HCL, or when you need conditional logic in IaC.

---

### 4. AWS CDK

**Best for:** AWS-native teams wanting typed programming for CloudFormation

- TypeScript, Python, Java, C# (.NET), Go
- Compiles to CloudFormation
- Type-safe AWS resource definitions
- Strong L2 constructs (higher-level abstractions)
- AWS-only

---

### 5. Ansible

**Best for:** Server configuration management, not IaC for cloud resources

- YAML-based playbooks
- SSH-based, agentless
- Good for: VM configuration, package installation, app deployment on existing servers
- Not ideal for: Provisioning cloud resources (use Terraform for that)

---

## SECTION E: Container Registries

| Registry | Free Tier | Pricing | Notes |
|----------|-----------|---------|-------|
| Docker Hub | 1 private repo | $5/month | Industry standard, rate limits on pulls |
| GitHub Container Registry (GHCR) | Free for public | Free for teams (included) | Best for GitHub-hosted projects |
| AWS ECR | 500MB free | $0.10/GB/month | AWS ecosystem |
| GCP Artifact Registry | 0.5GB free | $0.10/GB/month | Replaces GCR |
| Azure Container Registry | Basic $5/month | - | Azure ecosystem |
| DigitalOcean Registry | 500MB free | $5/month (5GB) | Simple |
| Quay.io (Red Hat) | Public free | Paid for private | Kubernetes/OCI standard |

---

## SECTION F: Secrets Management in CI/CD

| Tool | CI Integration | Free | Notes |
|------|---------------|------|-------|
| GitHub Secrets | GitHub Actions native | Yes | Per-repo or org secrets |
| GitLab CI Variables | GitLab CI native | Yes | Per-project or group |
| Doppler | All major CI/CD | Free tier | Best DX for secret management |
| Infisical | All major CI/CD | Free tier (self-host) | Open source alternative |
| HashiCorp Vault | All major CI/CD | Self-hosted | Enterprise grade |
| AWS Secrets Manager | AWS | $0.40/secret/month | AWS native |
| GCP Secret Manager | GCP | 6 secrets free | GCP native |

---

## CI/CD Decision Guide

```
Where is your code hosted?
├── GitHub → GitHub Actions (default, huge ecosystem)
├── GitLab → GitLab CI/CD (native integration, best features)
└── Self-hosted Git (Gitea/Forgejo) → Woodpecker CI or Gitea Actions

What are your priorities?
├── Speed / build time → CircleCI (best caching) or GitHub Actions (parallel jobs)
├── Kubernetes deployments → ArgoCD (GitOps) on top of your CI
├── Everything in one tool → GitLab CI/CD
├── Enterprise on-premises → Jenkins or self-hosted GitLab
└── Lightweight self-hosted → Woodpecker CI

Do you need Infrastructure as Code?
├── New project → OpenTofu (open source Terraform)
├── AWS native teams → AWS CDK
├── Prefer programming languages → Pulumi
└── Server config management → Ansible
```

---

## Common CI/CD Patterns

### GitHub Actions with Railway
```yaml
name: Deploy to Railway
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
        run: npx @railway/cli deploy
```

### GitHub Actions with Fly.io
```yaml
name: Deploy to Fly.io
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --remote-only
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
```

### GitHub Actions with Docker + GHCR
```yaml
name: Build and Push Docker
on:
  push:
    branches: [main]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Login to GHCR
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - name: Build and Push
        uses: docker/build-push-action@v5
        with:
          push: true
          tags: ghcr.io/${{ github.repository }}:latest
```

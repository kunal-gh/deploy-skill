# DevSecOps & Secrets Management — Research (July 2026)

> Last research update: 2026-07-09
> Always verify pricing, licensing, and incident claims at official docs.

## SECRETS MANAGEMENT TOOLS

### DOPPLER
**Type:** SaaS-only managed secrets manager. Best developer experience.

**Free Tier (Developer):**
- Up to 3 users (then $8/user/month up to 25)
- 10 projects, 4 environments/project, 50 service tokens
- API, webhooks, CLI: YES
- RBAC, SAML SSO, secret rotation: NO

**Paid:**
- Team: ~$21/user/month — 500 users, 250 projects, 15 envs, RBAC, SAML SSO, secret rotation
- Enterprise: Custom — custom permissions, SCIM, dynamic secrets, 99.95% SLO, dedicated account manager

**CI/CD Integration:**
- GitHub Actions: `dopplerhq/secrets-fetch-action@v1` — supports OIDC (keyless, no stored token)
- GitLab CI: `doppler run -- your-script.sh` using service token as GitLab CI/CD variable
- OIDC recommended: `id-token: write` permission + OIDC auth = no static DOPPLER_TOKEN needed

**Cloud Integration:**
- AWS: Native sync → populates AWS Secrets Manager, Parameter Store directly
- GCP: Sync to GCP Secret Manager
- Azure: Sync to Azure Key Vault
- Kubernetes: Doppler Kubernetes Operator (Helm) → creates/updates K8s Secrets from DopplerSecret CRDs, reloads pods on change
- Vercel, Netlify, Render: Native 1-click integrations

**Self-Hosted:** NO — SaaS only. Biggest limitation.

**Best for:** Startups wanting speed over control. Multi-environment projects. Teams without dedicated infra/security engineers. Developer onboarding (new dev runs `doppler setup`, gets all secrets instantly).
**Worst for:** Regulated industries needing air-gapped/on-prem. Dynamic DB credentials. Complex enterprise multi-org policy.

**GOTCHAS:**
1. SaaS lock-in: If Doppler goes down, deployments fail. Sync to AWS Secrets Manager as backup.
2. K8s bootstrap: need Doppler service token in a K8s Secret to bootstrap operator (chicken-and-egg). Use external-secrets-operator or Sealed Secrets for initial token.
3. Free tier pricing has shifted over time — verify exact limits at doppler.com
4. No audit log exports on free tier
5. Secret rotation is Team+ only

---

### INFISICAL
**Type:** Open-source + SaaS. Self-hostable. End-to-end encrypted.

**Free Tier (SaaS Cloud):**
- 5 users, 3 projects, 3 environments, 3 machine identities
- 1 secret version, 1-day audit logs
- MFA, SSO, SCIM: NO

**Self-Hosted (Open-Source):** MIT-licensed core. UNLIMITED everything. Zero cost.

**Paid (SaaS):**
- Pro: ~$8-18/user/month — more identities, longer audit logs, custom envs, RBAC
- Enterprise (SaaS/Self-Hosted): Custom — SCIM, advanced RBAC, compliance, SSO

**CI/CD Integration:**
- GitHub Actions: `Infisical/secrets-action@v1.0.7` with universal-auth (client-id + client-secret)
- GitLab CI: `infisical run --projectId=xxx --env=prod -- your-command`

**Cloud/K8s Integration:**
- Kubernetes: Infisical Secrets Operator (syncs secrets into K8s Secrets from Infisical projects)
- Dynamic secrets: Short-lived credentials for PostgreSQL, MySQL, MongoDB
- External Secrets Operator compatibility: Can act as ESO backend
- AWS, GCP, Azure: Machine identities + injection or sync

**Self-Hosted:** YES — First-class support. Docker Compose, Kubernetes (Helm). Requires MongoDB + Redis + TLS.

**Key Differentiator:** End-to-end client-side encryption. Server NEVER sees plaintext secrets.
**Expanding scope:** PKI (X.509 cert management), SSH certificate management (ephemeral SSH certs replacing static keys), secret scanning, Infisical Gateway for private infra.

**Best for:** Companies with data residency/compliance requirements. GitOps-heavy K8s environments. Teams migrating off Vault wanting lower ops overhead.
**Worst for:** Teams without engineering capacity for self-hosted infra (Doppler instead). Very large machine identity sprawl on SaaS (cost scales per identity).

**GOTCHAS:**
1. Self-hosting requires MongoDB + Redis + LB + TLS — budget 2-4 engineer-days
2. Machine identity pricing: on SaaS, every CI/CD runner + every K8s service account + every microservice = seat. Self-host to avoid.
3. E2E encryption: lose your encryption keys = lose your secrets. Document key recovery procedures.
4. Enterprise features are maturing vs Vault
5. MongoDB dependency if org standardizes on PostgreSQL-only environments

---

### HASHICORP VAULT / OPENBAO
**Type:** Enterprise-grade. Dynamic secrets. Beyond KV storage.

**What Vault Does Beyond Simple Secrets:**
- Dynamic secrets: generates short-lived on-demand credentials for PostgreSQL, MySQL, MongoDB, Oracle, AWS STS, Azure AD, GCP IAM, SSH, Kubernetes
- Encryption as a Service (Transit engine): apps encrypt/decrypt without managing keys
- PKI Secrets Engine: Full CA, auto-rotation TLS certs
- Every secret has TTL → auto-expires → Vault revokes
- Audit log every request
- Sentinel Policies (Enterprise): policy-as-code access control
- Namespaces (Enterprise): multi-tenancy
- Cross-datacenter replication (Enterprise)

**Editions & Pricing:**
| Edition | Cost | Notes |
|---|---|---|
| Community Edition | Free self-hosted | BSL 1.1 (NOT open source — restrictions apply) |
| HCP Vault Secrets | Free tier + paid | Simple KV only, light version |
| HCP Vault Dedicated Dev | ~$0.62/hr/cluster | Low-cost dev |
| HCP Vault Dedicated Standard | ~$1.58/hr/cluster + ~$73/mo/client | Full Vault |
| Vault Enterprise | Custom (IBM sales only) | HSM, replication, Sentinel, all features |

**IBM Acquisition (2025):** IBM acquired HashiCorp. Pricing reportedly increased post-acquisition. Review contracts carefully.

**CI/CD Integration:**
- GitHub Actions: `hashicorp/vault-action` — authenticates via GitHub OIDC or AppRole
- GitLab CI: JWT auth method (GitLab issues OIDC JWTs per job)
- Kubernetes: Vault Agent Sidecar or Vault Secrets Operator (injects secrets as files or env vars into pods)

**Dynamic Database Credentials — How It Works:**
1. Vault holds the root DB credentials (app never knows them)
2. App requests credentials from Vault → Vault creates temporary user (TTL 1h)
3. App gets temporary username + password in file/env
4. After TTL expires, Vault revokes the database user
5. App must renew or re-request before expiry

**Auto-Unseal:** Configure AWS KMS, GCP KMS, or Azure Key Vault for automatic unseal on restart. Critical for production — forgetting this = cluster offline after every restart.

**Self-Hosted:** YES — Primary deployment model. HA requires Raft or Consul storage backend.

**OpenBao (True OSS Fork):**
- MPL 2.0 license (truly open source, OSI-approved)
- Fork from Vault 1.14.0, donated to Linux Foundation / OpenSSF
- Drop-in API compatible with Vault
- NVIDIA is notable adopter
- No Vault Enterprise-specific features (Sentinel, multi-region replication, HSM)
- Choose OpenBao when: BSL restrictions matter, building competing product, want OSS governance

**Best for:** Large enterprises with complex multi-cloud secrets. Dynamic DB credentials (Vault uniquely excels here). Internal PKI. Compliance-heavy (SOC2, PCI-DSS, FedRAMP). Teams with dedicated platform engineers.
**Worst for:** Small teams without platform engineer. Simple .env replacement use case. Teams wanting 30-min setup.

**GOTCHAS:**
1. Unsealing: Vault starts sealed. Configure auto-unseal via KMS or clusters go offline on restart.
2. BSL license: Community Edition cannot be used in products competing with HashiCorp.
3. TCO: "Free" Community Edition = 0.5-1 FTE engineering work for HA + monitoring + backup + patching.
4. HCP Vault Clients: ~$73/month per client. Large microservices orgs can rack enormous bills.
5. IBM post-acquisition pricing uncertainty.
6. Lease renewal complexity: apps using dynamic secrets must handle lease renewal or rely on Vault Agent.

---

### 1PASSWORD SECRETS AUTOMATION
**Type:** Extension of 1Password for machine/pipeline secrets.
**Pricing:** Included in existing 1Password subscriptions (Teams ~$4/user/mo, Business ~$8/user/mo)
**Best for:** Orgs already paying for 1Password — Secrets Automation is essentially free.
**Self-Hosted:** Partial — 1Password Connect server is self-hosted Docker container (vault remains in 1Password cloud).
**Worst for:** K8s-native secrets sync (weaker story), dynamic DB credentials, orgs not already on 1Password.

---

### AWS SECRETS MANAGER
**Pricing:** ~$0.40/secret/month + ~$0.05/10K API calls
**Scale warning:** 1,000 secrets = $400/month storage only
**Best for:** AWS-native workloads + RDS (best auto-rotation support), Lambda/ECS seamless via IAM role
**GOTCHAS:**
1. Per-secret billing hits hard: 50 secrets × 10 environments = 500 secrets = $200/month. Use Parameter Store for non-sensitive config (more generous free tier).
2. Cross-region replication doubles secret costs
3. Rotation Lambda cold starts during rotation windows

---

### GCP SECRET MANAGER
**Pricing:** ~$0.06/version/month + ~$0.03/10K access operations
**Best for:** GCP-native (GKE Workload Identity, Cloud Run, Cloud Functions — no key files needed)
**Less out-of-box rotation support vs AWS**

---

### AZURE KEY VAULT
**Pricing:** ~$0.03/10K operations (software keys), ~$1.00/10K (HSM keys), ~$3/certificate/month
**Key advantage:** FIPS 140-3 HSM-protected keys, deep Azure AD/Entra ID integration
**GOTCHA:** Soft-delete cannot be disabled (90-day purge protection) — surprises in terraform destroy workflows. Two permission models (legacy Access Policies + RBAC) — standardize on RBAC.

---

### SOPS (Secrets OPerationS) — CNCF Sandbox Project
**Type:** File-encryption tool for GitOps. Encrypts YAML/JSON/ENV values in-place for safe git commits.
**Encryption backends:** age (recommended 2026, modern, simple), AWS KMS, GCP KMS, Azure Key Vault, HashiCorp Vault, PGP (legacy — avoid)
**Pricing:** Free. Open source.
**GitOps integration:** Flux CD has native SOPS decryption built-in. Argo CD requires argocd-sops plugin or Helm-Secrets.
**Best for:** GitOps workflows where secrets go in Git. "Secrets as Code." Offline/air-gapped environments.
**GOTCHAS:**
1. Lose age private key = lose all secrets encrypted with it
2. Not a secrets server — no audit logs, RBAC, or expiry. Just file encryption.
3. Key rotation = re-encrypting all files (script this carefully)

---

## SECURITY SCANNING TOOLS

### SNYK
**What It Scans:** SAST (Snyk Code), SCA/Dependencies (Snyk Open Source), Container images, IaC (Terraform, K8s, CloudFormation, Helm)
**Key Feature:** Reachability Analysis — determines if vulnerable library function is actually called (massive false-positive reduction). Automated Fix PRs.

**Free Tier:**
- Snyk Open Source (SCA): 200 tests/month
- Snyk Code (SAST): 100 tests/month
- Snyk Container: 100 tests/month
- Snyk IaC: 300 tests/month

**Paid:**
- Team: ~$25-98/developer/month — unlimited tests, Jira integration
- Enterprise: Custom — SSO, SCIM, SIEM integration

**GitHub Actions:**
```yaml
- uses: snyk/actions/node@master
  env:
    SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
  with:
    command: test
```

**Self-Hosted:** NO. Enterprise Broker for private SCM/registry connectivity without traffic leaving network.

**GOTCHAS:**
1. Free tier burns fast in CI/CD — 200 tests/month = 20 PRs × 3 pipeline stages
2. Test limits per-organization, not per-user — all projects share quota
3. Reachability analysis not supported for all languages
4. `snyk monitor` (upload results) needed alongside `snyk test` (fail build)
5. License compliance scanning is paid-only

---

### TRIVY (Aqua Security)
**Type:** Free, open-source, all-in-one scanner. Apache 2.0 license. Single binary.

**What Trivy Scans:**
- Container images: OS package CVEs + app dependency CVEs
- Filesystems, Git repos, Kubernetes clusters (live cluster)
- Terraform/IaC, Helm charts, AWS/Azure ARM/GCP misconfigurations
- SBOM generation (CycloneDX, SPDX)
- VM images, secrets in code

**Pricing:** FREE. Apache 2.0. No limits.

**⚠️ CRITICAL 2026 SUPPLY CHAIN INCIDENT:**
In March 2026, threat actors ("TeamPCP") compromised Trivy's release infrastructure using stolen credentials. Malicious code was force-pushed to `aquasecurity/trivy-action` and `aquasecurity/setup-trivy` GitHub Actions. Compromised binary v0.69.4 was released. The attack harvested CI/CD environment variables and secrets from any pipeline using compromised versions.

**MANDATORY SAFE PATTERN — PIN TO SHA:**
```yaml
# VULNERABLE (mutable tag) — NEVER DO THIS:
uses: aquasecurity/trivy-action@master

# SAFE (pinned commit SHA):
uses: aquasecurity/trivy-action@a20de5420d57c4102486cdd9349b532415f896f5
```
Safe versions: v0.69.2, v0.69.3 (patched releases followed)

**GitHub Actions (safe, with SARIF upload):**
```yaml
- name: Run Trivy
  uses: aquasecurity/trivy-action@a20de5420d57c4102486cdd9349b532415f896f5
  with:
    image-ref: 'my-app:${{ github.sha }}'
    format: 'sarif'
    output: 'trivy-results.sarif'
    severity: 'CRITICAL,HIGH'

- name: Upload to GitHub Security tab
  uses: github/codeql-action/upload-sarif@v3
  with:
    sarif_file: 'trivy-results.sarif'
```

**Cloud Integration:** Default scanner in Harbor registry. `trivy k8s --report=summary cluster` scans live K8s.

**GOTCHAS:**
1. Supply chain incident 2026 — always pin to SHA, never to @master or @latest
2. Vulnerability DB can become stale in air-gapped environments — set up local DB mirror
3. High false positive rate on old base images — use `--ignore-unfixed` for CVEs with no available fix
4. IaC scanning absorbed tfsec — `trivy config` replaces `tfsec`; some rule IDs changed
5. No built-in alerting — build the notification pipeline yourself

---

### SONARQUBE / SONARQUBE CLOUD (formerly SonarCloud — rebranded 2026)
**Type:** Code quality + SAST. Leading static analysis platform.

**Editions (Server/Self-Hosted):**
| Edition | Cost | Key Features |
|---|---|---|
| Community Build | Free (OSS) | Main branch ONLY, 19 languages, basic security |
| Developer Edition | Annual license (per LoC) | PR/branch analysis, taint analysis, C/C++/Swift, AI CodeFix |
| Enterprise Edition | Annual license | Portfolio management, security reports |
| Data Center Edition | Annual | HA clustering |

**SonarQube Cloud (SaaS):**
- Free: up to 50,000 LoC for private projects
- Paid: subscription by LoC (contact for pricing)
- Public repos: always free

**Community Build vs Developer Edition — CRITICAL DIFFERENCE:**
- Community Build: Main branch ONLY. NO PR decoration. NO advanced SAST (taint analysis). NO AI CodeFix.
- Developer Edition: All branches, PR analysis, taint analysis, AI CodeFix.
- **If you need "don't merge vulnerable PRs" quality gate → you MUST have Developer Edition.**

**GOTCHAS:**
1. Community Build's PR limitation is a dealbreaker for most teams — discovered after deployment
2. No migration path between Server and Cloud — choose once
3. SonarQube Server requires PostgreSQL database — add DB maintenance to TCO
4. Quality Gate can block emergency hotfix deployments if not tuned — define bypass procedure
5. LoC counting is measured after deduplication/comment stripping — differs from your count

---

### GITHUB SECRET SCANNING & SECRET PROTECTION
**Free (Public repos):** Automatic scanning, 200+ partner secret patterns, auto-revocation with providers (e.g., AWS auto-revokes), Push Protection blocks pushes with detected secrets.

**GitHub Secret Protection (Paid — Private repos):** $19/active committer/month
- All free features
- Custom patterns (regex)
- Copilot AI detection (catches unstructured/generic passwords)
- Validity checks (tests if secret is still active)
- Delegated bypass controls
- Public repo monitoring for enterprise

**GitHub Code Security (separate):** $30/active committer/month — CodeQL SAST
**Note:** GitHub split "GitHub Advanced Security" into separate "Secret Protection" and "Code Security" products in 2025.

**GOTCHAS:**
1. Push protection can be bypassed by developers ("I'll fix this later") — track bypass events in audit log
2. No retroactive history scanning — run TruffleHog on existing git history separately
3. Per-committer pricing: even 1 commit in billing period = counted committer

---

### SEMGREP
**Type:** Fast, flexible SAST. Pattern-matching on AST (no false positives from code in comments).
**Free:** Community CLI forever. AppSec Platform free for ≤10 contributors/month.
**Team:** ~$35/contributor/month — cross-file analysis, dashboard, PR orchestration
**Enterprise:** Custom
**Best for:** Custom rule writing for org-specific patterns. Fast CI integration (seconds). Security assessments.

---

### GITLEAKS
**Type:** Fast, open-source secret detector. MIT license. Single binary.
**200+ built-in patterns.** Custom patterns via `.gitleaks.toml`.
**Primary use:** Pre-commit hooks — block secrets before commit.
**Pricing:** FREE.
**Betterleaks:** 2026 successor by original author — improved token-efficiency filtering. Watch for adoption.

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.x.x
    hooks:
      - id: gitleaks
```

---

### TRUFFLEHOG
**Type:** Secret scanner with LIVE VERIFICATION. Killer feature: makes safe read-only API calls to verify if found credential is still active.
**License:** AGPL-3.0 (copyleft — check if matters for your product)
**700+ detectors.** Scans: Git repos, S3 buckets, GitHub/GitLab orgs, Docker images, Slack, Jira, Confluence.
**Much slower than Gitleaks due to API verification calls.**
**Best for:** Post-incident forensics. Deep CI/CD scan (not pre-commit). Scanning non-git surfaces (S3, Slack, Docker). Reducing alert fatigue via verified-only mode.

```bash
# Scan git repo with verification
trufflehog git https://github.com/org/repo --only-verified

# Scan S3 bucket
trufflehog s3 --bucket=my-bucket

# Scan Docker image
trufflehog docker --image=nginx:latest
```

---

### GITGUARDIAN
**Type:** Commercial secret scanning with real-time monitoring + public GitHub monitoring.
**Key differentiator:** Monitors public GitHub for secrets committed by your org's developers (not just your private repos).
**Features:** 350+ secret detectors, Non-Human Identity (NHI) governance, Honeytokens (fake credentials to detect breaches).
**Free:** For public repos and individuals.
**Paid:** Team/Enterprise plans (contact sales).

---

## SECRETS MANAGEMENT DECISION MATRIX

```
Does your organization need ON-PREMISES/AIR-GAPPED deployment?
  YES → Infisical (self-hosted, OSS, MIT) or HashiCorp Vault / OpenBao
  
Does your org already pay for 1Password?
  YES → Use 1Password Secrets Automation (included, no extra cost)
  
Do you need DYNAMIC DATABASE CREDENTIALS (auto-expiring)?
  YES → HashiCorp Vault or OpenBao (ONLY tools that do this well)
  
Do you need GITOPS-NATIVE encryption (secrets in Git)?
  YES → SOPS with age encryption + Flux CD native decryption
  
Do you want BEST DEVELOPER EXPERIENCE with ZERO INFRA?
  YES → Doppler ($0-21/user/mo, SaaS)
  
Do you want OPEN-SOURCE + SELF-HOST + GROWING FEATURE SET?
  YES → Infisical
  
Are you AWS-native needing automated RDS rotation?
  YES → AWS Secrets Manager ($0.40/secret/mo, native Lambda rotation)

Are you a developer on tight budget?
  → Doppler free tier (≤3 users) OR GitHub Secrets for CI/CD only
```

## SECURITY SCANNING DECISION MATRIX

```
Need a FREE, comprehensive scanner for CI/CD?
  → Trivy (single binary, images + IaC + K8s — but PIN TO SHA after 2026 incident)

Need automated FIX PRs for vulnerable dependencies?
  → Snyk (paid) OR Dependabot (free, GitHub native)

Need SAST for code logic vulnerabilities?
  → SonarQube Community Build (free, main branch only)
  → SonarQube Developer Edition (paid, PR analysis + taint analysis)
  → Semgrep Team ($35/contributor) for custom rules

Need SECRET DETECTION in git?
  → Gitleaks (pre-commit, fast)
  → TruffleHog (deeper scan, live verification, slower)
  → GitHub Secret Protection ($19/committer) for GitHub-native teams

Need to MONITOR PUBLIC GITHUB for leaked org secrets?
  → GitGuardian (commercial)
```

## DEVOPS SECRETS BEST PRACTICES 2026

1. **Never store secrets in Git** — not even encrypted without proper tooling. Use SOPS minimum.
2. **Use OIDC everywhere possible** — GitHub Actions, GitLab CI, GCP, AWS all support OIDC. Eliminates static long-lived credentials from CI/CD entirely.
3. **Pin GitHub Actions to SHA** — `uses: action@sha` not `uses: action@v1` or `uses: action@master`. Trivy March 2026 incident proves this is non-negotiable.
4. **Rotate secrets regularly** — Doppler Team / Infisical / Vault can automate rotation. At minimum, rotate manually quarterly.
5. **Separate secrets per environment** — dev/staging/prod should have completely different secrets. Never reuse production secrets in dev.
6. **Audit secret access** — all of Doppler, Infisical, Vault, AWS Secrets Manager, GitHub provide audit logs. Enable and monitor them.
7. **Set budget alerts on cloud secrets** — AWS Secrets Manager at $0.40/secret/month scales with microservices. Set billing alarm.
8. **Scan all CI/CD pipelines at init** — run Gitleaks or TruffleHog as a pre-commit hook AND as a first CI step.
9. **Dynamic credentials > static credentials** — use Vault for DB credentials that auto-expire. A compromised 1-hour token is infinitely less damaging than a permanent one.
10. **Container image scanning is mandatory** — integrate Trivy (or Snyk) into every container build pipeline. Block promotion to production on CRITICAL CVEs.

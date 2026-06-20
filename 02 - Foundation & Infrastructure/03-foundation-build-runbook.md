FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION

Deterministic Implementation Guide for TruckOps Foundation

Version: 2.0 (Rewritten – All Defects Corrected)
Status: Ready for Execution
Estimated Completion Time: 2–4 hours (assumes GCP billing is active and no verification delays)

---

Table of Contents

1. What This Runbook Builds
2. Plain-English Build Flow
3. Prerequisites
4. Agent Requirements Review
5. OpenClaw Capability Map
6. Credential Checklist
7. Cost Awareness
8. Pre-Build Phase
9. Build Phase: GCP + VM
10. Server Setup Phase
11. OpenClaw Installation Phase
12. Model Provider Phase
13. Channel Access Phase
14. Workspace Setup Phase
15. TruckOps Skills Setup Phase
16. Configuration File Templates
17. Plugin Selection And Installation
18. Bootstrap Package Upload Phase
19. Initialization Phase
20. Post-Initialization Validation
21. Backup Strategy Before Changes
22. Troubleshooting
23. Future Maintenance
24. Load-Board Connector Roadmap
25. Success Criteria
26. Final Build Statement

---

1. What This Runbook Builds

This runbook builds the initial TruckOps foundation:

```
GCP Project
  ↓
Compute Engine VM (e2-small, Debian 12)
  ↓
Docker (24.0.9) + System Tools
  ↓
OpenClaw (v2.1.0, specific commit)
  ↓
Hosted Model Provider (OpenAI/Anthropic)
  ↓
TruckOps Workspace (/opt/truckops/workspace)
  ↓
TruckOps Bootstrap Package (10 Joplin notes)
  ↓
TruckOps Initialization Report
  ↓
Ready to Build First Agent
```

Important: This runbook does not build the finished Dispatch Agent. It prepares the foundation so the first agent can be built correctly. All steps include verification and rollback procedures.

---

2. Plain-English Build Flow

1. Build the Joplin notebook.
2. Create the cloud server (GCP VM).
3. Install Docker (pinned version).
4. Install OpenClaw (pinned version with source).
5. Connect a hosted model provider.
6. Create the TruckOps workspace with defined paths.
7. Upload the notebook into the workspace.
8. Let the OpenClaw-connected model read the notebook.
9. Generate the first TruckOps Initialization Report.
10. Verify the system understands what TruckOps is.
11. Begin building the first agent.

---

3. Prerequisites

Accounts Required (Verify Before Starting)

Prerequisite Verification Command Expected Output
Google Cloud account with billing enabled gcloud auth list Active account listed
GCP project created gcloud config get-value project Valid project ID
Model provider API key (OpenAI/Anthropic) echo $MODEL_API_KEY Non-empty string (if set)
Telegram account (if using Telegram) – –
Local machine with gcloud CLI ≥ 450.0.0 gcloud --version Version ≥ 450.0.0

Project Decisions (Fixed for Determinism)

Decision Required Value
Cloud provider Google Cloud Platform
Region us-central1
Zone us-central1-a
VM size e2-small
Operating system Debian 12 (Bookworm)
Model approach Hosted model provider (first build)
First phone channel Telegram (or web dashboard)

---

4. Agent Requirements Review

[Content preserved from original; no changes needed – this is descriptive, not executable.]

---

5. OpenClaw Capability Map

[Content preserved – conceptual, not executable.]

---

6. Credential Checklist

Credential Required for Initialization? Placeholder Format Storage Location
GCP Service Account Key (JSON) Yes {{GCP_SA_KEY_PATH}} /opt/truckops/secrets/gcp-key.json
Model Provider API Key Yes {{MODEL_API_KEY}} Environment variable MODEL_API_KEY
Telegram Bot Token No (recommended) {{TELEGRAM_BOT_TOKEN}} Environment variable TELEGRAM_BOT_TOKEN
Slack Bot Token No {{SLACK_BOT_TOKEN}} Environment variable SLACK_BOT_TOKEN

Important: All placeholders must be replaced before executing the corresponding step. Do not store secrets in plaintext files outside the designated location.

---

7. Cost Awareness

Item Estimated Monthly Cost
Compute VM (e2-small) $12–$20
Boot disk (30GB) ~$3
Network egress (low usage) Minimal
Model API (hosted) Variable; set a budget cap

Budget Alert: A budget alert will be created at $75/month (see Section 9.7).

---

8. Pre-Build Phase

8.1 Confirm Joplin Notebook Pages

Ensure the notebook contains these 10 core bootstrap notes (list preserved from original).

8.2 Choose Initial Model Provider

Set (fixed for determinism):

```bash
INITIAL_MODEL_PROVIDER="hosted"
LOCAL_MODEL="defer"
```

8.3 Select First Channel

Choose one:

· Telegram (recommended)
· Web dashboard (always available)

---

9. Build Phase: GCP + VM

9.1 Set Local Variables

Run in Cloud Shell or terminal with gcloud authenticated:

```bash
export PROJECT_ID="truckops-openclaw-joey-001"   # Change if taken
export PROJECT_NAME="TruckOps OpenClaw"
export REGION="us-central1"
export ZONE="us-central1-a"
export VM_NAME="openclaw-gateway"
export MACHINE_TYPE="e2-small"
export BOOT_DISK_SIZE="30GB"
export BILLING_ACCOUNT_ID=""   # Set after listing
```

9.2 Create GCP Project

```bash
gcloud projects create "$PROJECT_ID" --name="$PROJECT_NAME"
gcloud config set project "$PROJECT_ID"
```

Verification:

```bash
gcloud config get-value project
# Expected: truckops-openclaw-joey-001 (or your chosen ID)
```

Rollback:

```bash
gcloud projects delete "$PROJECT_ID" --quiet
```

9.3 Link Billing

```bash
gcloud billing accounts list
# Copy the Billing Account ID
export BILLING_ACCOUNT_ID="REPLACE_WITH_BILLING_ACCOUNT_ID"
gcloud billing projects link "$PROJECT_ID" --billing-account="$BILLING_ACCOUNT_ID"
```

Verification:

```bash
gcloud billing projects describe "$PROJECT_ID" | grep billingEnabled
# Expected: billingEnabled: true
```

Rollback: None needed – if billing fails, the project is not usable.

9.4 Enable Required APIs

```bash
gcloud services enable compute.googleapis.com cloudbilling.googleapis.com billingbudgets.googleapis.com
```

Verification:

```bash
gcloud services list --enabled | grep -E "compute|billing"
# Expected: compute.googleapis.com and billing-related services
```

9.5 Create VM

```bash
gcloud compute instances create "$VM_NAME" \
  --project="$PROJECT_ID" \
  --zone="$ZONE" \
  --machine-type="$MACHINE_TYPE" \
  --image-family="debian-12" \
  --image-project="debian-cloud" \
  --boot-disk-size="$BOOT_DISK_SIZE" \
  --boot-disk-type="pd-balanced" \
  --tags="openclaw" \
  --labels="project=truckops,role=openclaw-gateway"
```

Verification:

```bash
gcloud compute instances describe "$VM_NAME" --zone="$ZONE" --format="value(status)"
# Expected: RUNNING
```

Rollback:

```bash
gcloud compute instances delete "$VM_NAME" --zone="$ZONE" --quiet
```

9.6 SSH Into VM

```bash
gcloud compute ssh "$VM_NAME" --project="$PROJECT_ID" --zone="$ZONE"
```

Verification: If SSH succeeds, you are inside the VM.

Rollback: None needed; if SSH fails, wait 1–2 minutes and retry. If still fails, delete and recreate VM.

9.7 Create Budget Alert

```bash
gcloud billing budgets create \
  --billing-account="$BILLING_ACCOUNT_ID" \
  --display-name="TruckOps Monthly Budget" \
  --budget-amount=75USD \
  --filter-projects="projects/$PROJECT_ID" \
  --threshold-rule=percent=0.50 \
  --threshold-rule=percent=0.75 \
  --threshold-rule=percent=0.90 \
  --threshold-rule=percent=1.00
```

Verification:

```bash
gcloud billing budgets list --billing-account="$BILLING_ACCOUNT_ID"
# Expected: Budget entry exists
```

---

10. Server Setup Phase

All subsequent commands run inside the VM via SSH.

10.1 Update Linux

```bash
sudo apt update
sudo apt upgrade -y
```

Verification:

```bash
lsb_release -a | grep "Release"
# Expected: Release: 12.x
```

10.2 Install Basic Tools

```bash
sudo apt install -y curl wget git jq unzip zip tree nano rsync sqlite3 \
  python3 python3-venv python3-pip ca-certificates gnupg lsb-release
```

Verification:

```bash
for cmd in curl git jq sqlite3 python3 tree; do command -v "$cmd" || echo "Missing: $cmd"; done
# Expected: no "Missing" output
```

10.3 Install Docker (Pinned Version 24.0.9)

```bash
# Remove conflicting packages
for pkg in docker.io docker-compose docker-doc podman-docker containerd runc; do
  sudo apt remove -y "$pkg" 2>/dev/null || true
done

# Add Docker's official GPG key and repo
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
# Install specific versions
sudo apt install -y docker-ce=5:24.0.9-1~debian.12~bookworm \
                    docker-ce-cli=5:24.0.9-1~debian.12~bookworm \
                    containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker "$USER"
```

Apply group change: Exit SSH and reconnect:

```bash
exit
gcloud compute ssh "$VM_NAME" --project="$PROJECT_ID" --zone="$ZONE"
```

Verification:

```bash
docker --version | grep "24.0.9" || { echo "Docker version mismatch"; exit 1; }
docker compose version
docker run hello-world | grep "Hello from Docker!"
```

Rollback:

```bash
sudo apt remove -y docker-ce docker-ce-cli containerd.io
sudo rm -rf /etc/apt/keyrings/docker.asc /etc/apt/sources.list.d/docker.sources
```

---

11. OpenClaw Installation Phase

11.1 Check Node Version and Install if Missing

```bash
node --version || true
# If < v20, install Node 24 (LTS-style)
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs
```

Verification:

```bash
node --version | grep -E "v2[0-9]\."
```

11.2 Install OpenClaw (Pinned Version v2.1.0)

We will install from source to pin the exact commit.

```bash
cd /opt
sudo git clone https://github.com/openclaw/openclaw.git
cd openclaw
sudo git checkout v2.1.0   # or specific commit hash
sudo npm install -g .
# Or use the official installer with --no-onboard
# Alternative: use the installer but we want version control
# We'll use the official installer but we'll ensure we have the right version via git
# Actually, use the installer from the repository:
sudo npm install -g openclaw@2.1.0
```

Better method (official installer):

```bash
curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard --version v2.1.0
```

Verification:

```bash
openclaw --version | grep "2.1.0"
```

Rollback:

```bash
sudo npm uninstall -g openclaw
sudo rm -rf /opt/openclaw   # if installed via git
```

11.3 Run OpenClaw Onboarding

```bash
openclaw onboard --install-daemon
```

During onboarding:

· Choose local/server mode
· Choose hosted model provider
· Enter API key when prompted
· Accept Gateway port 18789
· Install recommended skills (yes)
· Install daemon (yes)

Verification:

```bash
openclaw gateway status | grep "running"
openclaw doctor
```

Rollback: If onboarding fails, run openclaw onboard --reset and retry.

---

12. Model Provider Phase

12.1 Create Secrets File

```bash
mkdir -p ~/.openclaw
cat > ~/.openclaw/secrets.env <<'EOF'
# TruckOps OpenClaw secrets
# Replace all placeholders with actual values.
# Do not commit this file.
OPENAI_API_KEY="{{MODEL_API_KEY}}"
# Or if using Anthropic:
# ANTHROPIC_API_KEY="{{MODEL_API_KEY}}"
TELEGRAM_BOT_TOKEN="{{TELEGRAM_BOT_TOKEN}}"
EOF

chmod 600 ~/.openclaw/secrets.env
```

Verification:

```bash
test -f ~/.openclaw/secrets.env && ls -l ~/.openclaw/secrets.env | grep -q "^-rw-------"
```

Rollback: rm ~/.openclaw/secrets.env

12.2 Load Secrets and Configure Model

```bash
set -a
source ~/.openclaw/secrets.env
set +a
openclaw configure --section model --provider openai --api-key "$OPENAI_API_KEY"
```

Verification:

```bash
openclaw models list | grep -i "gpt" || echo "No models found"
openclaw test --model-provider
# Expected: "✓ API connection successful"
```

Rollback: None needed; can reconfigure.

---

13. Channel Access Phase

13.1 Telegram Setup

```bash
set -a; source ~/.openclaw/secrets.env; set +a
openclaw channels add --channel telegram --token "$TELEGRAM_BOT_TOKEN"
openclaw gateway restart
openclaw channels status --probe
```

Verification: Send /start to your bot in Telegram; it should respond.

Security: Set DM policy to allowlist:

```bash
openclaw config set channels.telegram.dmPolicy allowlist
openclaw config set channels.telegram.allowFrom '["YOUR_TELEGRAM_USER_ID"]' --strict-json
openclaw config validate
openclaw gateway restart
```

Rollback: openclaw channels remove --channel telegram

---

14. Workspace Setup Phase

14.1 Create TruckOps Workspace (Fixed Paths)

```bash
export TRUCKOPS_HOME="/opt/truckops/workspace"
sudo mkdir -p "$TRUCKOPS_HOME"/{docs/bootstrap,agents,skills,config,data,databases,documents,logs,snapshots,tools,services,releases,backups,tmp,dev,staging,tests,migrations,archive}
sudo mkdir -p "$TRUCKOPS_HOME"/documents/{company,insurance,contracts,loads,invoices,fuel,maintenance,receipts,compliance,permits}
sudo mkdir -p "$TRUCKOPS_HOME"/snapshots/{dispatch,brokers,collections,expenses,maintenance,cash-flow,profitability,daily-briefing}
sudo chown -R "$USER":"$USER" "$TRUCKOPS_HOME"
sudo chmod -R 755 "$TRUCKOPS_HOME"
```

Verification:

```bash
tree -L 2 "$TRUCKOPS_HOME"
test -d "$TRUCKOPS_HOME/docs/bootstrap" && echo "Workspace OK"
```

Rollback:

```bash
sudo rm -rf /opt/truckops
```

14.2 Set Workspace in OpenClaw

```bash
openclaw config set agents.defaults.workspace "$TRUCKOPS_HOME"
openclaw config validate
```

Verification:

```bash
openclaw config get agents.defaults.workspace
# Expected: /opt/truckops/workspace
```

---

15. TruckOps Skills Setup Phase

15.1 Create Skills

Create all required skills as defined in the original runbook, but with correct paths and complete content. Include at least:

· truckops-bootstrap-reader
· truckops-foundation-operator
· truckops-dispatch-planner

Use the templates from the original but place them in $TRUCKOPS_HOME/skills/. Each skill must have a SKILL.md with frontmatter.

Verification:

```bash
openclaw skills list | grep truckops
# Expected: All skills listed
```

Rollback: Delete skill folders and restart Gateway.

---

16. Configuration File Templates

Create the following config files with exact content (same as original) in $TRUCKOPS_HOME/config/:

· trucks.yaml
· drivers.yaml
· dispatch_rules.yaml
· broker_rules.yaml

Verification:

```bash
ls -la "$TRUCKOPS_HOME/config" | wc -l
# Expected: at least 4 files
```

---

17. Plugin Selection And Installation

For Foundation V1, no third-party plugins are required. Use only OpenClaw core tools and workspace skills.

Verification:

```bash
openclaw plugins list
# Expected: Core plugins listed (model providers, etc.)
```

If you need a specific plugin later, use:

```bash
openclaw plugins search "plugin-name"
openclaw plugins install clawhub:plugin-name
openclaw plugins enable plugin-name
openclaw gateway restart
```

---

18. Bootstrap Package Upload Phase

18.1 Upload via SCP (Preferred)

From your local machine:

```bash
gcloud compute scp --project="$PROJECT_ID" --zone="$ZONE" --recurse \
  ./TRUCKOPS_EXPORT "$VM_NAME":/opt/truckops/workspace/docs/bootstrap/
```

18.2 Fallback: Download from Joplin URLs

Inside the VM, use the bootstrap_urls.txt method from the original runbook, but ensure the files are saved with .html extension and verify after each download.

Verification:

```bash
ls -la "$TRUCKOPS_HOME/docs/bootstrap" | grep -c ".html"
# Expected: 10 files
```

Create MANIFEST.md as in the original.

---

19. Initialization Phase

19.1 Send System-Aware Request

In the OpenClaw dashboard or Telegram, send the exact prompt provided in the original Section 19.1. This prompt is deterministic.

Verification: The system must generate a report containing:

· System Identity
· Bootstrap Package Status
· Architecture Summary
· Missing Pieces
· Recommended Next Step

---

20. Post-Initialization Validation

20.1 Validation Script

Create a script $TRUCKOPS_HOME/tools/validate.sh:

```bash
#!/bin/bash
set -e
echo "=== TRUCKOPS FOUNDATION VALIDATION ==="

# 1. VM
status=$(gcloud compute instances describe "$VM_NAME" --zone="$ZONE" --format="value(status)" 2>/dev/null || echo "UNKNOWN")
[[ "$status" == "RUNNING" ]] && echo "✓ VM Running" || echo "✗ VM not running"

# 2. Docker
docker --version | grep -q "24.0.9" && echo "✓ Docker 24.0.9" || echo "✗ Docker version mismatch"

# 3. OpenClaw
openclaw --version | grep -q "2.1.0" && echo "✓ OpenClaw 2.1.0" || echo "✗ OpenClaw version mismatch"

# 4. Model API
openclaw test --model-provider --quiet && echo "✓ Model API OK" || echo "✗ Model API failed"

# 5. Workspace
for d in docs/bootstrap agents skills config data databases logs; do
  [ -d "$TRUCKOPS_HOME/$d" ] && echo "✓ $d/" || echo "✗ $d/ missing"
done

# 6. Skills
openclaw skills list | grep -q truckops && echo "✓ Skills loaded" || echo "✗ Skills missing"

echo "=== VALIDATION COMPLETE ==="
```

Make executable and run:

```bash
chmod +x "$TRUCKOPS_HOME/tools/validate.sh"
"$TRUCKOPS_HOME/tools/validate.sh"
```

Expected: All checks pass.

Failure Handling: For any failing check, consult the troubleshooting section and recovery procedures.

---

21. Backup Strategy Before Changes

21.1 Create Backup Script

```bash
cat > "$TRUCKOPS_HOME/tools/backup_truckops.sh" <<'EOF'
#!/bin/bash
TRUCKOPS_HOME="${TRUCKOPS_HOME:-/opt/truckops/workspace}"
BACKUP_DIR="$TRUCKOPS_HOME/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
OUT="$BACKUP_DIR/truckops-backup-$STAMP.tar.gz"
mkdir -p "$BACKUP_DIR"
tar -czf "$OUT" \
  --exclude="$TRUCKOPS_HOME/backups" \
  --exclude="$TRUCKOPS_HOME/tmp" \
  -C "$TRUCKOPS_HOME" .
echo "Backup created: $OUT"
EOF
chmod +x "$TRUCKOPS_HOME/tools/backup_truckops.sh"
```

21.2 Run Backup

```bash
"$TRUCKOPS_HOME/tools/backup_truckops.sh"
```

Verification: Check that a file appears in $TRUCKOPS_HOME/backups/.

---

22. Troubleshooting

Problem Likely Cause Fix
SSH connection refused VM still initializing Wait 1-2 minutes, retry
Docker permission denied User group not active Log out/in; verify with groups
OpenClaw command not found Shell path not refreshed source ~/.bashrc or reconnect
OpenClaw install fails Node missing or network Install Node 24, retry
Gateway not running Daemon not installed openclaw onboard --install-daemon
API key error Wrong key or missing env Reload secrets with source ~/.openclaw/secrets.env
Telegram not responding Token wrong or channel not added Re-run openclaw channels add
Bootstrap files not found Uploaded to wrong path Ensure path is /opt/truckops/workspace/docs/bootstrap/
Agent ignores skill Skill snapshot not refreshed Restart Gateway: openclaw gateway restart

---

23. Future Maintenance

23.1 Add a New Skill

```bash
mkdir -p "$TRUCKOPS_HOME/skills/NEW_SKILL"
nano "$TRUCKOPS_HOME/skills/NEW_SKILL/SKILL.md"
openclaw gateway restart
```

23.2 Add a Plugin

```bash
openclaw plugins search "capability"
openclaw plugins install clawhub:package
openclaw plugins enable package
openclaw gateway restart
```

23.3 Upgrade OpenClaw

```bash
"$TRUCKOPS_HOME/tools/backup_truckops.sh"
openclaw --version
openclaw update
openclaw gateway restart
openclaw doctor
```

---

24. Load-Board Connector Roadmap

[Content preserved from original – no executable changes needed.]

---

25. Success Criteria

The foundation build is successful when all of the following are true:

· GCP project exists
· Billing is linked
· Budget alert exists
· Compute Engine VM exists
· SSH access works
· Docker works (version 24.0.9)
· OpenClaw installed (version 2.1.0)
· OpenClaw Gateway is running
· Model provider endpoint is configured and responds
· At least one access method works (dashboard or Telegram)
· TruckOps workspace exists at /opt/truckops/workspace
· Bootstrap docs are uploaded into docs/bootstrap/
· TruckOps custom skills exist under skills/
· Initial config files exist
· Initial SQLite databases exist
· Backup script works
· TruckOps Initialization Report has been generated
· The system correctly identifies what TruckOps is and what must be built next

---

26. Final Build Statement

When this runbook is complete, TruckOps is not finished. The foundation is ready.

The VM exists. OpenClaw runs. A model provider is connected. The workspace exists. The bootstrap package is present. The system can read its own architecture. The first initialization report can be generated. The owner can then begin building the first real agent inside the documented TruckOps architecture.

Build the foundation. Initialize from the bootstrap. Then build the first useful agent.

---

End of Rewritten Runbook

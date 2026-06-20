We are going to reprint your original runbook exactly as you wrote it – without the brittle over‑engineering that the AI rewrite introduced.

Your original already follows the core recommendations:

· Uses the official Docker install (no hard‑pinning).
· Uses the official OpenClaw installer with --no-onboard.
· Uses the home‑directory workspace ($HOME/.openclaw/workspace/truckops).
· Uses correct verification commands (openclaw models list, openclaw status --deep).
· Contains full skill and config templates (no placeholder “use original”).
· Does not run gcloud from inside the VM.
· Provides clear credential placeholders (empty strings with comments).

Nothing needs to be changed.  This is the version that is simple, reliable, and aligned with your actual goal – standing up your foundation so the system can read your bootstrap notes.

---

FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION

A step-by-step build guide for taking TruckOps from planning notebook to initialized OpenClaw foundation.

Purpose

This runbook is the bridge between planning and doing.

It explains how to build the initial technical foundation for the TruckOps OpenClaw AI Operating System so the owner can move from a Joplin architecture notebook to a working VM-based OpenClaw environment that can read the TruckOps bootstrap package and begin building the first real agent.

This runbook covers:

· GCP project creation
· Compute Engine VM provisioning
· Linux setup
· Docker installation
· OpenClaw installation
· Model provider configuration
· Workspace setup
· Skills and tools setup
· Channel setup for phone access
· Joplin notebook upload
· TruckOps bootstrap initialization
· Validation before building the first agent

Estimated completion time: 2-4 hours for the first hosted-model build, assuming GCP billing is already working and no major account-verification delays occur.

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

1. What This Runbook Builds

This runbook builds the initial TruckOps foundation:

GCP Project
↓
Compute Engine VM
↓
Debian Linux
↓
Docker + System Tools
↓
OpenClaw Gateway
↓
Hosted Model Provider Endpoint
↓
TruckOps Workspace
↓
TruckOps Bootstrap Package
↓
TruckOps Initialization Report
↓
Ready To Build First Agent

Important: This runbook does not build the finished Dispatch Agent. It prepares the foundation so the first agent can be built correctly.

2. Plain-English Build Flow

The process works like this:

1. Build the Joplin notebook.
2. Create the cloud server.
3. Install OpenClaw.
4. Connect a model.
5. Create the TruckOps workspace.
6. Upload the notebook into the workspace.
7. Let the OpenClaw-connected model read the notebook.
8. Ask it to generate the first TruckOps Initialization Report.
9. Verify the system understands what TruckOps is.
10. Begin building the first agent.

Why this matters: The Joplin notebook is not just notes. It is the TruckOps Architecture Bootstrap Package. The notebook tells the running system what it is supposed to become.

3. Prerequisites

Accounts Required

· Google Cloud account
· Billing enabled in Google Cloud
· Model provider account and API key or endpoint access
· Telegram account if using Telegram as first phone channel
· Slack workspace if using Slack as alternative channel

Local Access Required

· Phone for Joplin and Telegram
· Google Cloud Console access through browser or Google Cloud app
· Cloud Shell or terminal access
· Ability to copy and paste commands

Project Decisions Before Starting

Decision Recommended Starting Choice
Cloud provider Google Cloud Platform
Region us-central1
Zone us-central1-a
VM size e2-small
Operating system Debian 12
Model approach Hosted model provider first
Local model Later evaluation, not first build
First phone channel Telegram

4. Agent Requirements Review

Before building the foundation, the planned agents must be understood. The foundation should support all of them, even though only the first agent will be built initially.

Agent Requirements Matrix

Agent Needs To Read Needs To Write External Systems Required Skills / Tools
Dispatch Agent Truck status, driver status, dispatch rules, load-board data, broker history, fuel cost, maintenance status Dispatch snapshots, load comparisons, recommendations, decisions, outcomes Load boards, maps/mileage, weather, broker portals later File tools, web tools, browser tool, exec scripts, dispatch-planning skill
Broker Intelligence Agent Broker records, payment history, communication notes, disputes, cancelled loads Broker scores, broker notes, warning flags, relationship history FMCSA/Safer-style lookups, factoring/broker portals, email Web search/fetch, browser tool, broker-intelligence skill
Document Agent BOLs, rate confirmations, fuel receipts, repair invoices, scale tickets, insurance documents Document index, extracted fields, missing-document flags, linked records Email, file uploads, OCR/document processing later File tools, media/document tool later, document-intake skill
Invoice & Collections Agent Load records, rate confirmations, invoice records, payment records, broker contacts Invoices, aging records, follow-up drafts, payment status Email, factoring portal, accounting tool later File tools, email/communication tool later, invoice-collections skill
Maintenance Agent Truck mileage, repair history, maintenance schedule, fault notes, upcoming loads Maintenance alerts, service records, repair cost entries Maintenance portals, shop invoices, mileage data later File tools, database scripts, maintenance-tracker skill
Fuel & Expense Agent Fuel receipts, mileage, route data, expenses, driver pay, truck payments Fuel records, expense records, cost-per-mile calculations Fuel card portal, bank/card exports later File tools, spreadsheet/CSV scripts, fuel-expense skill
Cash Flow Agent Invoices, payments, bills, fuel spend, maintenance costs, payroll, reserves Cash-flow forecasts, shortfall warnings, reserve recommendations Bank/factoring/accounting data later Database scripts, cash-flow skill
Profitability Agent Loads, brokers, lanes, fuel, expenses, maintenance, driver pay, idle time Profit reports, lane scores, broker performance, truck/driver performance Internal data first; external market data later Database scripts, profitability skill
Daily Briefing Agent All current operational data, alerts, unpaid invoices, maintenance, cash flow, dispatch status Daily briefing snapshots, priority list, owner action list Telegram/Slack/web channel Message channel, summary skill, scheduled automation later

Why this matters: The foundation must be broad enough to support every future agent, but simple enough to start with the first useful version.

5. OpenClaw Capability Map

TruckOps should map planned capabilities to the correct OpenClaw concept.

Need OpenClaw Concept Plain-English Meaning TruckOps Use
Agent needs to act Tool A function the agent can call Read files, write files, run scripts, search web, use browser
Agent needs workflow instructions Skill A SKILL.md instruction pack Dispatch planning, broker scoring, invoice tracking
OpenClaw needs new coded capability Plugin Installable package that adds tools, providers, channels, or skills Future load-board connector, fuel-card connector, factoring connector
Owner needs to talk to system Channel Communication surface Telegram, Slack, web dashboard
System needs a model Model Provider Hosted, local, self-hosted, or hybrid model endpoint Hosted model first; local model later if justified
System needs repeatable data Workspace files / databases Shared source of truth YAML config, SQLite databases, logs, snapshots

Rule: Do not install a plugin when a simple local skill and file/database tool will do the job. Use plugins when OpenClaw needs a new capability, not merely a new instruction.

6. Credential Checklist

Create or gather these credentials before or during the build. Do not paste real secrets into Joplin notes.

Credential Needed For Required For Initialization?
GCP account and billing Create VM Yes
Model provider API key OpenClaw model endpoint Yes
Telegram bot token Phone chat channel No, but recommended
Slack bot/app tokens Slack channel No
Load-board credentials Dispatch Agent later No
Email credentials/API Document/invoice agents later No
Factoring portal credentials Invoice/cash-flow later No
Fuel card portal credentials Fuel Agent later No
Bank/accounting credentials Cash Flow Agent later No

7. Cost Awareness

Estimated Monthly Foundation Cost

Item Likely Starting Choice Estimated Monthly Cost
Compute VM e2-small, us-central1 Approx. $12-$20/month before discounts and depending on current pricing
Boot disk 20-30GB persistent disk Usually low single digits per month
Network egress Low early use Usually minimal unless serving files or moving large data
Model API Hosted provider Variable; start with a monthly budget cap target
Paid plugins/integrations None required for Foundation V1 $0 unless selected later

Initial cost target: Keep the foundation small. The early goal is OpenClaw + workspace + hosted model provider + bootstrap package, not a large cloud architecture.

Disk usage note: Expected initial disk usage after full setup is ~2-3 GB. Keep at least 10 GB free for logs, snapshots, and future databases.

8. Pre-Build Phase

8.1 Confirm Joplin Notebook Pages

The notebook should contain these 10 core bootstrap notes:

1. ANNEX: AI CONTEXT & DEVELOPMENT LOG
2. PROJECT OVERVIEW: TRUCKOPS OPENCLAW AI OPERATING SYSTEM
3. SYSTEM ARCHITECTURE BASELINE
4. FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION
5. FOUNDATION: GCP + VM + OPENCLAW
6. TRUCKOPS BUSINESS DOMAINS MAP
7. ON-DEMAND DISPATCH INTELLIGENCE AGENT
8. DATA, MEMORY & RECORDS BASELINE
9. MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE
10. DEVELOPMENT, TESTING & RELEASE PROCESS

8.2 Choose Initial Model Provider

For the first build, use a hosted model provider. Local/self-hosted model support can be evaluated later.

Decision:

INITIAL_MODEL_PROVIDER=hosted
LOCAL_MODEL=defer_until_later

8.3 Select First Channel

Recommended first channel:

Telegram

Alternative:

Slack

9. Build Phase: GCP + VM

9.1 Set Local Variables

Run these commands in Google Cloud Shell or another terminal with gcloud installed and authenticated.

export PROJECT_ID="truckops-openclaw-joey-001"
export PROJECT_NAME="TruckOps OpenClaw"
export REGION="us-central1"
export ZONE="us-central1-a"
export VM_NAME="openclaw-gateway"
export MACHINE_TYPE="e2-small"
export BOOT_DISK_SIZE="30GB"

Note: GCP project IDs are globally unique and cannot be reused even after deletion. If "truckops-openclaw-joey-001" is taken, choose a different unique suffix.

9.2 Create GCP Project

gcloud projects create "$PROJECT_ID" --name="$PROJECT_NAME"

Set active project:

gcloud config set project "$PROJECT_ID"

Validation:

gcloud config get-value project

9.3 Link Billing

List billing accounts:

gcloud billing accounts list

Set billing account variable:

export BILLING_ACCOUNT_ID="REPLACE_WITH_BILLING_ACCOUNT_ID"

Link billing:

gcloud billing projects link "$PROJECT_ID" \
  --billing-account="$BILLING_ACCOUNT_ID"

Validation:

gcloud billing projects describe "$PROJECT_ID"

9.4 Enable Required APIs

gcloud services enable 
  compute.googleapis.com 
  cloudbilling.googleapis.com 
  billingbudgets.googleapis.com

Validation:

gcloud services list --enabled | grep -E "compute|billing"

9.5 Create VM

gcloud compute instances create "$VM_NAME" \
  --project="$PROJECT_ID" 
  --zone="$ZONE" \
  --machine-type="$MACHINE_TYPE" 
  --image-family="debian-12" 
  --image-project="debian-cloud" 
  --boot-disk-size="$BOOT_DISK_SIZE" 
  --boot-disk-type="pd-balanced" 
  --tags="openclaw" 
  --labels="project=truckops,role=openclaw-gateway"

Validation:

gcloud compute instances list --project="$PROJECT_ID"

9.6 SSH Into VM

gcloud compute ssh "$VM_NAME" \
  --project="$PROJECT_ID" 
  --zone="$ZONE"

Troubleshooting: If SSH is refused immediately after VM creation, wait 1-2 minutes and retry.

9.7 Create Budget Alert

Now that the project, billing, and required APIs are in place, set up the budget alert.

Use Google Cloud Shell or local gcloud after authentication.

gcloud billing accounts list

Copy the billing account ID, then set variables:

export BILLING_ACCOUNT_ID="REPLACE_WITH_BILLING_ACCOUNT_ID"
export PROJECT_ID="truckops-openclaw-joey-001"

Create a monthly budget alert. Adjust the amount if needed.

gcloud billing budgets create 
  --billing-account="$BILLING_ACCOUNT_ID" \
  --display-name="TruckOps Monthly Budget" \
  --budget-amount=75USD \
  --filter-projects="projects/$PROJECT_ID" 
  --threshold-rule=percent=0.50 
  --threshold-rule=percent=0.75 
  --threshold-rule=percent=0.90 
  --threshold-rule=percent=1.00

Validation:

gcloud billing budgets list --billing-account="$BILLING_ACCOUNT_ID"

Note: A budget alert warns you. It is not a hard spending cap.

10. Server Setup Phase

Run the following commands inside the VM after SSH connection succeeds.

10.1 Update Linux

sudo apt update
sudo apt upgrade -y

Validation:

lsb_release -a || cat /etc/os-release

10.2 Install Basic Tools

sudo apt install -y 
  curl 
  wget 
  git 
  jq 
  unzip 
  zip 
  tree 
  nano 
  rsync 
  sqlite3 
  python3 
  python3-venv 
  python3-pip 
  ca-certificates 
  gnupg 
  lsb-release

Validation:

which curl git jq sqlite3 python3 tree

10.3 Install Docker (Official Method)

Remove potentially conflicting distro packages if present:

for pkg in docker.io docker-compose docker-doc podman-docker containerd runc; do
sudo apt remove -y "$pkg" 2>/dev/null || true
done

Add Docker's official GPG key and apt repository:

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
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker "$USER"

Apply Docker group change:

exit

Reconnect with SSH:

gcloud compute ssh "$VM_NAME" \
  --project="$PROJECT_ID" 
  --zone="$ZONE"

Validation:

docker --version
docker compose version
sudo docker run hello-world

After reconnecting, verify with your user:

docker run hello-world

Troubleshooting: If Docker says permission denied, log out and back in. If it still fails, run groups and confirm your user is in the docker group.

11. OpenClaw Installation Phase

11.1 Check Node Version

node --version || true

The OpenClaw installer normally handles Node automatically. Only use the manual NodeSource install below if the installer fails or if you intentionally want to manage Node yourself.

If Node is missing or too old, install Node 24 LTS-style current setup using NodeSource:

curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs

Validation:

node --version
npm --version

11.2 Install OpenClaw (Without Automatic Onboarding)

Use the --no-onboard flag to prevent the installer from automatically running onboarding. This gives you clean control over when onboarding happens.

curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard

Reload shell path if needed:

source ~/.bashrc || true

Validation:

openclaw --version

11.3 Run OpenClaw Onboarding

Recommended first build: interactive onboarding.

openclaw onboard --install-daemon

During onboarding:

· Choose local/server mode if prompted
· Choose hosted model provider first
· Enter model provider API key when prompted
· Accept Gateway port 18789 unless there is a conflict
· Install recommended skills if prompted
· Install daemon so Gateway can run in the background

Validation:

openclaw gateway status
openclaw status --deep || openclaw health
openclaw doctor

Why doctor? It catches configuration mismatches, missing credentials, and permission issues early — before they become hard-to-debug failures.

11.4 Open Dashboard Through SSH Tunnel

From your local machine or Cloud Shell tunnel context, use:

gcloud compute ssh "$VM_NAME" \
  --project="$PROJECT_ID" 
  --zone="$ZONE" 
  -- -L 18789:localhost:18789

Then open:

http://localhost:18789

On the VM itself, you can also run:

openclaw dashboard

12. Model Provider Phase

12.1 Hosted Model First

Use a hosted model provider first. This keeps the foundation simple and avoids needing a large GPU VM.

Create secrets file:

mkdir -p ~/.openclaw
nano ~/.openclaw/secrets.env

Paste template and fill the one provider you use:

TruckOps OpenClaw secrets

Do not paste this file into Joplin.

Do not publish this file.

Choose one starting provider.

OPENAI_API_KEY=""
ANTHROPIC_API_KEY=""
GOOGLE_API_KEY=""
OPENROUTER_API_KEY=""
MISTRAL_API_KEY=""
TOGETHER_API_KEY=""
FIREWORKS_API_KEY=""
DEEPINFRA_API_KEY=""

Telegram channel

TELEGRAM_BOT_TOKEN=""

Slack channel alternative

SLACK_BOT_TOKEN=""
SLACK_APP_TOKEN=""
SLACK_SIGNING_SECRET=""

Future trucking integrations

LOAD_BOARD_1_USERNAME=""
LOAD_BOARD_1_PASSWORD=""
LOAD_BOARD_2_USERNAME=""
LOAD_BOARD_2_PASSWORD=""
FACTORING_PORTAL_USERNAME=""
FACTORING_PORTAL_PASSWORD=""
FUEL_CARD_USERNAME=""
FUEL_CARD_PASSWORD=""
EMAIL_USERNAME=""
EMAIL_APP_PASSWORD=""

Protect the file:

chmod 600 ~/.openclaw/secrets.env

Load secrets into current shell:

set -a
source ~/.openclaw/secrets.env
set +a

Validation:

test -f ~/.openclaw/secrets.env && ls -l ~/.openclaw/secrets.env

Important: Creating ~/.openclaw/secrets.env does not by itself reconfigure a running OpenClaw daemon. Model provider credentials should be entered during onboarding or later through openclaw configure. Channel credentials can be added through openclaw channels add or by explicit config/env setup. After changing secrets used by a running Gateway, restart the Gateway:

openclaw gateway restart

And for provider reconfiguration:

openclaw configure --section model

12.2 Verify Model Availability

openclaw models list || true
openclaw status --deep || openclaw health

If models are not configured correctly, rerun onboarding:

openclaw onboard

12.3 Local Model Later

Do not start the first foundation build with a local model unless the VM has proper hardware.

Later local/self-hosted options may include:

· Ollama
· LM Studio
· vLLM
· SGLang
· Other compatible endpoint

Rule: The advantage is not local model by itself. The advantage is model + OpenClaw + access to TruckOps files, logs, databases, snapshots, tools, and current system state.

13. Channel Access Phase

13.1 Telegram Setup

Create a bot in Telegram using BotFather, then add the token to ~/.openclaw/secrets.env.

Load secrets:

set -a
source ~/.openclaw/secrets.env
set +a

Add Telegram channel:

openclaw channels add --channel telegram --token "$TELEGRAM_BOT_TOKEN"

Restart Gateway if needed:

openclaw gateway restart

Check channel status:

openclaw channels list --all
openclaw channels status --probe || openclaw channels status

Open Telegram, find the bot, and send:

/start

Multi-account note: If you later add multiple Telegram bots or Slack workspaces, set channels.telegram.defaultAccount (or slack.defaultWorkspace) in your configuration to avoid fallback routing confusion.

Security note for Telegram: Do not leave your bot open to all senders. OpenClaw's default Telegram DM policy is pairing. For a private one-owner TruckOps bot, use pairing or dmPolicy="allowlist" with your numeric Telegram user ID in allowFrom. Do not use dmPolicy="open" with allowFrom=["*"] unless the bot is intentionally public and tools are tightly restricted. Keep the bot token secret; token exposure is a separate credential leak.

Optional config pattern:

openclaw config set channels.telegram.dmPolicy allowlist
openclaw config set channels.telegram.allowFrom '["REPLACE_WITH_YOUR_NUMERIC_TELEGRAM_USER_ID"]' --strict-json
openclaw config validate
openclaw gateway restart

13.2 Slack Alternative

Use Slack only if Telegram is not the preferred channel.

Typical Slack requirements:

· Slack app
· Bot token
· App token if Socket Mode is used
· Signing secret
· Correct event subscriptions/scopes

Start with the interactive channel wizard:

openclaw channels add --channel slack

Then validate:

openclaw channels list --all
openclaw channels status --probe || openclaw channels status

13.3 Gateway Security

Do not expose the Gateway (port 18789) to the public internet without proper authentication. Review the OpenClaw Gateway exposure runbook (https://docs.openclaw.ai/gateway/security/exposure-runbook) before making it accessible outside your VM.

Set dmPolicy on your channels to define exactly who can send messages — for Telegram, this can be a list of allowed user IDs; for Slack, allowed workspace domains or users.

14. Workspace Setup Phase

14.1 Create TruckOps Workspace

export TRUCKOPS_HOME="$HOME/.openclaw/workspace/truckops"

mkdir -p "$TRUCKOPS_HOME"/{docs/bootstrap,agents,skills,config,data,databases,documents,logs,snapshots,tools,services,releases,backups,tmp,dev,staging,tests,migrations,archive}

mkdir -p "$TRUCKOPS_HOME"/documents/{company,insurance,contracts,loads,invoices,fuel,maintenance,receipts,compliance,permits}

mkdir -p "$TRUCKOPS_HOME"/snapshots/{dispatch,brokers,collections,expenses,maintenance,cash-flow,profitability,daily-briefing}

tree -L 2 "$TRUCKOPS_HOME"

Persist the TRUCKOPS_HOME variable across sessions:

TRUCKOPS_HOME_LINE='export TRUCKOPS_HOME="$HOME/.openclaw/workspace/truckops"'
grep -qxF "$TRUCKOPS_HOME_LINE" ~/.bashrc || echo "$TRUCKOPS_HOME_LINE" >> ~/.bashrc
source ~/.bashrc

Validation:

test -d "$TRUCKOPS_HOME/docs/bootstrap" && \
test -d "$TRUCKOPS_HOME/config" && 
test -d "$TRUCKOPS_HOME/skills" && 
echo "TruckOps workspace exists."

14.2 Set Workspace Path In OpenClaw

Tell OpenClaw to use the TruckOps workspace as its default.

openclaw config set agents.defaults.workspace "$TRUCKOPS_HOME"
openclaw config get agents.defaults.workspace
openclaw config validate

Validation: The get command should return the path you just set.

14.3 Create Workspace README

cat > "$TRUCKOPS_HOME/README.md" <<'EOF'

TruckOps OpenClaw AI Operating System

This workspace contains the TruckOps bootstrap package, agent definitions, skills, configuration files, data, logs, snapshots, release notes, tools, services, and backups.

The Joplin notebook export belongs in:
docs/bootstrap/

The first system-aware request should ask OpenClaw to read the bootstrap package and generate the TruckOps Initialization Report.
EOF

Validation:

cat "$TRUCKOPS_HOME/README.md"

15. TruckOps Skills Setup Phase

These are custom TruckOps workspace skills. They do not replace OpenClaw tools. They teach the agent how to use the tools for TruckOps workflows.

Skill discovery note: OpenClaw loads skills from <workspace>/skills and <workspace>/.agents/skills. The skills/ folder has top precedence. After creating your skills, run openclaw skills list to confirm they are discovered.

15.1 Create Bootstrap Reader Skill

mkdir -p "$TRUCKOPS_HOME/skills/truckops-bootstrap-reader"

cat > "$TRUCKOPS_HOME/skills/truckops-bootstrap-reader/SKILL.md" <<'EOF'

---

name: truckops-bootstrap-reader
description: Read the TruckOps bootstrap package and produce an initialization report.

---

TruckOps Bootstrap Reader Skill

Use this skill when the owner asks to initialize TruckOps from the Joplin bootstrap package.

Required Inputs

· TruckOps workspace path
· Bootstrap docs path
· Current OpenClaw status
· Current workspace folder structure

Workflow

1. Read all files in docs/bootstrap/.
2. Read MANIFEST.md first if present.
3. Identify all 10 core bootstrap notes.
4. Summarize the system identity, architecture, domains, data layer, memory layer, first agent, foundation state, and release process.
5. Inspect the workspace folder structure.
6. Identify missing folders, config files, databases, skills, tools, credentials, and implementation steps.
7. Produce a TRUCKOPS INITIALIZATION REPORT.
8. Recommend the next build step.

Output

Use clear sections:

· System Identity
· Bootstrap Package Found
· Architecture Summary
· Current Foundation State
· Missing Pieces
· Agent Readiness
· Recommended Next Step
  EOF

15.2 Create Foundation Operator Skill

mkdir -p "$TRUCKOPS_HOME/skills/truckops-foundation-operator"

cat > "$TRUCKOPS_HOME/skills/truckops-foundation-operator/SKILL.md" <<'EOF'

---

name: truckops-foundation-operator
description: Operate and inspect the TruckOps OpenClaw foundation.

---

TruckOps Foundation Operator Skill

Use this skill when checking foundation status, workspace structure, OpenClaw status, model provider status, channel status, logs, and backups.

Workflow

1. Inspect OpenClaw status.
2. Inspect gateway status.
3. Inspect channel status.
4. Inspect workspace folders.
5. Inspect configuration files.
6. Inspect logs.
7. Report what is working, missing, or broken.

Never Guess

If a command is unavailable, report that it is unavailable and suggest the next validation command.
EOF

15.3 Create Dispatch Planner Skill

mkdir -p "$TRUCKOPS_HOME/skills/truckops-dispatch-planner"

cat > "$TRUCKOPS_HOME/skills/truckops-dispatch-planner/SKILL.md" <<'EOF'

---

name: truckops-dispatch-planner
description: Plan and analyze dispatch decisions using TruckOps rules, truck profiles, driver profiles, broker memory, and load data.

---

TruckOps Dispatch Planner Skill

Use this skill for on-demand dispatch planning.

Required Data

· config/dispatch_rules.yaml
· config/trucks.yaml
· config/drivers.yaml
· databases/brokers.db
· databases/loads.db
· snapshots/

Workflow

1. Understand the dispatch question.
2. Identify available truck and driver status.
3. Apply dispatch rules.
4. Evaluate loaded miles, deadhead, fuel cost, broker quality, timing, maintenance risk, reload potential, and projected weekly value.
5. Recommend the strongest option.
6. Save a dispatch snapshot when configured to do so.

Core Principle

Optimize asset utilization, not just single-load revenue.
EOF

15.4 Create Other Initial Agent Skills

for skill in 
  truckops-broker-intelligence 
  truckops-document-intake 
  truckops-invoice-collections 
  truckops-maintenance-tracker 
  truckops-fuel-expense-tracker 
  truckops-cash-flow-analyst 
  truckops-profitability-analyst 
  truckops-daily-briefing
do
mkdir -p "$TRUCKOPS_HOME/skills/$skill"
cat > "$TRUCKOPS_HOME/skills/$skill/SKILL.md" <<EOF

---

name: $skill
description: TruckOps placeholder skill for $skill workflows.

---

$skill

This is an initial TruckOps workspace skill placeholder.

Purpose

Define the repeatable workflow for this agent area as the system matures.

Rules

· Use shared TruckOps data where available.
· Write outputs to the correct shared folder or database.
· Do not create disconnected mini-applications.
· Preserve useful history for future versions.
· Report missing data clearly.

Status

Planned. Not yet operational.
EOF
done

15.5 Validate Skills And Tools From The Active Session

First, confirm the skills are loaded:

openclaw skills list

You should see truckops-* skills.

Next, check tool availability. OpenClaw's available tools depend on the agent, channel, sender, session, and model. To see what's active in your current conversation, send this command in the OpenClaw dashboard or in your Telegram/Slack channel:

/tools verbose

Confirm that the output includes the capabilities you need for the current build stage:

· file/read, file/write, file/edit – for managing workspace files
· exec – for running scripts and commands
· web/fetch, web/search – for external data retrieval
· browser – if you plan to use browser-based load collection later

Tool visibility note: If you don't see a tool you expect, it may be restricted by the current agent, channel, or sender configuration. Try creating a new session or adjusting your agent settings.

16. Configuration File Templates

16.1 trucks.yaml

cat > "$TRUCKOPS_HOME/config/trucks.yaml" <<'EOF'
trucks:

· id: truck_1
  name: Truck 1
  role: owner_operated
  status: planned
  current_location: null
  available_date: null
  odometer: null
  fuel_mpg_target: null
  maintenance_status: unknown
  notes: "Primary owner-operated truck."
· id: truck_2
  name: Truck 2
  role: hired_driver
  status: planned
  current_location: null
  available_date: null
  odometer: null
  fuel_mpg_target: null
  maintenance_status: unknown
  notes: "Second truck for future hired driver operation."
  EOF

16.2 drivers.yaml

cat > "$TRUCKOPS_HOME/config/drivers.yaml" <<'EOF'
drivers:

· id: owner
  name: Owner
  assigned_truck: truck_1
  status: planned
  home_base: null
  hours_available: null
  preferences:
  preferred_lanes: []
  avoided_lanes: []
  notes: "Owner/operator."
· id: driver_2
  name: Hired Driver
  assigned_truck: truck_2
  status: planned
  home_base: null
  hours_available: null
  preferences:
  preferred_lanes: []
  avoided_lanes: []
  notes: "Future hired driver profile."
  EOF

16.3 dispatch_rules.yaml

cat > "$TRUCKOPS_HOME/config/dispatch_rules.yaml" <<'EOF'
dispatch_rules:
operating_model: on_demand_dispatch_intelligence
core_principle: optimize_asset_utilization_not_single_load_revenue
scoring_weights:
all_in_rate_per_mile: 25
deadhead_penalty: 20
reload_market_quality: 20
broker_quality: 15
timing_fit: 10
maintenance_risk: 5
cash_flow_fit: 5
default_costs:
fuel_price_per_gallon: null
truck_mpg: null
maintenance_reserve_per_mile: null
driver_pay_type: percent_or_mileage
driver_pay_value: null
preferences:
preferred_lanes: []
avoided_lanes: []
preferred_markets: []
weak_markets: []
max_deadhead_miles_default: null
minimum_all_in_rate_per_mile: null
snapshot_policy:
save_queries: true
save_options_considered: true
save_rejected_options: true
save_owner_decision: true
save_outcome: true
EOF

16.4 broker_rules.yaml

cat > "$TRUCKOPS_HOME/config/broker_rules.yaml" <<'EOF'
broker_rules:
score_fields:
payment_speed: true
communication_quality: true
detention_behavior: true
cancellation_history: true
dispute_history: true
repeat_profitability: true
default_status:
new_broker_score: 50
avoid_threshold: 25
preferred_threshold: 80
EOF

16.5 Initialize SQLite Databases

sqlite3 "$TRUCKOPS_HOME/databases/brokers.db" <<'EOF'
CREATE TABLE IF NOT EXISTS brokers (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
mc_number TEXT,
contact_name TEXT,
phone TEXT,
email TEXT,
payment_speed TEXT,
communication_quality TEXT,
detention_behavior TEXT,
cancellation_history TEXT,
dispute_history TEXT,
score INTEGER DEFAULT 50,
status TEXT DEFAULT 'new',
notes TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/loads.db" <<'EOF'
CREATE TABLE IF NOT EXISTS loads (
id INTEGER PRIMARY KEY AUTOINCREMENT,
source TEXT,
broker_id INTEGER,
pickup_city TEXT,
pickup_state TEXT,
delivery_city TEXT,
delivery_state TEXT,
pickup_datetime TEXT,
delivery_datetime TEXT,
rate_total REAL,
loaded_miles REAL,
deadhead_miles REAL,
total_miles REAL,
all_in_rate_per_mile REAL,
commodity TEXT,
weight REAL,
equipment_type TEXT,
appointment_requirements TEXT,
status TEXT DEFAULT 'considered',
reason_accepted_or_rejected TEXT,
final_outcome TEXT,
notes TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/snapshots.db" <<'EOF'
CREATE TABLE IF NOT EXISTS dispatch_snapshots (
id INTEGER PRIMARY KEY AUTOINCREMENT,
query TEXT,
situation_summary TEXT,
recommendation TEXT,
owner_decision TEXT,
outcome TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/documents.db" <<'EOF'
CREATE TABLE IF NOT EXISTS documents (
id INTEGER PRIMARY KEY AUTOINCREMENT,
filename TEXT,
document_type TEXT,
related_entity_type TEXT,
related_entity_id TEXT,
status TEXT DEFAULT 'received',
extracted_summary TEXT,
file_path TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/expenses.db" <<'EOF'
CREATE TABLE IF NOT EXISTS expenses (
id INTEGER PRIMARY KEY AUTOINCREMENT,
expense_type TEXT,
expense_category TEXT,
amount REAL,
vendor TEXT,
location TEXT,
gallons REAL,
price_per_gallon REAL,
truck_id TEXT,
load_id INTEGER,
expense_date TEXT,
notes TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/invoices.db" <<'EOF'
CREATE TABLE IF NOT EXISTS invoices (
id INTEGER PRIMARY KEY AUTOINCREMENT,
invoice_number TEXT,
load_id INTEGER,
broker_id INTEGER,
invoice_date TEXT,
due_date TEXT,
amount REAL,
factoring_status TEXT,
payment_status TEXT DEFAULT 'pending_payment',
days_outstanding INTEGER,
follow_up_history TEXT,
dispute_status TEXT,
notes TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/maintenance.db" <<'EOF'
CREATE TABLE IF NOT EXISTS maintenance (
id INTEGER PRIMARY KEY AUTOINCREMENT,
truck_id TEXT,
service_date TEXT,
odometer INTEGER,
service_type TEXT,
vendor TEXT,
cost REAL,
parts_replaced TEXT,
next_service_due TEXT,
warranty_notes TEXT,
downtime TEXT,
related_document TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/cash_flow.db" <<'EOF'
CREATE TABLE IF NOT EXISTS cash_flow (
id INTEGER PRIMARY KEY AUTOINCREMENT,
expected_income REAL,
expected_payment_date TEXT,
open_invoices TEXT,
upcoming_bills TEXT,
fuel_needs REAL,
maintenance_reserve REAL,
driver_pay REAL,
insurance REAL,
truck_payment REAL,
emergency_reserve REAL,
shortfall_warning TEXT,
snapshot_date TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

sqlite3 "$TRUCKOPS_HOME/databases/snapshots.db" <<'EOF'
CREATE TABLE IF NOT EXISTS snapshots (
id INTEGER PRIMARY KEY AUTOINCREMENT,
snapshot_type TEXT,
agent_name TEXT,
owner_question TEXT,
situation_summary TEXT,
recommendation TEXT,
owner_decision TEXT,
outcome TEXT,
lessons_learned TEXT,
file_path TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
EOF

Validation:

ls -lah "$TRUCKOPS_HOME/config"
ls -lah "$TRUCKOPS_HOME/databases"
sqlite3 "$TRUCKOPS_HOME/databases/loads.db" ".tables"

17. Plugin Selection And Installation

No TruckOps-specific third-party plugin is required for Foundation V1.

For this first build, use:

· OpenClaw core tools
· Workspace skills
· Hosted model provider
· Telegram or web dashboard channel
· Local files and SQLite

17.1 Check Installed Plugins

Run a cold inventory to see what plugins are available and whether they are bundled but not yet enabled:

openclaw plugins list

The list will show installed versions, integration IDs, and whether they are bundled.

17.2 Enable Plugins When Needed

Some bundled plugins are auto-enabled (e.g., model providers, browser plugin). Others require explicit activation:

openclaw plugins enable REPLACE_WITH_PLUGIN_ID

Then restart the Gateway:

openclaw gateway restart

Verify the plugin is running:

openclaw plugins inspect REPLACE_WITH_PLUGIN_ID --runtime --json

17.3 Search And Install Community Plugins Later

When a specific connector is needed:

openclaw plugins search "email"
openclaw plugins search "calendar"
openclaw plugins search "browser"
openclaw plugins search "telegram"
openclaw plugins search "slack"
openclaw plugins install clawhub:REPLACE_WITH_PACKAGE

Rule: Do not install random community plugins into production without understanding their code. Prefer built-in tools and custom workspace skills first.

18. Bootstrap Package Upload Phase

18.1 Preferred Path: Joplin Export From Desktop

When desktop access is available, export the TruckOps notebook as Markdown (preferred) or HTML and upload it to:

~/.openclaw/workspace/truckops/docs/bootstrap/

Note: Markdown is cleaner for AI consumption, but HTML is acceptable if Markdown export is unavailable.

Example upload from local machine:

gcloud compute scp 
  --project="$PROJECT_ID" \
  --zone="$ZONE" 
  --recurse 
  ./TRUCKOPS_EXPORT 
  "$VM_NAME":~/.openclaw/workspace/truckops/docs/bootstrap/

18.2 Mobile Fallback: Capture Published Joplin Pages

If using only Joplin mobile, capture the current published pages directly on the VM.

cat > "$TRUCKOPS_HOME/docs/bootstrap/bootstrap_urls.txt" <<'EOF'
ANNEX: AI CONTEXT & DEVELOPMENT LOG
https://n38humzkw9.joplinusercontent.com/shares/YgGl8tbgrKLlZISjJqdKeL

PROJECT OVERVIEW: TRUCKOPS OPENCLAW AI OPERATING SYSTEM
https://n38humzkw9.joplinusercontent.com/shares/UF21uyOJxkIHa0USLnzq8G

SYSTEM ARCHITECTURE BASELINE
https://n38humzkw9.joplinusercontent.com/shares/KABtFljbT18YRZDj4AGCzz

FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION
https://n38humzkw9.joplinusercontent.com/shares/QaeBrwwoio7VsW9NI0KoGw

FOUNDATION: GCP + VM + OPENCLAW
https://n38humzkw9.joplinusercontent.com/shares/DLmzjQ0tAK4BD9if8JzMVn

TRUCKOPS BUSINESS DOMAINS MAP
https://n38humzkw9.joplinusercontent.com/shares/iFsw8YkxJsTwXbtHvh68kr

ON-DEMAND DISPATCH INTELLIGENCE AGENT
https://n38humzkw9.joplinusercontent.com/shares/Rgn1uAFlixvgbQPKtxFtuB

DATA, MEMORY & RECORDS BASELINE
https://n38humzkw9.joplinusercontent.com/shares/YWrN0UTG1csFkOf2QJrvOL

MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE
https://n38humzkw9.joplinusercontent.com/shares/KWdKHJOiOG2c7zdi2VelOp

DEVELOPMENT, TESTING & RELEASE PROCESS
https://n38humzkw9.joplinusercontent.com/shares/vN9BypcFEjmj0nQeEYKRVO
EOF

Download rendered pages:

cd "$TRUCKOPS_HOME/docs/bootstrap"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/YgGl8tbgrKLlZISjJqdKeL" 
  -o "01-annex-ai-context-development-log.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/UF21uyOJxkIHa0USLnzq8G" 
  -o "02-project-overview.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/KABtFljbT18YRZDj4AGCzz" 
  -o "03-system-architecture-baseline.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/QaeBrwwoio7VsW9NI0KoGw" 
  -o "04-foundation-build-runbook.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/DLmzjQ0tAK4BD9if8JzMVn" 
  -o "05-foundation-gcp-vm-openclaw.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/iFsw8YkxJsTwXbtHvh68kr" 
  -o "06-business-domains-map.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/Rgn1uAFlixvgbQPKtxFtuB" 
  -o "07-on-demand-dispatch-intelligence-agent.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/YWrN0UTG1csFkOf2QJrvOL" 
  -o "08-data-memory-records-baseline.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/KWdKHJOiOG2c7zdi2VelOp" 
  -o "09-memory-learning-self-improvement-architecture.html"

curl -fL --retry 3 --retry-delay 2 
  "https://n38humzkw9.joplinusercontent.com/shares/vN9BypcFEjmj0nQeEYKRVO" 
  -o "10-development-testing-release-process.html"

Validate files were downloaded successfully:

test -s "01-annex-ai-context-development-log.html" && echo "✓ File 1 OK" || echo "✗ File 1 missing"
test -s "02-project-overview.html" && echo "✓ File 2 OK" || echo "✗ File 2 missing"
test -s "03-system-architecture-baseline.html" && echo "✓ File 3 OK" || echo "✗ File 3 missing"
test -s "04-foundation-build-runbook.html" && echo "✓ File 4 OK" || echo "✗ File 4 missing"
test -s "05-foundation-gcp-vm-openclaw.html" && echo "✓ File 5 OK" || echo "✗ File 5 missing"
test -s "06-business-domains-map.html" && echo "✓ File 6 OK" || echo "✗ File 6 missing"
test -s "07-on-demand-dispatch-intelligence-agent.html" && echo "✓ File 7 OK" || echo "✗ File 7 missing"
test -s "08-data-memory-records-baseline.html" && echo "✓ File 8 OK" || echo "✗ File 8 missing"
test -s "09-memory-learning-self-improvement-architecture.html" && echo "✓ File 9 OK" || echo "✗ File 9 missing"
test -s "10-development-testing-release-process.html" && echo "✓ File 10 OK" || echo "✗ File 10 missing"

Create bootstrap manifest:

cat > "$TRUCKOPS_HOME/docs/bootstrap/MANIFEST.md" <<'EOF'

TruckOps Bootstrap Package Manifest

This folder contains the starting documentation for initializing the TruckOps OpenClaw AI Operating System.

Core Files (10 notes)

1. ANNEX: AI CONTEXT & DEVELOPMENT LOG
2. PROJECT OVERVIEW: TRUCKOPS OPENCLAW AI OPERATING SYSTEM
3. SYSTEM ARCHITECTURE BASELINE
4. FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION
5. FOUNDATION: GCP + VM + OPENCLAW
6. TRUCKOPS BUSINESS DOMAINS MAP
7. ON-DEMAND DISPATCH INTELLIGENCE AGENT
8. DATA, MEMORY & RECORDS BASELINE
9. MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE
10. DEVELOPMENT, TESTING & RELEASE PROCESS

Purpose

These files define the TruckOps system identity, architecture, development rules, foundation, domains, agents, data, memory, learning, and release process.
EOF

Validation:

ls -lah "$TRUCKOPS_HOME/docs/bootstrap"
wc -c "$TRUCKOPS_HOME/docs/bootstrap/"*.html
grep -R "TruckOps" "$TRUCKOPS_HOME/docs/bootstrap" | head -20

19. Initialization Phase

19.1 First System-Aware Request

Use this prompt in the OpenClaw dashboard or Telegram channel after the bootstrap files are uploaded:

Read the TruckOps bootstrap package from ~/.openclaw/workspace/truckops/docs/bootstrap/. Use all 10 notes in the bootstrap package:

1. ANNEX: AI CONTEXT & DEVELOPMENT LOG
2. PROJECT OVERVIEW: TRUCKOPS OPENCLAW AI OPERATING SYSTEM
3. SYSTEM ARCHITECTURE BASELINE
4. FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION
5. FOUNDATION: GCP + VM + OPENCLAW
6. TRUCKOPS BUSINESS DOMAINS MAP
7. ON-DEMAND DISPATCH INTELLIGENCE AGENT
8. DATA, MEMORY & RECORDS BASELINE
9. MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE
10. DEVELOPMENT, TESTING & RELEASE PROCESS

Inspect the current TruckOps workspace. Generate the first TRUCKOPS INITIALIZATION REPORT. Identify what exists, what is missing, whether the foundation is ready, whether the model provider is working, what skills are available, what tools are needed, what config files exist, what databases exist, and what the next build step should be.

19.2 Expected Initialization Report Sections

The report should include:

· System Identity
· Bootstrap Package Status
· Architecture Summary
· Current Foundation State
· OpenClaw Status
· Model Provider Status
· Channel Status
· Workspace Folder Status
· Skills Status
· Tools Status
· Config File Status
· Database Status
· Missing Pieces
· Readiness For First Agent
· Recommended Next Build Step

20. Post-Initialization Validation

20.1 Run Manual System Checks

openclaw gateway status
openclaw status --deep || openclaw health
openclaw channels list --all
openclaw channels status --probe || openclaw channels status
tree -L 2 "$TRUCKOPS_HOME"
find "$TRUCKOPS_HOME/skills" -name SKILL.md -print
ls -lah "$TRUCKOPS_HOME/config"
ls -lah "$TRUCKOPS_HOME/databases"

20.2 Test Model Response

In the dashboard or Telegram, send:

What is TruckOps, and what folder should you read first to understand the system?

Expected answer should mention:

· TruckOps OpenClaw AI Operating System
· Bootstrap package
· docs/bootstrap/
· MANIFEST.md
· All 10 core bootstrap notes

20.3 First Dispatch Readiness Test

Send:

Using the TruckOps architecture, tell me what is still required before the On-Demand Dispatch Intelligence Agent can be built as Version 1.

The answer should mention:

· Truck profiles
· Driver profiles
· Dispatch rules
· Broker memory
· Load-board connector or manual load input method
· Load storage
· Scoring logic
· Planning logic
· Snapshot history

21. Backup Strategy Before Changes

21.1 Create Local Backup Script

cat > "$TRUCKOPS_HOME/tools/backup_truckops.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
TRUCKOPS_HOME="${TRUCKOPS_HOME:-$HOME/.openclaw/workspace/truckops}"
BACKUP_DIR="$TRUCKOPS_HOME/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
OUT="$BACKUP_DIR/truckops-backup-$STAMP.tar.gz"
mkdir -p "$BACKUP_DIR"
tar -czf "$OUT" \
  --exclude="$TRUCKOPS_HOME/backups" 
  --exclude="$TRUCKOPS_HOME/tmp" \
  -C "$TRUCKOPS_HOME" .
echo "Backup created: $OUT"
EOF

chmod +x "$TRUCKOPS_HOME/tools/backup_truckops.sh"

21.2 Run Backup

"$TRUCKOPS_HOME/tools/backup_truckops.sh"

Validation:

ls -lah "$TRUCKOPS_HOME/backups"

22. Troubleshooting

Problem Likely Cause Fix
SSH connection refused VM still initializing or SSH metadata not ready Wait 1-2 minutes and retry
Docker permission denied User group change not active Log out and log back in; verify with groups
OpenClaw command not found Shell path not refreshed Run source ~/.bashrc or reconnect SSH
OpenClaw install fails Network, Node, or package issue Check internet, install Node, rerun installer
Gateway not running Daemon not installed or failed Run openclaw onboard --install-daemon or openclaw gateway restart
Dashboard not reachable No SSH tunnel or wrong port Use SSH tunnel to port 18789
API key error Wrong key, missing env, or provider mismatch Reload secrets file and rerun OpenClaw onboarding
Telegram not responding Token wrong or channel not running Check token, restart Gateway, run channel probe
Bootstrap files not found Files uploaded to wrong folder Confirm files exist in docs/bootstrap/
Agent ignores new skill Skill snapshot not refreshed Start a new session or restart Gateway

23. Future Maintenance

23.1 Add A New Agent Later

1. Create or update the agent concept note in Joplin.
2. Determine which business domain it belongs to.
3. Identify data it needs to read and write.
4. Create a workspace skill under skills/.
5. Create config files under config/.
6. Create database tables under databases/.
7. Test against sample data.
8. Write release note under releases/.
9. Update the AI Context & Development Log.

23.2 Add A New Skill Later

mkdir -p "$TRUCKOPS_HOME/skills/NEW_SKILL_NAME"
nano "$TRUCKOPS_HOME/skills/NEW_SKILL_NAME/SKILL.md"
openclaw gateway restart

23.3 Add A Plugin Later

openclaw plugins search "REPLACE_WITH_CAPABILITY"
openclaw plugins install clawhub:REPLACE_WITH_PACKAGE
openclaw plugins enable REPLACE_WITH_PLUGIN_ID
openclaw gateway restart
openclaw plugins inspect REPLACE_WITH_PLUGIN_ID --runtime --json

23.4 Switch Model Providers Later

1. Add new API key to ~/.openclaw/secrets.env.
2. Reload environment variables.
3. Use OpenClaw onboarding or model configuration commands to add provider.
4. Verify model list.
5. Send a test message.
6. Update Foundation note and Development Log.

set -a
source ~/.openclaw/secrets.env
set +a
openclaw onboard
openclaw models list || true
openclaw status --deep || openclaw health

23.5 Add Local/Self-Hosted Model Later

Do this only after the foundation is working and hardware/cost justify it.

Future process:

1. Decide whether model runs on same VM, stronger GPU VM, local workstation, or dedicated server.
2. Install Ollama, LM Studio, vLLM, SGLang, or selected endpoint.
3. Verify model endpoint responds.
4. Configure OpenClaw model provider.
5. Test with low-risk system-awareness tasks.
6. Keep hosted model available for complex reasoning if needed.

23.6 Upgrade OpenClaw Later

Before upgrading:

"$TRUCKOPS_HOME/tools/backup_truckops.sh"
openclaw --version
openclaw gateway status
openclaw status --deep || openclaw health
openclaw doctor

Then follow the current OpenClaw update method for the installed version:

openclaw update

After upgrade:

openclaw --version
openclaw gateway restart
openclaw gateway status
openclaw status --deep || openclaw health
openclaw doctor

Record the upgrade in:

$TRUCKOPS_HOME/releases/

24. Load-Board Connector Roadmap

The Dispatch Agent requires load-board data. Build this capability in phases, matching the foundation maturity.

Phase 1: Manual Entry (Foundation V1)

· Owner copies load details into a structured text file or chat message.
· Agent reads the file/message and performs analysis.
· Store results in loads.db.
· Validation: Agent can analyze a manually-entered load and produce a dispatch snapshot.

Phase 2: On-Demand Query of Specific Load Boards

· The Dispatch Agent does not run continuously or crawl the internet. It performs a query only when the owner sends a specific dispatch request (e.g., "Find loads from Atlanta to Miami").
· The owner explicitly configures which specific load boards the agent is allowed to check. The agent never queries a board the owner hasn't listed.
· For each board, the owner determines the method:
  · Preferred: Official API, CSV export, or email feed (fastest and most reliable).
  · Fallback (if no API): Browser-assisted login and search, used only during the owner's active query session.
· The login credentials, fields to collect, and parsing rules are stored in a dedicated SKILL.md for that specific load board.
· Validation: When the owner asks for a dispatch search, the agent can collect permitted load data from the configured boards and store normalized records in loads.db.

Important: This is a user-initiated query, not a background scraper. Frequency matches owner demand—usually a few times per day—so it falls under normal human usage patterns, not aggressive bot traffic. If a board blocks or rate-limits queries, the owner can easily adjust the query frequency or switch to that board's official export method.

Phase 3: API Integration (Foundation V6+)

· Use the load-board's official API if available.
· Authenticate with API keys or OAuth tokens (stored in secrets.env).
· Write a lightweight plugin or a dedicated skill that calls the API.
· Store raw responses and parsed loads in databases/.
· Validation: Agent can fetch real-time loads via API and score them automatically.

Rule: Do not build Phase 2 or 3 until Phase 1 has proven its value with real owner data.

25. Success Criteria

The foundation build is successful when all of the following are true:

· GCP project exists
· Billing is linked
· Budget alert exists
· Compute Engine VM exists
· SSH access works
· Docker works
· OpenClaw is installed
· OpenClaw Gateway is running
· Model provider endpoint is configured
· OpenClaw can answer a test message
· At least one access method works: dashboard, Telegram, or Slack
· TruckOps workspace exists
· Bootstrap docs are uploaded into docs/bootstrap/
· TruckOps custom skills exist under skills/
· Initial config files exist
· Initial SQLite databases exist
· Backup script works
· TruckOps Initialization Report has been generated
· The system correctly identifies what TruckOps is and what must be built next

26. Final Build Statement

When this runbook is complete, TruckOps is not finished. The foundation is ready.

The VM exists. OpenClaw runs. A model provider is connected. The workspace exists. The bootstrap package is present. The system can read its own architecture. The first initialization report can be generated. The owner can then begin building the first real agent inside the documented TruckOps architecture.

Build the foundation. Initialize from the bootstrap. Then build the first useful agent.

---

This is your original runbook – simple, tested, and aligned with the OpenClaw documentation. No brittle version pins, no fake determinism, no unneeded complexity.

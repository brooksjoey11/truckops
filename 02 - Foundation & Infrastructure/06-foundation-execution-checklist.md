# Foundation Execution Checklist

## Purpose

This checklist converts the Foundation Build Runbook into an execution tracker.

Use this file to verify that the TruckOps foundation has been built, not merely documented.

---

## Execution Rule

Do not mark a step complete unless the verification command or verification evidence confirms it.

---

## Required Inputs

| Input | Required | Source |
|---|---:|---|
| GCP billing account | Yes | Project owner |
| GCP project ID | Yes | Project owner |
| GCP region | Yes | Default: `us-central1` |
| VM zone | Yes | Default: `us-central1-a` |
| VM machine type | Yes | Default: `e2-small` |
| Debian version | Yes | Debian 12 |
| SSH access | Yes | GCP Compute Engine |
| Model provider API key | Yes | Secret Manager |
| TruckOps repository URL | Yes | Repository |
| `$TRUCKOPS_HOME` | Yes | `/opt/truckops` production default |

---

## Phase 1 — GCP Project

| Step | Action | Verification | Status |
|---|---|---|---|
| 1.1 | Create GCP project | Project appears in GCP console | Not Started |
| 1.2 | Link billing account | Billing enabled | Not Started |
| 1.3 | Enable Compute Engine API | API status enabled | Not Started |
| 1.4 | Enable Secret Manager API | API status enabled | Not Started |
| 1.5 | Enable Cloud Logging API | API status enabled | Not Started |
| 1.6 | Set budget alert | Budget alert visible | Not Started |

**Commands:**

```bash
gcloud config set project "$GCP_PROJECT_ID"

gcloud services enable compute.googleapis.com
gcloud services enable secretmanager.googleapis.com
gcloud services enable logging.googleapis.com
```

**Verification:**

```bash
gcloud services list --enabled \
  --filter="name:(compute.googleapis.com OR secretmanager.googleapis.com OR logging.googleapis.com)"
```

---

## Phase 2 — VM Provisioning

| Step | Action | Verification | Status |
|---|---|---|---|
| 2.1 | Create Debian 12 VM | VM appears in Compute Engine | Not Started |
| 2.2 | Confirm machine type `e2-small` | VM details show `e2-small` | Not Started |
| 2.3 | Confirm zone | VM zone matches selected zone | Not Started |
| 2.4 | Confirm SSH access | SSH login succeeds | Not Started |
| 2.5 | Update packages | No pending critical updates | Not Started |

**Command:**

```bash
gcloud compute instances create truckops-openclaw-vm \
  --zone="$GCP_ZONE" \
  --machine-type=e2-small \
  --image-family=debian-12 \
  --image-project=debian-cloud \
  --boot-disk-size=30GB
```

**Verification:**

```bash
gcloud compute instances describe truckops-openclaw-vm \
  --zone="$GCP_ZONE" \
  --format="table(name,machineType,status,zone)"
```

---

## Phase 3 — Base System Setup

| Step | Action | Verification | Status |
|---|---|---|---|
| 3.1 | SSH into VM | Shell access confirmed | Not Started |
| 3.2 | Install updates | Package update completes | Not Started |
| 3.3 | Install Git | `git --version` returns version | Not Started |
| 3.4 | Install Docker | `docker --version` returns version | Not Started |
| 3.5 | Add user to Docker group | Docker runs without sudo after relogin | Not Started |

**Commands:**

```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git curl ca-certificates gnupg
```

**Docker install verification:**

```bash
docker --version
docker run hello-world
```

---

## Phase 4 — Workspace Creation

| Step | Action | Verification | Status |
|---|---|---|---|
| 4.1 | Set `TRUCKOPS_HOME` | Variable prints expected path | Not Started |
| 4.2 | Create workspace folders | Validation command passes | Not Started |
| 4.3 | Clone repository | Repository files visible | Not Started |
| 4.4 | Copy bootstrap docs | Bootstrap folder populated | Not Started |
| 4.5 | Create config files | Config files exist without secrets | Not Started |

**Commands:**

```bash
export TRUCKOPS_HOME="/opt/truckops"
sudo mkdir -p "$TRUCKOPS_HOME"
sudo chown -R "$USER:$USER" "$TRUCKOPS_HOME"
```

**Clone:**

```bash
git clone https://github.com/brooksjoey11/truckops "$TRUCKOPS_HOME/bootstrap/repository"
```

**Initialize workspace:**

```bash
bash "$TRUCKOPS_HOME/bootstrap/repository/tools/initialize_workspace.sh"
```

**Validation:**

```bash
test -d "$TRUCKOPS_HOME/bootstrap/repository" \
&& test -d "$TRUCKOPS_HOME/config" \
&& test -d "$TRUCKOPS_HOME/agents" \
&& test -d "$TRUCKOPS_HOME/data" \
&& echo "Workspace baseline present"
```

---

## Phase 5 — OpenClaw Installation

| Step | Action | Verification | Status |
|---|---|---|---|
| 5.1 | Install OpenClaw | OpenClaw files or container present | Not Started |
| 5.2 | Start OpenClaw | OpenClaw process/container running | Not Started |
| 5.3 | Confirm local endpoint | HTTP response received | Not Started |
| 5.4 | Configure model provider | Test prompt succeeds | Not Started |
| 5.5 | Confirm logs write | OpenClaw log file updates | Not Started |

Verification commands depend on the selected OpenClaw installation method.

**Minimum verification:**

```bash
docker ps
curl -s "$OPENCLAW_BASE_URL/health" || true
```

---

## Phase 6 — Model Provider Configuration

| Step | Action | Verification | Status |
|---|---|---|---|
| 6.1 | Set `MODEL_PROVIDER_NAME` | Variable set to chosen provider label | Not Started |
| 6.2 | Set `MODEL_PROVIDER_ENDPOINT` | Variable set to provider endpoint URL | Not Started |
| 6.3 | Test model endpoint | Test prompt returns valid response | Not Started |

The model provider is fully configurable. Set `MODEL_PROVIDER_NAME` to any label (e.g., `local`, `anthropic`, `mistral`) and `MODEL_PROVIDER_ENDPOINT` to the corresponding endpoint URL. No specific vendor is required.

```bash
export MODEL_PROVIDER_NAME="local"
export MODEL_PROVIDER_ENDPOINT="http://localhost:11434/api/generate"
```

---

## Phase 7 — Secret Storage

| Step | Action | Verification | Status |
|---|---|---|---|
| 7.1 | Store model provider key | Secret exists in Secret Manager | Not Started |
| 7.2 | Store Telegram token if used | Secret exists in Secret Manager | Not Started |
| 7.3 | Store future external credentials only as secrets | No credentials in repo files | Not Started |

**Command pattern:**

```bash
printf "%s" "$MODEL_PROVIDER_API_KEY" | gcloud secrets create model_provider_api_key --data-file=-
```

**Verification:**

```bash
gcloud secrets list
```

---

## Phase 8 — TruckOps Initialization

| Step | Action | Verification | Status |
|---|---|---|---|
| 8.1 | Upload bootstrap package to OpenClaw workspace | Docs readable in workspace | Not Started |
| 8.2 | Generate Initialization Report | Report file exists | Not Started |
| 8.3 | Confirm system understands TruckOps architecture | Report references Orchestrator, foundation, data, memory, agents | Not Started |
| 8.4 | Save report to bootstrap folder | Report stored under initialization reports | Not Started |

**Output location:**

```
$TRUCKOPS_HOME/bootstrap/initialization-reports/
```

**Required report name pattern:**

```
truckops-initialization-report-YYYY-MM-DD.md
```

---

## Phase 9 — Orchestrator Readiness

| Step | Action | Verification | Status |
|---|---|---|---|
| 9.1 | Create Orchestrator workspace directory | Directory exists | Not Started |
| 9.2 | Add Orchestrator manifest | `agent.yaml` exists | Not Started |
| 9.3 | Register Orchestrator in OpenClaw | Agent visible in registry | Not Started |
| 9.4 | Run intent parsing test | Structured intent returned | Not Started |
| 9.5 | Run routing test with Dispatch mock | Route decision returned | Not Started |

**Required directory:**

```
$TRUCKOPS_HOME/agents/orchestrator/
```

---

## Phase 10 — Foundation Completion Criteria

Foundation is complete only when:

- GCP project exists.
- Billing is enabled.
- Compute Engine API is enabled.
- Secret Manager API is enabled.
- VM is running.
- SSH access works.
- Docker works.
- OpenClaw is installed.
- OpenClaw endpoint responds.
- Model provider endpoint responds.
- `$TRUCKOPS_HOME` exists.
- Canonical workspace structure exists.
- Repository bootstrap package is present.
- Initialization Report is generated.
- No credentials are stored in repository files.
- Orchestrator implementation can begin.

---

## Foundation Status Summary

| Area | Required Completion State | Current Default |
|---|---|---|
| GCP | Project, billing, APIs enabled | Not Started |
| VM | Debian 12 `e2-small` running | Not Started |
| Docker | Installed and verified | Not Started |
| OpenClaw | Installed and responding | Not Started |
| Model provider | Configured and tested | Not Started |
| Workspace | Canonical structure created | Not Started |
| Bootstrap | Repository uploaded/readable | Not Started |
| Initialization | Report generated | Not Started |
| Orchestrator | Ready to implement | Not Started |

---

## Handoff to Orchestrator Build

After this checklist passes, proceed to:

```
04 - Agents & Features/ORCHESTRATOR AGENT.md
```

Do not begin specialist-agent implementation until the Orchestrator Agent has a working registry, routing behavior, and at least one mock specialist workflow.

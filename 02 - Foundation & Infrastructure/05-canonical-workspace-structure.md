# Canonical Workspace Structure

## Purpose

This file defines the single canonical TruckOps runtime workspace structure.

All runbooks, agents, scripts, records, tests, logs, memory files, backups, and release procedures must refer to this structure unless a later release explicitly changes it.

---

## Canonical Root

The runtime workspace root is:

```
$TRUCKOPS_HOME
```

Default development value:

```bash
export TRUCKOPS_HOME="$HOME/truckops"
```

Default production value:

```bash
export TRUCKOPS_HOME="/opt/truckops"
```

---

## Required Environment Variables

| Variable | Required | Example | Purpose |
|---|---:|---|---|
| `TRUCKOPS_HOME` | Yes | `/opt/truckops` | Runtime workspace root |
| `TRUCKOPS_ENV` | Yes | `development`, `staging`, `production` | Runtime environment |
| `GCP_PROJECT_ID` | Yes | `truckops-prod-001` | GCP project |
| `GCP_REGION` | Yes | `us-central1` | GCP region |
| `OPENCLAW_BASE_URL` | Yes | `http://localhost:8080` | OpenClaw endpoint |
| `MODEL_PROVIDER_NAME` | Yes | Any label (e.g., `local`, `anthropic`, `openai`) | Model provider label |
| `MODEL_PROVIDER_ENDPOINT` | Yes | Provider endpoint URL | Model endpoint |
| `SQLITE_DB_PATH` | Yes | `$TRUCKOPS_HOME/data/truckops.sqlite` | Structured data path |
| `VECTOR_DB_PATH` | Yes | `$TRUCKOPS_HOME/data/vector` | Vector memory path |

No specific model provider or API vendor is required. `MODEL_PROVIDER_NAME` and `MODEL_PROVIDER_ENDPOINT` accept any compliant endpoint.

---

## Workspace Directory Tree

```
$TRUCKOPS_HOME/
├── README.md
├── bootstrap/
│   ├── repository/
│   ├── joplin-export/
│   └── initialization-reports/
├── config/
│   ├── workspace.yaml
│   ├── agents.yaml
│   ├── records.yaml
│   ├── memory.yaml
│   ├── logging.yaml
│   ├── release.yaml
│   └── secrets.example.yaml
├── agents/
│   ├── orchestrator/
│   ├── dispatch/
│   ├── document_compliance/
│   ├── invoicing_collections/
│   ├── broker_intelligence/
│   ├── maintenance/
│   ├── fuel_expense/
│   ├── cash_flow/
│   ├── profitability/
│   └── daily_briefing/
├── data/
│   ├── truckops.sqlite
│   ├── vector/
│   ├── schemas/
│   ├── migrations/
│   └── exports/
├── memory/
│   ├── owner/
│   ├── business/
│   ├── agents/
│   ├── lessons/
│   └── archived/
├── records/
│   ├── company/
│   ├── compliance/
│   ├── trucks/
│   ├── drivers/
│   ├── dispatch/
│   ├── brokers/
│   ├── documents/
│   ├── invoices/
│   ├── expenses/
│   ├── maintenance/
│   ├── cash-flow/
│   ├── profitability/
│   └── open-loops/
├── dev/
│   ├── experiments/
│   ├── prototypes/
│   ├── sample-data/
│   └── scratch/
├── staging/
│   ├── release-candidates/
│   ├── test-data/
│   └── validation-reports/
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── end-to-end/
│   └── fixtures/
├── tools/
│   ├── backup_truckops.sh
│   ├── restore_truckops.sh
│   ├── health_check.sh
│   └── initialize_workspace.sh
├── logs/
│   ├── system/
│   ├── orchestrator/
│   ├── agents/
│   ├── openclaw/
│   ├── workflows/
│   └── releases/
├── backups/
│   ├── daily/
│   ├── pre-release/
│   └── manual/
└── releases/
    ├── notes/
    ├── manifests/
    └── rollback/
```

---

## Directory Responsibilities

| Directory | Responsibility |
|---|---|
| `bootstrap/` | Stores original bootstrap material and initialization outputs |
| `config/` | Stores non-secret runtime configuration |
| `agents/` | Stores agent definitions, prompts, skills, workflows, and local tests |
| `data/` | Stores structured databases, vector databases, schemas, and migrations |
| `memory/` | Stores persistent learned context and system lessons |
| `records/` | Stores operational business records |
| `dev/` | Stores experimental development work that must not affect production |
| `staging/` | Stores release-candidate validation materials |
| `tests/` | Stores repeatable test cases and fixtures |
| `tools/` | Stores operational shell scripts and utility commands |
| `logs/` | Stores system, agent, workflow, release, and audit logs |
| `backups/` | Stores workspace backups |
| `releases/` | Stores release notes, manifests, and rollback plans |

---

## Agent Directory Standard

Each agent directory must use this structure:

```
agents/{canonical_agent_id}/
├── README.md
├── agent.yaml
├── prompts/
│   ├── system.md
│   └── task.md
├── skills/
├── workflows/
├── schemas/
├── tests/
└── logs/
```

Required files:

| File | Required | Purpose |
|---|---:|---|
| `README.md` | Yes | Human-readable agent overview |
| `agent.yaml` | Yes | Machine-readable agent manifest |
| `prompts/system.md` | Yes | Agent-level operating prompt |
| `skills/` | Yes | Skill definitions |
| `workflows/` | When applicable | Multi-step workflow definitions |
| `schemas/` | Yes | Input/output contracts |
| `tests/` | Yes | Agent-specific validation tests |
| `logs/` | Yes | Agent-local logs if not centralized |

All prompts must be stored as separate markdown or YAML files in the `prompts/` directory. They must not be hard-coded in agent logic.

---

## Configuration Boundary

Files in `config/` may contain:

- Non-secret defaults
- Environment names
- Local paths
- Agent IDs
- Feature flags
- Log levels
- Schema paths
- Runtime modes

Files in `config/` must not contain:

- API keys
- Passwords
- Tokens
- Private keys
- Broker credentials
- Load board credentials
- Personal financial account credentials

Secrets must be stored in GCP Secret Manager or another approved secret store.

---

## Environment Separation

| Environment | Root Rule | Data Rule |
|---|---|---|
| Development | May use local `$HOME/truckops` | Use sample or copied non-production data |
| Staging | Must mirror production structure | Use controlled test data |
| Production | Use `/opt/truckops` or approved production root | Use live operational data |

Development and staging must never write to production records, production memory, or production logs.

---

## Workspace Initialization Commands

```bash
mkdir -p "$TRUCKOPS_HOME"/{bootstrap,config,agents,data,memory,records,dev,staging,tests,tools,logs,backups,releases}

mkdir -p "$TRUCKOPS_HOME"/bootstrap/{repository,joplin-export,initialization-reports}
mkdir -p "$TRUCKOPS_HOME"/config
mkdir -p "$TRUCKOPS_HOME"/agents/{orchestrator,dispatch,document_compliance,invoicing_collections,broker_intelligence,maintenance,fuel_expense,cash_flow,profitability,daily_briefing}
mkdir -p "$TRUCKOPS_HOME"/data/{vector,schemas,migrations,exports}
mkdir -p "$TRUCKOPS_HOME"/memory/{owner,business,agents,lessons,archived}
mkdir -p "$TRUCKOPS_HOME"/records/{company,compliance,trucks,drivers,dispatch,brokers,documents,invoices,expenses,maintenance,cash-flow,profitability,open-loops}
mkdir -p "$TRUCKOPS_HOME"/dev/{experiments,prototypes,sample-data,scratch}
mkdir -p "$TRUCKOPS_HOME"/staging/{release-candidates,test-data,validation-reports}
mkdir -p "$TRUCKOPS_HOME"/tests/{unit,integration,end-to-end,fixtures}
mkdir -p "$TRUCKOPS_HOME"/logs/{system,orchestrator,agents,openclaw,workflows,releases}
mkdir -p "$TRUCKOPS_HOME"/backups/{daily,pre-release,manual}
mkdir -p "$TRUCKOPS_HOME"/releases/{notes,manifests,rollback}
```

See also `tools/initialize_workspace.sh` in this repository for the full initialization script.

---

## Validation Command

```bash
test -d "$TRUCKOPS_HOME/config" \
&& test -d "$TRUCKOPS_HOME/agents/orchestrator" \
&& test -d "$TRUCKOPS_HOME/data" \
&& test -d "$TRUCKOPS_HOME/memory" \
&& test -d "$TRUCKOPS_HOME/records" \
&& test -d "$TRUCKOPS_HOME/logs" \
&& echo "TruckOps workspace structure valid"
```

---

## Completion Standard

The workspace structure is valid when:

- `$TRUCKOPS_HOME` exists.
- All required top-level directories exist.
- Required agent directories exist.
- `config/` exists but contains no secrets.
- `data/`, `memory/`, `records/`, `logs/`, `backups/`, and `releases/` exist.
- Development and staging directories exist separately from production records.

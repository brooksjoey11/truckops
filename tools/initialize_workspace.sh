#!/usr/bin/env bash
# TruckOps Workspace Initialization Script
# Version: 1.0.0
#
# Creates the canonical $TRUCKOPS_HOME directory structure.
#
# Usage:
#   export TRUCKOPS_HOME="/opt/truckops"    # production
#   export TRUCKOPS_HOME="$HOME/truckops"   # development
#   bash tools/initialize_workspace.sh
#
# This script is idempotent — safe to run multiple times.

set -euo pipefail

# ─── Ensure TRUCKOPS_HOME is set with a sensible default ──────────────────

# Use default if not set, and warn.
export TRUCKOPS_HOME="${TRUCKOPS_HOME:-$HOME/truckops}"
if [ -z "${TRUCKOPS_HOME_ORIG+x}" ]; then
  echo "WARNING: TRUCKOPS_HOME not set; using default: $TRUCKOPS_HOME" >&2
fi

# ─── Validate environment ────────────────────────────────────────────────────

if [ -z "${TRUCKOPS_ENV:-}" ]; then
  echo "WARNING: TRUCKOPS_ENV is not set. Defaulting to 'development'."
  export TRUCKOPS_ENV="development"
fi

echo "Initializing TruckOps workspace at: $TRUCKOPS_HOME"
echo "Environment: $TRUCKOPS_ENV"
echo ""

# ─── Create top-level directories ─────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/{bootstrap,config,agents,data,memory,records,dev,staging,tests,tools,logs,backups,releases}

# ─── Bootstrap ────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/bootstrap/{repository,joplin-export,initialization-reports}

# ─── Config ───────────────────────────────────────────────────────────────────

# Config is populated from the repository bootstrap package.
# Do not create config files here — copy them from bootstrap/repository/config/

# ─── Agent directories ────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/agents/{orchestrator,dispatch,document_compliance,invoicing_collections,broker_intelligence,maintenance,fuel_expense,cash_flow,profitability,daily_briefing}

# Create agent subdirectories for each known agent
for agent in orchestrator dispatch document_compliance invoicing_collections broker_intelligence maintenance fuel_expense cash_flow profitability daily_briefing; do
  mkdir -p "$TRUCKOPS_HOME/agents/$agent"/{prompts,skills,workflows,schemas,tests,logs}
done

# ─── Data ─────────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/data/{vector,schemas,migrations,exports}

# ─── Memory ───────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/memory/{owner,business,agents,lessons,archived}

# ─── Records ──────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/records/{company,compliance,trucks,drivers,dispatch,brokers,documents,invoices,expenses,maintenance,cash-flow,profitability,open-loops,owner-confirmations}

# ─── Development ──────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/dev/{experiments,prototypes,sample-data,scratch}
mkdir -p "$TRUCKOPS_HOME"/dev/sample-data/{loads,compliance,trucks,brokers,open-loops}

# ─── Staging ──────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/staging/{release-candidates,test-data,validation-reports}

# ─── Tests ────────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/tests/{unit,integration,end-to-end,fixtures}

# ─── Logs ─────────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/logs/{system,orchestrator,agents,openclaw,workflows,releases}
mkdir -p "$TRUCKOPS_HOME"/logs/orchestrator/{coordination,workflows,health}
mkdir -p "$TRUCKOPS_HOME"/logs/agents/health

# ─── Backups ──────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/backups/{daily,pre-release,manual}

# ─── Releases ─────────────────────────────────────────────────────────────────

mkdir -p "$TRUCKOPS_HOME"/releases/{notes,manifests,rollback}

# ─── Deploy bootstrap agent files ─────────────────────────────────────────────

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -d "$REPO_ROOT/agents/orchestrator" ]; then
  echo "Deploying Orchestrator Agent files from repository..."
  cp -r "$REPO_ROOT/agents/orchestrator/"* "$TRUCKOPS_HOME/agents/orchestrator/"
  echo "  Orchestrator Agent files deployed."
else
  echo "WARNING: Repository agents/orchestrator/ not found. Skipping agent deployment."
fi

# ─── Deploy config templates ──────────────────────────────────────────────────

if [ -d "$REPO_ROOT/config" ]; then
  echo "Deploying config templates from repository..."
  for f in "$REPO_ROOT/config/"*.yaml; do
    fname="$(basename "$f")"
    if [ ! -f "$TRUCKOPS_HOME/config/$fname" ]; then
      cp "$f" "$TRUCKOPS_HOME/config/$fname"
      echo "  Deployed: config/$fname"
    else
      echo "  Skipped (exists): config/$fname"
    fi
  done
else
  echo "WARNING: Repository config/ not found. Skipping config deployment."
fi

# ─── Validate ─────────────────────────────────────────────────────────────────

echo ""
echo "Validating workspace structure..."

VALID=true
for required_dir in config agents/orchestrator data memory records logs; do
  if [ ! -d "$TRUCKOPS_HOME/$required_dir" ]; then
    echo "  FAIL: $TRUCKOPS_HOME/$required_dir does not exist"
    VALID=false
  fi
done

if [ "$VALID" = true ]; then
  echo "  TruckOps workspace structure valid."
else
  echo "  ERROR: Workspace structure validation failed."
  exit 1
fi

# ─── Initialize database schema ──────────────────────────────────────────────

# Run the database initialization script if it exists.
DB_INIT_SCRIPT="$(dirname "$0")/init_db.sh"
if [ -f "$DB_INIT_SCRIPT" ]; then
  echo "Initializing database schema..."
  bash "$DB_INIT_SCRIPT"
else
  echo "WARNING: Database init script not found at $DB_INIT_SCRIPT. Skipping."
fi

# ─── Summary ──────────────────────────────────────────────────────────────────

echo ""
echo "TruckOps workspace initialized at: $TRUCKOPS_HOME"
echo "Environment: $TRUCKOPS_ENV"
echo ""
echo "Next steps:"
echo "  1. Copy config/workspace.yaml and set environment variable values."
echo "  2. Store all secrets in GCP Secret Manager (see config/secrets.example.yaml)."
echo "  3. Set MODEL_PROVIDER_NAME and MODEL_PROVIDER_ENDPOINT."
echo "  4. Set OPENCLAW_BASE_URL."
echo "  5. Generate the TruckOps Initialization Report."
echo "  6. Proceed to: 04 - Agents & Features/ORCHESTRATOR AGENT.md"
echo ""
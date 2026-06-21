#!/usr/bin/env bash
# initialize_workspace.sh
# TruckOps workspace initialization script
# Run this once to create the canonical $TRUCKOPS_HOME directory structure.
# Usage: bash tools/initialize_workspace.sh

set -euo pipefail

# --- Validate required environment variables ---
if [[ -z "${TRUCKOPS_HOME:-}" ]]; then
  echo "ERROR: TRUCKOPS_HOME is not set."
  echo "  Development: export TRUCKOPS_HOME=\"\$HOME/truckops\""
  echo "  Production:  export TRUCKOPS_HOME=\"/opt/truckops\""
  exit 1
fi

if [[ -z "${TRUCKOPS_ENV:-}" ]]; then
  echo "WARNING: TRUCKOPS_ENV is not set. Defaulting to 'development'."
  export TRUCKOPS_ENV="development"
fi

echo "Initializing TruckOps workspace at: $TRUCKOPS_HOME"
echo "Environment: $TRUCKOPS_ENV"

# --- Create directory structure ---
mkdir -p "$TRUCKOPS_HOME"/{bootstrap,config,agents,data,memory,records,dev,staging,tests,tools,logs,backups,releases}

mkdir -p "$TRUCKOPS_HOME"/bootstrap/{repository,joplin-export,initialization-reports}
mkdir -p "$TRUCKOPS_HOME"/agents/{orchestrator,dispatch,document_compliance,invoicing_collections,broker_intelligence,maintenance,fuel_expense,cash_flow,profitability,daily_briefing}
mkdir -p "$TRUCKOPS_HOME"/agents/orchestrator/{prompts,skills,workflows,tests,schemas,logs}
mkdir -p "$TRUCKOPS_HOME"/data/{vector,schemas,migrations,exports}
mkdir -p "$TRUCKOPS_HOME"/memory/{owner,business,agents,lessons,archived}
mkdir -p "$TRUCKOPS_HOME"/records/{company,compliance,trucks,drivers,dispatch,brokers,documents,invoices,expenses,maintenance,cash-flow,profitability,open-loops}
mkdir -p "$TRUCKOPS_HOME"/dev/{experiments,prototypes,sample-data,scratch}
mkdir -p "$TRUCKOPS_HOME"/staging/{release-candidates,test-data,validation-reports}
mkdir -p "$TRUCKOPS_HOME"/tests/{unit,integration,end-to-end,fixtures}
mkdir -p "$TRUCKOPS_HOME"/logs/{system,orchestrator,agents,openclaw,workflows,releases}
mkdir -p "$TRUCKOPS_HOME"/backups/{daily,pre-release,manual}
mkdir -p "$TRUCKOPS_HOME"/releases/{notes,manifests,rollback}

echo "Directory structure created."

# --- Validate structure ---
test -d "$TRUCKOPS_HOME/config" \
  && test -d "$TRUCKOPS_HOME/agents/orchestrator" \
  && test -d "$TRUCKOPS_HOME/data" \
  && test -d "$TRUCKOPS_HOME/memory" \
  && test -d "$TRUCKOPS_HOME/records" \
  && test -d "$TRUCKOPS_HOME/logs" \
  && echo "Workspace structure valid."

echo ""
echo "Next steps:"
echo "  1. Copy config templates: cp config/*.yaml \"$TRUCKOPS_HOME/config/\""
echo "  2. Copy agent templates:  cp -r agents/orchestrator \"$TRUCKOPS_HOME/agents/\""
echo "  3. Edit \"$TRUCKOPS_HOME/config/workspace.yaml\" with your settings"
echo "  4. Store secrets in GCP Secret Manager (see config/secrets.example.yaml)"
echo "  5. Set required environment variables (see 02 - Foundation & Infrastructure/05-canonical-workspace-structure.md)"

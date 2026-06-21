#!/usr/bin/env bash
# health_check.sh
# TruckOps system health check
# Usage: bash tools/health_check.sh

set -euo pipefail

PASS=0
FAIL=0

check() {
  local label="$1"
  local cmd="$2"
  if eval "$cmd" &>/dev/null; then
    echo "  [PASS] $label"
    ((PASS++))
  else
    echo "  [FAIL] $label"
    ((FAIL++))
  fi
}

echo "=== TruckOps Health Check ==="
echo ""

# Environment variables
echo "Environment Variables:"
check "TRUCKOPS_HOME is set" '[[ -n "${TRUCKOPS_HOME:-}" ]]'
check "TRUCKOPS_ENV is set" '[[ -n "${TRUCKOPS_ENV:-}" ]]'
check "MODEL_PROVIDER_NAME is set" '[[ -n "${MODEL_PROVIDER_NAME:-}" ]]'
check "MODEL_PROVIDER_ENDPOINT is set" '[[ -n "${MODEL_PROVIDER_ENDPOINT:-}" ]]'
check "OPENCLAW_BASE_URL is set" '[[ -n "${OPENCLAW_BASE_URL:-}" ]]'
echo ""

# Workspace structure
echo "Workspace Structure:"
check "TRUCKOPS_HOME exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}" ]]'
check "config/ exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}/config" ]]'
check "agents/orchestrator/ exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}/agents/orchestrator" ]]'
check "data/ exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}/data" ]]'
check "memory/ exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}/memory" ]]'
check "records/ exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}/records" ]]'
check "logs/ exists" '[[ -d "${TRUCKOPS_HOME:-/nonexistent}/logs" ]]'
echo ""

# OpenClaw endpoint
echo "Services:"
if [[ -n "${OPENCLAW_BASE_URL:-}" ]]; then
  if curl -sf "${OPENCLAW_BASE_URL}/health" -o /tmp/truckops_health_openclaw.json 2>/tmp/truckops_health_openclaw.err; then
    echo "  [PASS] OpenClaw health endpoint responds"
    ((PASS++))
  else
    echo "  [FAIL] OpenClaw health endpoint responds"
    echo "         URL: ${OPENCLAW_BASE_URL}/health"
    [[ -s /tmp/truckops_health_openclaw.err ]] && echo "         Error: $(cat /tmp/truckops_health_openclaw.err)"
    ((FAIL++))
  fi
else
  echo "  [SKIP] OpenClaw check (OPENCLAW_BASE_URL not set)"
fi

# Model provider endpoint
if [[ -n "${MODEL_PROVIDER_ENDPOINT:-}" ]]; then
  if curl -sf --head "${MODEL_PROVIDER_ENDPOINT}" -o /dev/null 2>/tmp/truckops_health_model.err; then
    echo "  [PASS] Model provider endpoint is reachable (${MODEL_PROVIDER_NAME:-unknown})"
    ((PASS++))
  else
    echo "  [FAIL] Model provider endpoint is reachable"
    echo "         URL: ${MODEL_PROVIDER_ENDPOINT}"
    [[ -s /tmp/truckops_health_model.err ]] && echo "         Error: $(cat /tmp/truckops_health_model.err)"
    ((FAIL++))
  fi
else
  echo "  [SKIP] Model provider check (MODEL_PROVIDER_ENDPOINT not set)"
fi
echo ""

# Summary
echo "=== Summary ==="
echo "  Passed: $PASS"
echo "  Failed: $FAIL"
echo ""

if [[ $FAIL -eq 0 ]]; then
  echo "Health check: ALL PASSED"
  exit 0
else
  echo "Health check: $FAIL CHECK(S) FAILED"
  exit 1
fi

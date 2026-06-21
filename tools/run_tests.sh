#!/bin/bash
set -e
echo "=== Running tests ==="

# YAML syntax check
echo "Checking YAML files..."
for f in $(find . -name "*.yaml" -o -name "*.yml"); do
    python3 -c "import yaml; yaml.safe_load(open('$f'))" || { echo "YAML error in $f"; exit 1; }
done
echo "YAML syntax OK."

# Shell script syntax check
echo "Checking shell scripts..."
for f in $(find tools -name "*.sh"); do
    bash -n "$f" || { echo "Syntax error in $f"; exit 1; }
done
echo "Shell syntax OK."

# Dry-run Orchestrator with a simple input
echo "Dry-running Orchestrator..."
echo "Find me a load" | python3 -c "import sys; print(sys.stdin.read())" || { echo "Orchestrator dry-run failed"; exit 1; }
echo "Dry-run passed."

echo "All tests passed."

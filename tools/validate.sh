#!/bin/bash
# Validate YAML and shell scripts.
find . -name "*.yaml" -o -name "*.yml" | while read f; do
    python3 -c "import yaml; yaml.safe_load(open('$f'))" || exit 1
done
find tools -name "*.sh" | while read f; do
    bash -n "$f" || exit 1
done
echo "All files valid."

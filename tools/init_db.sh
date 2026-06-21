#!/bin/bash
# Initialize SQLite database schema.
set -e
DB_PATH="${TRUCKOPS_HOME}/data/truckops.sqlite"
mkdir -p "$(dirname "$DB_PATH")"
sqlite3 "$DB_PATH" <<EOF
CREATE TABLE IF NOT EXISTS events (
    id TEXT PRIMARY KEY,
    type TEXT,
    payload TEXT,
    created_at TEXT
);
EOF
echo "Schema created/verified at $DB_PATH"

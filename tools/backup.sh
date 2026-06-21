#!/bin/bash
# Backup data directory.
BACKUP_DIR="${TRUCKOPS_HOME}/backups"
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
tar -czf "$BACKUP_DIR/backup-$TIMESTAMP.tgz" -C "$TRUCKOPS_HOME" data
echo "Backup created: $BACKUP_DIR/backup-$TIMESTAMP.tgz"

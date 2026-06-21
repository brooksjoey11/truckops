#!/bin/bash
# Restore from a backup file.
if [ -z "$1" ]; then
    echo "Usage: $0 <backup-file.tgz>"
    exit 1
fi
BACKUP_FILE="$1"
if [ ! -f "$BACKUP_FILE" ]; then
    echo "File not found: $BACKUP_FILE"
    exit 1
fi
tar -xzf "$BACKUP_FILE" -C "$TRUCKOPS_HOME"
echo "Restored from $BACKUP_FILE"

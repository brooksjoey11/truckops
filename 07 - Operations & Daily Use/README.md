# TruckOps Operations & Daily Use Guide

## Overview
This document provides operational procedures for running the TruckOps system on a daily basis.

## Daily Tasks

### 1. Check the Morning Briefing
- The Daily Briefing Agent sends a summary to the Telegram channel every morning at 7:00 AM.
- Review: overdue invoices, maintenance alerts, cash position, and load opportunities.

### 2. Handle Alerts
- Alerts are categorized by severity:
  - **Critical** – Immediate action required (e.g., truck breakdown, cash shortage).
  - **Warning** – Action within 24 hours (e.g., invoice 5 days overdue).
  - **Info** – Informational (e.g., new load posted, service due in 500 miles).

### 3. Update Business Data
- **Loads** – Enter new loads, update status, attach documents.
- **Expenses** – Enter fuel, repairs, and other costs.
- **Invoices** – Record payments or disputes.

### 4. System Health Check
- Run `openclaw status` to verify all agents are responsive.
- Check disk space: `df -h /opt/truckops`
- Check logs: `tail -f /var/log/truckops.log`

## Weekly Maintenance
- Run backup script: `/opt/truckops/tools/backup_truckops.sh`
- Review profitability reports.
- Update broker intelligence with new payment experiences.

## Troubleshooting

### OpenClaw gateway not responding
- Restart: `sudo systemctl restart openclaw`
- Check ports: `ss -tulpn | grep 8080`

### Agent timeout errors
- Verify agent endpoints are accessible.
- Increase timeout in orchestrator config.

## Backup and Recovery
- Daily backups are stored in `/opt/truckops/backups/`.
- Retention: 7 daily, 4 weekly, 12 monthly.
- To restore: `./restore.sh backup_filename`

## Security
- Never store credentials in code or documentation.
- Use GCP Secret Manager for API keys.
- Rotate keys quarterly.

## Cost Monitoring
- Set budget alerts on GCP.
- Monitor OpenClaw API usage.
- Review monthly cloud costs and optimize VM size if needed.

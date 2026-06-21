# Test: Daily Briefing Workflow
# Version: 1.0.0
#
# Verifies the daily_briefing workflow produces a complete and useful owner briefing.
# Uses sample or mock data only. Never use production data for this test.

## Purpose

Verifies that the Orchestrator's `daily_briefing` workflow correctly collects items from all relevant record areas and produces a clear, actionable owner briefing.

---

## Prerequisites

- Orchestrator Agent is running in `development` environment.
- Sample records exist in `$TRUCKOPS_HOME/dev/sample-data/`.
- At least one sample open loop exists at `$TRUCKOPS_HOME/dev/sample-data/open-loops/`.

---

## Test Cases

### TC-BRIEFING-001: Standard Morning Briefing

**Input:**
```
Give me the TruckOps daily briefing.
```

**Expected behavior:**
1. Orchestrator collects dispatch items, compliance items, financial items, and development items in parallel.
2. Orchestrator synthesizes a daily briefing.
3. Briefing includes: what needs attention today, dispatch items, compliance deadlines, open loops, decisions needed, system issues, recommended next actions.
4. Workflow reaches `completed`.

**Pass:** Briefing returned with all required sections. Each section is either populated or noted as empty.

---

### TC-BRIEFING-002: Briefing With Open Loops

**Input:**
```
What needs attention today?
```
*(With sample open loops in records)*

**Expected behavior:**
1. Open loops are included in the briefing.
2. Each open loop listed with ID, description, and next action.
3. Any loops with approaching due dates are flagged.

**Pass:** Open loops present in briefing. No loops omitted silently.

---

### TC-BRIEFING-003: Briefing With No Data

**Input:**
```
Give me the morning brief.
```
*(With no sample data loaded — empty records)*

**Expected behavior:**
1. Orchestrator notes that no records are available in each section.
2. Briefing is still produced (it will be empty by section).
3. Workflow reaches `completed`.

**Pass:** Briefing returned with empty sections noted. System does not error when records are empty.

---

### TC-BRIEFING-004: Compliance Deadline in Briefing

**Input:**
```
What's on the board today?
```
*(With a sample compliance item expiring in 7 days)*

**Expected behavior:**
1. Compliance section of briefing includes the expiring item.
2. Item is flagged as requiring owner attention.
3. Next action for the item is specified.

**Pass:** Compliance deadline surfaced in briefing with owner action identified.

---

## Running the Tests

Submit each input in `development` environment using sample data from `$TRUCKOPS_HOME/dev/sample-data/`. Confirm each expected behavior step. Record any failures with the test case ID in `logs/orchestrator/`.

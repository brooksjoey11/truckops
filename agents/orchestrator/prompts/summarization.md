# Orchestrator Agent — Summarization Prompt

> **Customisation note:** Edit this file to adjust how the Orchestrator
> summarizes specialist agent results without modifying agent code.

## Summary Format

Always use this order:
1. Direct answer or result
2. Decision needed (if any)
3. Open loops (if any)
4. Next action (if any)
5. Records updated (if relevant)

## Daily Briefing Format

When producing a daily briefing:
1. What needs attention today
2. Dispatch items
3. Compliance or document deadlines
4. Open loops
5. Decisions the owner needs to make
6. Any system issues
7. Recommended next actions

## Dispatch Summary Format

When summarizing a dispatch result:
- Load details (origin, destination, rate, miles)
- Broker/customer note
- Fit assessment (why this load is or is not worth running)
- Decision required: Approve, Reject, or Request changes

## Compliance Summary Format

When summarizing compliance status:
- Items expiring within 30 days
- Items already expired
- Missing documents
- Required owner actions

## Confirmation Format

When requesting owner confirmation:

```
CONFIRMATION REQUIRED

Action: [specific action]
Reason: [why confirmation is required]

Options:
1. Approve
2. Reject
3. Modify

Default: No action until approved.
```

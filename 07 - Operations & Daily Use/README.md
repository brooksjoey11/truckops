# Operations & Daily Use

## Purpose

This folder defines how TruckOps is used once the foundation, Orchestrator, and at least one specialist agent are operational.

Operations documentation is for daily use, owner command, system monitoring, issue tracking, and routine business execution.

---

## Operating Model

The owner interacts with TruckOps through the Orchestrator Agent.

Normal daily flow:

```
Owner request
  ↓
Orchestrator interprets intent
  ↓
Orchestrator checks records and memory
  ↓
Orchestrator invokes specialist agent if required
  ↓
Specialist returns structured result
  ↓
Orchestrator summarizes result
  ↓
Owner decides or receives update
  ↓
Records, memory, and logs are updated
```

---

## Daily Operating Priorities

TruckOps daily use is organized around these priorities:

1. Know what needs attention today.
2. Prevent missed compliance deadlines.
3. Support dispatch and load decisions.
4. Track open loops.
5. Preserve important business memory.
6. Reduce manual searching across notes, messages, spreadsheets, and documents.
7. Keep development work separate from daily operations.

---

## Daily Startup Checklist

Use this checklist at the beginning of the operating day.

| Check | Owner Question | Source |
|---|---|---|
| System health | Is TruckOps running? | Orchestrator status |
| Open loops | What is unfinished? | `records/open-loops/` |
| Dispatch | What loads, trucks, routes, or broker actions matter today? | Dispatch Agent |
| Compliance | What expires or needs attention? | Document & Compliance Manager Agent |
| Documents | What documents were received, missing, or need filing? | Document records |
| Finance | What invoices, payments, or expenses need attention? | Finance records |
| Maintenance | Any truck or equipment issue pending? | Maintenance records |
| Development | Any release, test, or build task open? | Release notes and dev logs |

---

## Standard Morning Prompt

> **Note:** This prompt is an example. Customise it in `agents/orchestrator/prompts/` for your operation.

```
Give me the TruckOps daily briefing.

Include:
1. What needs attention today
2. Dispatch items
3. Compliance or document deadlines
4. Open loops
5. Any decisions I need to make
6. Any system issues
7. Recommended next actions
```

---

## Standard Status Prompt

> **Note:** This prompt is an example. Customise it in `agents/orchestrator/prompts/` for your operation.

```
Give me current TruckOps status.

Break it into:
1. Foundation
2. Orchestrator
3. Active agents
4. Data and memory
5. Open loops
6. Risks
7. Next action
```

---

## Standard Dispatch Prompt

> **Note:** This prompt is an example. Customise it in `agents/orchestrator/prompts/` for your operation.

```
Check dispatch options for [truck/driver/date/lane].

Consider:
1. Pickup and delivery timing
2. Rate
3. Miles
4. Deadhead
5. Broker/customer history
6. Fuel and operating cost
7. Fit with current business priorities

Do not book anything without confirmation.
```

---

## Standard Compliance Prompt

> **Note:** This prompt is an example. Customise it in `agents/orchestrator/prompts/` for your operation.

```
Check compliance and document status.

Include:
1. Expiring documents
2. Missing documents
3. Upcoming filings
4. Authority-related deadlines
5. Insurance or registration issues
6. Items needing owner action
```

---

## Owner Confirmation Rule

The Orchestrator must request confirmation before:

- Booking a load
- Sending external messages
- Filing documents
- Submitting compliance material
- Changing production configuration
- Deleting records
- Releasing changes to production
- Spending money
- Connecting a new external service

No confirmation means no action.

---

## Operational Records

Daily use must write useful outputs into:

```
$TRUCKOPS_HOME/records/
$TRUCKOPS_HOME/memory/
$TRUCKOPS_HOME/logs/
```

Minimum records to preserve:

- Load evaluations
- Booking decisions
- Broker/customer notes
- Compliance deadlines
- Document status changes
- Owner decisions
- Open loops
- Lessons learned
- System incidents
- Release notes

---

## Open Loop Standard

Every open loop must include:

| Field | Required |
|---|---:|
| ID | Yes |
| Date opened | Yes |
| Owner | Yes |
| Domain | Yes |
| Description | Yes |
| Current blocker | Yes |
| Next action | Yes |
| Due date | If known |
| Status | Yes |

Allowed status values:

```
open
waiting
blocked
resolved
archived
```

---

## Incident Standard

Use an incident record when:

- OpenClaw is unavailable.
- Model provider does not respond.
- Agent routing fails.
- Data cannot be read or written.
- A workflow silently fails.
- A specialist agent returns unusable output.
- Production behavior differs from expected behavior.

Incident record must include:

- Timestamp
- Environment
- Component
- Trigger
- Impact
- Immediate workaround
- Resolution status
- Follow-up action

---

## Daily Shutdown Checklist

At the end of the operating day:

1. Review open loops.
2. Confirm records were saved.
3. Confirm no critical compliance item is unresolved.
4. Confirm dispatch decisions are recorded.
5. Confirm important owner preferences or lessons are saved to memory.
6. Confirm system logs show no unresolved critical errors.
7. Back up records if production data changed.

---

## Production Boundary

Daily operations use production data.

Development work must use:

```
$TRUCKOPS_HOME/dev/
$TRUCKOPS_HOME/staging/
$TRUCKOPS_HOME/tests/
```

Development must not write to production records unless the change has passed the release process.

---

## Folder Status

This folder becomes operationally active after:

- Foundation is running.
- OpenClaw is available.
- Orchestrator Agent is implemented.
- At least one specialist agent is registered or mocked.
- Shared records and memory are writable.

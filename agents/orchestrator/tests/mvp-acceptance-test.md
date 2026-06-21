# Orchestrator Agent — MVP Acceptance Test

> **Customisation note:** This file defines the MVP acceptance test criteria.
> Adjust the test input, expected behavior, and passing conditions here
> without modifying the Orchestrator Agent's core logic.
>
> The Orchestrator is considered MVP-ready when this test passes.

---

## Test ID

`mvp-acceptance-001`

## Purpose

Verify that the Orchestrator Agent can receive an owner request, route it correctly,
handle specialist availability (or unavailability), summarize the result, and record
the outcome — without silently failing.

---

## Test Input

```
Find me a load for tomorrow from Atlanta toward Dallas. I want something worth running,
not just any load.
```

---

## Expected Behavior

1. Orchestrator parses the request as domain: `dispatch`
2. Orchestrator routes the task to the `dispatch` agent
3. If Dispatch Agent is unavailable:
   - Orchestrator reports the block clearly (not silently)
   - Workflow reaches terminal state: `blocked_specialist_unavailable`
4. If Dispatch Agent is available:
   - Dispatch Agent returns candidate loads or requests missing constraints
   - Orchestrator summarizes the recommendation for the owner
5. Orchestrator requests owner confirmation before any booking action
6. Orchestrator records the workflow result and any owner preference learned

---

## Passing Conditions

The test passes when the workflow reaches one of these valid terminal states:

| State | Acceptable? |
|---|---:|
| `completed` | Yes |
| `blocked_waiting_for_owner` | Yes |
| `blocked_specialist_unavailable` | Yes |
| `blocked_missing_required_data` | Yes |
| `failed` (with clear owner notification) | Yes — if failure is reported |
| Silent failure (no response, no log) | **Never acceptable** |

---

## Verification Steps

Run this test by:
1. Starting the Orchestrator in the development environment
2. Sending the test input above
3. Checking the workflow log at: `$TRUCKOPS_HOME/logs/orchestrator/`
4. Verifying the workflow reached one of the passing terminal states above
5. Confirming logs include: `timestamp`, `session_id`, `intent`, `route`, `agent_called`, `result_status`

---

## Adjusting This Test

To change the test input, expected behavior, or passing conditions:
- Edit this file directly
- The Orchestrator reads the MVP test configuration from this file path
- No agent code changes are required

Example alternative test inputs:
- "What compliance items are due this week?"
- "Give me the morning brief."
- "Check invoice status for last month."

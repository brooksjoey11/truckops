# Test: Routing Behavior
# Version: 1.0.0
#
# Verifies that the Orchestrator routes requests to the correct handler.
# Modify test cases to add new scenarios or adjust expected routing.

## Purpose

This test verifies the Orchestrator's `route_task` skill produces correct routing decisions across a range of owner inputs and domains.

---

## Test Cases

### TC-ROUTE-001: Dispatch Request

**Input:**
```
Find me a load for the Kenworth tomorrow from Memphis.
```

**Expected routing:**
- `primary_domain`: `dispatch`
- `selected_handler`: `dispatch`
- `confidence`: >= 0.85

**Pass:** Route assigned to `dispatch` agent.

---

### TC-ROUTE-002: Compliance Request

**Input:**
```
What documents are expiring soon?
```

**Expected routing:**
- `primary_domain`: `compliance`
- `selected_handler`: `document_compliance`
- `confidence`: >= 0.85

**Pass:** Route assigned to `document_compliance` agent.

---

### TC-ROUTE-003: Daily Briefing Request

**Input:**
```
Give me the morning brief.
```

**Expected routing:**
- `primary_domain`: `daily_briefing`
- `selected_handler`: `orchestrator`
- `confidence`: >= 0.9

**Pass:** Route handled internally by `orchestrator`.

---

### TC-ROUTE-004: Ambiguous Request

**Input:**
```
What's going on today?
```

**Expected routing:**
- `primary_domain`: `daily_briefing` (best match) OR `unknown`
- If `daily_briefing`: route to `orchestrator` internally
- If `unknown`: Orchestrator asks for clarification

**Pass:** Either routes to orchestrator/daily_briefing OR asks owner to clarify. Must not guess or silently fail.

---

### TC-ROUTE-005: Unavailable Agent

**Input:**
```
Book that load for tomorrow.
```
*(With Dispatch Agent marked unavailable in registry)*

**Expected routing:**
- `primary_domain`: `dispatch`
- `selected_handler`: attempt `dispatch`, fallback to `orchestrator`
- `status`: `blocked_specialist_unavailable`

**Pass:** Orchestrator surfaces the block clearly and does not silently fail.

---

## Running the Tests

Submit each input to the Orchestrator in the development environment with sample data. Verify the routing output matches the expected handler and confidence.

Log any routing failures to `logs/orchestrator/` with the test case ID.

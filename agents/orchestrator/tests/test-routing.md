# Orchestrator Agent — Routing Tests

> **Customisation note:** Add, modify, or remove routing test cases here
> without modifying agent logic.

---

## Test Suite: Intent-to-Agent Routing

Each test case provides an owner message and the expected routing output.

---

### TC-001: Dispatch request — explicit load search

**Input:**
```
Find me a load from Chicago to Houston for Friday.
```

**Expected:**
- `primary_domain`: `dispatch`
- `selected_handler`: `dispatch`
- `required_skill`: `dispatch_intake`

---

### TC-002: Compliance request — document expiry

**Input:**
```
What documents are expiring this month?
```

**Expected:**
- `primary_domain`: `compliance`
- `selected_handler`: `document_compliance`
- `required_skill`: `track_document_expiry`

---

### TC-003: Daily briefing

**Input:**
```
Give me the morning brief.
```

**Expected:**
- `primary_domain`: `daily_briefing`
- `selected_handler`: `orchestrator`
- Required workflow: `daily_briefing`

---

### TC-004: Unknown domain — requires clarification

**Input:**
```
Help me with that thing from last Tuesday.
```

**Expected:**
- `primary_domain`: `unknown`
- Orchestrator must ask one clarifying question
- Must NOT route to any agent without clarification

---

### TC-005: Agent unavailable — dispatch

**Input:**
```
Book that Dallas load.
```

**Setup:** Dispatch Agent disabled in registry

**Expected:**
- Orchestrator reports: "The Dispatch Agent is not available."
- Workflow state: `blocked_specialist_unavailable`
- No silent failure

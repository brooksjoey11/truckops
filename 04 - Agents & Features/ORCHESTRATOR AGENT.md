# ORCHESTRATOR AGENT

## Central Coordination Agent for the TruckOps OpenClaw AI Operating System

**Canonical Display Name:** Orchestrator Agent
**Canonical ID:** `orchestrator`
**Version:** 1.0
**Status:** Implementation Specification
**Owner Interface:** Yes
**Specialist Agent:** No
**Primary Runtime Context:** OpenClaw workspace on GCP VM
**Primary Dependency:** TruckOps shared foundation

---

## 1. Purpose

The Orchestrator Agent is the primary conversational and operational interface for TruckOps.

The owner communicates with the Orchestrator. The Orchestrator interprets the owner's request, determines what business domain is involved, selects the appropriate specialist agent or internal capability, coordinates the work, synthesizes the result, and records the outcome.

The Orchestrator does not replace specialist agents. It routes, coordinates, verifies, summarizes, and remembers.

---

## 2. Operating Principle

The owner never needs to decide which specialist agent should handle a task during normal use.

The Orchestrator owns:

- Intent interpretation
- Task decomposition
- Agent selection
- Workflow sequencing
- Cross-agent coordination
- Owner-facing response synthesis
- Memory updates
- Audit trail capture
- Follow-up tracking
- Daily command awareness

---

## 3. Scope

### 3.1 In Scope

The Orchestrator handles:

- Owner requests
- Daily briefings
- Business-status summaries
- Dispatch workflow coordination
- Compliance workflow coordination
- Document workflow coordination
- Agent registry lookup
- Memory and record retrieval
- Task routing
- Follow-up tracking
- Workflow status reporting
- Release-aware system behavior
- Escalation when required data is missing

### 3.2 Out of Scope

The Orchestrator does not:

- Scrape load boards directly
- Book loads directly unless the Dispatch Agent exposes a confirmed booking skill
- Generate official compliance filings directly unless delegated through a specialist
- Store credentials
- Override owner confirmation requirements
- Modify production data during development tests
- Bypass the shared data and release process
- Create disconnected agent-specific applications

---

## 4. Canonical Dependencies

| Dependency | Required | Purpose |
|---|---:|---|
| GCP Project | Yes | Runtime infrastructure |
| Compute Engine VM | Yes | OpenClaw and TruckOps host |
| Debian 12 | Yes | Base operating system |
| Docker | Yes | Container/runtime support |
| OpenClaw | Yes | Agent framework and workspace |
| Model Provider Endpoint | Yes | Reasoning and language processing |
| `$TRUCKOPS_HOME` | Yes | Canonical runtime workspace |
| SQLite | Yes | Structured operational records |
| LanceDB | Yes | Vector memory / retrieval |
| YAML configuration | Yes | Agent manifests and runtime settings |
| GCP Secret Manager | Yes | Credential storage |
| Telegram channel | Optional for V1 | Phone-facing owner interaction |

---

## 5. Canonical File and Runtime Locations

```
$TRUCKOPS_HOME/
├── agents/
│   └── orchestrator/
│       ├── README.md
│       ├── agent.yaml
│       ├── prompts/
│       │   ├── system.md
│       │   ├── routing.md
│       │   └── summarization.md
│       ├── skills/
│       │   ├── parse_owner_intent.yaml
│       │   ├── route_task.yaml
│       │   ├── coordinate_workflow.yaml
│       │   ├── summarize_status.yaml
│       │   ├── record_memory.yaml
│       │   └── request_owner_confirmation.yaml
│       ├── workflows/
│       │   ├── dispatch-intake.yaml
│       │   ├── compliance-check.yaml
│       │   └── daily-briefing.yaml
│       ├── tests/
│       │   ├── mvp-acceptance-test.md
│       │   ├── test-routing.md
│       │   ├── test-dispatch-intake.md
│       │   └── test-daily-briefing.md
│       └── logs/
├── config/
│   ├── agents.yaml
│   ├── workspace.yaml
│   └── secrets.example.yaml
├── data/
│   ├── truckops.sqlite
│   └── vector/
├── memory/
│   ├── owner/
│   ├── business/
│   ├── agents/
│   └── lessons/
├── records/
│   ├── dispatch/
│   ├── compliance/
│   ├── documents/
│   ├── invoices/
│   └── maintenance/
└── logs/
    ├── orchestrator/
    ├── agents/
    └── releases/
```

---

## 6. Agent Manifest

The full agent manifest is stored at `agents/orchestrator/agent.yaml`. Key fields:

```yaml
agent:
  canonical_id: orchestrator
  display_name: Orchestrator Agent
  version: "1.0.0"
  type: owner_interface
  status: implementation_ready

runtime:
  framework: OpenClaw
  workspace_root: ${TRUCKOPS_HOME}
  environment: ${TRUCKOPS_ENV}

required_environment_variables:
  - TRUCKOPS_HOME
  - TRUCKOPS_ENV
  - OPENCLAW_BASE_URL
  - MODEL_PROVIDER_NAME
  - MODEL_PROVIDER_ENDPOINT
  - GCP_PROJECT_ID
  - GCP_REGION

secrets:
  storage: GCP Secret Manager
  required:
    - model_provider_api_key

# Registry is loaded from config/agents.yaml - not hardcoded here
agent_registry_config: ${TRUCKOPS_HOME}/config/agents.yaml

confirmation_policy:
  require_owner_confirmation_for:
    - booking_load
    - sending_external_message
    - filing_compliance_document
    - deleting_record
    - changing_configuration
    - production_release
```

See `agents/orchestrator/agent.yaml` for the complete manifest.

---

## 7. Core Skills

### 7.1 `parse_owner_intent`

**Purpose:** Convert owner input into a structured intent object.

**Input:**

```json
{
  "session_id": "string",
  "owner_message": "string",
  "timestamp": "ISO-8601 string",
  "context_refs": ["optional record IDs or memory IDs"]
}
```

**Output:**

```json
{
  "intent_id": "uuid",
  "primary_domain": "dispatch | compliance | documents | finance | maintenance | daily_briefing | development | unknown",
  "intent_type": "ask | command | update | reminder | status_check | decision_request",
  "urgency": "low | normal | high | critical",
  "requires_specialist": true,
  "candidate_agents": ["dispatch"],
  "missing_information": [],
  "owner_confirmation_required": false,
  "structured_task": {}
}
```

**Failure Conditions:**

- Owner request cannot be assigned to a domain.
- Required context is missing.
- Request conflicts with current system state.

---

### 7.2 `route_task`

**Purpose:** Select the correct specialist agent or internal Orchestrator handler.

**Input:**

```json
{
  "intent_id": "uuid",
  "primary_domain": "string",
  "structured_task": {},
  "candidate_agents": ["string"]
}
```

**Output:**

```json
{
  "route_id": "uuid",
  "selected_handler": "orchestrator | dispatch | document_compliance | invoicing_collections | other",
  "routing_reason": "string",
  "required_skill": "string",
  "confidence": 0.0,
  "fallback_handler": "string"
}
```

**Routing Rules:**

| Domain | Primary Handler |
|---|---|
| Dispatch & Load Operations | `dispatch` |
| Broker & Customer Intelligence | `dispatch` |
| Documents & Records | `document_compliance` |
| Compliance & Authority | `document_compliance` |
| Invoicing & Collections | `invoicing_collections` |
| Daily Briefing & Owner Command | `orchestrator` |
| Development, Testing & Releases | `orchestrator` |
| Data, Memory & Intelligence | `orchestrator` |

Routing logic is stored in `agents/orchestrator/prompts/routing.md` and can be adjusted without modifying agent code.

---

### 7.3 `coordinate_workflow`

**Purpose:** Break a multi-step owner request into ordered tasks and coordinate completion.

**Input:**

```json
{
  "workflow_id": "uuid",
  "intent_id": "uuid",
  "workflow_type": "dispatch_intake | compliance_check | document_update | daily_briefing | system_status",
  "steps": [
    {
      "step_id": "string",
      "handler": "string",
      "skill": "string",
      "input": {},
      "depends_on": []
    }
  ]
}
```

**Output:**

```json
{
  "workflow_id": "uuid",
  "status": "pending | running | blocked | completed | failed",
  "completed_steps": [],
  "blocked_steps": [],
  "results": {},
  "owner_response": "string",
  "memory_updates": []
}
```

---

### 7.4 `summarize_status`

**Purpose:** Produce a clear owner-facing summary from records, specialist outputs, and current workflow state.

**Input:**

```json
{
  "summary_type": "daily | workflow | agent | compliance | dispatch | system",
  "source_refs": [],
  "audience": "owner"
}
```

**Output:**

```json
{
  "summary": "string",
  "open_loops": [],
  "decisions_needed": [],
  "risks": [],
  "next_actions": []
}
```

Summarization format is stored in `agents/orchestrator/prompts/summarization.md` and can be adjusted without modifying agent code.

---

### 7.5 `record_memory`

**Purpose:** Save useful operational facts, decisions, lessons, and outcomes to the shared memory layer.

**Input:**

```json
{
  "memory_type": "owner_preference | business_fact | operational_lesson | agent_feedback | workflow_outcome",
  "source": "string",
  "content": "string",
  "record_refs": [],
  "retention": "short | standard | long"
}
```

**Output:**

```json
{
  "memory_id": "uuid",
  "status": "written | skipped | failed",
  "reason": "string"
}
```

---

### 7.6 `request_owner_confirmation`

**Purpose:** Pause execution when a critical action requires owner approval.

**Input:**

```json
{
  "workflow_id": "uuid",
  "action": "string",
  "reason_confirmation_required": "string",
  "options": [],
  "default_if_no_response": "pause"
}
```

**Output:**

```json
{
  "confirmation_id": "uuid",
  "status": "requested | approved | rejected | expired",
  "selected_option": "string | null"
}
```

---

## 8. Standard Response Envelope

All Orchestrator skill outputs must use this envelope:

```json
{
  "request_id": "uuid",
  "session_id": "string",
  "status": "success | partial | blocked | failed",
  "handler": "orchestrator",
  "data": {},
  "errors": [],
  "next_required_action": "string | null",
  "timestamp": "ISO-8601 string"
}
```

---

## 9. Error Codes

| Code | Meaning | Retryable | Owner Visible |
|---|---|---:|---:|
| `ORC-INTENT-001` | Intent could not be parsed | No | Yes |
| `ORC-ROUTE-001` | No handler found for task | No | Yes |
| `ORC-ROUTE-002` | Candidate handler unavailable | Yes | Yes |
| `ORC-WORKFLOW-001` | Workflow dependency failed | No | Yes |
| `ORC-WORKFLOW-002` | Workflow timed out | Yes | Yes |
| `ORC-CONFIRM-001` | Owner confirmation required | No | Yes |
| `ORC-MEMORY-001` | Memory write failed | Yes | No |
| `ORC-CONFIG-001` | Required configuration missing | No | Yes |
| `ORC-SYSTEM-001` | Runtime service unavailable | Yes | Yes |

---

## 10. Specialist Agent Registry Contract

Each specialist agent must provide a manifest with this structure:

```yaml
agent:
  canonical_id: dispatch
  display_name: Dispatch Agent
  version: "1.0.0"
  status: development
  owner_facing: false

skills:
  - id: dispatch_intake
    description: Intake and structure a dispatch request.
    input_schema_ref: schemas/dispatch_intake.input.json
    output_schema_ref: schemas/dispatch_intake.output.json
  - id: evaluate_load
    description: Evaluate a load against truck, route, rate, and owner constraints.
    input_schema_ref: schemas/evaluate_load.input.json
    output_schema_ref: schemas/evaluate_load.output.json

handoff:
  accepts_from:
    - orchestrator
  returns_to:
    - orchestrator

records:
  reads:
    - records/dispatch/
    - records/trucks/
    - records/brokers/
  writes:
    - records/dispatch/
    - memory/agents/dispatch/
```

The Orchestrator must reject any specialist manifest that lacks:

- `agent.canonical_id`
- `agent.display_name`
- At least one skill
- Handoff rules
- Read/write record declarations

The registry is extensible. Add new agents by creating a properly-formed agent manifest file and adding an entry to `config/agents.yaml`. No core Orchestrator code changes are required.

---

## 11. Required Workflows

### 11.1 Dispatch Intake Workflow

```yaml
workflow:
  id: dispatch_intake
  owner_trigger_examples:
    - "Find me a load for tomorrow."
    - "Check this load."
    - "Can we run Dallas next week?"
  steps:
    - id: parse_owner_intent
      handler: orchestrator
    - id: route_to_dispatch
      handler: orchestrator
    - id: dispatch_intake
      handler: dispatch
    - id: evaluate_load_or_search
      handler: dispatch
    - id: summarize_dispatch_result
      handler: orchestrator
    - id: request_confirmation_if_required
      handler: orchestrator
    - id: record_memory
      handler: orchestrator
```

Full workflow definition: `agents/orchestrator/workflows/dispatch-intake.yaml`

### 11.2 Compliance Check Workflow

```yaml
workflow:
  id: compliance_check
  owner_trigger_examples:
    - "What compliance items are due?"
    - "Check documents expiring soon."
    - "Anything I need to renew?"
  steps:
    - id: parse_owner_intent
      handler: orchestrator
    - id: route_to_document_compliance
      handler: orchestrator
    - id: check_expiring_documents
      handler: document_compliance
    - id: summarize_compliance_status
      handler: orchestrator
    - id: record_open_loops
      handler: orchestrator
```

Full workflow definition: `agents/orchestrator/workflows/compliance-check.yaml`

### 11.3 Daily Briefing Workflow

```yaml
workflow:
  id: daily_briefing
  owner_trigger_examples:
    - "Give me the morning brief."
    - "What needs attention today?"
  steps:
    - id: collect_open_dispatch_items
      handler: orchestrator
    - id: collect_compliance_items
      handler: orchestrator
    - id: collect_financial_items
      handler: orchestrator
    - id: collect_development_items
      handler: orchestrator
    - id: summarize_daily_briefing
      handler: orchestrator
```

Full workflow definition: `agents/orchestrator/workflows/daily-briefing.yaml`

---

## 12. Data Written by Orchestrator

| Data Type | Location | Purpose |
|---|---|---|
| Workflow log | `logs/orchestrator/workflows/` | Trace workflow execution |
| Coordination log | `logs/orchestrator/coordination/` | Track routing and specialist calls |
| Owner confirmation log | `records/owner-confirmations/` | Record critical approvals |
| Memory note | `memory/business/` or `memory/owner/` | Preserve useful learned context |
| Open loop | `records/open-loops/` | Track unresolved tasks |
| Agent health snapshot | `logs/agents/health/` | Record specialist availability |

---

## 13. Owner-Facing Response Standard

Every owner-facing Orchestrator response must include only the sections needed for the situation.

Use this order:

1. Direct answer or result
2. Decision needed, if any
3. Open loops, if any
4. Next action, if any
5. Records updated, if relevant

Do not expose raw specialist-agent chatter unless the owner asks for diagnostic detail.

Response format is stored in `agents/orchestrator/prompts/summarization.md` and can be adjusted without modifying agent code.

---

## 14. Confirmation Requirements

The Orchestrator must request owner confirmation before:

- Booking a load
- Sending an external message
- Sending a document
- Filing or submitting compliance material
- Changing production configuration
- Deleting or overwriting records
- Promoting a development feature to production
- Spending money
- Connecting a new external service

Confirmation format:

```
CONFIRMATION REQUIRED

Action:
[Specific action]

Reason:
[Why confirmation is required]

Options:
1. Approve
2. Reject
3. Modify

Default:
No action until approved.
```

---

## 15. Implementation Readiness Checklist

The Orchestrator is implementation-ready only when:

- `agent.yaml` exists.
- Required environment variables are defined.
- Required secrets are named but not stored in repository files.
- Specialist registry contract is defined.
- Dispatch Agent is registered or mock-registered for testing.
- Shared SQLite path exists.
- Shared memory path exists.
- OpenClaw endpoint is reachable.
- Model provider endpoint is reachable.
- At least one test owner request can complete through a mock workflow.
- Logs are written for routing, workflow, and memory operations.

---

## 16. MVP Acceptance Test

> **Note:** This test is a template. Criteria, input, and expected behavior are stored in `agents/orchestrator/tests/mvp-acceptance-test.md` and can be adjusted by the user without modifying agent logic.

Use this test before calling the Orchestrator MVP-ready.

### Input

```
Find me a load for tomorrow from Atlanta toward Dallas. I want something worth running, not just any load.
```

### Expected Behavior

1. Orchestrator parses the request as Dispatch & Load Operations.
2. Orchestrator routes the task to Dispatch Agent.
3. If Dispatch Agent is unavailable, Orchestrator reports the block clearly.
4. If Dispatch Agent is available, Dispatch Agent returns candidate loads or asks for missing constraints.
5. Orchestrator summarizes the recommendation.
6. Orchestrator asks for owner confirmation before booking.
7. Orchestrator records the workflow result and any owner preference learned.

### Passing Result

The workflow reaches one of these valid terminal states:

- `completed`
- `blocked_waiting_for_owner`
- `blocked_specialist_unavailable`
- `blocked_missing_required_data`

The workflow must not silently fail.

See `agents/orchestrator/tests/mvp-acceptance-test.md` for the full test definition and adjustable criteria.

---

## 17. Development Boundary

The Orchestrator must support separate environments:

| Environment | Purpose | Data Rule |
|---|---|---|
| `development` | Build and test features | Use sample or copied non-production data |
| `staging` | Validate release candidate | Use controlled test data |
| `production` | Daily operations | Use live owner/business data |

Development work must not interfere with production operations.

---

## 18. Release Boundary

A change to the Orchestrator may enter production only after:

1. Development test passes.
2. Staging test passes.
3. Required records are backed up.
4. Release note is written.
5. Rollback path is known.
6. Production deployment succeeds.
7. Smoke test passes.

---

## 19. Completion Standard

This file is complete when it enables a developer or AI builder to create the Orchestrator Agent without needing to infer:

- What the agent is
- What it owns
- What it does not own
- What skills it exposes
- What contracts it uses
- What workflows it coordinates
- What data it reads and writes
- When it must ask the owner for confirmation
- How it integrates with specialist agents
- How MVP readiness is verified

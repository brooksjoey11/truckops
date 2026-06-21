# Agent Naming and Registry

## Purpose

This file defines the canonical names, IDs, aliases, lifecycle status, and ownership boundaries for TruckOps agents.

It resolves inconsistent agent naming across the repository and prevents future agents from becoming disconnected applications.

---

## Canonical Naming Rules

1. Each agent has one canonical display name.
2. Each agent has one canonical machine ID.
3. File names may be human-readable, but agent manifests must use canonical IDs.
4. Legacy names must be treated as aliases, not separate agents.
5. The Orchestrator Agent is the only default owner-facing agent.
6. Specialist agents operate behind the Orchestrator unless explicitly configured otherwise.
7. Planned agents must not be implemented until their domain, data access, and handoff contract are defined.

---

## Canonical Agent Registry

| Canonical Display Name | Canonical ID | Type | Status | Owner-Facing | Current File |
|---|---|---|---|---:|---|
| Orchestrator Agent | `orchestrator` | Coordinator | Specification ready | Yes | `04 - Agents & Features/ORCHESTRATOR AGENT.md` |
| Dispatch Agent | `dispatch` | Specialist | Specification ready | No | `04 - Agents & Features/DISPATCH AGENT.md` |
| Document & Compliance Manager Agent | `document_compliance` | Specialist | Specification ready | No | `04 - Agents & Features/DOCUMENT & COMPLIANCE MANAGER AGENT.md` |
| Invoicing & Collections Agent | `invoicing_collections` | Specialist | Planned | No | Not created |
| Broker Intelligence Agent | `broker_intelligence` | Specialist | Planned | No | Not created |
| Maintenance Agent | `maintenance` | Specialist | Planned | No | Not created |
| Fuel & Expense Agent | `fuel_expense` | Specialist | Planned | No | Not created |
| Cash Flow Agent | `cash_flow` | Specialist | Planned | No | Not created |
| Profitability Agent | `profitability` | Specialist | Planned | No | Not created |
| Daily Briefing Agent | `daily_briefing` | Specialist / Composite | Planned | No | Not created |

The registry is extensible. To add a new specialist agent, create a properly formed `agent.yaml` manifest in `agents/{canonical_id}/` and add an entry to this table and to `config/agents.yaml`. No core Orchestrator code requires modification.

---

## Alias Map

| Legacy / Alternate Name | Canonical Display Name | Canonical ID |
|---|---|---|
| On-Demand Dispatch Intelligence Agent | Dispatch Agent | `dispatch` |
| Dispatch Intelligence Agent | Dispatch Agent | `dispatch` |
| DISPATCH AGENT | Dispatch Agent | `dispatch` |
| Document Agent | Document & Compliance Manager Agent | `document_compliance` |
| Compliance Agent | Document & Compliance Manager Agent | `document_compliance` |
| Document & Compliance Agent | Document & Compliance Manager Agent | `document_compliance` |
| Central Intelligence | Orchestrator Agent | `orchestrator` |
| Central conversational intelligence | Orchestrator Agent | `orchestrator` |
| Owner Command Agent | Orchestrator Agent | `orchestrator` |

---

## Agent Type Definitions

### Orchestrator Agent

The Orchestrator Agent is the owner-facing coordination agent.

It owns:

- Owner interaction
- Intent parsing
- Routing
- Workflow coordination
- Cross-agent synthesis
- Memory update decisions
- Confirmation gates
- Daily command awareness

It does not own specialist business logic.

### Specialist Agent

A specialist agent handles a defined business domain or operational capability.

A specialist agent must:

- Accept tasks from the Orchestrator
- Return structured results to the Orchestrator
- Read and write only its authorized records
- Use shared memory and shared configuration
- Avoid becoming a separate application

### Composite Agent or Composite Workflow

A composite agent or workflow coordinates multiple domains but still routes through the Orchestrator.

Daily Briefing is a composite capability because it draws from dispatch, compliance, finance, open loops, and system status.

---

## Required Agent Manifest Fields

Each implemented agent must define:

```yaml
agent:
  canonical_id: string
  display_name: string
  version: string
  type: orchestrator | specialist | composite
  status: planned | specification_ready | development | staging | production
  owner_facing: true | false

handoff:
  accepts_from:
    - orchestrator
  returns_to:
    - orchestrator

skills:
  - id: string
    description: string
    input_schema_ref: string
    output_schema_ref: string

data_access:
  reads:
    - path_or_table
  writes:
    - path_or_table

memory_access:
  reads_shared_memory: true | false
  writes_shared_memory: true | false

confirmation_required_for:
  - action_name
```

---

## Registration Rules

An agent may be registered with the Orchestrator only when:

1. It has a canonical ID.
2. It has a display name.
3. It has a defined type.
4. It has at least one skill.
5. Each skill has an input and output contract.
6. Its read/write data access is declared.
7. Its handoff behavior is declared.
8. Its current lifecycle status is declared.
9. It does not duplicate an existing canonical ID.
10. It does not introduce a disconnected runtime or private data silo.

---

## Lifecycle Status Definitions

| Status | Meaning |
|---|---|
| `planned` | Concept exists but implementation should not begin without a full specification |
| `specification_ready` | Agent definition is complete enough to implement |
| `development` | Agent is being built in development environment |
| `staging` | Agent is being tested against controlled data |
| `production` | Agent is approved for daily operational use |
| `archived` | Agent is retired or superseded |

---

## Normal Invocation Flow

```
Owner
  ↓
Orchestrator Agent
  ↓
Specialist Agent Registry
  ↓
Selected Specialist Agent
  ↓
Structured Result
  ↓
Orchestrator Summary
  ↓
Owner
```

---

## Prohibited Agent Patterns

Do not create:

- A specialist agent with direct owner-facing behavior unless explicitly approved.
- A specialist agent with private memory disconnected from shared memory.
- A duplicate agent under a different name.
- A feature-specific application that bypasses the shared foundation.
- A new agent without a manifest.
- A new agent without data-access boundaries.
- A new agent without test criteria.

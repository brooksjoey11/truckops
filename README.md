# TruckOps OpenClaw AI Operating System

## Bootstrap Package

**Version:** 1.1
**Status:** Documentation Complete | Foundation Not Yet Built | Orchestrator Specification Added
**Primary Runtime Target:** GCP Compute Engine VM + Debian 12 + Docker + OpenClaw
**Primary User Interface:** Orchestrator Agent

---

## Purpose

This repository contains the TruckOps Architecture Bootstrap Package: the complete documentation and architectural foundation for the TruckOps OpenClaw AI Operating System.

TruckOps is an AI-powered operating system for small trucking businesses. It transforms scattered spreadsheets, chat threads, documents, dispatch notes, reminders, and disconnected tools into a unified business brain.

This bootstrap package defines:

- What TruckOps is and why it exists
- The complete system architecture
- Foundation infrastructure requirements
- GCP + VM + OpenClaw setup path
- Business domains and their relationships
- Agent names, agent responsibilities, and specialist-agent boundaries
- Orchestrator Agent implementation specification
- Data, memory, and records structure
- Development, testing, and release process
- Operations and daily-use guidance
- Productization and future market-readiness boundaries

---

## Current Execution State

| Component | Status | Next Action |
|---|---|---|
| Repository documentation | Complete enough for foundation build | Maintain through release notes |
| GCP project | Not created | Execute foundation checklist |
| Compute Engine VM | Not created | Provision Debian 12 VM |
| Docker runtime | Not installed | Install during VM setup |
| OpenClaw | Not installed | Install after Docker |
| Model provider endpoint | Not configured | Configure after OpenClaw install |
| TruckOps workspace | Not created | Create under canonical workspace structure |
| Bootstrap package upload | Not uploaded | Upload after workspace creation |
| Initialization Report | Not generated | Generate after bootstrap upload |
| Orchestrator Agent spec | Defined | Implement after foundation build |
| Dispatch Agent spec | Defined | Implement after Orchestrator |
| Document & Compliance Manager Agent spec | Defined | Implement after Dispatch V1 or parallel staging |
| Daily operations docs | Defined | Use after runtime exists |
| Productization docs | Defined | Use only after owner-operated MVP proves value |

---

## Repository Structure

```
truckops/
├── README.md
├── 00 - Project Control & AI Context/
│   └── 00-annex-ai-context-development-log.md
├── 01 - Project Overview & Architecture/
│   ├── 01-project-overview.md
│   └── 02-system-architecture-baseline.md
├── 02 - Foundation & Infrastructure/
│   ├── 03-foundation-build-runbook.md
│   ├── 04-foundation-gcp-vm-openclaw.md
│   ├── 05-canonical-workspace-structure.md
│   └── 06-foundation-execution-checklist.md
├── 03 - Business Domains/
│   └── 04-truckops-business-domains-map.md
├── 04 - Agents & Features/
│   ├── ORCHESTRATOR AGENT.md
│   ├── DISPATCH AGENT.md
│   ├── DOCUMENT & COMPLIANCE MANAGER AGENT.md
│   └── AGENT NAMING AND REGISTRY.md
├── 05 - Data, Memory & Intelligence/
│   ├── 07-data-memory-records-baseline.md
│   └── 08-memory-learning-self-improvement-architecture.md
├── 06 - Development, Testing & Releases/
│   ├── 06-agent-creator.md
│   ├── 08-development-testing-release-process.md
│   ├── 09-project-smart-audit.md
│   └── 10-updates-implement.md
├── 07 - Operations & Daily Use/
│   └── README.md
├── 08 - Productization & Marketable System/
│   └── README.md
├── 99 - Archive/
│   └── README.md
├── agents/
│   └── orchestrator/
│       ├── README.md
│       ├── agent.yaml
│       ├── prompts/
│       ├── skills/
│       ├── workflows/
│       ├── schemas/
│       └── tests/
├── config/
│   ├── workspace.yaml
│   ├── agents.yaml
│   └── secrets.example.yaml
└── tools/
    └── initialize_workspace.sh
```

---

## Canonical Reading Order

### For Project Understanding

1. `README.md`
2. `00 - Project Control & AI Context/00-annex-ai-context-development-log.md`
3. `01 - Project Overview & Architecture/01-project-overview.md`
4. `01 - Project Overview & Architecture/02-system-architecture-baseline.md`
5. `03 - Business Domains/04-truckops-business-domains-map.md`

### For Foundation Build

1. `02 - Foundation & Infrastructure/04-foundation-gcp-vm-openclaw.md`
2. `02 - Foundation & Infrastructure/03-foundation-build-runbook.md`
3. `02 - Foundation & Infrastructure/05-canonical-workspace-structure.md`
4. `02 - Foundation & Infrastructure/06-foundation-execution-checklist.md`

### For Agent Implementation

1. `04 - Agents & Features/AGENT NAMING AND REGISTRY.md`
2. `04 - Agents & Features/ORCHESTRATOR AGENT.md`
3. `04 - Agents & Features/DISPATCH AGENT.md`
4. `04 - Agents & Features/DOCUMENT & COMPLIANCE MANAGER AGENT.md`
5. `05 - Data, Memory & Intelligence/07-data-memory-records-baseline.md`
6. `05 - Data, Memory & Intelligence/08-memory-learning-self-improvement-architecture.md`

### For Safe Development

1. `06 - Development, Testing & Releases/08-development-testing-release-process.md`
2. `06 - Development, Testing & Releases/06-agent-creator.md`
3. `06 - Development, Testing & Releases/09-project-smart-audit.md`
4. `06 - Development, Testing & Releases/10-updates-implement.md`

### For Daily Use

1. `07 - Operations & Daily Use/README.md`

### For Productization

1. `08 - Productization & Marketable System/README.md`

---

## Canonical Agent Names

| Canonical Display Name | Canonical ID | File |
|---|---|---|
| Orchestrator Agent | `orchestrator` | `04 - Agents & Features/ORCHESTRATOR AGENT.md` |
| Dispatch Agent | `dispatch` | `04 - Agents & Features/DISPATCH AGENT.md` |
| Document & Compliance Manager Agent | `document_compliance` | `04 - Agents & Features/DOCUMENT & COMPLIANCE MANAGER AGENT.md` |
| Invoicing & Collections Agent | `invoicing_collections` | Planned |
| Broker Intelligence Agent | `broker_intelligence` | Planned |
| Maintenance Agent | `maintenance` | Planned |
| Fuel & Expense Agent | `fuel_expense` | Planned |
| Cash Flow Agent | `cash_flow` | Planned |
| Profitability Agent | `profitability` | Planned |
| Daily Briefing Agent | `daily_briefing` | Planned |

Legacy names such as "On-Demand Dispatch Intelligence Agent," "Dispatch Intelligence Agent," and "DISPATCH AGENT" refer to the same canonical agent: **Dispatch Agent** with canonical ID `dispatch`.

---

## Architecture Overview

```
Owner / User
    ↓
Orchestrator Agent
    ↓
Specialist Agents
    ├── Dispatch Agent
    ├── Document & Compliance Manager Agent
    ├── Invoicing & Collections Agent
    ├── Broker Intelligence Agent
    ├── Maintenance Agent
    ├── Fuel & Expense Agent
    ├── Cash Flow Agent
    ├── Profitability Agent
    └── Daily Briefing Agent
    ↓
Shared Foundation
    ├── GCP Project
    ├── Compute Engine VM
    ├── Debian 12
    ├── Docker
    ├── OpenClaw
    └── Model Provider Endpoint
    ↓
Shared Data, Memory & Records Layer
    ├── SQLite
    ├── LanceDB
    ├── YAML configuration
    ├── Workspace folders
    └── Audit logs
```

The owner interacts with the Orchestrator Agent. Specialist agents do not become separate user-facing applications. They operate behind the Orchestrator and use the shared foundation, shared data, shared memory, shared configuration, and shared release process.

---

## Core Rules

1. Start small. Prove usefulness. Save the data. Build intelligence from real use.
2. Features must not become disconnected applications.
3. Agent behavior must be configuration-driven where practical.
4. Credentials must never be stored in notes, prompts, public files, or repository documentation.
5. Data collected by one agent must be available to the shared intelligence layer unless explicitly restricted.
6. Development and testing must not interfere with daily operations.
7. Every meaningful change must be documented in release notes.
8. The Orchestrator is the primary owner interface.
9. Specialist agents are invoked by the Orchestrator, not directly by the owner during normal use.
10. The system must remain useful before it becomes sophisticated.

---

## Immediate Execution Path

### Phase 1 — Foundation

1. Create the GCP project.
2. Enable billing and required APIs.
3. Provision the Compute Engine VM.
4. Install Debian 12 updates.
5. Install Docker.
6. Install OpenClaw.
7. Configure the model provider endpoint.
8. Create `$TRUCKOPS_HOME`.
9. Create the canonical workspace structure.
10. Upload the bootstrap package.
11. Generate the TruckOps Initialization Report.

**Primary file:** `02 - Foundation & Infrastructure/06-foundation-execution-checklist.md`

### Phase 2 — Orchestrator

1. Implement the Orchestrator Agent from `04 - Agents & Features/ORCHESTRATOR AGENT.md`.
2. Configure the agent registry.
3. Connect the Orchestrator to OpenClaw.
4. Connect the Orchestrator to shared data and memory.
5. Run the first owner-command workflow.

### Phase 3 — First Specialist

1. Implement Dispatch Agent V1.
2. Register Dispatch Agent with the Orchestrator.
3. Run sample dispatch workflows with mock data.
4. Save all routing decisions, load evaluations, and owner feedback.

### Phase 4 — Daily Use MVP

1. Add Document & Compliance Manager Agent.
2. Add daily briefing.
3. Add operational dashboard notes.
4. Begin release logging and lessons-learned capture.

---

## MVP Definition

TruckOps reaches MVP when:

- Foundation is running on GCP VM.
- OpenClaw is accessible.
- Model provider endpoint responds.
- TruckOps workspace exists.
- Bootstrap package is uploaded.
- Orchestrator Agent accepts owner input.
- Orchestrator can invoke at least one specialist agent.
- Dispatch Agent V1 can process a mock or manually entered load workflow.
- Data is saved to the shared records layer.
- Logs and release notes are created for changes.

---

## License

This repository is private intellectual property of the TruckOps owner. It is not publicly licensed for redistribution.

---

## Contact

For questions or contributions, refer to the TruckOps owner.

---

Build the foundation. Initialize from the bootstrap. Implement the Orchestrator. Then build the first useful specialist agent.

# Orchestrator Agent

**Canonical ID:** `orchestrator`
**Version:** 1.0.0
**Type:** Owner Interface / Coordinator
**Status:** Implementation Ready

---

## Overview

The Orchestrator Agent is the primary owner-facing coordination agent for TruckOps. It interprets owner requests, routes tasks to specialist agents, coordinates workflows, synthesizes results, and records memory.

---

## Files in This Directory

| File / Directory | Purpose |
|---|---|
| `agent.yaml` | Machine-readable agent manifest |
| `prompts/system.md` | Primary system prompt (customizable) |
| `prompts/routing.md` | Routing decision prompt (customizable) |
| `prompts/summarization.md` | Response summarization prompt (customizable) |
| `skills/` | Skill definitions (YAML, one per skill) |
| `workflows/` | Multi-step workflow definitions (YAML) |
| `schemas/` | Input/output JSON schema contracts |
| `tests/` | Agent validation tests |
| `logs/` | Agent-local logs |

---

## Quick Start

1. Copy this directory to `$TRUCKOPS_HOME/agents/orchestrator/`
2. Set required environment variables (see `agent.yaml`)
3. Review and customize prompts in `prompts/`
4. Run the MVP acceptance test: `tests/mvp-acceptance-test.yaml`

---

## Customization

All prompts are stored as separate files in `prompts/`. Edit them to match your business context and preferences without modifying the Orchestrator's core logic.

All workflow definitions are stored in `workflows/`. Add or modify workflows without modifying core code.

All skill definitions are stored in `skills/`. Each skill is a self-contained YAML file.

---

## Related Documentation

- Full specification: `04 - Agents & Features/ORCHESTRATOR AGENT.md`
- Agent registry: `04 - Agents & Features/AGENT NAMING AND REGISTRY.md`
- Workspace structure: `02 - Foundation & Infrastructure/05-canonical-workspace-structure.md`

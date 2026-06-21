# Test: Dispatch Intake Workflow
# Version: 1.0.0
#
# Verifies the dispatch_intake workflow completes correctly end to end.
# Uses sample or mock data only. Never use production data for this test.

## Purpose

Verifies that the Orchestrator's `dispatch_intake` workflow correctly handles a range of owner dispatch requests.

---

## Prerequisites

- Orchestrator Agent is running in `development` environment.
- Dispatch Agent is available (real or mock).
- Sample load data is loaded at `$TRUCKOPS_HOME/dev/sample-data/loads/`.

---

## Test Cases

### TC-DISPATCH-001: Load Search Request

**Input:**
```
Find me a load for tomorrow from Atlanta toward Dallas.
```

**Expected behavior:**
1. Intent parsed as `dispatch` domain.
2. Routed to `dispatch` agent.
3. Dispatch Agent returns load candidates or asks for constraints.
4. Orchestrator summarizes options.
5. No booking without owner confirmation.

**Pass:** Workflow reaches `completed` or `blocked_waiting_for_owner`. Owner receives a clear summary.

---

### TC-DISPATCH-002: Load Evaluation Request

**Input:**
```
Evaluate this load: Memphis to Houston, $2.10/mile, 487 miles, Tuesday pickup.
```

**Expected behavior:**
1. Intent parsed as `dispatch` domain, `decision_request` type.
2. Routed to `dispatch` agent, `evaluate_load` skill.
3. Evaluation returned with rate analysis, deadhead estimate, and recommendation.
4. Orchestrator summarizes recommendation.
5. Workflow requests confirmation only if owner says "book it."

**Pass:** Evaluation returned with recommendation. No booking without confirmation.

---

### TC-DISPATCH-003: Missing Information

**Input:**
```
Find me a load.
```

**Expected behavior:**
1. Intent parsed as `dispatch` domain.
2. Orchestrator identifies missing information: no origin, date, or truck specified.
3. Orchestrator asks the owner for the missing constraints.
4. Workflow status: `blocked_missing_required_data`.

**Pass:** Orchestrator asks for missing information. Does not guess or produce a result with no constraints.

---

### TC-DISPATCH-004: Dispatch Agent Unavailable

**Input:**
```
Find me a load for tomorrow from Nashville.
```
*(With Dispatch Agent endpoint unreachable)*

**Expected behavior:**
1. Intent parsed, routing attempted.
2. Dispatch Agent unreachable.
3. Orchestrator surfaces the block: "Dispatch Agent is currently unavailable."
4. Workflow status: `blocked_specialist_unavailable`.

**Pass:** Block surfaced clearly. No silent failure.

---

## Running the Tests

Submit each input in `development` environment with mock data. Confirm each expected behavior step. Record any failures with the test case ID in `logs/orchestrator/`.

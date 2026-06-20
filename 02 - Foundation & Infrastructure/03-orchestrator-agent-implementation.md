# Orchestrator Agent — Implementation Specification

## 1. Purpose
The Orchestrator Agent is the sole conversational interface between the owner and the TruckOps system. It interprets natural language requests, manages context, delegates to specialist agents, synthesizes responses, and learns from interactions.

## 2. Architecture
- Built as an OpenClaw skill module.
- Exposes a REST API endpoint (`/api/v1/chat`) for Telegram and web clients.
- Uses OpenClaw's built-in memory (LanceDB) for short-term and long-term context.
- Maintains a conversation state machine (idle, gathering, delegating, responding).

## 3. API Contract

### Request
```json
POST /api/v1/chat
{
  "session_id": "uuid",
  "message": "string",
  "context": { }
}
```

### Response
```json
{
  "response": "string",
  "actions_taken": [ "delegated_to_dispatch", "queried_invoices" ],
  "suggestions": [ "Follow up on invoice #1048" ]
}
```

## 4. Skills
The Orchestrator possesses the following built-in skills (no delegation required):

- **Greeting/Intent Recognition** – Classifies user intent (planning, status, decision, etc.)
- **Context Management** – Maintains conversation history and domain context
- **Routing** – Determines which specialist agent to invoke
- **Synthesis** – Combines outputs from multiple agents into a coherent answer
- **Learning** – Logs interactions to the Memory & Learning system for improvement

## 5. Delegation Protocol
When a specialist agent is required:
1. Prepare a structured query for the agent (JSON-formatted).
2. Invoke the agent via its own API or OpenClaw sub-skill.
3. Await response (asynchronous with timeout).
4. Synthesize the response and present to the user.

## 6. Configuration
```yaml
orchestrator:
  session_timeout: 3600
  max_delegation_retries: 2
  agent_endpoints:
    dispatch: "http://localhost:8001/v1/execute"
    document: "http://localhost:8002/v1/execute"
  memory:
    vector_db: "/data/lancedb"
    sqlite_db: "/data/truckops.db"
```

## 7. Python Skeleton
```python
# orchestrator.py
from openclaw import Skill, Memory
from flask import Flask, request, jsonify

app = Flask(__name__)
memory = Memory()

@app.route('/api/v1/chat', methods=['POST'])
def chat():
    data = request.json
    session_id = data['session_id']
    message = data['message']

    # 1. Intent classification (ML or rule-based)
    intent = classify_intent(message)

    # 2. Delegate if needed
    if intent == 'dispatch':
        result = call_agent('dispatch', message)
    elif intent == 'document':
        result = call_agent('document', message)
    else:
        result = synthesize_direct(message)

    # 3. Save interaction for learning
    memory.log(session_id, message, result)

    return jsonify({
        'response': result['text'],
        'actions_taken': result.get('actions', []),
        'suggestions': result.get('suggestions', [])
    })

# Additional helper functions...
```

## 8. Deployment
- Deployed as a Docker container within the OpenClaw stack.
- Exposed via OpenClaw gateway.
- Health check endpoint: `/api/v1/health`.

## 9. Testing Plan
- Unit tests for each skill.
- Integration tests with mock specialist agents.
- End-to-end tests with real OpenClaw instance.

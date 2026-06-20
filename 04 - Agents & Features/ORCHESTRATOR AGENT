<h1 style="color:#F97316;">ORCHESTRATOR AGENT</h1>

<h3 style="color:#B8C7CC;">Central coordination brain for the TruckOps OpenClaw AI Operating System</h3>

<hr>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>The <strong>Orchestrator Agent</strong> is the central coordination brain of the TruckOps system. It understands overall business goals, breaks down complex requests, routes tasks to specialist agents (Dispatch, Document &amp; Compliance, Invoicing, etc.), and weaves their outputs into a seamless, coordinated response. It manages the entire workflow from load booking to invoicing without manual intervention.</p>

<p>This agent is not a specialist in any operational domain. It does not find loads, match trucks, extract PDF data, or generate invoices. Instead, it <strong>orchestrates</strong> the interaction between specialist agents to achieve a user's goal expressed in natural language or structured commands.</p>

<p><span style="color:#FACC15; font-weight:600;">Target user:</span> The owner‑operator who has multiple specialist agents but struggles to coordinate them manually. They want to say "book a load from Chicago to Dallas for next Tuesday" and have the system handle everything end‑to‑end.</p>

<hr>

<h2 style="color:#00A6A6;">Scope &amp; Operational Boundaries</h2>

<h3 style="color:#B8C7CC;">Business Domains Served</h3>

<p>The Orchestrator operates across <strong>all</strong> TruckOps business domains, as defined in the Business Domains Map:</p>

<table>
  <thead><tr><th>Domain</th><th>Role of the Orchestrator</th></tr></thead>
  <tbody>
    <tr><td><strong>Dispatch &amp; Load Operations</strong></td><td>Orchestrates load discovery, matching, booking, and tracking via the Dispatch Agent</td></tr>
    <tr><td><strong>Broker &amp; Customer Intelligence</strong></td><td>Coordinates broker interactions and rate negotiations via the Dispatch Agent</td></tr>
    <tr><td><strong>Documents &amp; Records</strong></td><td>Triggers document generation and compliance tracking via the Document &amp; Compliance Agent</td></tr>
    <tr><td><strong>Compliance &amp; Authority</strong></td><td>Monitors and acts on compliance deadlines via the Document &amp; Compliance Agent</td></tr>
    <tr><td><strong>Invoicing &amp; Collections</strong></td><td>Initiates invoicing and collections via the Invoicing Agent</td></tr>
    <tr><td><strong>Company &amp; Administration</strong></td><td>Maintains audit trails, coordination logs, and overall system health</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">What This Agent Does</h3>

<ul>
  <li>Parses user intent from natural language or structured commands</li>
  <li>Breaks down complex goals into executable workflows</li>
  <li>Routes tasks to the appropriate specialist agents</li>
  <li>Aggregates and synthesises results from multiple agents</li>
  <li>Manages conversation state and context across interactions</li>
  <li>Schedules and triggers periodic jobs (e.g., daily compliance check)</li>
  <li>Maintains a registry of all specialist agents and their capabilities</li>
  <li>Provides a unified interface for the user to interact with the whole system</li>
  <li>Records coordination logs and audit trails for all orchestrated actions</li>
</ul>

<h3 style="color:#B8C7CC;">What This Agent Does Not Do</h3>

<ul>
  <li>Does <strong>not</strong> perform specialist tasks directly (e.g., does not find loads, extract PDFs, or create invoices)</li>
  <li>Does <strong>not</strong> store data that belongs to specialist agents – only workflow, task, and coordination data</li>
  <li>Does <strong>not</strong> replace the user's final decision – it presents recommendations and requires confirmation for critical actions</li>
  <li>Does <strong>not</strong> store credentials or secrets – uses GCP Secret Manager</li>
</ul>

<h3 style="color:#B8C7CC;">Handoff Points</h3>

<table>
  <thead><tr><th>Condition</th><th>Handoff To</th></tr></thead>
  <tbody>
    <tr><td>Load discovery or booking required</td><td>Dispatch Intelligence Agent</td></tr>
    <tr><td>Document generation or compliance check needed</td><td>Document &amp; Compliance Manager Agent</td></tr>
    <tr><td>Invoice creation required after delivery</td><td>Invoicing &amp; Collections Agent</td></tr>
    <tr><td>User asks for a system status report</td><td>Orchestrator (directly, via internal summary)</td></tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Capabilities &amp; Skills</h2>

<p>The Orchestrator exposes the following discrete skills to the user (via the OpenClaw interface) and to itself for internal workflows.</p>

<table>
  <thead><tr><th>Skill Name</th><th>Description</th><th>Trigger</th><th>Orchestrator‑Invoked Signature</th></tr></thead>
  <tbody>
    <tr><td><code>parse_user_intent</code></td><td>Parses natural language or structured input to identify the user's goal</td><td>On‑demand (user request)</td><td><code>parse_user_intent(input: str) -> Intent</code></td></tr>
    <tr><td><code>route_to_agent</code></td><td>Routes a task to the appropriate specialist agent based on intent</td><td>On‑demand</td><td><code>route_to_agent(task: Task, agent_name: str) -> RoutingResult</code></td></tr>
    <tr><td><code>orchestrate_workflow</code></td><td>Breaks down a complex goal into a sequence of tasks and executes them</td><td>On‑demand</td><td><code>orchestrate_workflow(goal: dict) -> WorkflowResult</code></td></tr>
    <tr><td><code>aggregate_results</code></td><td>Combines outputs from multiple agents into a unified response</td><td>On‑demand</td><td><code>aggregate_results(responses: list[dict]) -> AggregatedResponse</code></td></tr>
    <tr><td><code>manage_conversation</code></td><td>Maintains conversational context across multiple interactions</td><td>On‑demand</td><td><code>manage_conversation(session_id: str, message: str) -> ConversationState</code></td></tr>
    <tr><td><code>schedule_job</code></td><td>Schedules a periodic job (e.g., daily compliance check) to be executed by the appropriate agent</td><td>On‑demand / Scheduled</td><td><code>schedule_job(cron: str, task: dict) -> JobResult</code></td></tr>
    <tr><td><code>register_agent</code></td><td>Registers a new specialist agent and its capabilities in the agent registry</td><td>System startup / On‑demand</td><td><code>register_agent(agent_manifest: dict) -> RegistrationResult</code></td></tr>
    <tr><td><code>audit_coordination</code></td><td>Records every coordination action for traceability</td><td>Internal (always)</td><td><code>audit_coordination(action: str, actor: str, target: dict) -> AuditResult</code></td></tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Input / Output Contracts</h2>

<p>All skills use the following standard JSON schemas, conforming to JSON Schema draft‑07.</p>

<h3 style="color:#B8C7CC;">Common Response Envelope</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["request_id", "status", "data", "metadata"],
  "properties": {
    "request_id": { "type": "string", "format": "uuid" },
    "status": { "type": "string", "enum": ["success", "partial", "error"] },
    "data": { "type": "object" },
    "metadata": {
      "type": "object",
      "properties": {
        "timestamp": { "type": "string", "format": "date-time" },
        "processing_time_ms": { "type": "integer" },
        "api_version": { "type": "string" }
      }
    }
  }
}</code></pre>

<h3 style="color:#B8C7CC;">Error Object Schema</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["code", "message", "retryable"],
  "properties": {
    "code": { "type": "string", "enum": ["ORC_001", "ORC_002", "ORC_003", "ORC_004", "ORC_005", "ORC_006", "ORC_007", "AGENT_001", "AGENT_002", "SYS_001"] },
    "message": { "type": "string" },
    "details": { "type": "object" },
    "retryable": { "type": "boolean" }
  }
}</code></pre>

<h3 style="color:#B8C7CC;">Skill‑Specific Schemas (Examples)</h3>

<p><strong><code>parse_user_intent</code> Input:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "type": "object",
  "required": ["input"],
  "properties": {
    "input": { "type": "string", "description": "Natural language or structured command" },
    "session_id": { "type": "string", "description": "Optional conversation session ID" }
  }
}</code></pre>

<p><strong><code>orchestrate_workflow</code> Input:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "type": "object",
  "required": ["goal"],
  "properties": {
    "goal": {
      "type": "object",
      "description": "Structured goal with action, parameters, and priority",
      "properties": {
        "action": { "type": "string", "enum": ["book_load", "file_compliance", "generate_invoice", "status_report"] },
        "parameters": { "type": "object" },
        "priority": { "type": "integer", "default": 1 }
      }
    }
  }
}</code></pre>

<p>Output schemas follow the common envelope with appropriate data structures. Full definitions are in the agent's source code.</p>

<hr>

<h2 style="color:#00A6A6;">Configuration Schema</h2>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code># Orchestrator Agent Configuration
# Version: 1.0.0
# All secrets are stored in GCP Secret Manager and referenced by name.

agent:
  name: "orchestrator"
  version: "1.0.0"
  log_level: "INFO"                     # DEBUG, INFO, WARN, ERROR, FATAL
  environment: "production"             # development, staging, production

gcp:
  project_id: "${ORCHESTRATOR_GCP_PROJECT_ID}"   # e.g., "truckops-123456"
  region: "${ORCHESTRATOR_GCP_REGION}"           # e.g., "us-central1"
  firestore_collection_workflows: "workflows"
  firestore_collection_tasks: "tasks"
  firestore_collection_agent_registry: "agent_registry"
  firestore_collection_conversations: "conversations"
  firestore_collection_coordination_logs: "coordination_logs"
  secret_manager_prefix: "truckops/orchestrator/"

database:
  sqlite_path: "${TRUCKOPS_HOME}/data/orchestrator.db"
  connection_pool_size: 5
  connection_timeout: 30

model:
  endpoint: "${OPENCLAW_MODEL_URL}"     # e.g., "http://localhost:11434/api/generate"
  timeout_seconds: 60
  retry_attempts: 3
  retry_backoff_seconds: 2

agent_registry:
  - name: "dispatch_intelligence"
    endpoint: "${DISPATCH_AGENT_ENDPOINT}"   # e.g., "http://dispatch:8080"
    enabled: true
    skills: ["find_loads", "match_truck_to_load", "book_load", "generate_bol"]
  - name: "document_compliance_manager"
    endpoint: "${DOCUMENT_AGENT_ENDPOINT}"   # e.g., "http://document:8080"
    enabled: true
    skills: ["track_document_expiry", "extract_pdf_data", "auto_file_report", "generate_document"]
  - name: "invoicing_collections"
    endpoint: "${INVOICING_AGENT_ENDPOINT}"  # e.g., "http://invoicing:8080"
    enabled: false
    skills: ["create_invoice", "send_invoice", "track_payment"]

workflow_definitions:
  book_load_workflow:
    steps:
      - skill: "find_loads"
        agent: "dispatch_intelligence"
      - skill: "match_truck_to_load"
        agent: "dispatch_intelligence"
      - skill: "suggest_rate"
        agent: "dispatch_intelligence"
      - skill: "book_load"
        agent: "dispatch_intelligence"
      - skill: "generate_bol"
        agent: "document_compliance_manager"
    final_step: "aggregate_results"

scheduled_jobs:
  daily_compliance_check:
    cron: "0 7 * * *"                  # Daily at 7:00 AM
    workflow: "compliance_check_workflow"
    params: {}

notifications:
  email:
    enabled: true
    smtp_host: "${SMTP_HOST}"
    smtp_port: 587
    smtp_user_secret: "smtp_user"
    smtp_password_secret: "smtp_password"
    from_address: "orchestrator@truckops.local"
    to_addresses:
      - "${OWNER_EMAIL}"
  slack:
    enabled: false
    webhook_url_secret: "slack_webhook_url"

logging:
  level: "INFO"
  format: "json"
  destination: "cloud_logging"          # "cloud_logging", "file", "both"
  file_path: "${TRUCKOPS_HOME}/logs/orchestrator.log"
  cloud_logging_name: "truckops-orchestrator"
  alert_on_error: true
  alert_webhook_secret: "alert_webhook_url"

self_improvement:
  enabled: true
  metrics_store: "firestore"
  feedback_collection: true
  learning_interval_hours: 24
  consolidation_cron: "0 2 * * *"</code></pre>

<hr>

<h2 style="color:#00A6A6;">Dependencies</h2>

<h3 style="color:#B8C7CC;">Python Libraries (with versions)</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code># pyproject.toml (Poetry)
[tool.poetry.dependencies]
python = "^3.11"
pydantic = "^2.0.0"
sqlalchemy = "^2.0.0"
google-cloud-firestore = "^2.13.0"
google-cloud-secret-manager = "^2.16.0"
google-cloud-logging = "^3.8.0"
python-dotenv = "^1.0.0"
croniter = "^2.0.0"
requests = "^2.31.0"
tenacity = "^8.2.0"
email-validator = "^2.1.0"
networkx = "^3.0"          # for workflow graph processing
</code></pre>

<h3 style="color:#B8C7CC;">External APIs</h3>

<p>The Orchestrator does not call external APIs directly; it delegates to specialist agents. However, it may use the OpenClaw model endpoint for intent parsing and conversation management.</p>

<table>
  <thead><tr><th>API</th><th>Purpose</th><th>Authentication</th></tr></thead>
  <tbody>
    <tr><td>OpenClaw Model API</td><td>Intent parsing, conversation, natural language understanding</td><td>API Key (Secret Manager)</td></tr>
    <tr><td>SMTP Server</td><td>Send email notifications</td><td>Username/Password (Secret Manager)</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">GCP Services</h3>

<table>
  <thead><tr><th>Service</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td><strong>Cloud Run</strong></td><td>Host the Orchestrator as a serverless container</td></tr>
    <tr><td><strong>Firestore</strong></td><td>Store workflows, tasks, agent registry, conversations, coordination logs</td></tr>
    <tr><td><strong>Secret Manager</strong></td><td>Store all secrets (API keys, passwords, tokens)</td></tr>
    <tr><td><strong>Cloud Scheduler</strong></td><td>Schedule periodic jobs (e.g., daily compliance check)</td></tr>
    <tr><td><strong>Cloud Logging</strong></td><td>Centralised structured logging and alerting</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">OpenClaw Hooks</h3>

<table>
  <thead><tr><th>Hook</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td><code>skill_registration</code></td><td>Register Orchestrator's own skills with the system</td></tr>
    <tr><td><code>event_bus</code></td><td>Publish and subscribe to system events (workflow started, task completed, etc.)</td></tr>
    <tr><td><code>memory_access</code></td><td>Read/write semantic and episodic memory for learning and context</td></tr>
    <tr><td><code>configuration_service</code></td><td>Retrieve runtime configuration</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">System Packages</h3>

<ul>
  <li><code>poetry</code> or <code>pip</code> – Dependency management</li>
  <li><code>gcloud</code> CLI – GCP interaction for deployment and secret management</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Initialisation Sequence</h2>

<ol>
  <li><strong>Workspace setup</strong> – Clone the TruckOps repository, create <code>$TRUCKOPS_HOME/agents/orchestrator/</code> with <code>src</code>, <code>tests</code>, <code>config</code>, <code>data</code>, <code>logs</code>.</li>
  <li><strong>Virtual environment</strong> – Python 3.11 venv, activate.</li>
  <li><strong>Dependency installation</strong> – Poetry or pip install.</li>
  <li><strong>Configuration</strong> – Copy <code>config.yaml.example</code> to <code>config.yaml</code>; fill all placeholders.</li>
  <li><strong>Secrets</strong> – Store all secrets in GCP Secret Manager (e.g., <code>truckops/orchestrator/smtp_user</code>, <code>truckops/orchestrator/model_api_key</code>).</li>
  <li><strong>Database migration</strong> – Run SQLite schema creation (tables for workflows, tasks, agent registry, conversations, coordination logs).</li>
  <li><strong>Firestore indexes</strong> – Create composite indexes for workflows by status/timestamp, tasks by parent workflow, etc.</li>
  <li><strong>Agent registry initialisation</strong> – Register specialist agents by sending registration manifests to their endpoints, or pre‑populate the registry from configuration.</li>
  <li><strong>Skill registration</strong> – Register Orchestrator's own skills with the OpenClaw system via <code>POST /api/v1/skills/register</code>.</li>
  <li><strong>Scheduled job setup</strong> – Configure Cloud Scheduler jobs for periodic workflows (e.g., daily compliance check).</li>
  <li><strong>Health check</strong> – Run <code>curl http://localhost:8080/health</code>; expect <code>{"status":"ok","version":"1.0.0"}</code>.</li>
  <li><strong>Success criterion</strong> – All configuration placeholders filled, secrets stored, database created, agent registry populated, skills registered, health check passes.</li>
</ol>

<hr>

<h2 style="color:#00A6A6;">Orchestrator Integration</h2>

<p>The Orchestrator is both a consumer and provider of skills:</p>

<ul>
  <li><strong>As a provider:</strong> It registers its own skills (<code>parse_user_intent</code>, <code>orchestrate_workflow</code>, etc.) with the OpenClaw system, so that users or other agents can call them.</li>
  <li><strong>As a consumer:</strong> It discovers specialist agents via the agent registry and invokes their skills via HTTP or Pub/Sub, aggregating results.</li>
</ul>

<h3 style="color:#B8C7CC;">Skill Registration (for its own skills)</h3>

<p>Same as other agents: <code>POST /api/v1/skills/register</code> with a manifest.</p>

<h3 style="color:#B8C7CC;">Request Handling</h3>

<p>Receives requests via HTTP or message queue. Each request includes <code>request_id</code>, <code>skill</code>, <code>parameters</code>, and <code>callback_url</code>.</p>

<h3 style="color:#B8C7CC;">Agent Discovery</h3>

<p>Queries the agent registry (Firestore) to find which agent can handle a given task. The registry contains endpoint URLs and skill lists.</p>

<h3 style="color:#B8C7CC;">Task Routing</h3>

<p>For each subtask, it calls the appropriate agent's endpoint with the task payload and receives a response. It may perform sequential or parallel execution based on workflow definition.</p>

<h3 style="color:#B8C7CC;">Progress Reporting</h3>

<p>Reports overall workflow progress to the caller via status updates and logs.</p>

<h3 style="color:#B8C7CC;">Result Aggregation</h3>

<p>Combines outputs from multiple agents into a unified response (e.g., a summary of a booked load with documents generated and invoice created).</p>

<h3 style="color:#B8C7CC;">Health Check</h3>

<p><code>GET /health</code> returns status and version; also checks connectivity to registered agents (optional).</p>

<h3 style="color:#B8C7CC;">Sequence Diagram (Typical Workflow)</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>User          Orchestrator        Dispatch Agent     Document Agent
  |                |                    |                  |
  |-- "Book load"--|                    |                  |
  |                |-- find_loads ----->|                  |
  |                |<-- loads ----------|                  |
  |                |-- match_truck ---->|                  |
  |                |<-- match ----------|                  |
  |                |-- book_load ------>|                  |
  |                |<-- booking --------|                  |
  |                |-- generate_bol ------------------>|
  |                |<-- BOL --------------------------|
  |<-- Summary ----|                    |                  |</code></pre>

<hr>

<h2 style="color:#00A6A6;">Data Models &amp; Storage</h2>

<h3 style="color:#B8C7CC;">Workflows</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>workflows</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>workflow_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>goal</code></td><td>map</td><td>Structured goal that triggered the workflow</td></tr>
    <tr><td><code>steps</code></td><td>array</td><td>Ordered list of task definitions</td></tr>
    <tr><td><code>status</code></td><td>string</td><td><code>pending</code>, <code>in_progress</code>, <code>completed</code>, <code>failed</code>, <code>cancelled</code></td></tr>
    <tr><td><code>current_step</code></td><td>integer</td><td>Index of the current step</td></tr>
    <tr><td><code>results</code></td><td>map</td><td>Accumulated results from each step</td></tr>
    <tr><td><code>started_at</code></td><td>timestamp</td><td></td></tr>
    <tr><td><code>completed_at</code></td><td>timestamp</td><td></td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Tasks</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>tasks</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>task_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>workflow_id</code></td><td>string</td><td>FK to workflow</td></tr>
    <tr><td><code>skill</code></td><td>string</td><td>Skill to invoke</td></tr>
    <tr><td><code>agent</code></td><td>string</td><td>Target agent name</td></tr>
    <tr><td><code>parameters</code></td><td>map</td><td>Input parameters</td></tr>
    <tr><td><code>status</code></td><td>string</td><td><code>queued</code>, <code>sent</code>, <code>completed</code>, <code>failed</code></td></tr>
    <tr><td><code>result</code></td><td>map</td><td>Output from agent</td></tr>
    <tr><td><code>error</code></td><td>string</td><td>Error message if failed</td></tr>
    <tr><td><code>sent_at</code></td><td>timestamp</td><td></td></tr>
    <tr><td><code>completed_at</code></td><td>timestamp</td><td></td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Agent Registry</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>agent_registry</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>agent_name</code></td><td>string (PK)</td><td>Unique agent identifier</td></tr>
    <tr><td><code>endpoint</code></td><td>string</td><td>Base URL of the agent</td></tr>
    <tr><td><code>skills</code></td><td>array</td><td>List of supported skill names</td></tr>
    <tr><td><code>enabled</code></td><td>boolean</td><td>Whether the agent is active</td></tr>
    <tr><td><code>last_heartbeat</code></td><td>timestamp</td><td>For health monitoring</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Conversations</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>conversations</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>session_id</code></td><td>string (PK)</td><td>Unique session ID</td></tr>
    <tr><td><code>messages</code></td><td>array</td><td>List of message objects (role, content, timestamp)</td></tr>
    <tr><td><code>context</code></td><td>map</td><td>Extracted context (e.g., current workflow, pending actions)</td></tr>
    <tr><td><code>created_at</code></td><td>timestamp</td><td></td></tr>
    <tr><td><code>updated_at</code></td><td>timestamp</td><td></td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Coordination Logs</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>coordination_logs</code>) (write‑only, immutable)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>log_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>action</code></td><td>string</td><td><code>parse_intent</code>, <code>route_task</code>, <code>aggregate</code>, etc.</td></tr>
    <tr><td><code>workflow_id</code></td><td>string</td><td>FK to workflow</td></tr>
    <tr><td><code>task_id</code></td><td>string</td><td>FK to task</td></tr>
    <tr><td><code>actor</code></td><td>string</td><td><code>user</code> or <code>system</code></td></tr>
    <tr><td><code>details</code></td><td>map</td><td>Additional info</td></tr>
    <tr><td><code>timestamp</code></td><td>timestamp</td><td>Auto‑set</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Shared Data Access</h3>

<table>
  <thead><tr><th>Data Type</th><th>Shared Via</th><th>Accessed By</th></tr></thead>
  <tbody>
    <tr><td>Workflow state</td><td>Firestore <code>workflows</code></td><td>All agents (read‑only for monitoring)</td></tr>
    <tr><td>Agent registry</td><td>Firestore <code>agent_registry</code></td><td>Orchestrator only (write), other agents (read)</td></tr>
    <tr><td>Coordination logs</td><td>Firestore <code>coordination_logs</code></td><td>All agents (read‑only)</td></tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Error Handling &amp; Logging</h2>

<h3 style="color:#B8C7CC;">Error Codes</h3>

<table>
  <thead><tr><th>Code</th><th>Description</th><th>HTTP Status</th><th>Retryable</th></tr></thead>
  <tbody>
    <tr><td><code>ORC_001</code></td><td>Unable to parse user intent</td><td>400</td><td>No</td></tr>
    <tr><td><code>ORC_002</code></td><td>No agent registered for the required skill</td><td>404</td><td>No</td></tr>
    <tr><td><code>ORC_003</code></td><td>Agent endpoint unreachable</td><td>503</td><td>Yes</td></tr>
    <tr><td><code>ORC_004</code></td><td>Agent returned an error</td><td>502</td><td>Yes</td></tr>
    <tr><td><code>ORC_005</code></td><td>Workflow step dependency failed</td><td>409</td><td>No</td></tr>
    <tr><td><code>ORC_006</code></td><td>Workflow timeout</td><td>408</td><td>No</td></tr>
    <tr><td><code>ORC_007</code></td><td>Invalid workflow definition</td><td>422</td><td>No</td></tr>
    <tr><td><code>AGENT_001</code></td><td>Agent registration failed</td><td>400</td><td>No</td></tr>
    <tr><td><code>AGENT_002</code></td><td>Agent not responding to health check</td><td>503</td><td>Yes</td></tr>
    <tr><td><code>SYS_001</code></td><td>Internal system error</td><td>500</td><td>Yes</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Retry Policies</h3>

<table>
  <thead><tr><th>Error Type</th><th>Max Retries</th><th>Backoff (s)</th><th>Multiplier</th></tr></thead>
  <tbody>
    <tr><td>Agent endpoint unreachable</td><td>3</td><td>2</td><td>2</td></tr>
    <tr><td>Agent returns transient error</td><td>3</td><td>2</td><td>2</td></tr>
    <tr><td>Model API timeout</td><td>2</td><td>1</td><td>2</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Fallback Behaviour</h3>

<ul>
  <li>If an agent fails, the Orchestrator may retry, or if a critical step fails, the workflow is marked as <code>failed</code> and the user is notified.</li>
  <li>If no agent can handle a task, the user is prompted for manual intervention.</li>
</ul>

<h3 style="color:#B8C7CC;">Structured Logging</h3>

<p>JSON format with fields: <code>timestamp</code>, <code>level</code>, <code>logger</code> (<code>orchestrator</code>), <code>message</code>, <code>request_id</code>, <code>workflow_id</code>, <code>task_id</code>, <code>processing_time_ms</code>.</p>

<p>Destinations: Cloud Logging (primary), local file (fallback).</p>

<h3 style="color:#B8C7CC;">Alerting</h3>

<p>Alerts sent via email/Slack for:</p>
<ul>
  <li>Workflow failures after retries exhausted</li>
  <li>Agent health check failures</li>
  <li>Any <code>FATAL</code> log event</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Self‑Improvement Hooks</h2>

<p>Implements memory/learning architecture from <code>07-memory-learning-self-improvement-architecture.md</code>.</p>

<h3 style="color:#B8C7CC;">Performance Metrics Recorded</h3>

<table>
  <thead><tr><th>Metric</th><th>Storage</th><th>Update Frequency</th></tr></thead>
  <tbody>
    <tr><td>Workflow completion rate</td><td>Firestore <code>metrics</code></td><td>Per workflow</td></tr>
    <tr><td>Routing accuracy (did the right agent get chosen?)</td><td>Firestore <code>metrics</code></td><td>Per task</td></tr>
    <tr><td>User satisfaction (via feedback)</td><td>Firestore <code>metrics</code></td><td>Per interaction</td></tr>
    <tr><td>Average workflow duration</td><td>Firestore <code>metrics</code></td><td>Per workflow</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Feedback Loops</h3>

<ol>
  <li><strong>Routing correction:</strong> If the user corrects a routing decision (e.g., "I wanted the document agent, not dispatch"), the Orchestrator updates its routing weights.</li>
  <li><strong>Workflow optimisation:</strong> If a workflow frequently fails at a certain step, the Orchestrator may suggest an alternate sequence or add a validation step.</li>
  <li><strong>Intent parsing improvement:</strong> Mis‑parsed intents are logged and used to fine‑tune the NLU model.</li>
</ol>

<h3 style="color:#B8C7CC;">Skill Evolution</h3>

<p>The Orchestrator monitors patterns in user requests and may propose new composite workflows or even new skills to the system.</p>

<h3 style="color:#B8C7CC;">Consolidation</h3>

<p>During idle periods (via <code>consolidation_cron</code>):</p>
<ol>
  <li>Review recent workflows and feedback</li>
  <li>Strengthen successful workflows (store as templates)</li>
  <li>Archive old coordination logs (&gt; 1 year)</li>
  <li>Generate a system health report for the owner</li>
</ol>

<hr>

<h2 style="color:#00A6A6;">Testing &amp; Release Strategy</h2>

<p>Follows <code>08-development-testing-release-process.md</code>.</p>

<h3 style="color:#B8C7CC;">Unit Testing</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>pytest tests/unit/ -v
python -m unittest tests/test_intent_parsing.py
python -m unittest tests/test_workflow_engine.py
python -m unittest tests/test_agent_routing.py</code></pre>

<p>Coverage target: &gt; 85%</p>

<h3 style="color:#B8C7CC;">Integration Testing</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>pytest tests/integration/ -v --env=staging
python -m unittest tests/test_agent_discovery.py
python -m unittest tests/test_full_workflow.py</code></pre>

<h3 style="color:#B8C7CC;">Sample Data</h3>

<p>Uses sample workflows and mock agents – never production data.</p>

<h3 style="color:#B8C7CC;">Release Workflow</h3>

<p>Development → Staging (with sample data) → Backup → Production → Verification → Documentation.</p>

<h3 style="color:#B8C7CC;">Rollback Plan</h3>

<p>Revert to previous Cloud Run image; restore Firestore from backup if schema changed.</p>

<h3 style="color:#B8C7CC;">Versioning</h3>

<p>Semantic versioning: MAJOR.MINOR.PATCH (breaking, new features, bug fixes).</p>

<h3 style="color:#B8C7CC;">Release Checklist</h3>

<ul>
  <li>All unit tests pass</li>
  <li>Integration tests pass in staging</li>
  <li>Sample workflows complete successfully</li>
  <li>Backup taken</li>
  <li>Release notes drafted</li>
  <li>Deployment successful</li>
  <li>Health check passes</li>
  <li>Smoke test (simple workflow) passes</li>
  <li>Rollback plan tested</li>
  <li>Documentation updated</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Self‑Verification Checklist</h2>

<p>Before deployment, verify all sections are complete:</p>

<table>
  <thead><tr><th>#</th><th>Checkpoint</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>Purpose &amp; Scope – explicitly coordination, includes problem/solution, covers all domains</td></tr>
    <tr><td>2</td><td>Capabilities &amp; Skills – at least 8 skills, each with signature and trigger</td></tr>
    <tr><td>3</td><td>Input / Output Contracts – JSON schemas for every skill; error object defined</td></tr>
    <tr><td>4</td><td>Configuration Schema – complete YAML with env vars, agent registry, workflows</td></tr>
    <tr><td>5</td><td>Dependencies – exact libraries, GCP services, OpenClaw hooks</td></tr>
    <tr><td>6</td><td>Initialisation Sequence – step‑by‑step, exact commands, success criterion</td></tr>
    <tr><td>7</td><td>Orchestrator Integration – registration, task handling, agent discovery, aggregation</td></tr>
    <tr><td>8</td><td>Data Models &amp; Storage – all models defined, shared access patterns</td></tr>
    <tr><td>9</td><td>Error Handling &amp; Logging – error codes, retries, fallback, structured logs</td></tr>
    <tr><td>10</td><td>Self‑Improvement Hooks – metrics, feedback, skill evolution, consolidation</td></tr>
    <tr><td>11</td><td>Testing &amp; Release Strategy – unit, integration, release workflow, rollback</td></tr>
    <tr><td>12</td><td>No placeholders – every <code>TODO</code> replaced with concrete defaults</td></tr>
    <tr><td>13</td><td>Configuration‑driven – all behaviour from config, not hard‑coded</td></tr>
    <tr><td>14</td><td>Follows template structure – matches <code>05-on-demand-dispatch-intelligence-agent.md</code></td></tr>
  </tbody>
</table>

<hr>
<p style="font-size:0.9em; color:#888;">This is the complete Orchestrator Agent definition page, ready for implementation.</p>

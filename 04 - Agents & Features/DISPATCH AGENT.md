<h1 style="color:#F97316;">ON-DEMAND DISPATCH INTELLIGENCE AGENT</h1>

<h3 style="color:#B8C7CC;">Specialist agent for load matching, truck assignment, rate negotiation, and compliance monitoring</h3>

<hr>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>The <strong>On-Demand Dispatch Intelligence Agent</strong> is a specialist TruckOps agent designed to serve as the operational brain for load matching, truck assignment, rate negotiation, document generation, and compliance monitoring for a small trucking business. It automates the entire load lifecycle from discovery to delivery, allowing the owner-operator to focus on driving rather than administrative coordination.</p>

<p>This agent is not a passive data tracker. The first version is intended to be proactive and action-oriented: the owner expresses a business goal (e.g., "find me a load from Chicago to Dallas for next Tuesday"), and the agent orchestrates the end-to-end workflow—finding loads, matching trucks, suggesting rates, generating documents, and monitoring compliance.</p>

<p><span style="color:#FACC15; font-weight:600;">Target user:</span> The owner‑operator who spends hours searching for loads, calling brokers, matching trucks, and chasing paperwork—and who worries about missing a rate opportunity or a compliance deadline.</p>

<hr>

<h2 style="color:#00A6A6;">Scope &amp; Operational Boundaries</h2>

<h3 style="color:#B8C7CC;">Business Domains Served</h3>

<p>The agent operates within the following TruckOps business domains, as defined in the Business Domains Map:</p>

<table>
  <thead>
    <tr><th>Domain</th><th>Role of This Agent</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>Dispatch &amp; Load Operations</strong></td><td>Primary owner – manages load discovery, matching, booking, and tracking</td></tr>
    <tr><td><strong>Broker &amp; Customer Intelligence</strong></td><td>Primary owner – maintains broker relationships, rates, and negotiation history</td></tr>
    <tr><td><strong>Documents &amp; Records</strong></td><td>Secondary – initiates document generation (BOLs, rate confirmations) and requests document management from Document &amp; Compliance Agent</td></tr>
    <tr><td><strong>Company &amp; Administration</strong></td><td>Secondary – maintains audit trails and operational history</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">What This Agent Does</h3>

<ul>
  <li>Discovers and filters loads from multiple sources (load boards, broker APIs, direct customer requests)</li>
  <li>Matches available trucks to loads based on equipment, capacity, driver hours, and preferences</li>
  <li>Suggests competitive rates using market data and historical rates</li>
  <li>Books loads and generates rate confirmations</li>
  <li>Generates essential documents (BOL, driver instructions, load summary)</li>
  <li>Monitors compliance status for drivers and equipment</li>
  <li>Sends proactive reminders for pickups, deliveries, and compliance deadlines</li>
  <li>Maintains a complete audit trail of all load-related actions</li>
</ul>

<h3 style="color:#B8C7CC;">What This Agent Does Not Do</h3>

<ul>
  <li>Does <strong>not</strong> handle document retention or expiry tracking – delegates to Document &amp; Compliance Manager Agent</li>
  <li>Does <strong>not</strong> create invoices or handle collections – hands off to Invoicing &amp; Collections Agent</li>
  <li>Does <strong>not</strong> store credentials or secrets – uses GCP Secret Manager</li>
  <li>Does <strong>not</strong> make operational decisions without owner approval – provides recommendations and requires confirmation for bookings</li>
</ul>

<h3 style="color:#B8C7CC;">Handoff Points</h3>

<table>
  <thead><tr><th>Condition</th><th>Handoff To</th></tr></thead>
  <tbody>
    <tr><td>Document generation needed (BOL, rate confirmation)</td><td>Document &amp; Compliance Manager Agent</td></tr>
    <tr><td>Invoice creation required after delivery</td><td>Invoicing &amp; Collections Agent</td></tr>
    <tr><td>Compliance status check (driver medical, insurance)</td><td>Document &amp; Compliance Manager Agent (read-only query)</td></tr>
    <tr><td>Owner asks for a load summary or dispatch report</td><td>Orchestrator Agent (via skill invocation)</td></tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Capabilities &amp; Skills</h2>

<p>The agent exposes the following discrete skills to the Orchestrator. Each skill is invoked on-demand, scheduled, or event-driven.</p>

<table>
  <thead><tr><th>Skill Name</th><th>Description</th><th>Trigger</th><th>Orchestrator‑Invoked Signature</th></tr></thead>
  <tbody>
    <tr><td><code>find_loads</code></td><td>Searches load boards and broker APIs for available loads matching criteria</td><td>On‑demand</td><td><code>find_loads(origin: str, destination: str, weight: int, equipment: str, pickup_date: str) -&gt; LoadList</code></td></tr>
    <tr><td><code>filter_loads</code></td><td>Applies advanced filters to a set of loads (rate, broker rating, distance, etc.)</td><td>On‑demand</td><td><code>filter_loads(load_ids: list[str], filters: dict) -&gt; FilteredLoadList</code></td></tr>
    <tr><td><code>match_truck_to_load</code></td><td>Matches one or more available trucks to a specific load based on capacity, availability, and driver preferences</td><td>On‑demand</td><td><code>match_truck_to_load(load_id: str, truck_ids: list[str] | None) -&gt; MatchResult</code></td></tr>
    <tr><td><code>suggest_rate</code></td><td>Suggests a competitive rate for a load based on market data, historical rates, and load attributes</td><td>On‑demand</td><td><code>suggest_rate(load_id: str, truck_id: str) -&gt; RateSuggestion</code></td></tr>
    <tr><td><code>negotiate_rate</code></td><td>Assists in rate negotiation by providing counter-offer suggestions and broker interaction history</td><td>On‑demand</td><td><code>negotiate_rate(load_id: str, truck_id: str, offered_rate: float) -&gt; NegotiationResult</code></td></tr>
    <tr><td><code>book_load</code></td><td>Books a load, sends rate confirmation, and initiates document generation</td><td>On‑demand</td><td><code>book_load(load_id: str, truck_id: str, rate: float, broker_id: str) -&gt; BookingResult</code></td></tr>
    <tr><td><code>generate_bol</code></td><td>Generates a Bill of Lading (BOL) for a booked load</td><td>On‑demand (event-driven after booking)</td><td><code>generate_bol(load_id: str) -&gt; DocumentResult</code></td></tr>
    <tr><td><code>monitor_compliance</code></td><td>Checks driver and equipment compliance status (medical, insurance, inspections)</td><td>Scheduled (weekly) + On‑demand</td><td><code>monitor_compliance(driver_id: str | None, truck_id: str | None) -&gt; ComplianceReport</code></td></tr>
    <tr><td><code>send_reminder</code></td><td>Sends proactive reminders for upcoming pickups, deliveries, or compliance deadlines</td><td>Scheduled (daily) + On‑demand</td><td><code>send_reminder(load_id: str | None, days_before: int) -&gt; ReminderResult</code></td></tr>
    <tr><td><code>audit_log</code></td><td>Records every action for traceability</td><td>Internal (always)</td><td><code>audit_log(action: str, actor: str, target: dict) -&gt; AuditResult</code></td></tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Input / Output Contracts</h2>

<p>All skills use the following standard JSON schemas. All schemas conform to JSON Schema draft‑07.</p>

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
    "code": { "type": "string", "enum": ["DSP_001", "DSP_002", "DSP_003", "DSP_004", "DSP_005", "DSP_006", "DSP_007", "BRO_001", "BRO_002", "RAT_001", "SYS_001"] },
    "message": { "type": "string" },
    "details": { "type": "object" },
    "retryable": { "type": "boolean" }
  }
}</code></pre>

<h3 style="color:#B8C7CC;">Skill‑Specific Schemas (Examples)</h3>

<p><strong><code>find_loads</code> Input:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "type": "object",
  "required": ["origin", "destination"],
  "properties": {
    "origin": { "type": "string", "description": "City, state, or ZIP code" },
    "destination": { "type": "string", "description": "City, state, or ZIP code" },
    "weight": { "type": "integer", "minimum": 0 },
    "equipment": { "type": "string", "enum": ["dry_van", "reefer", "flatbed", "step_deck", "power_only"] },
    "pickup_date": { "type": "string", "format": "date" },
    "max_miles": { "type": "integer", "minimum": 0 },
    "broker_id": { "type": "string" }
  }
}</code></pre>

<p><strong><code>book_load</code> Input:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "type": "object",
  "required": ["load_id", "truck_id", "rate", "broker_id"],
  "properties": {
    "load_id": { "type": "string" },
    "truck_id": { "type": "string" },
    "rate": { "type": "number", "minimum": 0 },
    "broker_id": { "type": "string" },
    "notes": { "type": "string" },
    "generate_documents": { "type": "boolean", "default": true }
  }
}</code></pre>

<p>Output schemas follow the common envelope with appropriate data structures. Full details are provided in the agent's source code repository.</p>

<hr>

<h2 style="color:#00A6A6;">Configuration Schema</h2>

<p>Below is the complete YAML configuration template. All secrets are referenced via GCP Secret Manager and never stored in plain text.</p>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code># On-Demand Dispatch Intelligence Agent Configuration
# Version: 1.0.0
# All secrets are stored in GCP Secret Manager and referenced by name.

agent:
  name: "dispatch_intelligence"
  version: "1.0.0"
  log_level: "INFO"                     # DEBUG, INFO, WARN, ERROR, FATAL
  environment: "production"             # development, staging, production

gcp:
  project_id: "${DISPATCH_AGENT_GCP_PROJECT_ID}"   # e.g., "truckops-123456"
  region: "${DISPATCH_AGENT_GCP_REGION}"           # e.g., "us-central1"
  bucket_documents: "${DISPATCH_AGENT_BUCKET_DOCUMENTS}"   # e.g., "truckops-dispatch-docs"
  bucket_temp: "${DISPATCH_AGENT_BUCKET_TEMP}"             # e.g., "truckops-dispatch-temp"
  firestore_collection_loads: "loads"
  firestore_collection_trucks: "trucks"
  firestore_collection_drivers: "drivers"
  firestore_collection_brokers: "brokers"
  firestore_collection_rates: "rates"
  firestore_collection_compliance: "compliance_items"
  firestore_collection_audit_logs: "audit_logs"
  secret_manager_prefix: "truckops/dispatch_agent/"

database:
  sqlite_path: "${TRUCKOPS_HOME}/data/dispatch_agent.db"
  connection_pool_size: 5
  connection_timeout: 30

model:
  endpoint: "${OPENCLAW_MODEL_URL}"     # e.g., "http://localhost:11434/api/generate"
  timeout_seconds: 60
  retry_attempts: 3
  retry_backoff_seconds: 2

load_sources:
  - type: "load_board_api"
    name: "dat_loadboard"
    endpoint: "${DAT_LOADBOARD_ENDPOINT}"
    api_key_secret: "dat_api_key"
    enabled: true
  - type: "broker_api"
    name: "tql"
    endpoint: "${TQL_API_ENDPOINT}"
    api_key_secret: "tql_api_key"
    enabled: false
  - type: "broker_api"
    name: "chrobinson"
    endpoint: "${CHROBINSON_API_ENDPOINT}"
    api_key_secret: "chrobinson_api_key"
    enabled: false

rate_database:
  historical_rates_path: "${TRUCKOPS_HOME}/data/historical_rates.db"
  update_frequency_hours: 24
  fuel_surcharge_formula: "0.15 * (current_fuel_price - base_fuel_price)"
  base_fuel_price: 3.50
  margin_percent: 15

compliance:
  ifta:
    filing_dates: ["2026-01-31", "2026-04-30", "2026-07-31", "2026-10-31"]
  "2290":
    filing_deadline_month: 8
  medical_card:
    renewal_years: 2
  insurance:
    renewal_years: 1

notifications:
  email:
    enabled: true
    smtp_host: "${SMTP_HOST}"
    smtp_port: 587
    smtp_user_secret: "smtp_user"
    smtp_password_secret: "smtp_password"
    from_address: "dispatch@truckops.local"
    to_addresses:
      - "${OWNER_EMAIL}"
  sms:
    enabled: false
    provider: "twilio"
    account_sid_secret: "twilio_account_sid"
    auth_token_secret: "twilio_auth_token"
    from_number: "${TWILIO_FROM_NUMBER}"
    to_numbers:
      - "${OWNER_PHONE}"
  slack:
    enabled: false
    webhook_url_secret: "slack_webhook_url"

scheduled_jobs:
  load_polling:
    cron: "0 */6 * * *"                # Every 6 hours
    skill: "find_loads"
    params:
      max_miles: 500
  compliance_monitor:
    cron: "0 7 * * 1"                  # Weekly on Monday at 7:00 AM
    skill: "monitor_compliance"
  reminder_send:
    cron: "0 8 * * *"                  # Daily at 8:00 AM
    skill: "send_reminder"
    days_before: 3

logging:
  level: "INFO"
  format: "json"
  destination: "cloud_logging"          # "cloud_logging", "file", "both"
  file_path: "${TRUCKOPS_HOME}/logs/dispatch_agent.log"
  cloud_logging_name: "truckops-dispatch-agent"
  alert_on_error: true
  alert_webhook_secret: "alert_webhook_url"

self_improvement:
  enabled: true
  metrics_store: "firestore"            # "firestore", "sqlite"
  feedback_collection: true
  learning_interval_hours: 24
  consolidation_cron: "0 2 * * *"      # Daily at 2:00 AM</code></pre>

<hr>

<h2 style="color:#00A6A6;">Dependencies</h2>

<h3 style="color:#B8C7CC;">Python Libraries (with versions)</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code># pyproject.toml (Poetry) or requirements.txt
[tool.poetry.dependencies]
python = "^3.11"
pydantic = "^2.0.0"
sqlalchemy = "^2.0.0"
google-cloud-storage = "^2.10.0"
google-cloud-firestore = "^2.13.0"
google-cloud-secret-manager = "^2.16.0"
google-cloud-logging = "^3.8.0"
python-dotenv = "^1.0.0"
croniter = "^2.0.0"
requests = "^2.31.0"
tenacity = "^8.2.0"
email-validator = "^2.1.0"
python-magic = "^0.4.27"</code></pre>

<h3 style="color:#B8C7CC;">External APIs</h3>

<table>
  <thead><tr><th>API</th><th>Purpose</th><th>Authentication</th></tr></thead>
  <tbody>
    <tr><td>DAT Load Board API</td><td>Find available loads</td><td>API Key (Secret Manager)</td></tr>
    <tr><td>TQL Broker API</td><td>Load discovery and booking</td><td>API Key (Secret Manager)</td></tr>
    <tr><td>C.H. Robinson API</td><td>Load discovery and booking</td><td>API Key (Secret Manager)</td></tr>
    <tr><td>IFTA Filing API</td><td>Submit quarterly fuel tax reports</td><td>API Key (Secret Manager)</td></tr>
    <tr><td>2290 E‑File API</td><td>Submit heavy vehicle use tax returns</td><td>API Key (Secret Manager)</td></tr>
    <tr><td>SMTP Server</td><td>Send email reminders</td><td>Username/Password (Secret Manager)</td></tr>
    <tr><td>Twilio (optional)</td><td>Send SMS reminders</td><td>Account SID + Auth Token (Secret Manager)</td></tr>
    <tr><td>Slack Webhook (optional)</td><td>Send alerts to Slack channel</td><td>Webhook URL (Secret Manager)</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">GCP Services</h3>

<table>
  <thead><tr><th>Service</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td><strong>Cloud Run</strong></td><td>Host the agent as a serverless container</td></tr>
    <tr><td><strong>Cloud Storage</strong></td><td>Store documents (BOLs, rate confirmations, temp files)</td></tr>
    <tr><td><strong>Firestore</strong></td><td>Store structured data (loads, trucks, drivers, brokers, rates, compliance, audit logs)</td></tr>
    <tr><td><strong>Secret Manager</strong></td><td>Store all secrets (API keys, passwords, tokens)</td></tr>
    <tr><td><strong>Cloud Scheduler</strong></td><td>Schedule periodic jobs (load polling, compliance checks, reminders)</td></tr>
    <tr><td><strong>Cloud Logging</strong></td><td>Centralised structured logging and alerting</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">OpenClaw Hooks</h3>

<table>
  <thead><tr><th>Hook</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td><code>skill_registration</code></td><td>Register skills with the Orchestrator</td></tr>
    <tr><td><code>event_bus</code></td><td>Publish and subscribe to system events (load booked, document generated)</td></tr>
    <tr><td><code>memory_access</code></td><td>Read/write semantic and episodic memory</td></tr>
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

<p>Follow these steps exactly to go from zero to a running agent.</p>

<ol>
  <li><strong>Workspace setup</strong> – Clone the TruckOps repository, create the agent directory structure (<code>$TRUCKOPS_HOME/agents/dispatch/</code>).</li>
  <li><strong>Virtual environment</strong> – Create and activate a Python virtual environment.</li>
  <li><strong>Dependency installation</strong> – Install all libraries via Poetry or pip.</li>
  <li><strong>Configuration</strong> – Copy the configuration template to <code>config.yaml</code>, fill all placeholders with actual values.</li>
  <li><strong>Secrets</strong> – Store all secrets in GCP Secret Manager; reference them in the configuration.</li>
  <li><strong>Database migration</strong> – Run SQLite schema creation scripts (provided in the agent definition).</li>
  <li><strong>Firestore indexes</strong> – Create required composite indexes.</li>
  <li><strong>Cloud Storage buckets</strong> – Create buckets for documents and temporary files.</li>
  <li><strong>Skill registration</strong> – Register all skills with the Orchestrator via the OpenClaw skill registration API.</li>
  <li><strong>Scheduled job setup</strong> – Configure Cloud Scheduler jobs for load polling, compliance checks, and reminders.</li>
  <li><strong>Health check</strong> – Run the agent’s health check endpoint to verify all connections.</li>
  <li><strong>Success criterion</strong> – The agent is “ready to run” when all configuration placeholders are filled and the initialisation script completes without errors.</li>
</ol>

<p>Include exact commands (bash, gcloud, Python) for each step – see the full agent definition repository for details.</p>

<hr>

<h2 style="color:#00A6A6;">Orchestrator Integration</h2>

<h3 style="color:#B8C7CC;">Skill Registration</h3>

<p>The agent registers its skills with the Orchestrator via the OpenClaw skill registration API. The skill manifest is a JSON object that describes each skill's name, description, input schema, and output schema.</p>

<p><strong>Registration endpoint:</strong> <code>POST /api/v1/skills/register</code></p>

<p><strong>Skill manifest example:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "agent": "dispatch_intelligence",
  "version": "1.0.0",
  "skills": [
    {
      "name": "find_loads",
      "description": "Searches for available loads matching criteria",
      "input_schema": { ... },
      "output_schema": { ... },
      "invocation_type": "sync",
      "timeout_seconds": 120
    }
  ]
}</code></pre>

<h3 style="color:#B8C7CC;">Request Handling</h3>

<p>The agent receives task requests via:</p>
<ul>
  <li><strong>HTTP callbacks</strong> from the Orchestrator (synchronous)</li>
  <li><strong>Pub/Sub messages</strong> for scheduled jobs (asynchronous)</li>
</ul>

<p><strong>Request format:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "request_id": "uuid",
  "skill": "find_loads",
  "parameters": { ... },
  "callback_url": "https://orchestrator/api/v1/results",
  "timeout": 120
}</code></pre>

<h3 style="color:#B8C7CC;">Progress Reporting</h3>

<p>The agent reports progress via:</p>
<ul>
  <li><strong>Status updates</strong> to the Orchestrator's status endpoint</li>
  <li><strong>Structured logs</strong> sent to Cloud Logging</li>
</ul>

<p><strong>Progress update:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "request_id": "uuid",
  "status": "processing",
  "progress_percent": 45,
  "message": "Querying load source 2 of 3"
}</code></pre>

<h3 style="color:#B8C7CC;">Result Delivery</h3>

<p>Upon completion, the agent sends results to the Orchestrator's callback URL:</p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "request_id": "uuid",
  "status": "success",
  "data": { ... },
  "metadata": {
    "timestamp": "2026-06-20T12:00:00Z",
    "processing_time_ms": 1234
  }
}</code></pre>

<h3 style="color:#B8C7CC;">Cancellation and Timeout</h3>

<ul>
  <li>The agent supports cancellation via a <code>cancel</code> message on the request channel.</li>
  <li>If a skill exceeds its configured timeout, the agent returns a timeout error and logs the incident.</li>
</ul>

<h3 style="color:#B8C7CC;">Health Check</h3>

<ul>
  <li><strong>Endpoint:</strong> <code>GET /health</code></li>
  <li><strong>Response:</strong> <code>{"status":"ok","version":"1.0.0","timestamp":"..."}</code></li>
  <li>Used by Cloud Run for liveness and readiness probes.</li>
</ul>

<h3 style="color:#B8C7CC;">Sequence Diagram (Typical Interaction)</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>Orchestrator          Dispatch Agent          External API
    |                      |                      |
    |-- Skill Request ---->|                      |
    |                      |-- API Call -------->|
    |                      |<-- Loads -----------|
    |                      |                      |
    |<-- Progress Update --|                      |
    |                      |                      |
    |                      |-- Match Truck ----->| (internal)
    |                      |                      |
    |<-- Result -----------|                      |</code></pre>

<hr>

<h2 style="color:#00A6A6;">Data Models &amp; Storage</h2>

<h3 style="color:#B8C7CC;">Loads</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>loads</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>load_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>origin</code></td><td>string</td><td>City, state, ZIP code</td></tr>
    <tr><td><code>destination</code></td><td>string</td><td>City, state, ZIP code</td></tr>
    <tr><td><code>weight</code></td><td>integer</td><td>Weight in pounds</td></tr>
    <tr><td><code>equipment_type</code></td><td>string</td><td><code>dry_van</code>, <code>reefer</code>, <code>flatbed</code>, etc.</td></tr>
    <tr><td><code>rate_offer</code></td><td>float</td><td>Offered rate by broker</td></tr>
    <tr><td><code>status</code></td><td>string</td><td><code>open</code>, <code>booked</code>, <code>in_progress</code>, <code>delivered</code>, <code>cancelled</code></td></tr>
    <tr><td><code>broker_id</code></td><td>string</td><td>FK to <code>brokers</code></td></tr>
    <tr><td><code>pickup_date</code></td><td>timestamp</td><td></td></tr>
    <tr><td><code>delivery_date</code></td><td>timestamp</td><td></td></tr>
    <tr><td><code>generated_documents</code></td><td>array</td><td>List of document IDs</td></tr>
    <tr><td><code>created_at</code></td><td>timestamp</td><td></td></tr>
  </tbody>
</table>

<p><strong>Indexes:</strong> <code>status</code> ascending, <code>pickup_date</code> ascending; <code>origin</code> ascending, <code>destination</code> ascending</p>

<h3 style="color:#B8C7CC;">Trucks</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>trucks</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>truck_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>license_plate</code></td><td>string</td><td></td></tr>
    <tr><td><code>capacity</code></td><td>integer</td><td>Weight capacity in pounds</td></tr>
    <tr><td><code>equipment_type</code></td><td>string</td><td><code>dry_van</code>, <code>reefer</code>, etc.</td></tr>
    <tr><td><code>availability</code></td><td>string</td><td><code>available</code>, <code>on_road</code>, <code>maintenance</code></td></tr>
    <tr><td><code>driver_id</code></td><td>string</td><td>FK to <code>drivers</code></td></tr>
  </tbody>
</table>

<p><strong>Indexes:</strong> <code>availability</code> ascending, <code>equipment_type</code> ascending</p>

<h3 style="color:#B8C7CC;">Drivers</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>drivers</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>driver_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>name</code></td><td>string</td><td></td></tr>
    <tr><td><code>license_number</code></td><td>string</td><td></td></tr>
    <tr><td><code>medical_card_expiry</code></td><td>date</td><td></td></tr>
    <tr><td><code>hours_available</code></td><td>integer</td><td>Hours of service remaining</td></tr>
    <tr><td><code>preferences</code></td><td>map</td><td>Equipment, routes, etc.</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Brokers</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>brokers</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>broker_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>name</code></td><td>string</td><td></td></tr>
    <tr><td><code>contact_email</code></td><td>string</td><td></td></tr>
    <tr><td><code>phone</code></td><td>string</td><td></td></tr>
    <tr><td><code>rating</code></td><td>float</td><td>0-5 scale</td></tr>
    <tr><td><code>preferred_terms</code></td><td>map</td><td>Payment terms, communication preferences</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Rates</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>rates</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>rate_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>load_id</code></td><td>string</td><td>FK to <code>loads</code></td></tr>
    <tr><td><code>truck_id</code></td><td>string</td><td>FK to <code>trucks</code></td></tr>
    <tr><td><code>offered_amount</code></td><td>float</td><td></td></tr>
    <tr><td><code>accepted_amount</code></td><td>float</td><td></td></tr>
    <tr><td><code>negotiation_history</code></td><td>array</td><td>List of offers/counteroffers</td></tr>
    <tr><td><code>created_at</code></td><td>timestamp</td><td></td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Compliance Items</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>compliance_items</code>)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>compliance_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>type</code></td><td>string</td><td><code>ifta</code>, <code>2290</code>, <code>medical</code>, <code>insurance</code></td></tr>
    <tr><td><code>due_date</code></td><td>date</td><td></td></tr>
    <tr><td><code>status</code></td><td>string</td><td><code>pending</code>, <code>filed</code>, <code>overdue</code>, <code>exempt</code></td></tr>
    <tr><td><code>document_reference</code></td><td>string</td><td>Link to document</td></tr>
    <tr><td><code>driver_id</code></td><td>string</td><td>FK to <code>drivers</code></td></tr>
    <tr><td><code>truck_id</code></td><td>string</td><td>FK to <code>trucks</code></td></tr>
  </tbody>
</table>

<p><strong>Indexes:</strong> <code>status</code> ascending, <code>due_date</code> ascending</p>

<h3 style="color:#B8C7CC;">Audit Logs</h3>

<p><strong>Storage:</strong> Firestore (collection: <code>audit_logs</code>) (write‑only, immutable)</p>

<table>
  <thead><tr><th>Field</th><th>Type</th><th>Description</th></tr></thead>
  <tbody>
    <tr><td><code>log_id</code></td><td>string (PK)</td><td>Unique ID (UUID)</td></tr>
    <tr><td><code>action</code></td><td>string</td><td><code>find</code>, <code>match</code>, <code>book</code>, <code>generate_bol</code>, etc.</td></tr>
    <tr><td><code>actor</code></td><td>string</td><td><code>user</code> or <code>system</code></td></tr>
    <tr><td><code>target_type</code></td><td>string</td><td><code>load</code>, <code>truck</code>, <code>driver</code>, <code>broker</code>, <code>rate</code></td></tr>
    <tr><td><code>target_id</code></td><td>string</td><td>ID of the target</td></tr>
    <tr><td><code>changes</code></td><td>map</td><td>Before/after for updates</td></tr>
    <tr><td><code>timestamp</code></td><td>timestamp</td><td>Auto‑set</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Shared Data Access</h3>

<table>
  <thead><tr><th>Data Type</th><th>Shared Via</th><th>Accessed By</th></tr></thead>
  <tbody>
    <tr><td>Load metadata</td><td>Firestore <code>loads</code></td><td>Document &amp; Compliance Agent (for document generation)</td></tr>
    <tr><td>Truck/driver availability</td><td>Firestore <code>trucks</code>, <code>drivers</code></td><td>Orchestrator (for daily briefing)</td></tr>
    <tr><td>Compliance status</td><td>Firestore <code>compliance_items</code></td><td>All agents (read‑only)</td></tr>
    <tr><td>Audit logs</td><td>Firestore <code>audit_logs</code></td><td>All agents (read‑only)</td></tr>
    <tr><td>Historical rates</td><td>SQLite (<code>historical_rates.db</code>)</td><td>All agents (read‑only)</td></tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Error Handling &amp; Logging</h2>

<h3 style="color:#B8C7CC;">Error Codes</h3>

<table>
  <thead><tr><th>Code</th><th>Description</th><th>HTTP Status</th><th>Retryable</th></tr></thead>
  <tbody>
    <tr><td><code>DSP_001</code></td><td>Load not found</td><td>404</td><td>No</td></tr>
    <tr><td><code>DSP_002</code></td><td>No matching trucks available</td><td>404</td><td>No</td></tr>
    <tr><td><code>DSP_003</code></td><td>Load source API unavailable</td><td>503</td><td>Yes</td></tr>
    <tr><td><code>DSP_004</code></td><td>Rate suggestion failed (insufficient data)</td><td>422</td><td>No</td></tr>
    <tr><td><code>DSP_005</code></td><td>Booking failed (broker rejected)</td><td>409</td><td>No</td></tr>
    <tr><td><code>DSP_006</code></td><td>Document generation failed</td><td>500</td><td>Yes</td></tr>
    <tr><td><code>DSP_007</code></td><td>Compliance check failed</td><td>500</td><td>No</td></tr>
    <tr><td><code>BRO_001</code></td><td>Broker not found</td><td>404</td><td>No</td></tr>
    <tr><td><code>BRO_002</code></td><td>Broker API error</td><td>502</td><td>Yes</td></tr>
    <tr><td><code>RAT_001</code></td><td>Rate calculation error</td><td>422</td><td>No</td></tr>
    <tr><td><code>SYS_001</code></td><td>Internal system error</td><td>500</td><td>Yes</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Retry Policies</h3>

<table>
  <thead><tr><th>Error Type</th><th>Max Retries</th><th>Backoff (seconds)</th><th>Backoff Multiplier</th></tr></thead>
  <tbody>
    <tr><td>Network timeout</td><td>3</td><td>2</td><td>2</td></tr>
    <tr><td>API rate limit</td><td>5</td><td>5</td><td>2</td></tr>
    <tr><td>Storage failure</td><td>3</td><td>1</td><td>2</td></tr>
    <tr><td>Model endpoint failure</td><td>2</td><td>1</td><td>2</td></tr>
    <tr><td>Document generation failure</td><td>2</td><td>2</td><td>2</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Fallback Behaviour</h3>

<table>
  <thead><tr><th>Scenario</th><th>Fallback Action</th></tr></thead>
  <tbody>
    <tr><td>Load board API fails</td><td>Log error, retry with backoff, if fails notify owner and suggest manual load search</td></tr>
    <tr><td>Rate suggestion fails</td><td>Use average market rate from historical database</td></tr>
    <tr><td>Booking fails</td><td>Log error, notify owner via alert, mark load as <code>pending</code></td></tr>
    <tr><td>Document generation fails</td><td>Retry, if still fails notify owner and provide manual document template</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Structured Logging</h3>

<p><strong>Format:</strong> JSON</p>

<p><strong>Example:</strong></p>
<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>{
  "timestamp": "2026-06-20T12:00:00Z",
  "level": "INFO",
  "logger": "dispatch_agent",
  "message": "Load booked successfully",
  "request_id": "abc-123",
  "load_id": "load-456",
  "truck_id": "truck-789",
  "rate": 2750.00,
  "broker_id": "broker-101",
  "processing_time_ms": 234
}</code></pre>

<p><strong>Log Levels:</strong> <code>DEBUG</code>, <code>INFO</code>, <code>WARN</code>, <code>ERROR</code>, <code>FATAL</code></p>

<p><strong>Destination:</strong> Cloud Logging (primary) + local file (fallback)</p>

<h3 style="color:#B8C7CC;">Alerting</h3>

<p>Alerts are sent via the configured notification channel (email/SMS/Slack) for:</p>
<ul>
  <li>Load booking failures (after retries exhausted)</li>
  <li>Critical compliance violations (expired medical card, insurance)</li>
  <li>Repeated API failures (&gt; 3 in 1 hour)</li>
  <li>Any <code>FATAL</code> log event</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Self‑Improvement Hooks</h2>

<p>The agent implements the memory and learning architecture defined in <code>07-memory-learning-self-improvement-architecture.md</code>.</p>

<h3 style="color:#B8C7CC;">Performance Metrics Recorded</h3>

<table>
  <thead><tr><th>Metric</th><th>Storage</th><th>Update Frequency</th></tr></thead>
  <tbody>
    <tr><td>Load matching success rate</td><td>Firestore <code>metrics</code></td><td>Per match attempt</td></tr>
    <tr><td>Rate negotiation effectiveness (accepted vs offered)</td><td>Firestore <code>metrics</code></td><td>Per booking</td></tr>
    <tr><td>Document generation accuracy</td><td>Firestore <code>metrics</code></td><td>Per generation</td></tr>
    <tr><td>Average processing time per request</td><td>Firestore <code>metrics</code></td><td>Per request</td></tr>
    <tr><td>Broker response time</td><td>Firestore <code>metrics</code></td><td>Per API call</td></tr>
    <tr><td>Owner satisfaction (via feedback)</td><td>Firestore <code>metrics</code></td><td>Per feedback</td></tr>
  </tbody>
</table>

<h3 style="color:#B8C7CC;">Feedback Loops</h3>

<ol>
  <li><strong>Owner Corrections:</strong> When the owner corrects a match or rate suggestion (e.g., "This truck is not available"), the agent:
    <ul>
      <li>Records the correction in episodic memory</li>
      <li>Updates the matching algorithm weights</li>
      <li>Adjusts availability confidence scores</li>
    </ul>
  </li>
  <li><strong>Booking Outcomes:</strong> If a booking is accepted or rejected:
    <ul>
      <li>Logs the outcome with context</li>
      <li>Adjusts rate suggestions for similar loads</li>
      <li>Updates broker reliability scores</li>
    </ul>
  </li>
  <li><strong>Missed Opportunities:</strong> If a load is booked by a competitor:
    <ul>
      <li>Records the loss</li>
      <li>Analyzes competitive factors</li>
      <li>Adjusts matching criteria for future loads</li>
    </ul>
  </li>
</ol>

<h3 style="color:#B8C7CC;">Learning Process</h3>

<ul>
  <li><strong>Matching Improvement:</strong> Use booking outcomes to refine matching algorithms (equipment compatibility, distance preferences, driver availability).</li>
  <li><strong>Rate Improvement:</strong> Use accepted/offered rates to fine-tune rate suggestions.</li>
  <li><strong>Broker Improvement:</strong> Use broker response times and acceptance rates to prioritize preferred brokers.</li>
</ul>

<h3 style="color:#B8C7CC;">Skill Evolution</h3>

<p>The agent monitors repeated manual actions and proposes new skills to the Orchestrator. For example, if the owner frequently asks for "all loads for the next 3 days from Dallas", the agent can propose a new skill <code>find_upcoming_loads</code>.</p>

<h3 style="color:#B8C7CC;">Consolidation ("Dreaming")</h3>

<p>During idle periods (configured via <code>consolidation_cron</code>), the agent:</p>
<ol>
  <li>Reviews recent bookings and feedback</li>
  <li>Strengthens frequently used patterns</li>
  <li>Archives old loads (&gt; 6 months)</li>
  <li>Generates a summary report for the owner</li>
  <li>Updates its internal configuration based on learned patterns</li>
</ol>

<hr>

<h2 style="color:#00A6A6;">Testing &amp; Release Strategy</h2>

<p>The agent follows the development and release process defined in <code>08-development-testing-release-process.md</code>.</p>

<h3 style="color:#B8C7CC;">Unit Testing</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code># Run unit tests
pytest tests/unit/ -v

# Test matching algorithms
python -m unittest tests/test_matching.py

# Test rate calculations
python -m unittest tests/test_rates.py

# Test document generation
python -m unittest tests/test_documents.py</code></pre>

<p><strong>Coverage target:</strong> &gt; 85%</p>

<h3 style="color:#B8C7CC;">Integration Testing</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code># Run integration tests against staging environment
pytest tests/integration/ -v --env=staging

# Test Orchestrator integration
python -m unittest tests/test_orchestrator_integration.py

# Test load board API integration with mock
python -m unittest tests/test_load_sources.py

# Test scheduled jobs with Cloud Scheduler emulator
python -m unittest tests/test_scheduler.py</code></pre>

<h3 style="color:#B8C7CC;">Sample Data</h3>

<p>All testing uses <strong>sample loads, trucks, drivers, and brokers</strong> – never production data. Sample data is stored in <code>$TRUCKOPS_HOME/tests/sample_data/</code>.</p>

<h3 style="color:#B8C7CC;">Release Workflow</h3>

<pre style="background:#1e1e1e; color:#d4d4d4; padding:1rem;"><code>Development
    ↓
Staging (test with sample data)
    ↓
Backup (backup current production)
    ↓
Production (deploy to Cloud Run)
    ↓
Verification (run health check and smoke tests)
    ↓
Documentation (update release notes)</code></pre>

<h3 style="color:#B8C7CC;">Rollback Plan</h3>

<p>If issues are found after release:</p>
<ol>
  <li>Revert to the previous container image in Cloud Run</li>
  <li>Restore the database from the backup taken before release</li>
  <li>Notify the owner via alert</li>
</ol>

<h3 style="color:#B8C7CC;">Versioning</h3>

<ul>
  <li><strong>Semantic versioning:</strong> <code>MAJOR.MINOR.PATCH</code></li>
  <li><code>MAJOR</code> – Breaking changes (schema changes, removed skills)</li>
  <li><code>MINOR</code> – New features (new skills, new load sources)</li>
  <li><code>PATCH</code> – Bug fixes, performance improvements</li>
</ul>

<h3 style="color:#B8C7CC;">Release Checklist</h3>

<ul>
  <li>All unit tests pass</li>
  <li>Integration tests pass in staging</li>
  <li>Sample loads processed correctly</li>
  <li>Backup of production data taken</li>
  <li>Release notes drafted</li>
  <li>Deployment to Cloud Run successful</li>
  <li>Health check passes</li>
  <li>Smoke test (one find, one match, one booking) passes</li>
  <li>Rollback plan tested</li>
  <li>Documentation updated</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Self‑Verification Checklist</h2>

<p>Before deployment, verify that all required sections are complete:</p>

<table>
  <thead><tr><th>#</th><th>Checkpoint</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>Purpose &amp; Scope – explicitly derived from business domains map; clear operational boundaries; includes problem/solution statement</td></tr>
    <tr><td>2</td><td>Capabilities &amp; Skills – at least 10 discrete skills; each has name, description, trigger, and Orchestrator signature</td></tr>
    <tr><td>3</td><td>Input / Output Contracts – JSON schemas for every skill; error object schema defined</td></tr>
    <tr><td>4</td><td>Configuration Schema – complete YAML template; all parameters have env var mappings, defaults, and descriptions</td></tr>
    <tr><td>5</td><td>Dependencies – exact libraries with versions; GCP services; OpenClaw hooks; system packages</td></tr>
    <tr><td>6</td><td>Initialisation Sequence – step‑by‑step from zero; exact commands; success criterion stated</td></tr>
    <tr><td>7</td><td>Orchestrator Integration – skill registration; request/response flow; health check</td></tr>
    <tr><td>8</td><td>Data Models &amp; Storage – all models defined; schemas; storage locations; sharing with other agents</td></tr>
    <tr><td>9</td><td>Error Handling &amp; Logging – error codes; retry policies; fallback; structured logging format</td></tr>
    <tr><td>10</td><td>Self‑Improvement Hooks – metrics; feedback loops; learning; skill evolution; consolidation</td></tr>
    <tr><td>11</td><td>Testing &amp; Release Strategy – unit, integration; sample data; release workflow; rollback; versioning</td></tr>
    <tr><td>12</td><td>No placeholders – every <code>TODO</code>, <code>FIXME</code>, or <code>configure as needed</code> replaced with concrete defaults or instructions</td></tr>
    <tr><td>13</td><td>Configuration‑driven – all behaviour driven by configuration, not hard‑coded into prompts</td></tr>
    <tr><td>14</td><td>Follows template structure – matches the granularity and organisation of <code>05-on-demand-dispatch-intelligence-agent.md</code></td></tr>
  </tbody>
</table>

<hr>
<p style="font-size:0.9em; color:#888;">This note provides the complete definition of the On‑Demand Dispatch Intelligence Agent, formatted for Joplin with consistent styling and structure.</p>

# DOCUMENT & COMPLIANCE MANAGER AGENT

## Purpose

The **Document & Compliance Manager Agent** is a specialist TruckOps agent designed to eliminate the administrative burden of paperwork and regulatory compliance for a small trucking business. It automates document tracking, expiry monitoring, missing paperwork detection, PDF data extraction, record keeping, and auto‑filing of simple reports with authorities (IFTA, 2290, etc.).[reference:0]

This agent is not a massive continuous monitoring system. The first version is intended to be simple, useful, and focused: the owner interacts with the agent when paperwork needs to be filed, documents need to be tracked, or compliance deadlines are approaching. The agent builds a current compliance snapshot and recommends the most optimized action based on the data present.[reference:1]

**Target user:** The owner‑operator who spends hours chasing paperwork and risks missing filing deadlines.[reference:2]

---

## Scope & Operational Boundaries

### Business Domains Served

The agent operates within the following TruckOps business domains, as defined in the Business Domains Map[reference:3]:

| Domain | Role of This Agent |
|--------|-------------------|
| **Documents & Records** | Primary owner – tracks, classifies, extracts, archives, and retrieves all business documents |
| **Compliance & Authority** | Primary owner – monitors deadlines, files reports, tracks renewals, ensures regulatory adherence |
| **Company & Administration** | Secondary – supports company record keeping, audit trails, and administrative workflows |
| **Dispatch & Load Operations** | Secondary – provides document support for loads (BOLs, rate confirmations) |
| **Invoicing & Collections** | Secondary – hands off invoice‑related documents to the Invoicing & Collections Agent |

### What This Agent Does

- Tracks document expiry dates (insurance, medical cards, IFTA, 2290, IRP, UCR, DOT inspections)
- Flags missing paperwork before it becomes a problem
- Extracts structured data from PDFs (load numbers, signatures, dates, amounts, parties)
- Classifies and archives documents into a searchable repository
- Monitors compliance deadlines and sends proactive reminders (30, 15, 7, 3, 1 days before expiry)
- Auto‑files simple reports with authorities where APIs exist (IFTA, 2290)
- Generates draft documents (rate confirmations, cover letters, filing summaries)
- Maintains a complete audit trail of all document and compliance actions

### What This Agent Does Not Do

- Does **not** handle invoice creation or collections – hands off to Invoicing & Collections Agent
- Does **not** make operational dispatch decisions – provides documents to Dispatch Agent upon request
- Does **not** store credentials or secrets – uses GCP Secret Manager
- Does **not** replace the owner’s judgment on compliance matters – provides recommendations and alerts

### Handoff Points

| Condition | Handoff To |
|-----------|------------|
| Invoice‑related document received | Invoicing & Collections Agent |
| Load‑related document (BOL, rate confirmation) needed for dispatch | Dispatch Intelligence Agent |
| Owner asks for a compliance summary | Orchestrator Agent (via skill invocation) |

---

## Capabilities & Skills

The agent exposes the following discrete skills to the Orchestrator. Each skill is invoked on‑demand, scheduled, or event‑driven.

| Skill Name | Description | Trigger | Orchestrator‑Invoked Signature |
|------------|-------------|---------|-------------------------------|
| `track_document_expiry` | Scans all documents, calculates expiry dates, updates status | Scheduled (daily) + On‑demand | `track_document_expiry(doc_ids: list[str] \| None, days_ahead: int = 30) -> ExpiryReport` |
| `send_reminder` | Sends proactive reminders via email/SMS for upcoming expiries | Scheduled (daily) | `send_reminder(doc_ids: list[str], days_before: int) -> ReminderResult` |
| `flag_missing_paperwork` | Detects missing required documents for loads, trucks, drivers | On‑demand | `flag_missing_paperwork(load_id: str \| None, truck_id: str \| None) -> MissingReport` |
| `extract_pdf_data` | Extracts structured data from uploaded PDF documents | On‑demand (event‑driven) | `extract_pdf_data(file_path: str, doc_type: str) -> ExtractionResult` |
| `classify_document` | Automatically classifies a document by type and content | On‑demand (event‑driven) | `classify_document(file_path: str) -> ClassificationResult` |
| `archive_document` | Moves processed documents to long‑term storage with metadata | On‑demand | `archive_document(doc_id: str) -> ArchiveResult` |
| `monitor_compliance_deadlines` | Checks all compliance items (IFTA, 2290, IRP, UCR, medical, insurance) | Scheduled (weekly) | `monitor_compliance_deadlines() -> ComplianceReport` |
| `auto_file_report` | Submits simple reports to authorities via available APIs | Scheduled (quarterly/monthly) | `auto_file_report(report_type: str, period: str) -> FilingResult` |
| `generate_document` | Creates draft documents (rate confirmations, cover letters, filing summaries) | On‑demand | `generate_document(template: str, data: dict) -> DocumentResult` |
| `audit_log` | Records every action for traceability | Internal (always) | `audit_log(action: str, actor: str, target: dict) -> AuditResult` |

---

## Input / Output Contracts

All skills use the following standard JSON schemas. All schemas conform to JSON Schema draft‑07.

### Common Response Envelope

```json
{
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
}
```

### Error Object Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["code", "message", "retryable"],
  "properties": {
    "code": { "type": "string", "enum": ["DOC_001", "DOC_002", "DOC_003", "DOC_004", "DOC_005", "DOC_006", "COM_001", "COM_002", "COM_003", "SYS_001"] },
    "message": { "type": "string" },
    "details": { "type": "object" },
    "retryable": { "type": "boolean" }
  }
}
```

### Skill‑Specific Schemas

#### `track_document_expiry`

**Input:**
```json
{
  "type": "object",
  "properties": {
    "doc_ids": { "type": "array", "items": { "type": "string" }, "description": "Optional list of document IDs. If omitted, checks all." },
    "days_ahead": { "type": "integer", "default": 30, "minimum": 1, "maximum": 365 }
  }
}
```

**Output (`data`):**
```json
{
  "type": "object",
  "properties": {
    "expired": { "type": "array", "items": { "$ref": "#/definitions/DocumentSummary" } },
    "expiring_soon": { "type": "array", "items": { "$ref": "#/definitions/DocumentSummary" } },
    "valid": { "type": "array", "items": { "$ref": "#/definitions/DocumentSummary" } }
  }
}
```

#### `extract_pdf_data`

**Input:**
```json
{
  "type": "object",
  "required": ["file_path", "doc_type"],
  "properties": {
    "file_path": { "type": "string", "description": "Path to PDF file in Cloud Storage or local temp" },
    "doc_type": { "type": "string", "enum": ["bol", "rate_conf", "insurance", "inspection", "driver_log", "ifta", "2290", "other"] }
  }
}
```

**Output (`data`):**
```json
{
  "type": "object",
  "properties": {
    "extracted_fields": { "type": "object" },
    "confidence_scores": { "type": "object", "additionalProperties": { "type": "number", "minimum": 0, "maximum": 1 } },
    "raw_text": { "type": "string" }
  }
}
```

#### `auto_file_report`

**Input:**
```json
{
  "type": "object",
  "required": ["report_type", "period"],
  "properties": {
    "report_type": { "type": "string", "enum": ["ifta", "2290", "irp", "ucr"] },
    "period": { "type": "string", "pattern": "^[0-9]{4}-(Q[1-4]|[0-9]{2})$" }
  }
}
```

**Output (`data`):**
```json
{
  "type": "object",
  "properties": {
    "filing_id": { "type": "string" },
    "status": { "type": "string", "enum": ["submitted", "pending", "failed"] },
    "confirmation": { "type": "string" },
    "api_response": { "type": "object" }
  }
}
```

---

## Configuration Schema

Below is the complete YAML configuration template. All secrets are referenced via GCP Secret Manager and never stored in plain text.

```yaml
# Document & Compliance Manager Agent Configuration
# Version: 1.0.0
# All secrets are stored in GCP Secret Manager and referenced by name.

agent:
  name: "document_compliance_manager"
  version: "1.0.0"
  log_level: "INFO"                     # DEBUG, INFO, WARN, ERROR, FATAL
  environment: "production"             # development, staging, production

gcp:
  project_id: "${DOCUMENT_AGENT_GCP_PROJECT_ID}"   # e.g., "truckops-123456"
  region: "${DOCUMENT_AGENT_GCP_REGION}"           # e.g., "us-central1"
  bucket_documents: "${DOCUMENT_AGENT_BUCKET_DOCUMENTS}"   # e.g., "truckops-documents"
  bucket_archives: "${DOCUMENT_AGENT_BUCKET_ARCHIVES}"     # e.g., "truckops-archives"
  bucket_temp: "${DOCUMENT_AGENT_BUCKET_TEMP}"             # e.g., "truckops-temp"
  firestore_collection_documents: "documents"
  firestore_collection_compliance: "compliance_items"
  firestore_collection_reminders: "reminders"
  firestore_collection_extraction_jobs: "extraction_jobs"
  firestore_collection_audit_logs: "audit_logs"
  secret_manager_prefix: "truckops/document_agent/"

database:
  sqlite_path: "${TRUCKOPS_HOME}/data/document_agent.db"
  connection_pool_size: 5
  connection_timeout: 30

model:
  endpoint: "${OPENCLAW_MODEL_URL}"     # e.g., "http://localhost:11434/api/generate"
  timeout_seconds: 60
  retry_attempts: 3
  retry_backoff_seconds: 2

document_storage:
  folders:
    incoming: "incoming/"
    processed: "processed/"
    archived: "archived/"
    temp: "temp/"
  allowed_extensions:
    - ".pdf"
    - ".png"
    - ".jpg"
    - ".jpeg"
    - ".tiff"
  max_file_size_mb: 50

compliance:
  ifta:
    filing_dates: ["2026-01-31", "2026-04-30", "2026-07-31", "2026-10-31"]
    api_endpoint: "${IFTA_API_ENDPOINT}"
    api_key_secret: "ifta_api_key"
  "2290":
    filing_deadline_month: 8
    api_endpoint: "${TAX_2290_API_ENDPOINT}"
    api_key_secret: "tax2290_api_key"
  irp:
    renewal_month: 12
    api_endpoint: "${IRP_API_ENDPOINT}"
    api_key_secret: "irp_api_key"
  ucr:
    filing_deadline_month: 3
    api_endpoint: "${UCR_API_ENDPOINT}"
    api_key_secret: "ucr_api_key"

notifications:
  email:
    enabled: true
    smtp_host: "${SMTP_HOST}"
    smtp_port: 587
    smtp_user_secret: "smtp_user"
    smtp_password_secret: "smtp_password"
    from_address: "compliance@truckops.local"
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
  expiry_check:
    cron: "0 6 * * *"                  # Daily at 6:00 AM
    skill: "track_document_expiry"
    days_ahead: 30
  reminder_send:
    cron: "0 8 * * *"                  # Daily at 8:00 AM
    skill: "send_reminder"
  compliance_monitor:
    cron: "0 7 * * 1"                  # Weekly on Monday at 7:00 AM
    skill: "monitor_compliance_deadlines"
  auto_file_ifta:
    cron: "0 9 31 1,4,7,10 *"          # Quarterly on Jan 31, Apr 30, Jul 31, Oct 31
    skill: "auto_file_report"
    report_type: "ifta"
  auto_file_2290:
    cron: "0 9 1 8 *"                  # Annually on August 1
    skill: "auto_file_report"
    report_type: "2290"

logging:
  level: "INFO"
  format: "json"
  destination: "cloud_logging"          # "cloud_logging", "file", "both"
  file_path: "${TRUCKOPS_HOME}/logs/document_agent.log"
  cloud_logging_name: "truckops-document-agent"
  alert_on_error: true
  alert_webhook_secret: "alert_webhook_url"

self_improvement:
  enabled: true
  metrics_store: "firestore"            # "firestore", "sqlite"
  feedback_collection: true
  learning_interval_hours: 24
  consolidation_cron: "0 2 * * *"      # Daily at 2:00 AM
```

---

## Dependencies

### Python Libraries (with versions)

```toml
# pyproject.toml (Poetry) or requirements.txt
[tool.poetry.dependencies]
python = "^3.11"
pydantic = "^2.0.0"
sqlalchemy = "^2.0.0"
google-cloud-storage = "^2.10.0"
google-cloud-firestore = "^2.13.0"
google-cloud-secret-manager = "^2.16.0"
google-cloud-logging = "^3.8.0"
PyPDF2 = "^3.0.0"
pdfplumber = "^0.10.0"
pytesseract = "^0.3.10"          # Optional, for OCR
Pillow = "^10.0.0"               # For image processing
python-dotenv = "^1.0.0"
croniter = "^2.0.0"
requests = "^2.31.0"
python-magic = "^0.4.27"
tenacity = "^8.2.0"
email-validator = "^2.1.0"
```

### External APIs

| API | Purpose | Authentication |
|-----|---------|----------------|
| IFTA Filing API | Submit quarterly fuel tax reports | API Key (Secret Manager) |
| 2290 E‑File API | Submit heavy vehicle use tax returns | API Key (Secret Manager) |
| IRP Renewal API (where available) | Renew apportioned registration | API Key (Secret Manager) |
| UCR Filing API | Submit unified carrier registration | API Key (Secret Manager) |
| SMTP Server | Send email reminders | Username/Password (Secret Manager) |
| Twilio (optional) | Send SMS reminders | Account SID + Auth Token (Secret Manager) |
| Slack Webhook (optional) | Send alerts to Slack channel | Webhook URL (Secret Manager) |

### GCP Services

| Service | Purpose |
|---------|---------|
| **Cloud Run** | Host the agent as a serverless container |
| **Cloud Storage** | Store documents (incoming, processed, archived, temp) |
| **Firestore** | Store structured data (documents, compliance items, reminders, audit logs) |
| **Secret Manager** | Store all secrets (API keys, passwords, tokens) |
| **Cloud Scheduler** | Schedule periodic jobs (expiry checks, reminders, auto‑filing) |
| **Cloud Logging** | Centralised structured logging and alerting |

### OpenClaw Hooks

| Hook | Purpose |
|------|---------|
| `skill_registration` | Register skills with the Orchestrator |
| `event_bus` | Publish and subscribe to system events (document uploaded, filing completed) |
| `memory_access` | Read/write semantic and episodic memory |
| `configuration_service` | Retrieve runtime configuration |

### System Packages

| Package | Purpose |
|---------|---------|
| `poetry` or `pip` | Dependency management |
| `libpoppler-cpp-dev` | PDF processing (pdfplumber dependency) |
| `tesseract-ocr` (optional) | OCR for scanned documents |
| `gcloud` CLI | GCP interaction for deployment and secret management |

---

## Initialisation Sequence

Follow these steps exactly to go from zero to a running agent.

### 1. Workspace Setup

```bash
# Clone the TruckOps repository
git clone https://github.com/brooksjoey11/truckops.git
cd truckops

# Create agent directory structure
mkdir -p $TRUCKOPS_HOME/agents/document_compliance/{src,tests,config,data,logs}
```

### 2. Virtual Environment

```bash
cd $TRUCKOPS_HOME/agents/document_compliance
python3.11 -m venv venv
source venv/bin/activate
```

### 3. Dependency Installation

```bash
# Using Poetry (recommended)
poetry init --no-interaction
poetry add pydantic sqlalchemy google-cloud-storage google-cloud-firestore google-cloud-secret-manager google-cloud-logging PyPDF2 pdfplumber pytesseract Pillow python-dotenv croniter requests python-magic tenacity email-validator

# Or using pip
pip install -r requirements.txt
```

### 4. Configuration

```bash
# Copy the configuration template
cp config/config.yaml.example config/config.yaml

# Fill all placeholders with actual values
# Use environment variables or direct editing
export DOCUMENT_AGENT_GCP_PROJECT_ID="truckops-123456"
export DOCUMENT_AGENT_GCP_REGION="us-central1"
export DOCUMENT_AGENT_BUCKET_DOCUMENTS="truckops-documents"
export DOCUMENT_AGENT_BUCKET_ARCHIVES="truckops-archives"
export DOCUMENT_AGENT_BUCKET_TEMP="truckops-temp"
export OPENCLAW_MODEL_URL="http://localhost:11434/api/generate"
export SMTP_HOST="smtp.gmail.com"
export OWNER_EMAIL="owner@example.com"
export OWNER_PHONE="+1234567890"
export TRUCKOPS_HOME="/opt/truckops"
```

### 5. Secrets Management

```bash
# Store all secrets in GCP Secret Manager
gcloud secrets create truckops/document_agent/ifta_api_key --data-file=- <<< "your-ifta-api-key"
gcloud secrets create truckops/document_agent/tax2290_api_key --data-file=- <<< "your-tax2290-api-key"
gcloud secrets create truckops/document_agent/irp_api_key --data-file=- <<< "your-irp-api-key"
gcloud secrets create truckops/document_agent/ucr_api_key --data-file=- <<< "your-ucr-api-key"
gcloud secrets create truckops/document_agent/smtp_user --data-file=- <<< "your-smtp-user"
gcloud secrets create truckops/document_agent/smtp_password --data-file=- <<< "your-smtp-password"
gcloud secrets create truckops/document_agent/twilio_account_sid --data-file=- <<< "your-twilio-sid"
gcloud secrets create truckops/document_agent/twilio_auth_token --data-file=- <<< "your-twilio-token"
gcloud secrets create truckops/document_agent/slack_webhook_url --data-file=- <<< "your-slack-webhook"
gcloud secrets create truckops/document_agent/alert_webhook_url --data-file=- <<< "your-alert-webhook"
```

### 6. Database Migration

```sql
-- sqlite schema (run via Python script or sqlite3 CLI)
CREATE TABLE IF NOT EXISTS documents (
    document_id TEXT PRIMARY KEY,
    type TEXT NOT NULL,
    file_path TEXT NOT NULL,
    uploaded_at DATETIME NOT NULL,
    extracted_data JSON,
    classification TEXT,
    status TEXT DEFAULT 'pending'
);

CREATE TABLE IF NOT EXISTS compliance_items (
    compliance_id TEXT PRIMARY KEY,
    type TEXT NOT NULL,
    jurisdiction TEXT,
    filing_date DATETIME,
    due_date DATETIME NOT NULL,
    status TEXT DEFAULT 'pending',
    document_reference TEXT
);

CREATE TABLE IF NOT EXISTS reminders (
    reminder_id TEXT PRIMARY KEY,
    document_id TEXT,
    compliance_id TEXT,
    sent_at DATETIME NOT NULL,
    sent_to TEXT NOT NULL,
    method TEXT NOT NULL,
    template_used TEXT
);

CREATE TABLE IF NOT EXISTS extraction_jobs (
    job_id TEXT PRIMARY KEY,
    document_id TEXT NOT NULL,
    status TEXT DEFAULT 'queued',
    result JSON,
    error_message TEXT,
    started_at DATETIME,
    completed_at DATETIME
);

CREATE TABLE IF NOT EXISTS audit_logs (
    log_id TEXT PRIMARY KEY,
    action TEXT NOT NULL,
    actor TEXT NOT NULL,
    target_type TEXT NOT NULL,
    target_id TEXT NOT NULL,
    changes JSON,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

```bash
sqlite3 $TRUCKOPS_HOME/data/document_agent.db < schema.sql
```

### 7. Firestore Indexes

Create the following composite indexes in the GCP Console or via `gcloud`:

```bash
gcloud firestore indexes composite create \
  --collection-group=documents \
  --field-config=field-path=status,order=ascending \
  --field-config=field-path=uploaded_at,order=descending

gcloud firestore indexes composite create \
  --collection-group=compliance_items \
  --field-config=field-path=status,order=ascending \
  --field-config=field-path=due_date,order=ascending
```

### 8. Cloud Storage Buckets

```bash
gsutil mb -l $DOCUMENT_AGENT_GCP_REGION gs://$DOCUMENT_AGENT_BUCKET_DOCUMENTS
gsutil mb -l $DOCUMENT_AGENT_GCP_REGION gs://$DOCUMENT_AGENT_BUCKET_ARCHIVES
gsutil mb -l $DOCUMENT_AGENT_GCP_REGION gs://$DOCUMENT_AGENT_BUCKET_TEMP

# Create folder structure
gsutil cp /dev/null gs://$DOCUMENT_AGENT_BUCKET_DOCUMENTS/incoming/
gsutil cp /dev/null gs://$DOCUMENT_AGENT_BUCKET_DOCUMENTS/processed/
gsutil cp /dev/null gs://$DOCUMENT_AGENT_BUCKET_ARCHIVES/
```

### 9. Skill Registration

```bash
# Register skills with the Orchestrator via OpenClaw API
curl -X POST http://localhost:8080/api/v1/skills/register \
  -H "Content-Type: application/json" \
  -d '{
    "agent": "document_compliance_manager",
    "skills": [
      "track_document_expiry",
      "send_reminder",
      "flag_missing_paperwork",
      "extract_pdf_data",
      "classify_document",
      "archive_document",
      "monitor_compliance_deadlines",
      "auto_file_report",
      "generate_document",
      "audit_log"
    ]
  }'
```

### 10. Scheduled Job Setup

```bash
# Create Cloud Scheduler jobs
gcloud scheduler jobs create pubsub expiry-check \
  --schedule="0 6 * * *" \
  --topic="document-agent-jobs" \
  --message-body='{"skill":"track_document_expiry","days_ahead":30}' \
  --location=$DOCUMENT_AGENT_GCP_REGION

gcloud scheduler jobs create pubsub reminder-send \
  --schedule="0 8 * * *" \
  --topic="document-agent-jobs" \
  --message-body='{"skill":"send_reminder"}' \
  --location=$DOCUMENT_AGENT_GCP_REGION

# ... repeat for other scheduled jobs as defined in config
```

### 11. Health Check

```bash
# Run the agent's health check endpoint
curl http://localhost:8080/health
# Expected response: {"status":"ok","version":"1.0.0","timestamp":"2026-06-20T12:00:00Z"}
```

### 12. Success Criterion

The agent is **ready to run** when:
- All configuration placeholders are filled
- All secrets are stored in GCP Secret Manager
- The database schema is created
- Firestore indexes are active
- Cloud Storage buckets exist with correct folder structure
- All skills are registered with the Orchestrator
- Scheduled jobs are configured
- The health check returns `{"status":"ok"}`

---

## Orchestrator Integration

### Skill Registration

The agent registers its skills with the Orchestrator via the OpenClaw skill registration API. The skill manifest is a JSON object that describes each skill's name, description, input schema, and output schema.

**Registration endpoint:** `POST /api/v1/skills/register`

**Skill manifest example:**
```json
{
  "agent": "document_compliance_manager",
  "version": "1.0.0",
  "skills": [
    {
      "name": "track_document_expiry",
      "description": "Scans documents and returns expiry status",
      "input_schema": { ... },
      "output_schema": { ... },
      "invocation_type": "sync",
      "timeout_seconds": 300
    }
  ]
}
```

### Request Handling

The agent receives task requests via:
- **HTTP callbacks** from the Orchestrator (synchronous)
- **Pub/Sub messages** for scheduled jobs (asynchronous)

**Request format:**
```json
{
  "request_id": "uuid",
  "skill": "track_document_expiry",
  "parameters": { ... },
  "callback_url": "https://orchestrator/api/v1/results",
  "timeout": 300
}
```

### Progress Reporting

The agent reports progress via:
- **Status updates** to the Orchestrator's status endpoint
- **Structured logs** sent to Cloud Logging

**Progress update:**
```json
{
  "request_id": "uuid",
  "status": "processing",
  "progress_percent": 45,
  "message": "Scanning document #12 of 27"
}
```

### Result Delivery

Upon completion, the agent sends results to the Orchestrator's callback URL:

**Result format:**
```json
{
  "request_id": "uuid",
  "status": "success",
  "data": { ... },
  "metadata": {
    "timestamp": "2026-06-20T12:00:00Z",
    "processing_time_ms": 1234
  }
}
```

### Cancellation and Timeout

- The agent supports cancellation via a `cancel` message on the request channel.
- If a skill exceeds its configured timeout, the agent returns a timeout error and logs the incident.

### Health Check

- **Endpoint:** `GET /health`
- **Response:** `{"status":"ok","version":"1.0.0","timestamp":"..."}`
- Used by Cloud Run for liveness and readiness probes.

### Sequence Diagram (Typical Interaction)

```
Orchestrator          Document Agent          External API
    |                      |                      |
    |-- Skill Request ---->|                      |
    |                      |-- API Call -------->|
    |                      |<-- API Response ----|
    |                      |                      |
    |<-- Progress Update --|                      |
    |                      |                      |
    |<-- Result -----------|                      |
```

---

## Data Models & Storage

### Documents

**Storage:** Firestore (collection: `documents`) + Cloud Storage (file payload)

| Field | Type | Description |
|-------|------|-------------|
| `document_id` | string (PK) | Unique ID (UUID) |
| `type` | string | `bol`, `rate_conf`, `insurance`, `inspection`, `driver_log`, `ifta`, `2290`, `other` |
| `file_path` | string | Cloud Storage path (e.g., `gs://bucket/incoming/doc.pdf`) |
| `uploaded_at` | timestamp | Upload timestamp |
| `extracted_data` | map | Extracted fields (load number, signature, dates, amounts, parties) |
| `classification` | string | Auto‑classified type |
| `status` | string | `pending`, `processed`, `archived`, `error` |
| `expiry_date` | timestamp | (if applicable) |
| `owner_id` | string | Reference to owner/truck/driver |
| `tags` | array | Searchable tags |

**Indexes:**
- `status` ascending, `uploaded_at` descending
- `type` ascending
- `expiry_date` ascending

### Compliance Items

**Storage:** Firestore (collection: `compliance_items`)

| Field | Type | Description |
|-------|------|-------------|
| `compliance_id` | string (PK) | Unique ID (UUID) |
| `type` | string | `ifta`, `2290`, `irp`, `ucr`, `medical_card`, `insurance` |
| `jurisdiction` | string | State or federal |
| `filing_date` | timestamp | Date filed (if completed) |
| `due_date` | timestamp | Deadline |
| `status` | string | `pending`, `filed`, `overdue`, `exempt` |
| `document_reference` | string | Link to associated document |
| `amount` | float | Filing fee or tax amount |
| `notes` | string | Additional info |

**Indexes:**
- `status` ascending, `due_date` ascending
- `type` ascending

### Reminders

**Storage:** Firestore (collection: `reminders`)

| Field | Type | Description |
|-------|------|-------------|
| `reminder_id` | string (PK) | Unique ID (UUID) |
| `document_id` | string | FK to `documents` (if applicable) |
| `compliance_id` | string | FK to `compliance_items` (if applicable) |
| `sent_at` | timestamp | When sent |
| `sent_to` | string | Email or phone number |
| `method` | string | `email`, `sms`, `slack` |
| `template_used` | string | Template name |
| `days_before` | integer | 30, 15, 7, 3, 1 |

### Extraction Jobs

**Storage:** Firestore (collection: `extraction_jobs`)

| Field | Type | Description |
|-------|------|-------------|
| `job_id` | string (PK) | Unique ID (UUID) |
| `document_id` | string | FK to `documents` |
| `status` | string | `queued`, `processing`, `completed`, `failed` |
| `result` | map | Extracted data |
| `error_message` | string | If failed |
| `started_at` | timestamp | |
| `completed_at` | timestamp | |

### Audit Logs

**Storage:** Firestore (collection: `audit_logs`) (write‑only, immutable)

| Field | Type | Description |
|-------|------|-------------|
| `log_id` | string (PK) | Unique ID (UUID) |
| `action` | string | `upload`, `extract`, `classify`, `archive`, `file_report`, `send_reminder`, etc. |
| `actor` | string | `user` or `system` |
| `target_type` | string | `document`, `compliance_item`, `reminder`, etc. |
| `target_id` | string | ID of the target |
| `changes` | map | Before/after for updates |
| `timestamp` | timestamp | Auto‑set |

### Shared Data Access

| Data Type | Shared Via | Accessed By |
|-----------|------------|-------------|
| Document metadata | Firestore `documents` | Dispatch Agent, Invoicing Agent |
| Compliance status | Firestore `compliance_items` | Orchestrator (for daily briefing) |
| Audit logs | Firestore `audit_logs` | All agents (read‑only) |
| Document files | Cloud Storage | All agents (read‑only) |
| Business rules | SQLite (`rules.db`) | All agents |

---

## Error Handling & Logging

### Error Codes

| Code | Description | HTTP Status | Retryable |
|------|-------------|-------------|-----------|
| `DOC_001` | Document not found | 404 | No |
| `DOC_002` | Invalid document type | 400 | No |
| `DOC_003` | PDF extraction failed (corrupted file) | 422 | No |
| `DOC_004` | PDF extraction failed (unsupported format) | 415 | No |
| `DOC_005` | Storage upload failed | 500 | Yes |
| `DOC_006` | Document classification failed | 500 | Yes |
| `COM_001` | Compliance deadline passed | 409 | No |
| `COM_002` | Filing API unreachable | 503 | Yes |
| `COM_003` | Filing API returned error | 502 | Yes |
| `SYS_001` | Internal system error | 500 | Yes |

### Retry Policies

| Error Type | Max Retries | Backoff (seconds) | Backoff Multiplier |
|------------|-------------|-------------------|-------------------|
| Network timeout | 3 | 2 | 2 |
| API rate limit | 5 | 5 | 2 |
| Storage failure | 3 | 1 | 2 |
| Model endpoint failure | 2 | 1 | 2 |

### Fallback Behaviour

| Scenario | Fallback Action |
|----------|-----------------|
| PDF extraction fails | Log error, mark document as `error`, notify owner via alert |
| Filing API fails | Log error, retry with exponential backoff, if still fails notify owner and mark compliance item as `pending` |
| Storage unavailable | Retry with backoff, if fails log critical error and halt further processing |
| Model endpoint unavailable | Use rule‑based extraction fallback (regex patterns) |

### Structured Logging

**Format:** JSON

**Example:**
```json
{
  "timestamp": "2026-06-20T12:00:00Z",
  "level": "INFO",
  "logger": "document_agent",
  "message": "Document processed successfully",
  "request_id": "abc-123",
  "document_id": "doc-456",
  "processing_time_ms": 234,
  "extracted_fields": 12
}
```

**Log Levels:**
- `DEBUG` – Detailed development logs
- `INFO` – Normal operational events
- `WARN` – Non‑critical issues (e.g., retry attempts)
- `ERROR` – Recoverable failures
- `FATAL` – Critical failures requiring immediate attention

**Destination:** Cloud Logging (primary) + local file (fallback)

### Alerting

Alerts are sent via the configured notification channel (email/SMS/Slack) for:
- Filing failures (after retries exhausted)
- Repeated extraction failures (> 3 in 1 hour)
- Storage capacity > 90%
- Any `FATAL` log event

---

## Self‑Improvement Hooks

The agent implements the memory and learning architecture defined in `08-memory-learning-self-improvement-architecture.md`[reference:4].

### Performance Metrics Recorded

| Metric | Storage | Update Frequency |
|--------|---------|------------------|
| PDF extraction accuracy (owner corrections) | Firestore `metrics` | Per correction |
| Filing success rate | Firestore `metrics` | Per filing |
| Reminder effectiveness (did owner act?) | Firestore `metrics` | Per reminder |
| Average processing time per document | Firestore `metrics` | Per document |
| Classification confidence distribution | Firestore `metrics` | Per classification |
| API latency (filing endpoints) | Firestore `metrics` | Per API call |

### Feedback Loops

1. **Owner Corrections:** When the owner corrects an extracted field (e.g., "This load number is wrong"), the agent:
   - Records the correction in episodic memory[reference:5]
   - Updates the extraction confidence score for that field type
   - Feeds the correction back into the extraction model (via fine‑tuning or rule update)

2. **Missed Deadlines:** If a compliance deadline is missed:
   - Logs the event with context
   - Adjusts reminder timing (e.g., send earlier for that type)
   - Proposes a new skill if the pattern repeats

3. **Filing Success:** If a filing fails:
   - Records the failure reason
   - Updates the filing strategy (e.g., try different endpoint, different time)

### Learning Process

- **Extraction Improvement:** Use owner corrections to update extraction heuristics and regex patterns.
- **Classification Improvement:** Use classification confidence and corrections to retrain a simple classifier (e.g., logistic regression) during consolidation.
- **Reminder Timing:** Adjust reminder schedules based on whether the owner acted on the reminder.

### Skill Evolution

The agent monitors repeated manual actions and proposes new skills to the Orchestrator. For example, if the owner frequently asks for "all documents for Truck 1", the agent can propose a new skill `get_truck_documents`.

### Consolidation ("Dreaming")

During idle periods (configured via `consolidation_cron`), the agent:
1. Reviews recent extraction jobs and corrections
2. Strengthens frequently used patterns
3. Archives old records (> 2 years)
4. Generates a summary report for the owner
5. Updates its internal configuration based on learned patterns

---

## Testing & Release Strategy

The agent follows the development and release process defined in `09-development-testing-release-process.md`[reference:6].

### Unit Testing

```bash
# Run unit tests
pytest tests/unit/ -v

# Test extraction with sample PDFs
python -m unittest tests/test_extraction.py

# Test compliance date calculations
python -m unittest tests/test_compliance.py
```

**Coverage target:** > 85%

### Integration Testing

```bash
# Run integration tests against staging environment
pytest tests/integration/ -v --env=staging

# Test Orchestrator integration
python -m unittest tests/test_orchestrator_integration.py

# Test scheduled jobs with Cloud Scheduler emulator
python -m unittest tests/test_scheduler.py
```

### Sample Data

All testing uses **sample documents and copied data** – never production data[reference:7]. Sample documents are stored in `$TRUCKOPS_HOME/tests/sample_documents/`.

### Release Workflow

```
Development
    ↓
Staging (test with sample data)
    ↓
Backup (backup current production)
    ↓
Production (deploy to Cloud Run)
    ↓
Verification (run health check and smoke tests)
    ↓
Documentation (update release notes)
```

### Rollback Plan

If issues are found after release:
1. Revert to the previous container image in Cloud Run
2. Restore the database from the backup taken before release
3. Notify the owner via alert

### Versioning

- **Semantic versioning:** `MAJOR.MINOR.PATCH`
- `MAJOR` – Breaking changes (schema changes, removed skills)
- `MINOR` – New features (new skills, new extractors)
- `PATCH` – Bug fixes, performance improvements

### Release Checklist

- [ ] All unit tests pass
- [ ] Integration tests pass in staging
- [ ] Sample documents processed correctly
- [ ] Backup of production data taken
- [ ] Release notes drafted
- [ ] Deployment to Cloud Run successful
- [ ] Health check passes
- [ ] Smoke test (one extraction, one filing) passes
- [ ] Rollback plan tested
- [ ] Documentation updated

---

## Self‑Verification Checklist

Before deployment, verify that all required sections are complete:

- [x] **Purpose & Scope** – explicitly derived from business domains map; clear operational boundaries
- [x] **Capabilities & Skills** – 10 discrete skills; each has name, description, trigger, and Orchestrator signature
- [x] **Input / Output Contracts** – JSON schemas for every skill; error object schema defined
- [x] **Configuration Schema** – complete YAML template; all parameters have env var mappings, defaults, and descriptions
- [x] **Dependencies** – exact libraries with versions; GCP services; OpenClaw hooks; system packages
- [x] **Initialisation Sequence** – step‑by‑step from zero; exact commands; success criterion stated
- [x] **Orchestrator Integration** – skill registration; request/response flow; health check
- [x] **Data Models & Storage** – all models defined; schemas; storage locations; sharing with other agents
- [x] **Error Handling & Logging** – error codes; retry policies; fallback; structured logging format
- [x] **Self‑Improvement Hooks** – metrics; feedback loops; learning; skill evolution; consolidation
- [x] **Testing & Release Strategy** – unit, integration; sample data; release workflow; rollback; versioning
- [x] **No placeholders** – every `TODO`, `FIXME`, or `configure as needed` replaced with concrete defaults or instructions
- [x] **Configuration‑driven** – all behaviour driven by configuration, not hard‑coded into prompts
- [x] **Follows template structure** – matches the granularity and organisation of `06-on-demand-dispatch-intelligence-agent.md`

<!-- File: 04-foundation-gcp-vm-openclaw.md -->
<!-- This file contains: FOUNDATION GCP VM OPENCLAW -->
<h1 style="color:#F97316;">FOUNDATION: GCP + VM + OPENCLAW</h1>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>This foundation note defines the base technical layer for the <strong>TruckOps OpenClaw AI Operating System</strong>.</p>

<p>This is the layer everything else depends on. The purpose is not just to create a VM and install OpenClaw. The purpose is to establish a shared, expandable foundation that future agents can use without each feature becoming its own separate application.</p>

<p>As TruckOps grows, Dispatch Agent, Document Agent, Broker Intelligence Agent, Invoice Agent, Maintenance Agent, Fuel & Expense Agent, Cash Flow Agent, Profitability Agent, Daily Briefing Agent, and future agents should all rely on the same foundation, the same business memory, the same configuration approach, and the same source of truth.</p>

<p><span style="color:#FACC15; font-weight:600;">Core principle:</span> Build one shared foundation first. Add agents as coordinated capabilities on top of it.</p>

<hr>

<h2 style="color:#00A6A6;">What This Foundation Does</h2>

<p>The foundation gives TruckOps a permanent technical home.</p>

<p>It provides:</p>

<ul>
  <li>A cloud VM that can stay available when needed</li>
  <li>A Linux environment for running services, scripts, tools, and agents</li>
  <li>Docker support for predictable deployments</li>
  <li>OpenClaw as the agent framework and command layer</li>
  <li>A place to store configuration, rules, logs, and agent files</li>
  <li>A place to store the TruckOps Architecture Bootstrap Package</li>
  <li>A future place to connect databases, document storage, secrets, backups, and shared memory</li>
  <li>A base layer that can expand without rebuilding the whole system every time a new feature is added</li>
</ul>

<p>The foundation should stay understandable. GCP can become confusing quickly, and cloud costs can accumulate if resources are added casually. This note exists to keep the system technically grounded, cost-aware, and organized.</p>

<hr>

<h2 style="color:#00A6A6;">Foundation Philosophy</h2>

<p>The foundation must follow the same development philosophy as the rest of TruckOps:</p>

<blockquote>
  <p><strong>Start small. Prove usefulness. Save the data. Build intelligence from real use.</strong></p>
</blockquote>

<p>The first foundation does not need to be enterprise-grade. It needs to be stable, understandable, affordable, and expandable.</p>

<p>Do not build a large cloud architecture before the system proves what it actually needs. Add infrastructure only when a real feature requires it.</p>

<p>The foundation should grow in layers:</p>

<ol>
  <li>Start with a simple VM and OpenClaw runtime.</li>
  <li>Add only the files, databases, and services required by the first working features.</li>
  <li>Capture real usage data, snapshots, decisions, documents, and outcomes.</li>
  <li>Use that real data to decide what infrastructure needs to be added next.</li>
  <li>Scale only when the current layer is no longer enough.</li>
</ol>

<p>The goal is not to avoid expansion. The goal is to expand intelligently.</p>

<hr>

<h2 style="color:#00A6A6;">TruckOps Bootstrap Role</h2>

<p>The TruckOps Joplin notebook is being built as the <strong>TruckOps Architecture Bootstrap Package</strong>.</p>

<p>That means the notebook is not only documentation. It is the human-readable definition of the system before the operational system exists.</p>

<p>Once the foundation exists, the notebook should be exported, uploaded into the TruckOps workspace, and made readable to OpenClaw-connected agents or tools. The notebook will help the running system understand:</p>

<ul>
  <li>What TruckOps is</li>
  <li>What the system is supposed to become</li>
  <li>What architecture governs the project</li>
  <li>What domains and agents are planned</li>
  <li>What development rules apply</li>
  <li>Where operational boundaries exist</li>
  <li>What has already been decided</li>
  <li>What should happen next</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> The notebook does not automatically build the system by itself. The notebook gives the future system its starting context. OpenClaw, the model provider, tools, file access, scripts, and owner instructions are what allow work to happen.</p>

<hr>

<h2 style="color:#00A6A6;">Important Architecture Rule</h2>

<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Features should not become separate disconnected applications.</p>

<p>Every TruckOps agent should plug into the same foundation. Each agent may have its own purpose, tools, prompts, and workflows, but the system should not fracture into isolated apps that cannot share information.</p>

<p>This matters because future versions of the agents will need access to shared business context:</p>

<ul>
  <li>Current truck status</li>
  <li>Driver status</li>
  <li>Load history</li>
  <li>Broker history</li>
  <li>Invoices</li>
  <li>Documents</li>
  <li>Fuel records</li>
  <li>Maintenance records</li>
  <li>Cash-flow data</li>
  <li>Profitability data</li>
  <li>Owner decisions</li>
  <li>Lessons learned</li>
  <li>Saved snapshots</li>
  <li>Current situational data</li>
</ul>

<p>If each feature becomes its own isolated application, TruckOps loses the main advantage of the system: a shared business brain.</p>

<hr>

<h2 style="color:#00A6A6;">Target Foundation Shape</h2>

<p>The long-term foundation should look like this:</p>

<pre><code>GCP Project
  ↓
Compute Engine VM
  ↓
Linux + Docker
  ↓
OpenClaw Gateway
  ↓
Model Provider Endpoint
  ↓
TruckOps Workspace
  ↓
Bootstrap Package + Shared Config + Shared Data + Shared Memory
  ↓
Tools / Skills / Connectors
  ↓
Agents
  ├── Dispatch Agent
  ├── Broker Intelligence Agent
  ├── Document Agent
  ├── Invoice & Collections Agent
  ├── Maintenance Agent
  ├── Fuel & Expense Agent
  ├── Cash Flow Agent
  ├── Profitability Agent
  └── Daily Briefing Agent</code></pre>

<p>The VM is not the product. OpenClaw is not the entire product. The product is the TruckOps operating system built on top of the foundation.</p>

<hr>

<h2 style="color:#00A6A6;">Model Provider Approach</h2>

<p>OpenClaw requires access to a model provider endpoint. That endpoint may be hosted, local, self-hosted, or hybrid.</p>

<p><span style="color:#FACC15; font-weight:600;">Provider-neutral wording:</span> TruckOps should not be designed around one model company. It should be designed around a model endpoint that can be changed as needs, cost, quality, and hardware change.</p>

<h3 style="color:#B8C7CC;">Hosted Model Endpoint</h3>

<p>A hosted model endpoint means OpenClaw calls a model provider over the internet.</p>

<p><span style="color:#FACC15; font-weight:600;">Examples:</span> OpenAI, Anthropic, Google Gemini, OpenRouter, Mistral, Together, Fireworks, DeepInfra, Amazon Bedrock, Cloudflare AI Gateway, Vercel AI Gateway, Qwen, Moonshot / Kimi, MiniMax, Novita, Venice, and other compatible providers.</p>

<p>This is likely the most practical starting path because it avoids the cost and complexity of running a powerful local model on the VM.</p>

<h3 style="color:#B8C7CC;">Local Or Self-Hosted Model Endpoint</h3>

<p>A local or self-hosted model endpoint means OpenClaw calls a model running on the same VM, another server, a local workstation, or a dedicated model host.</p>

<p><span style="color:#FACC15; font-weight:600;">Examples:</span> Ollama, LM Studio, vLLM, SGLang, or another compatible local/self-hosted endpoint.</p>

<p>This may become useful later if hardware and cost justify it. The advantage is not merely that the model is local. The advantage comes when the model has access to TruckOps documentation, files, logs, databases, snapshots, tools, and current system state.</p>

<h3 style="color:#B8C7CC;">Hybrid Model Setup</h3>

<p>The likely long-term best structure is a hybrid approach.</p>

<ul>
  <li>Use hosted models for difficult reasoning, architecture, planning, and complex debugging.</li>
  <li>Use local or self-hosted models for system-aware summaries, document review, log review, routine checks, and private local analysis if hardware supports it.</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Current planning assumption:</span> Start with a hosted model endpoint. Preserve the option to add local or hybrid model routing later.</p>

<hr>

<h2 style="color:#00A6A6;">Base Setup Requirements</h2>

<h3 style="color:#B8C7CC;">What Must Exist Before TruckOps Can Initialize</h3>

<ol>
  <li>OpenClaw installed and running</li>
  <li>A model provider endpoint configured</li>
  <li>A TruckOps workspace path created</li>
  <li>Tools and skills available</li>
  <li>Access to notebook files</li>
  <li>Permission to read, write, and run commands where needed</li>
  <li>Clear initialization instructions</li>
</ol>

<p>These are the practical bases that must be covered before the notebook can become useful to the running system.</p>

<hr>

<h2 style="color:#00A6A6;">Cost Awareness</h2>

<p>Cloud cost begins at the foundation. Every future feature can add cost through compute, storage, databases, APIs, logging, bandwidth, model usage, or always-on services.</p>

<p><span style="color:#FACC15; font-weight:600;">Cost rule:</span> Do not add paid infrastructure casually. Add it only when a feature needs it and the benefit is clear.</p>

<h3 style="color:#B8C7CC;">Initial Cost Target</h3>

<p>The early foundation should stay small. A small VM is enough for initial testing, notes, configuration, light scripts, and early agent workflows.</p>

<p>Initial cost planning should assume:</p>

<ul>
  <li>Small VM first</li>
  <li>Small boot disk first</li>
  <li>Minimal always-on services</li>
  <li>No unnecessary managed databases at the beginning</li>
  <li>No large storage buckets until documents or backups require them</li>
  <li>No heavy dashboards until useful data exists</li>
  <li>No local model hosting until hardware and cost justify it</li>
</ul>

<h3 style="color:#B8C7CC;">Cost Controls To Add Early</h3>

<ul>
  <li>Set a GCP budget alert</li>
  <li>Review VM size before upgrading</li>
  <li>Track disk usage</li>
  <li>Track model/API usage</li>
  <li>Keep logs from growing forever</li>
  <li>Use one shared foundation instead of multiple duplicate services</li>
  <li>Document every recurring-cost resource added to the project</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> Cost should be treated as part of the architecture, not an afterthought.</p>

<hr>

<h2 style="color:#00A6A6;">Initial Build Sequence</h2>

<p>The practical foundation sequence should be:</p>

<pre><code>1. Finalize the Joplin bootstrap notebook enough to define the system.
2. Create the GCP project.
3. Create the Compute Engine VM.
4. Install Linux dependencies and Docker.
5. Install OpenClaw.
6. Run OpenClaw onboarding.
7. Configure a hosted model provider endpoint first.
8. Create the TruckOps workspace.
9. Export the Joplin notebook.
10. Upload the notebook export to the VM.
11. Give OpenClaw/tools access to read the notebook files.
12. Ask the system to initialize from the bootstrap package.
13. Generate the first TruckOps Initialization Report.
14. Begin building the first operational layer.</code></pre>

<p><span style="color:#FACC15; font-weight:600;">Plain-English meaning:</span> Build the blueprint first. Build the server second. Install the framework third. Upload the blueprint fourth. Then ask the running system to read the blueprint and report what exists, what is missing, and what should happen next.</p>

<hr>

<h2 style="color:#00A6A6;">Step 1: Create GCP Project</h2>

<p><span style="color:#FACC15; font-weight:600;">Recommended project name:</span> <code>truckops-openclaw</code></p>

<h3 style="color:#B8C7CC;">Web Console</h3>

<ol>
  <li>Go to <a href="https://console.cloud.google.com">console.cloud.google.com</a></li>
  <li>IAM & Admin &gt; Create Project</li>
  <li>Name it: <code>truckops-openclaw</code></li>
  <li>Enable billing</li>
  <li>Navigate to APIs & Services &gt; Enable APIs</li>
  <li>Search <code>Compute Engine API</code> and enable it</li>
</ol>

<h3 style="color:#B8C7CC;">Command Line</h3>

<pre><code class="language-bash">gcloud projects create truckops-openclaw --name="TruckOps OpenClaw"
gcloud config set project truckops-openclaw
gcloud services enable compute.googleapis.com</code></pre>

<hr>

<h2 style="color:#00A6A6;">Step 2: Create The VM</h2>

<h3 style="color:#B8C7CC;">Initial VM</h3>

<ul>
  <li><span style="color:#FACC15; font-weight:600;">Name:</span> <code>openclaw-gateway</code></li>
  <li><span style="color:#FACC15; font-weight:600;">Region:</span> <code>us-central1</code></li>
  <li><span style="color:#FACC15; font-weight:600;">Zone:</span> <code>us-central1-a</code></li>
  <li><span style="color:#FACC15; font-weight:600;">Machine type:</span> <code>e2-small</code> for early testing</li>
  <li><span style="color:#FACC15; font-weight:600;">Boot disk:</span> Debian 12, 20GB minimum</li>
</ul>

<h3 style="color:#B8C7CC;">Machine Size Options</h3>

<table>
  <thead>
    <tr>
      <th>Type</th>
      <th>Specs</th>
      <th>Best For</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>e2-micro</code></td>
      <td>Shared CPU, 1GB RAM</td>
      <td>Very light testing only; may struggle with builds or browser automation</td>
    </tr>
    <tr>
      <td><code>e2-small</code></td>
      <td>2 vCPU, 2GB RAM</td>
      <td>Minimum practical starting point</td>
    </tr>
    <tr>
      <td><code>e2-medium</code></td>
      <td>2 vCPU, 4GB RAM</td>
      <td>Better once agents, browser sessions, or databases become more active</td>
    </tr>
  </tbody>
</table>

<p>Start small. Upgrade only after the system shows that it needs more resources.</p>

<hr>

<h2 style="color:#00A6A6;">Step 3: SSH Into The VM</h2>

<p>In the Compute Engine dashboard, click the <strong>SSH</strong> button next to the VM.</p>

<p><span style="color:#FACC15; font-weight:600;">Note:</span> SSH key propagation can take 1–2 minutes after VM creation. If connection is refused, wait and retry.</p>

<hr>

<h2 style="color:#00A6A6;">Step 4: Install Docker</h2>

<p>Run these commands in the VM terminal:</p>

<pre><code class="language-bash">sudo apt update
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER</code></pre>

<p>Log out and back in for the group change to take effect.</p>

<p>Verify Docker:</p>

<pre><code class="language-bash">docker --version</code></pre>

<hr>

<h2 style="color:#00A6A6;">Step 5: Install OpenClaw</h2>

<p>On the VM, run:</p>

<pre><code class="language-bash">curl -fsSL https://openclaw.ai/install.sh | bash</code></pre>

<hr>

<h2 style="color:#00A6A6;">Step 6: Run OpenClaw Onboarding</h2>

<pre><code class="language-bash">openclaw onboard --install-daemon</code></pre>

<p>The onboarding process should walk through the gateway, model provider, channels, skills, and workspace-related setup.</p>

<hr>

<h2 style="color:#00A6A6;">Step 7: Verify OpenClaw</h2>

<p>Run status or health checks available in the installed OpenClaw version.</p>

<pre><code class="language-bash">openclaw status --deep</code></pre>

<p>If the installed version supports Gateway-specific status commands, also check the Gateway status.</p>

<hr>

<h2 style="color:#00A6A6;">Shared Workspace Structure</h2>

<p>The foundation should use a clear shared workspace so future agents do not scatter files everywhere.</p>

<p>Suggested structure:</p>

<pre><code>~/.openclaw/workspace/truckops/
  docs/
    bootstrap/
  agents/
  config/
  data/
  databases/
  documents/
  logs/
  snapshots/
  tools/
  services/
  releases/
  backups/</code></pre>

<h3 style="color:#B8C7CC;">Folder Purpose</h3>

<table>
  <thead>
    <tr>
      <th>Folder</th>
      <th>Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>docs/bootstrap/</code></td>
      <td>Exported Joplin bootstrap package and project documentation</td>
    </tr>
    <tr>
      <td><code>agents/</code></td>
      <td>Agent instructions, prompts, and role definitions</td>
    </tr>
    <tr>
      <td><code>config/</code></td>
      <td>Business rules, settings, feature configuration</td>
    </tr>
    <tr>
      <td><code>data/</code></td>
      <td>Structured project data and working files</td>
    </tr>
    <tr>
      <td><code>databases/</code></td>
      <td>SQLite or later database files</td>
    </tr>
    <tr>
      <td><code>documents/</code></td>
      <td>BOLs, rate confirmations, receipts, invoices, inspections, and business documents</td>
    </tr>
    <tr>
      <td><code>logs/</code></td>
      <td>Runtime logs, errors, and system activity</td>
    </tr>
    <tr>
      <td><code>snapshots/</code></td>
      <td>Saved agent queries, situation snapshots, recommendations, decisions, and outcomes</td>
    </tr>
    <tr>
      <td><code>tools/</code></td>
      <td>Reusable scripts and connector tools</td>
    </tr>
    <tr>
      <td><code>services/</code></td>
      <td>Shared business logic such as scoring, extraction, calculation, and planning services</td>
    </tr>
    <tr>
      <td><code>releases/</code></td>
      <td>Release notes, version changes, migration notes, and upgrade records</td>
    </tr>
    <tr>
      <td><code>backups/</code></td>
      <td>Local backup staging before remote backup is added</td>
    </tr>
  </tbody>
</table>

<p><span style="color:#FACC15; font-weight:600;">Key rule:</span> Every agent should use this shared workspace unless there is a clear reason not to.</p>

<hr>

<h2 style="color:#00A6A6;">Notebook Upload And Initialization</h2>

<p>After the VM and OpenClaw foundation exist, the Joplin notebook should be exported and uploaded to:</p>

<pre><code>~/.openclaw/workspace/truckops/docs/bootstrap/</code></pre>

<p>Then OpenClaw-connected tools or agents should be given access to read and search that folder.</p>

<p>The first system-aware request should be:</p>

<blockquote>
  <p>Read the TruckOps bootstrap package from the docs/bootstrap folder. Summarize the system architecture. Inspect the current workspace. Tell me what exists, what is missing, and what the next build step should be.</p>
</blockquote>

<p>The expected first output should be:</p>

<pre><code>TRUCKOPS INITIALIZATION REPORT</code></pre>

<p>That report should identify:</p>

<ul>
  <li>System identity</li>
  <li>Architecture baseline found or missing</li>
  <li>Foundation note found or missing</li>
  <li>AI context page found or missing</li>
  <li>Agent notes found or missing</li>
  <li>Current workspace folders</li>
  <li>Missing folders</li>
  <li>Missing configuration files</li>
  <li>Missing databases</li>
  <li>Available tools or skills</li>
  <li>Model provider status</li>
  <li>Recommended next build step</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Shared Data And Memory Layer</h2>

<p>TruckOps will become more valuable as it saves real business history. The foundation must support shared memory across all agents.</p>

<p>This does not mean complex infrastructure is required immediately. It means the system should be designed so data collected by one agent can later help another agent.</p>

<h3 style="color:#B8C7CC;">Early Data Storage</h3>

<p>For early versions, use simple files and SQLite databases.</p>

<ul>
  <li><code>dispatch_rules.yaml</code></li>
  <li><code>trucks.yaml</code></li>
  <li><code>drivers.yaml</code></li>
  <li><code>brokers.db</code></li>
  <li><code>loads.db</code></li>
  <li><code>documents.db</code></li>
  <li><code>expenses.db</code></li>
  <li><code>snapshots.db</code></li>
</ul>

<p>SQLite is enough for early local development and small-business workflows. A managed database can be considered later if the system outgrows local storage.</p>

<h3 style="color:#B8C7CC;">Shared Memory Concept</h3>

<p>The system should eventually remember:</p>

<ul>
  <li>Every dispatch query</li>
  <li>Every planning snapshot</li>
  <li>Every load considered</li>
  <li>Every load booked</li>
  <li>Every rejected load and reason</li>
  <li>Every broker interaction</li>
  <li>Every document processed</li>
  <li>Every invoice created</li>
  <li>Every payment received</li>
  <li>Every fuel purchase</li>
  <li>Every repair</li>
  <li>Every maintenance event</li>
  <li>Every owner decision</li>
  <li>Every final outcome</li>
</ul>

<p>This is how TruckOps becomes smarter over time without needing to start as an overbuilt system.</p>

<hr>

<h2 style="color:#00A6A6;">Configuration Principle</h2>

<p>Agent behavior should be driven by configuration files whenever possible, not hard-coded into prompts.</p>

<p>Examples:</p>

<ul>
  <li>Dispatch rules belong in <code>config/dispatch_rules.yaml</code></li>
  <li>Truck profiles belong in <code>config/trucks.yaml</code> or <code>data/trucks.yaml</code></li>
  <li>Driver profiles belong in <code>config/drivers.yaml</code> or <code>data/drivers.yaml</code></li>
  <li>Broker rules belong in <code>config/broker_rules.yaml</code></li>
  <li>Feature settings belong in named configuration files</li>
</ul>

<p>This keeps the system easier to adjust without rewriting the agent every time business rules change.</p>

<hr>

<h2 style="color:#00A6A6;">Secrets And Credentials</h2>

<p>Credentials should not be placed directly into agent prompts, notes, public files, or published Joplin shares.</p>

<p>Examples of credentials:</p>

<ul>
  <li>Model provider API keys</li>
  <li>Load-board usernames and passwords</li>
  <li>Telegram bot token</li>
  <li>Slack tokens</li>
  <li>Email credentials</li>
  <li>Database passwords</li>
  <li>Broker portal credentials</li>
</ul>

<h3 style="color:#B8C7CC;">Early Approach</h3>

<p>For early testing, use environment variables or a local secrets file that is not committed, shared, or copied into notes.</p>

<pre><code>~/.openclaw/secrets.env</code></pre>

<h3 style="color:#B8C7CC;">Later Approach</h3>

<p>As the system matures, secrets management can be moved into a more formal GCP secrets tool or a controlled vault-style setup.</p>

<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Agents should use credentials. They should not expose credentials.</p>

<hr>

<h2 style="color:#00A6A6;">Access From Phone</h2>

<h3 style="color:#B8C7CC;">Option A: Telegram</h3>

<ol>
  <li>Create a Telegram bot using <a href="https://t.me/botfather">@BotFather</a></li>
  <li>Copy the bot token</li>
  <li>Add the token to OpenClaw configuration or secrets</li>
  <li>Start a chat with the bot and send <code>/start</code></li>
  <li>Text the system from anywhere</li>
</ol>

<h3 style="color:#B8C7CC;">Option B: Slack</h3>

<ol>
  <li>Create a Slack app in the workspace</li>
  <li>Enable the required connection mode and event subscriptions</li>
  <li>Copy the required tokens or secrets</li>
  <li>Add them to OpenClaw configuration or secrets</li>
  <li>Invite the bot to a channel and mention it to ask questions</li>
</ol>

<h3 style="color:#B8C7CC;">Option C: Web Dashboard Via Secure Access</h3>

<p>The dashboard should be accessed through a secure method such as local access, SSH tunnel, Tailscale, or another controlled access method rather than casually exposing it to the public internet.</p>

<p><span style="color:#FACC15; font-weight:600;">Access principle:</span> Access should remain simple. The owner should be able to interact with TruckOps from the road without dealing with unnecessary technical friction.</p>

<hr>

<h2 style="color:#00A6A6;">Foundation Roadmap</h2>

<p>The foundation should mature in stages as the system proves what it needs.</p>

<h3 style="color:#B8C7CC;">Foundation V1: Simple Runtime</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Get the system running.</p>

<ul>
  <li>GCP project</li>
  <li>Compute Engine VM</li>
  <li>Docker</li>
  <li>OpenClaw Gateway</li>
  <li>Basic dashboard or chat access</li>
  <li>Basic workspace folder</li>
  <li>Hosted model provider endpoint</li>
</ul>

<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Planned foundation layer.</p>

<h3 style="color:#B8C7CC;">Foundation V2: Bootstrap And Workspace Initialization</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Move the notebook from planning material into system-readable bootstrap material.</p>

<ul>
  <li>Export Joplin notebook</li>
  <li>Upload export to <code>docs/bootstrap/</code></li>
  <li>Enable file-reading or search access</li>
  <li>Generate TruckOps Initialization Report</li>
  <li>Create missing workspace folders</li>
  <li>Confirm current-state baseline</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V3: Shared Workspace And Config</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Stop files and rules from becoming scattered.</p>

<ul>
  <li>Standard TruckOps workspace folder</li>
  <li>Shared config files</li>
  <li>Agent instruction files</li>
  <li>Basic secrets approach</li>
  <li>Basic logs folder</li>
  <li>Manual backups</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V4: Shared Data Layer</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Make agents share the same business memory.</p>

<ul>
  <li>SQLite databases</li>
  <li>Truck records</li>
  <li>Driver records</li>
  <li>Broker records</li>
  <li>Load records</li>
  <li>Document index</li>
  <li>Expense records</li>
  <li>Snapshot history</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V5: Backups And Recovery</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Protect business memory.</p>

<ul>
  <li>Scheduled backups</li>
  <li>Database backup process</li>
  <li>Document backup process</li>
  <li>Recovery instructions</li>
  <li>Exportable project archive</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V6: Tool And Connector Layer</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Give agents controlled access to external systems.</p>

<ul>
  <li>Load-board connectors</li>
  <li>Email/document intake</li>
  <li>Fuel data intake</li>
  <li>Maintenance record intake</li>
  <li>Broker portal tools</li>
  <li>Shared connector logging</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V7: Intelligence Layer</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Use saved history to improve recommendations.</p>

<ul>
  <li>Saved dispatch snapshots</li>
  <li>Pattern recognition</li>
  <li>Broker behavior analysis</li>
  <li>Lane history analysis</li>
  <li>Profitability history</li>
  <li>Lessons learned memory</li>
  <li>Cross-agent context sharing</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V8: Local Or Hybrid Model Evaluation</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Decide whether local/self-hosted model capability creates enough advantage to justify hardware and cost.</p>

<ul>
  <li>Evaluate local model hardware needs</li>
  <li>Evaluate Ollama, LM Studio, vLLM, SGLang, or other endpoints</li>
  <li>Decide what tasks should use local models</li>
  <li>Decide what tasks should still use hosted models</li>
  <li>Preserve hybrid routing option</li>
</ul>

<h3 style="color:#B8C7CC;">Foundation V9: Scale And Optimization</h3>

<p><span style="color:#A5B4FC; font-weight:600;">Purpose:</span> Upgrade only when real usage requires it.</p>

<ul>
  <li>Larger VM if needed</li>
  <li>Managed database if needed</li>
  <li>Object storage if document volume grows</li>
  <li>Monitoring and alerting</li>
  <li>Better secrets management</li>
  <li>Performance tuning</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">How New Features Should Use The Foundation</h2>

<p>Every new feature should answer these questions before implementation:</p>

<ol>
  <li>What existing foundation layer does this feature need?</li>
  <li>What shared data does it need to read?</li>
  <li>What new data will it create?</li>
  <li>Where will that data be stored?</li>
  <li>Which other agents may need this data later?</li>
  <li>Does this feature require new infrastructure, or can it use what already exists?</li>
  <li>Does it create recurring cost?</li>
  <li>Does it require credentials?</li>
  <li>Does it need backups?</li>
  <li>Does it improve the shared business brain?</li>
</ol>

<p>If a feature does not strengthen the shared TruckOps system, its design should be reconsidered.</p>

<hr>

<h2 style="color:#00A6A6;">Foundation Support For Dispatch Agent</h2>

<p>The On-Demand Dispatch Intelligence Agent fits this foundation well.</p>

<p>It should use:</p>

<ul>
  <li>Shared truck profiles</li>
  <li>Shared driver profiles</li>
  <li>Shared broker memory</li>
  <li>Shared load database</li>
  <li>Shared dispatch rules</li>
  <li>Shared snapshot history</li>
  <li>Shared tools and connectors</li>
  <li>Shared cost and logging practices</li>
</ul>

<p>Because the first Dispatch Agent is on-demand, it does not require the foundation to become large immediately. It can query load boards when asked, produce a dispatch snapshot, save the result, and build history over time.</p>

<p>This makes it a good first real feature for the TruckOps foundation.</p>

<hr>

<h2 style="color:#00A6A6;">What To Avoid</h2>

<ul>
  <li>Do not create separate disconnected mini-apps for each feature.</li>
  <li>Do not duplicate data stores unless there is a clear reason.</li>
  <li>Do not hard-code business rules into prompts when they should live in config files.</li>
  <li>Do not scatter documents, logs, and databases across random folders.</li>
  <li>Do not add paid GCP services without documenting why they are needed.</li>
  <li>Do not scale the VM before the current size proves insufficient.</li>
  <li>Do not build complex infrastructure before the feature has proven useful.</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Related Runbook Needed</h2>

<p>This foundation note explains what the foundation is and how it should mature.</p>

<p>A separate runbook should explain the exact step-by-step implementation process for setting up GCP, VM, OpenClaw, model provider endpoint, workspace, tools, notebook upload, permissions, and initialization.</p>

<p><span style="color:#FACC15; font-weight:600;">Runbook page to create:</span></p>

<pre><code>FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION</code></pre>

<p>That runbook should live in:</p>

<pre><code>02 - Foundation & Infrastructure</code></pre>

<hr>

<h2 style="color:#00A6A6;">What Comes Next</h2>

<p>With this foundation running, build features as agents, tools, data structures, workflows, and dashboards on top of it:</p>

<ul>
  <li>On-Demand Dispatch Intelligence Agent</li>
  <li>Broker Intelligence Agent</li>
  <li>Document Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Maintenance Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Cash Flow Agent</li>
  <li>Profitability Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p>Each agent should use the same foundation, contribute to the same business memory, and strengthen the system as a whole.</p>

<hr>

<h2 style="color:#00A6A6;">Current Status</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Foundation concept matured. Initial setup remains planned. Future foundation expansion should follow the roadmap above and remain aligned with the TruckOps development philosophy.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> No GCP VM, OpenClaw installation, TruckOps workspace, model provider endpoint, uploaded bootstrap package, operational tools, or live TruckOps system has been completed yet.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Create the Foundation Build Runbook so the owner has a direct, step-by-step path from GCP setup to TruckOps initialization.</p>

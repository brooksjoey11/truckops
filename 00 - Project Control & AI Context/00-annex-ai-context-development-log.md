<!-- File: 00-annex-ai-context-development-log.md -->
<!-- This file contains: ANNEX: AI CONTEXT & DEVELOPMENT LOG -->
<h1 style="color:#F97316;">ANNEX: AI CONTEXT & DEVELOPMENT LOG</h1>
<h3 style="color:#B8C7CC;">The context, guidelines, and development log for the TruckOps OpenClaw AI Operating System.</h3>
<hr>

<h2 style="color:#00A6A6;">Purpose</h2>
<p>This note serves as the contextual anchor for the <strong>TruckOps OpenClaw AI Operating System</strong>.</p>
<p>Its purpose is to provide an AI assistant with a quick, consolidated understanding of what TruckOps is, what it is becoming, what has been defined, what has not been built yet, and how the system should be developed going forward.</p>
<p>Future versions of the AI assistant should read this note first to understand the project before interacting with other notes.</p>
<p>This page contains:</p>
<ul>
  <li>How to use this notebook as a bootstrap package</li>
  <li>Core development rules</li>
  <li>Current documentation status</li>
  <li>What is already defined vs. what is still planned</li>
  <li>Key lessons learned during development</li>
  <li>Decision records that matter for future development</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">How To Use This Notebook</h2>
<p>The TruckOps Joplin notebook is intended to become the <strong>TruckOps Architecture Bootstrap Package</strong>.</p>
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

<h2 style="color:#00A6A6;">Core Development Rules</h2>
<p>These are the non-negotiable rules that guide all TruckOps development:</p>
<ol>
  <li><strong>Start small. Prove usefulness. Save the data. Build intelligence from real use.</strong></li>
  <li>Features should <strong>not</strong> become separate disconnected applications. Every agent should plug into the same foundation.</li>
  <li>Agent behavior should be driven by configuration files whenever possible, not hard-coded into prompts.</li>
  <li>Credentials should never be stored in Joplin notes, public files, or agent prompts.</li>
  <li>Data collected by one agent must be accessible to other agents. The system must have a shared business brain.</li>
  <li>Development work should not interfere with production records, live documents, active databases, or operational decisions.</li>
  <li>Before a feature is released, it must be tested with sample or copied data, validated, and backed up.</li>
  <li>Every meaningful change should be documented in a release note.</li>
</ol>
<hr>

<h2 style="color:#00A6A6;">Project Status Overview</h2>
<table>
  <thead>
    <tr>
      <th>Component</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Joplin bootstrap notebook</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>Project Overview</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>System Architecture Baseline</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>Foundation: GCP + VM + OpenClaw</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>Foundation Build Runbook</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>TruckOps Business Domains Map</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>On-Demand Dispatch Intelligence Agent</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>Data, Memory & Records Baseline</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>Memory, Learning & Self-Improvement Architecture</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>Development, Testing & Release Process</td>
      <td><span style="color:#34D399;">Complete</span></td>
    </tr>
    <tr>
      <td>GCP Project</td>
      <td><span style="color:#FCD34D;">Not created</span></td>
    </tr>
    <tr>
      <td>Compute Engine VM</td>
      <td><span style="color:#FCD34D;">Not created</span></td>
    </tr>
    <tr>
      <td>OpenClaw installation</td>
      <td><span style="color:#FCD34D;">Not installed</span></td>
    </tr>
    <tr>
      <td>TruckOps workspace</td>
      <td><span style="color:#FCD34D;">Not created</span></td>
    </tr>
    <tr>
      <td>Model provider endpoint</td>
      <td><span style="color:#FCD34D;">Not configured</span></td>
    </tr>
    <tr>
      <td>Bootstrap package upload</td>
      <td><span style="color:#FCD34D;">Not uploaded</span></td>
    </tr>
    <tr>
      <td>Initialization Report</td>
      <td><span style="color:#FCD34D;">Not generated</span></td>
    </tr>
    <tr>
      <td>Dispatch Agent V1</td>
      <td><span style="color:#FCD34D;">Not built</span></td>
    </tr>
  </tbody>
</table>
<hr>

<h2 style="color:#00A6A6;">Documentation Suite Summary</h2>
<p>The complete TruckOps bootstrap package now includes the following notes. They should be read in this order:</p>
<table>
  <thead>
    <tr>
      <th>Order</th>
      <th>Note</th>
      <th>Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>PROJECT OVERVIEW: TRUCKOPS OPENCLAW AI OPERATING SYSTEM</td>
      <td>Defines what TruckOps is and why it exists</td>
    </tr>
    <tr>
      <td>2</td>
      <td>SYSTEM ARCHITECTURE BASELINE</td>
      <td>Defines how TruckOps is organized</td>
    </tr>
    <tr>
      <td>3</td>
      <td>FOUNDATION: GCP + VM + OPENCLAW</td>
      <td>Defines the technical foundation concept</td>
    </tr>
    <tr>
      <td>4</td>
      <td>FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION</td>
      <td>Step-by-step build guide for the foundation</td>
    </tr>
    <tr>
      <td>5</td>
      <td>TRUCKOPS BUSINESS DOMAINS MAP</td>
      <td>Maps business areas to agents and data</td>
    </tr>
    <tr>
      <td>6</td>
      <td>DATA, MEMORY & RECORDS BASELINE</td>
      <td>Defines what data exists and where it lives</td>
    </tr>
    <tr>
      <td>7</td>
      <td>MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE</td>
      <td>Defines how the system learns and improves</td>
    </tr>
    <tr>
      <td>8</td>
      <td>ON-DEMAND DISPATCH INTELLIGENCE AGENT</td>
      <td>Defines the first operational agent</td>
    </tr>
    <tr>
      <td>9</td>
      <td>DEVELOPMENT, TESTING & RELEASE PROCESS</td>
      <td>Defines how changes are safely made</td>
    </tr>
    <tr>
      <td>10</td>
      <td>ANNEX: AI CONTEXT & DEVELOPMENT LOG</td>
      <td>Provides context and tracks progress</td>
    </tr>
  </tbody>
</table>
<hr>

<h2 style="color:#00A6A6;">Joplin Notebook Role</h2>
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

<h2 style="color:#00A6A6;">Key Decisions Log</h2>
<h3 style="color:#B8C7CC;">Decision: Foundation-First Approach</h3>
<p><strong>Date:</strong> June 2026</p>
<p><strong>Decision:</strong> Build one shared foundation first. Add agents as coordinated capabilities on top of it.</p>
<p><strong>Rationale:</strong> Features should not become separate disconnected applications. Every TruckOps agent should plug into the same foundation. Each agent may have its own purpose, tools, prompts, and workflows, but the system should not fracture into isolated apps that cannot share information.</p>
<hr>

<h3 style="color:#B8C7CC;">Decision: Hosted Model First</h3>
<p><strong>Date:</strong> June 2026</p>
<p><strong>Decision:</strong> Start with a hosted model provider endpoint. Preserve the option to add local or hybrid model routing later.</p>
<p><strong>Rationale:</strong> A hosted model endpoint avoids the cost and complexity of running a powerful local model on the VM. This is likely the most practical starting path.</p>
<hr>

<h3 style="color:#B8C7CC;">Decision: On-Demand Dispatch First</h3>
<p><strong>Date:</strong> June 2026</p>
<p><strong>Decision:</strong> The On-Demand Dispatch Intelligence Agent is the first operational agent to build.</p>
<p><strong>Rationale:</strong> It is on-demand, so it does not require the foundation to become large immediately. It can query load boards when asked, produce a dispatch snapshot, save the result, and build history over time. This makes it a good first real feature for the TruckOps foundation.</p>
<hr>

<h3 style="color:#B8C7CC;">Decision: Data-First Documentation</h3>
<p><strong>Date:</strong> June 2026</p>
<p><strong>Decision:</strong> Define the complete data, memory, and records structure before building any operational system.</p>
<p><strong>Rationale:</strong> The system should not rely on memory inside a chat thread. If something matters to the business, it should be saved into the TruckOps workspace. Defining the data structure first ensures the system is built around the business, not around technical convenience.</p>
<hr>

<h3 style="color:#B8C7CC;">Decision: Self-Improvement Architecture</h3>
<p><strong>Date:</strong> June 2026</p>
<p><strong>Decision:</strong> Include a memory, learning, and self-improvement architecture as a core part of the system design.</p>
<p><strong>Rationale:</strong> TruckOps should not just answer questions. It should remember, learn, reflect, and improve. The system should become a business partner, not just a tool.</p>
<hr>

<h2 style="color:#00A6A6;">Lessons Learned</h2>
<h3 style="color:#B8C7CC;">Lesson: Context is Limited</h3>
<p>AI assistants have limited context windows. Memory is a hurdle with any AI. It builds quickly and overwhelms.</p>
<p><strong>Mitigation:</strong> TruckOps uses layered memory (short-term, long-term semantic, episodic, active recall, self-improvement) so the system does not rely only on the current chat session. Memory plugins like <code>memory-lancedb</code> and <code>memory-wiki</code> provide persistent, searchable memory.</p>
<hr>

<h3 style="color:#B8C7CC;">Lesson: Records vs Memory vs Intelligence</h3>
<p>Data, memory, and intelligence are different layers. Records are raw facts. Memory is useful history. Intelligence is patterns learned from history.</p>
<p><strong>Mitigation:</strong> Separate the data layer from the learning layer. Use records for business data. Use snapshots for episodic memory. Use pattern recognition for intelligence.</p>
<hr>

<h3 style="color:#B8C7CC;">Lesson: Build the Blueprint First</h3>
<p>A system built without a clear architecture becomes a messy pile of experiments, half-built agents, random scripts, and temporary files.</p>
<p><strong>Mitigation:</strong> Define the complete architecture, domains, data, and development process before building anything. The Joplin notebook serves as the "blueprint" that guides all future development.</p>
<hr>

<h3 style="color:#B8C7CC;">Lesson: Internal Consistency Matters</h3>
<p>When documentation is inconsistent (e.g., the Memory note says "install the mandatory memory stack" but the runbook doesn't include it), it creates confusion and delays.</p>
<p><strong>Mitigation:</strong> Cross-reference notes and keep them synchronized. The Foundation Build Runbook now includes recommended memory plugin configuration steps, and the Memory note clarifies which plugins are truly mandatory vs. recommended vs. optional.</p>
<hr>

<h3 style="color:#B8C7CC;">Lesson: Distinguish Official from Community</h3>
<p>Community tools like <code>openclaw-superpowers</code> can significantly enhance capabilities, but they are not official OpenClaw plugins. Relying on them as "mandatory" creates risk if they break or are discontinued.</p>
<p><strong>Mitigation:</strong> The core foundation should depend only on official, bundled components. Community tools should be evaluated after the foundation is stable and treated as optional enhancements.</p>
<hr>

<h2 style="color:#00A6A6;">Current Status</h2>
<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Documentation complete. The complete TruckOps Architecture Bootstrap Package has been defined.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> No GCP VM, OpenClaw installation, TruckOps workspace, model provider endpoint, uploaded bootstrap package, operational tools, or live TruckOps system has been completed yet.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Execute the <strong>FOUNDATION BUILD RUNBOOK</strong> to provision the GCP VM, install OpenClaw, and create the initial workspace. Following that, upload the bootstrap package, generate the first TruckOps Initialization Report, and begin building the On-Demand Dispatch Intelligence Agent.</p>
<hr>

<h2 style="color:#00A6A6;">What Comes Next</h2>
<p>With the foundation built, build features as agents, tools, data structures, workflows, and dashboards on top of it:</p>
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

<h2 style="color:#00A6A6;">Note Version History</h2>
<table>
  <thead>
    <tr>
      <th>Version</th>
      <th>Date</th>
      <th>Change</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>v1.0</td>
      <td>June 2026</td>
      <td>Initial creation of Annex note</td>
    </tr>
    <tr>
      <td>v1.1</td>
      <td>June 2026</td>
      <td>Updated status to reflect complete documentation suite; added Foundation Build Runbook to completed list; updated "Next likely step" to execution phase; added Lessons Learned section</td>
    </tr>
  </tbody>
</table>

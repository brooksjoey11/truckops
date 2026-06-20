<!-- File: 01-project-overview.md -->
<!-- This file contains: PROJECT OVERVIEW -->
<h1 style="color:#F97316;">SYSTEM ARCHITECTURE BASELINE</h1>

<h3 style="color:#B8C7CC;">The organizing map for the entire TruckOps OpenClaw AI Operating System.</h3>

<hr>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>This page defines the baseline architecture for the <strong>TruckOps OpenClaw AI Operating System</strong>.</p>

<p>The purpose of this page is to explain how the entire system is organized before individual features, agents, tools, databases, or automations are built.</p>

<p>This is not only a technical architecture page. It defines the full operating architecture of the project:</p>

<ul>
  <li>The business areas TruckOps supports</li>
  <li>The shared foundation everything depends on</li>
  <li>The data and memory layer that makes the system smarter over time</li>
  <li>The agents that perform specialized work</li>
  <li>The features those agents create</li>
  <li>The business problems those features solve</li>
  <li>The separation between operational use and development/testing</li>
  <li>The path for moving tested upgrades into the live system</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Purpose in one sentence:</span> This page tells future AI instances, developers, and the owner where new ideas belong inside TruckOps before anything is built.</p>

<hr>

<h2 style="color:#00A6A6;">Plain-English Definition</h2>

<p>TruckOps is a private AI-supported business operating system for an owner-operator trucking business.</p>

<p>It is not meant to be a pile of disconnected tools. It is meant to become one coordinated system where the foundation, agents, data, records, decisions, lessons learned, and daily operations all support one another.</p>

<p>The basic idea is:</p>

<blockquote>
  <p><strong>Build one shared foundation. Add useful agents on top. Save what they learn. Use that history to make the business sharper over time.</strong></p>
</blockquote>

<hr>

<h2 style="color:#00A6A6;">Architecture In One View</h2>

<pre><code>TruckOps OpenClaw AI Operating System

  Project Documentation Layer
    ↓
  Foundation & Infrastructure Layer
    ↓
  Shared Data, Memory & Records Layer
    ↓
  Shared Planning & Intelligence Layer
    ↓
  Business Domains
    ├── Administrative Domain
    ├── Operations Domain
    ├── Planning & Intelligence Domain
    ├── Development, Testing & Release Domain
    └── Future Productization Domain
    ↓
  Agents
    ↓
  Features
    ↓
  Business Solutions
    ↓
  Saved History + Lessons Learned
    ↓
  Smarter Future Versions</code></pre>

<p>This structure should guide future development. New ideas should be placed into the existing architecture instead of becoming isolated side projects.</p>

<hr>

<h2 style="color:#00A6A6;">Core Architectural Principle</h2>

<p><span style="color:#FACC15; font-weight:600;">Principle:</span> TruckOps should be built as one connected operating system, not as separate mini-applications.</p>

<p>Each agent may have its own job, but all agents should rely on the shared foundation, shared data, shared memory, shared rules, shared records, and shared lessons learned.</p>

<p>This matters because the real power of TruckOps comes from connection.</p>

<p>A Dispatch Agent becomes more useful when it can see broker history, maintenance status, fuel cost, driver availability, cash-flow pressure, and previous dispatch outcomes.</p>

<p>A Cash Flow Agent becomes more useful when it can see invoices, fuel spend, upcoming maintenance, truck payments, and expected load revenue.</p>

<p>A Profitability Agent becomes more useful when it can connect loads, brokers, lanes, fuel, repairs, driver pay, deadhead, idle time, and real outcomes.</p>

<p><span style="color:#FACC15; font-weight:600;">Architecture rule:</span> New features should strengthen the shared TruckOps system. They should not create disconnected data, disconnected logic, or disconnected workflows unless there is a clear reason.</p>

<hr>

<h2 style="color:#00A6A6;">Development Philosophy</h2>

<p><span style="color:#FACC15; font-weight:600;">Core Philosophy:</span> Start small. Prove usefulness. Save the data. Build intelligence from real use.</p>

<p>The system should be built carefully and intentionally. It should not be overbuilt before the early versions prove value.</p>

<p>The preferred pattern is:</p>

<ol>
  <li>Identify a real business problem.</li>
  <li>Determine where that problem belongs in the TruckOps architecture.</li>
  <li>Build the smallest useful version of the solution.</li>
  <li>Connect it to the shared foundation and shared data where appropriate.</li>
  <li>Use it in realistic owner workflows.</li>
  <li>Save the queries, snapshots, decisions, outputs, and outcomes.</li>
  <li>Use that saved history to improve future versions.</li>
</ol>

<p>The goal is not to build something complicated. The goal is to build something useful, connected, expandable, and intelligent.</p>

<hr>

<h2 style="color:#00A6A6;">Layer 1: Project Documentation Layer</h2>

<p>The project documentation layer is the Joplin notebook itself.</p>

<p>The notebook is the top-level project folder. It preserves the vision, architecture, foundation, agents, development history, decisions, lessons learned, and future plans.</p>

<p>This layer exists because the owner is a one-man operation: owner, operator, planner, developer, dispatcher, and system designer. The notebook reduces context loss and keeps the project from depending on memory alone.</p>

<p><span style="color:#FACC15; font-weight:600;">Primary purpose:</span> Make the project understandable to the owner and transferable to future AI instances or development platforms.</p>

<p>The documentation layer includes:</p>

<ul>
  <li>Project overview</li>
  <li>System architecture baseline</li>
  <li>Foundation documentation</li>
  <li>Business domain notes</li>
  <li>Agent and feature notes</li>
  <li>Data and memory notes</li>
  <li>Development, testing, and release notes</li>
  <li>AI context and continuity instructions</li>
  <li>Development log</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Layer 2: Foundation & Infrastructure Layer</h2>

<p>The foundation is the technical base that supports the entire system.</p>

<p>It is expected to include:</p>

<ul>
  <li>Google Cloud Platform</li>
  <li>Compute Engine VM</li>
  <li>Docker</li>
  <li>OpenClaw</li>
  <li>Shared workspace structure</li>
  <li>Shared configuration</li>
  <li>Shared tools and connectors</li>
  <li>Credential and secrets handling</li>
  <li>Backups and recovery</li>
  <li>Cost controls</li>
</ul>

<p>The foundation is not the finished product. It is the base that allows the rest of the system to exist.</p>

<p><span style="color:#FACC15; font-weight:600;">Foundation rule:</span> The foundation should support all future agents and features. It should not be rebuilt separately for each new capability.</p>

<hr>

<h2 style="color:#00A6A6;">Layer 3: Shared Data, Memory & Records Layer</h2>

<p>This layer is where TruckOps becomes more than a chatbot or dashboard.</p>

<p>It stores the business records and history that future agents need in order to reason, compare, detect patterns, and make useful recommendations.</p>

<p>This layer may include:</p>

<ul>
  <li>Truck records</li>
  <li>Driver records</li>
  <li>Load records</li>
  <li>Broker records</li>
  <li>Invoice records</li>
  <li>Payment records</li>
  <li>Documents</li>
  <li>Fuel records</li>
  <li>Expense records</li>
  <li>Maintenance records</li>
  <li>Dispatch snapshots</li>
  <li>Owner decisions</li>
  <li>Outcomes</li>
  <li>Lessons learned</li>
</ul>

<p>The shared memory layer is what allows one part of the system to help another part of the system.</p>

<p><span style="color:#FACC15; font-weight:600;">Example:</span> A maintenance record should not only help the Maintenance Agent. It may also affect dispatch decisions, cash-flow forecasting, profitability analysis, and daily briefings.</p>

<hr>

<h2 style="color:#00A6A6;">Layer 4: Shared Planning & Intelligence Layer</h2>

<p>The shared planning and intelligence layer sits above raw records and below final recommendations.</p>

<p>This layer helps the system interpret what the data means.</p>

<p>It should help answer questions like:</p>

<ul>
  <li>What is changing?</li>
  <li>What opportunity is forming?</li>
  <li>What problem is developing?</li>
  <li>What pattern would the owner probably miss?</li>
  <li>What decision needs attention?</li>
  <li>What tool or feature should be developed next?</li>
  <li>What does the current situation suggest?</li>
</ul>

<p>This layer may eventually support trend recognition, opportunity detection, strategic planning, risk detection, and cross-agent analysis.</p>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> This layer should grow from saved history and real use. It does not need to be fully built at the beginning.</p>

<hr>

<h2 style="color:#00A6A6;">Layer 5: Business Domains</h2>

<p>Business domains are the major areas of the trucking business that TruckOps supports.</p>

<p>Agents live inside domains. Features are created inside domains. Problems should be routed to the domain where they belong.</p>

<h3 style="color:#B8C7CC;">Administrative Domain</h3>

<p>The Administrative Domain handles records, documentation, financial tracking, invoices, payments, filing, and business organization.</p>

<p><span style="color:#FACC15; font-weight:600;">Examples:</span></p>

<ul>
  <li>Document Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Records tracking</li>
  <li>Expense tracking</li>
  <li>Payment follow-up</li>
  <li>Document linking</li>
  <li>Financial recordkeeping</li>
</ul>

<h3 style="color:#B8C7CC;">Operations Domain</h3>

<p>The Operations Domain handles the movement and productive use of trucks, loads, drivers, brokers, maintenance, fuel, lanes, and daily execution.</p>

<p><span style="color:#FACC15; font-weight:600;">Examples:</span></p>

<ul>
  <li>On-Demand Dispatch Intelligence Agent</li>
  <li>Broker Intelligence Agent</li>
  <li>Maintenance Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Truck utilization tracking</li>
  <li>Load planning</li>
  <li>Recovery planning</li>
</ul>

<h3 style="color:#B8C7CC;">Planning & Intelligence Domain</h3>

<p>The Planning & Intelligence Domain helps the owner see across the business instead of only reacting to one task at a time.</p>

<p><span style="color:#FACC15; font-weight:600;">Examples:</span></p>

<ul>
  <li>Daily Briefing Agent</li>
  <li>Profitability Agent</li>
  <li>Cash Flow Agent</li>
  <li>Trend recognition</li>
  <li>Opportunity detection</li>
  <li>Strategic planning support</li>
  <li>Business improvement recommendations</li>
</ul>

<h3 style="color:#B8C7CC;">Development, Testing & Release Domain</h3>

<p>This domain protects the operational system from unfinished features.</p>

<p>It defines how new ideas are built, tested, validated, migrated, installed, connected, initialized, verified, and documented before becoming part of daily use.</p>

<h3 style="color:#B8C7CC;">Future Productization Domain</h3>

<p>This domain exists because TruckOps may eventually become more than a private business tool.</p>

<p>If the system proves real value, the reusable system shell may later become a product, template, managed service, or marketable operating system after private business data is removed or separated.</p>

<hr>

<h2 style="color:#00A6A6;">Layer 6: Agents</h2>

<p>Agents are specialized AI workers inside the TruckOps system.</p>

<p>An agent should have:</p>

<ul>
  <li>A clear job</li>
  <li>A clear business domain</li>
  <li>Defined inputs</li>
  <li>Defined outputs</li>
  <li>Access to the correct shared data</li>
  <li>A reason for existing</li>
  <li>A way to save useful history</li>
</ul>

<p>Agents should not be built just because an idea sounds interesting. They should exist because they solve a real problem, reduce workload, improve decisions, protect profit, improve asset use, or create useful business memory.</p>

<p><span style="color:#FACC15; font-weight:600;">Agent rule:</span> An agent becomes valuable when it produces a useful feature or business solution.</p>

<hr>

<h2 style="color:#00A6A6;">Layer 7: Features</h2>

<p>Features are the practical capabilities created by agents, tools, workflows, dashboards, databases, and connectors.</p>

<p>Examples:</p>

<ul>
  <li>Load comparison</li>
  <li>Broker scoring</li>
  <li>Document extraction</li>
  <li>Invoice aging</li>
  <li>Maintenance tracking</li>
  <li>Fuel cost analysis</li>
  <li>Cash-flow forecasting</li>
  <li>Profitability reporting</li>
  <li>Daily briefing</li>
  <li>Opportunity detection</li>
</ul>

<p>A feature should always answer:</p>

<blockquote>
  <p><strong>What problem does this solve, what time does it save, what asset does it optimize, or what decision does it improve?</strong></p>
</blockquote>

<hr>

<h2 style="color:#00A6A6;">Layer 8: Business Solutions</h2>

<p>Business solutions are the actual results created by the system.</p>

<p>Examples:</p>

<ul>
  <li>Less time spent manually comparing loads</li>
  <li>Better use of truck availability</li>
  <li>Fewer missed invoices</li>
  <li>Less paperwork confusion</li>
  <li>Better broker decisions</li>
  <li>Earlier maintenance awareness</li>
  <li>Clearer cash-flow visibility</li>
  <li>Better understanding of true profit</li>
  <li>Lower dependence on owner memory</li>
  <li>Faster daily decision-making</li>
</ul>

<p>The purpose of TruckOps is not to collect features. The purpose is to create business advantage.</p>

<hr>

<h2 style="color:#00A6A6;">Operational System vs Development System</h2>

<p>TruckOps must clearly separate the fully operational system from development and testing work.</p>

<p>The operational system is the version the owner depends on for daily business use. Development and testing areas are where new features, upgrades, experiments, and version changes are built and checked before being added to the operational side.</p>

<p><span style="color:#FACC15; font-weight:600;">Environment boundary:</span> New development should not interfere with features or records that are already operational and depended on for daily work.</p>

<h3 style="color:#B8C7CC;">Development Environment</h3>

<p>The development environment is where new ideas are built.</p>

<p><span style="color:#FACC15; font-weight:600;">Purpose:</span> Create new agents, tools, prompts, database changes, dashboards, workflows, and experiments.</p>

<p>This area can be rough because it is where the system is being figured out.</p>

<h3 style="color:#B8C7CC;">Testing / Staging Environment</h3>

<p>The testing or staging environment is where new work is proven before it touches the operational system.</p>

<p><span style="color:#FACC15; font-weight:600;">Purpose:</span> Test features against sample data, copied data, controlled cases, or a limited non-critical workflow.</p>

<p>This area answers:</p>

<ul>
  <li>Does it work?</li>
  <li>Does it read the correct data?</li>
  <li>Does it write data correctly?</li>
  <li>Does it duplicate anything?</li>
  <li>Does it connect to the right shared foundation?</li>
  <li>Does it fit the existing architecture?</li>
  <li>Is it ready for daily use?</li>
</ul>

<h3 style="color:#B8C7CC;">Production Environment</h3>

<p>The production environment is the live operational TruckOps system.</p>

<p><span style="color:#FACC15; font-weight:600;">Purpose:</span> Run the real business.</p>

<p>Production includes real truck data, driver data, broker records, load records, invoices, documents, maintenance records, fuel records, financial records, dispatch snapshots, daily briefings, and daily-use workflows.</p>

<p><span style="color:#FACC15; font-weight:600;">Production rule:</span> Production should be stable, recoverable, and protected from unfinished work.</p>

<hr>

<h2 style="color:#00A6A6;">Development-To-Production Release Path</h2>

<p>When a new feature or upgrade is ready, it should follow a clear path into the operational system.</p>

<pre><code>Idea / Problem
  ↓
Development Build
  ↓
Testing With Sample Or Copied Data
  ↓
Validation
  ↓
Production Backup
  ↓
Migration / Install
  ↓
Connection To Shared Data Or Tools
  ↓
Initialization
  ↓
Verification
  ↓
Documentation Update
  ↓
Operational Use</code></pre>

<h3 style="color:#B8C7CC;">Release Step Meanings</h3>

<table>
  <thead>
    <tr>
      <th>Step</th>
      <th>Meaning</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Idea / Problem</td>
      <td>Define the problem or capability needed.</td>
    </tr>
    <tr>
      <td>Development Build</td>
      <td>Create the first working version.</td>
    </tr>
    <tr>
      <td>Testing</td>
      <td>Use copied, sample, or controlled data to test behavior.</td>
    </tr>
    <tr>
      <td>Validation</td>
      <td>Confirm the feature works and fits the architecture.</td>
    </tr>
    <tr>
      <td>Production Backup</td>
      <td>Create a restore point before changing the live system.</td>
    </tr>
    <tr>
      <td>Migration / Install</td>
      <td>Move the tested feature into the operational system.</td>
    </tr>
    <tr>
      <td>Connection</td>
      <td>Connect it to shared data, config, tools, agents, or dashboards.</td>
    </tr>
    <tr>
      <td>Initialization</td>
      <td>Complete first-run setup, tables, settings, or starting records.</td>
    </tr>
    <tr>
      <td>Verification</td>
      <td>Confirm it works after installation.</td>
    </tr>
    <tr>
      <td>Documentation Update</td>
      <td>Update the relevant note and the development log.</td>
    </tr>
  </tbody>
</table>

<p>This path keeps development moving while protecting the operational system.</p>

<hr>

<h2 style="color:#00A6A6;">How Future Problems Should Be Routed</h2>

<p>When the owner brings a new problem, future AI instances should not automatically assume the answer is a new agent.</p>

<p>The correct first question is:</p>

<blockquote>
  <p><strong>Where does this belong in the existing TruckOps architecture?</strong></p>
</blockquote>

<p>The solution may be:</p>

<ul>
  <li>A new agent</li>
  <li>An upgrade to an existing agent</li>
  <li>A shared tool</li>
  <li>A connector</li>
  <li>A database table</li>
  <li>A configuration rule</li>
  <li>A dashboard view</li>
  <li>A workflow change</li>
  <li>A report</li>
  <li>A foundation upgrade</li>
  <li>A release process change</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Routing rule:</span> Solve the problem in the place where it naturally belongs. Do not create new complexity when the existing architecture can support the solution.</p>

<hr>

<h2 style="color:#00A6A6;">Example: Dispatch Agent Fit</h2>

<p>The On-Demand Dispatch Intelligence Agent belongs primarily in the <strong>Operations Domain</strong>.</p>

<p>It uses:</p>

<ul>
  <li>Foundation and infrastructure</li>
  <li>Shared truck data</li>
  <li>Shared driver data</li>
  <li>Shared broker memory</li>
  <li>Shared load records</li>
  <li>Shared dispatch rules</li>
  <li>Shared snapshots</li>
  <li>Shared planning and intelligence layer</li>
</ul>

<p>It creates:</p>

<ul>
  <li>Load comparisons</li>
  <li>Dispatch snapshots</li>
  <li>Best-move recommendations</li>
  <li>Rejected option records</li>
  <li>Owner decision history</li>
  <li>Outcome history</li>
</ul>

<p>That saved history can later improve profitability analysis, broker scoring, lane intelligence, cash-flow forecasting, and daily briefings.</p>

<p>This is how one agent strengthens the whole system.</p>

<hr>

<h2 style="color:#00A6A6;">Reusable System Shell And Future Productization</h2>

<p>TruckOps begins as a private system built for the owner’s trucking business.</p>

<p>If the system proves real operational value, a future version may become marketable.</p>

<p>The reusable system would not be the owner’s private data. The reusable system would be the shell, structure, workflows, agents, schemas, setup process, dashboards, and operating logic.</p>

<table>
  <thead>
    <tr>
      <th>Part</th>
      <th>Reusable Later?</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Foundation setup</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Agent framework</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Prompt and instruction structure</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Database schema</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Dashboard structure</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Workflow logic</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Private loads, brokers, invoices, and business records</td>
      <td>No</td>
    </tr>
    <tr>
      <td>Private business history</td>
      <td>No, unless intentionally anonymized later</td>
    </tr>
  </tbody>
</table>

<p><span style="color:#FACC15; font-weight:600;">Productization principle:</span> Build for private usefulness first. Preserve the option to separate the reusable system from private data later.</p>

<hr>

<h2 style="color:#00A6A6;">What This Architecture Protects</h2>

<p>This architecture protects the project from:</p>

<ul>
  <li>Disconnected tools</li>
  <li>Duplicated data</li>
  <li>Unclear feature ownership</li>
  <li>Confusing folder structure</li>
  <li>Agents that do not solve real problems</li>
  <li>Features that cannot share memory</li>
  <li>Testing that interferes with daily operations</li>
  <li>Development work that cannot be safely moved into production</li>
  <li>A system that becomes too confusing for one person to manage</li>
</ul>

<p>The architecture should make the system easier to understand, easier to expand, and easier to trust.</p>

<hr>

<h2 style="color:#00A6A6;">Current Baseline Summary</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Current project state:</span> The project is in early planning and documentation. The foundation is planned. The first agent concept is the On-Demand Dispatch Intelligence Agent. The notebook structure is being organized before implementation begins.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Current architectural direction:</span> One shared foundation, multiple business domains, specialized agents, practical features, shared memory, protected operational use, and a clear release path for future upgrades.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Current priority:</span> Preserve the architecture clearly enough that future AI instances can understand the system, identify where new work belongs, and continue development without forcing the owner to repeatedly re-explain the project.</p>

<hr>

<h2 style="color:#00A6A6;">Final Operating Statement</h2>

<p>TruckOps should become a connected AI-supported trucking business operating system. Its value comes from the shared foundation, shared business memory, practical agents, real-world features, and the owner’s ability to use the system from the road to make faster, sharper, better-informed decisions.</p>

<p>The system should be built one useful layer at a time, with every new capability strengthening the whole.</p>

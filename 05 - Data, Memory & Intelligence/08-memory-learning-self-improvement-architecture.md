<h1 style="color:#F97316;">MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE</h1>

<h3 style="color:#B8C7CC;">The dynamic intelligence layer that enables TruckOps to remember conversations, learn from interactions, reflect on its own performance, and improve itself over time.</h3>

<hr>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>This note defines how the TruckOps OpenClaw AI Operating System remembers, learns, reflects, and improves—using the most advanced memory and learning stack available in 2026, while fitting comfortably within an 8GB RAM VM.</p>

<p>The purpose is to transform TruckOps from a system that merely stores records into a system that grows smarter with every conversation, every decision, and every outcome.</p>

<p>TruckOps should not just answer questions. It should:</p>

<ul>
  <li>Remember what you told it without you repeating yourself</li>
  <li>Recall relevant context automatically before you ask</li>
  <li>Learn from corrections and mistakes</li>
  <li>Recognize patterns across loads, brokers, lanes, and expenses</li>
  <li>Suggest improvements to its own behavior and to the business</li>
  <li>Write new skills during conversation without requiring code changes</li>
  <li>Consolidate knowledge during idle time ("dreaming")</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Core rule:</span> If the system learns something useful, it should be able to use that knowledge to make better decisions tomorrow—without being reminded.</p>

<p>This page explains:</p>

<ul>
  <li>The Four-Pillar Model of memory and learning</li>
  <li>How TruckOps stores and retrieves semantic memory</li>
  <li>How episodic memory captures decisions and outcomes</li>
  <li>How active recall provides context proactively</li>
  <li>How the system writes new skills and improves itself</li>
  <li>How consolidation ("dreaming") strengthens useful knowledge</li>
  <li>The specific open‑source stack and its RAM footprint</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Relationship to Other Notes</h2>

<p>This document defines how TruckOps learns, remembers, and improves itself.</p>

<p>For the actual business data (trucks, loads, brokers, expenses) and where it is stored, see:</p>

<p><strong>DOCUMENT A: DATA, MEMORY & RECORDS BASELINE</strong></p>

<p>For how to install, configure, and enable the memory stack, see:</p>

<p><strong>FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION</strong></p>

<hr>

<h2 style="color:#00A6A6;">Plain-English Summary</h2>

<p>Think of your current TruckOps system like a file cabinet. It has labeled folders, well-organized records, and clear filing rules. That's necessary—but it's not enough.</p>

<p>A file cabinet doesn't:</p>

<ul>
  <li>Remember what you said yesterday</li>
  <li>Notice patterns across months of records</li>
  <li>Learn from mistakes</li>
  <li>Suggest better ways to do things</li>
  <li>Improve itself over time</li>
  <li>Connect dots across separate interactions</li>
  <li>Consolidate what it knows into a coherent picture</li>
</ul>

<p>This document builds a brain for the file cabinet.</p>

<p>That brain is built on four pillars:</p>

<ol>
  <li><strong>Semantic Memory</strong> – Facts, knowledge, preferences, and extracted intelligence.</li>
  <li><strong>Episodic Memory</strong> – Events, decisions, outcomes, and the story of the business.</li>
  <li><strong>Active Recall</strong> – Automatic retrieval of relevant context before every response.</li>
  <li><strong>Self‑Improvement</strong> – The system writes new skills and refines its own behavior.</li>
</ol>

<p>On top of these pillars, a <strong>Consolidation Layer ("Dreaming")</strong> runs in the background: it reviews recent interactions, strengthens frequently used memories, fades irrelevant noise, and writes consolidated knowledge to a structured wiki.</p>

<p>TruckOps becomes smarter the more you use it—and it does so with a memory stack that fits entirely in 8GB of RAM.</p>

<hr>

<h2 style="color:#00A6A6;">The Four‑Pillar Model</h2>

<h3 style="color:#B8C7CC;">Pillar 1: Semantic Memory (Facts & Knowledge)</h3>

<p><strong>What it stores:</strong> Business facts, preferences, entity relationships, extracted knowledge, patterns, and learned intelligence.</p>

<p><strong>2026 standard:</strong> Hybrid retrieval—vector + keyword (BM25) + reranking.</p>

<p><strong>Implementation:</strong></p>
<ul>
  <li><strong>Vector Database:</strong> LanceDB (local, embedded) – zero infrastructure, < 200MB RAM, supports hybrid search.</li>
  <li><strong>Embedding Model:</strong> <code>all-MiniLM-L6-v2</code> (384 dimensions) – light, fast, and accurate for business context. Optionally upgrade to <code>gemini-embedding-001</code> (3072 dims) if more precision is needed (still under 8GB).</li>
  <li><strong>Reranker:</strong> Cross-encoder (<code>ms-marco-MiniLM-L-6-v2</code>) – re‑ranks top 20–50 results; adds ~50ms, doubles precision.</li>
  <li><strong>Keyword Search:</strong> BM25 (built into LanceDB) – catches exact matches that vectors might miss.</li>
</ul>

<p><strong>Plugin:</strong> <code>memory-lancedb</code> (bundled, recommended) – must be enabled via <code>plugins.slots.memory = "memory-lancedb"</code>.</p>

<p><strong>Companion:</strong> <code>memory-wiki</code> – compiles durable memory into a navigable knowledge vault with provenance. Sits alongside, does not replace the active memory plugin.</p>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Semantic memory gives the system a long‑term, searchable brain that remembers everything you've told it and can retrieve relevant facts instantly.</p>

<hr>

<h3 style="color:#B8C7CC;">Pillar 2: Episodic Memory (Events & Decisions)</h3>

<p><strong>What it stores:</strong> Sequences of events, decision snapshots, outcomes, and lessons learned—the narrative of the business.</p>

<p><strong>Implementation:</strong></p>
<ul>
  <li><strong>Snapshot Schema:</strong> Structured YAML/JSON with fields: <code>{options, recommendation, rationale, decision, outcome, lesson}</code>.</li>
  <li><strong>Episodic Index:</strong> Lightweight SQLite table linking snapshot IDs to vector embeddings (stored in LanceDB or a separate table).</li>
  <li><strong>Outcome Loop:</strong> After an outcome is known, the system revisits the snapshot, extracts a lesson, and writes it to semantic memory.</li>
</ul>

<p><strong>Storage location:</strong> <code>snapshots/</code> folder (as defined in DOCUMENT A) and optionally in <code>databases/snapshots.db</code>.</p>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> The system learns from actual outcomes, not just from plans. It remembers that a load looked good on paper but left the truck in a weak market—and factors that into future recommendations.</p>

<hr>

<h3 style="color:#B8C7CC;">Pillar 3: Active Recall (Proactive Memory)</h3>

<p><strong>What it does:</strong> Runs before every response, automatically pulls in relevant semantic and episodic memory, and injects context without you asking.</p>

<p><strong>Implementation:</strong> The bundled <strong>Active Memory</strong> plugin (optional but recommended). It searches semantic memory (LanceDB) for the most relevant facts and past episodes based on the current query, and prepends them to the conversation context.</p>

<p><strong>Configuration:</strong></p>
<pre><code>{
  "plugins": {
    "active_memory": {
      "enabled": true,
      "recall_count": 5,
      "min_relevance": 0.65
    }
  }
}</code></pre>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> The system just knows. When you ask "What loads should I consider?" it already knows your truck's maintenance status, broker payment history, current cash position, and which lanes worked last time—without you having to remind it.</p>

<hr>

<h3 style="color:#B8C7CC;">Pillar 4: Self‑Improvement (Skill Writing)</h3>

<p><strong>What it does:</strong> The system writes its own new skills during conversation. When it discovers a useful workflow, it can codify it as a reusable skill.</p>

<p><strong>Implementation:</strong> <code>openclaw-superpowers</code> (community skill library). Includes <code>create-skill</code> – the system can write a new skill when it identifies a successful pattern. Self‑modification with security guardrails.</p>

<p><strong>Examples of skills the system should write:</strong></p>
<ul>
  <li><code>evaluate_reload_market</code> – when the owner repeatedly rejects loads due to weak reloads, the system codifies that evaluation logic.</li>
  <li><code>broker_score</code> – when the owner consistently favours brokers who pay within 7 days, the system writes a scoring skill.</li>
  <li><code>fuel_optimization</code> – when the owner mentions that certain lanes have cheap fuel, the system writes a skill to factor that into load decisions.</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> The system doesn't wait for you to write code. It learns a new workflow, writes a skill, and improves itself continuously.</p>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> <code>openclaw-superpowers</code> is community‑built. Install it <em>after</em> core stability. The memory layer works without it—skill writing is the capstone, not the foundation.</p>

<hr>

<h2 style="color:#00A6A6;">The Consolidation Layer: "Dreaming"</h2>

<p><strong>What it is:</strong> OpenClaw's experimental "Dreaming" feature—a background memory consolidation process that runs when the system is idle.</p>

<p><strong>What it does:</strong></p>
<ul>
  <li>Reviews recent interactions</li>
  <li>Identifies patterns across sessions</li>
  <li>Strengthens frequently used memories</li>
  <li>Fades irrelevant noise</li>
  <li>Writes consolidated knowledge to the <code>memory-wiki</code> vault</li>
</ul>

<p><strong>Enable it:</strong> <code>openclaw dreaming --enable</code></p>

<p><strong>RAM impact:</strong> Runs as a background process; configurable to run during low‑usage hours. Minimal active RAM footprint.</p>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> This is the "tell your friends about it" layer. The system doesn't just remember—it dreams. Overnight, it consolidates, connects dots, and becomes smarter by morning.</p>

<hr>

<h2 style="color:#00A6A6;">Technical Stack & Resource Footprint</h2>

<p>All components are open source and fit comfortably within an 8GB RAM VM.</p>

<table>
  <thead>
    <tr>
      <th>Layer</th>
      <th>Component</th>
      <th>License</th>
      <th>RAM Estimate (active)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Vector DB</td>
      <td>LanceDB</td>
      <td>Apache 2.0</td>
      <td>~150 MB</td>
    </tr>
    <tr>
      <td>Embeddings</td>
      <td><code>sentence-transformers/all-MiniLM-L6-v2</code></td>
      <td>Apache 2.0</td>
      <td>~500 MB</td>
    </tr>
    <tr>
      <td>Reranker</td>
      <td><code>cross-encoder/ms-marco-MiniLM-L-6-v2</code></td>
      <td>Apache 2.0</td>
      <td>~300 MB</td>
    </tr>
    <tr>
      <td>SQLite</td>
      <td>Bundled with OpenClaw</td>
      <td>Public Domain</td>
      <td>~50 MB</td>
    </tr>
    <tr>
      <td>Memory Plugin</td>
      <td><code>memory-lancedb</code></td>
      <td>MIT</td>
      <td>~100 MB</td>
    </tr>
    <tr>
      <td>Wiki</td>
      <td><code>memory-wiki</code></td>
      <td>MIT</td>
      <td>~50 MB</td>
    </tr>
    <tr>
      <td>Active Memory</td>
      <td>Bundled with OpenClaw</td>
      <td>MIT</td>
      <td>~50 MB</td>
    </tr>
    <tr>
      <td>Superpowers (optional)</td>
      <td><code>openclaw-superpowers</code></td>
      <td>MIT</td>
      <td>~100 MB</td>
    </tr>
    <tr>
      <td><strong>Total (active)</strong></td>
      <td></td>
      <td></td>
      <td><strong>~1.3 GB</strong></td>
    </tr>
  </tbody>
</table>

<p>The remaining 6.7 GB is available for OpenClaw itself, agents, and headroom. The stack runs comfortably in 2 GB total.</p>

<hr>

<h2 style="color:#00A6A6;">Memory Plugin Stack (Summary)</h2>

<table>
  <thead>
    <tr>
      <th>Plugin</th>
      <th>Type</th>
      <th>Status</th>
      <th>Function</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>memory-core</code></td>
      <td>Bundled</td>
      <td><span style="color:#A5B4FC;">Default</span></td>
      <td>Baseline memory (Markdown + SQLite) – not recommended for production.</td>
    </tr>
    <tr>
      <td><code>memory-lancedb</code></td>
      <td>Bundled</td>
      <td><span style="color:#34D399;">Recommended</span></td>
      <td>Long‑term semantic memory with hybrid vector+BM25 search and auto‑capture.</td>
    </tr>
    <tr>
      <td><code>memory-wiki</code></td>
      <td>Bundled</td>
      <td><span style="color:#34D399;">Recommended</span></td>
      <td>Structured knowledge vault with provenance, sits alongside active memory.</td>
    </tr>
    <tr>
      <td>Active Memory</td>
      <td>Bundled</td>
      <td><span style="color:#34D399;">Recommended</span></td>
      <td>Automatic recall before every response – proactive context.</td>
    </tr>
    <tr>
      <td><code>openclaw-superpowers</code></td>
      <td>Community</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Self‑improvement, skill writing, self‑recovery.</td>
    </tr>
    <tr>
      <td><code>memory-lancedb-pro</code></td>
      <td>Community</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Enhanced LanceDB with additional retrieval optimisations.</td>
    </tr>
    <tr>
      <td><code>openclaw-hybrid-memory</code></td>
      <td>Community</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Structured store + semantic recall + knowledge graph.</td>
    </tr>
  </tbody>
</table>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> Only one plugin can own the active memory slot via <code>plugins.slots.memory</code>. <code>memory-wiki</code> and Active Memory work alongside it—they do not replace it.</p>

<hr>

<h2 style="color:#00A6A6;">What This System Replaces</h2>

<p>The old "Level 6 memory" concept was a goal without a concrete implementation. This architecture delivers a working, production‑ready memory stack that:</p>

<ul>
  <li><strong>Captures automatically</strong> – no <code>remember this</code> commands.</li>
  <li><strong>Recalls proactively</strong> – relevant context appears before you ask.</li>
  <li><strong>Learns from outcomes</strong> – not just conversations, but what actually happened.</li>
  <li><strong>Writes its own skills</strong> – discovers workflows, codifies them, improves itself.</li>
  <li><strong>Consolidates overnight</strong> – "dreams" to strengthen useful knowledge and fade noise.</li>
  <li><strong>Fits in 8GB RAM</strong> – local‑first, no external cloud dependencies.</li>
</ul>

<p>This is not a future aspiration—it is a buildable plan using existing open‑source components.</p>

<hr>

<h2 style="color:#00A6A6;">Implementation Roadmap</h2>

<table>
  <thead>
    <tr>
      <th>Phase</th>
      <th>Action</th>
      <th>Timeline</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Phase 1</td>
      <td>Enable <code>memory-lancedb</code> as the memory plugin (replace <code>memory-core</code>).</td>
      <td>Foundation Build</td>
    </tr>
    <tr>
      <td>Phase 2</td>
      <td>Enable <code>memory-wiki</code> for provenance and auditing.</td>
      <td>Foundation Build</td>
    </tr>
    <tr>
      <td>Phase 3</td>
      <td>Enable Active Memory plugin with appropriate recall settings.</td>
      <td>Foundation Build</td>
    </tr>
    <tr>
      <td>Phase 4</td>
      <td>Define snapshot schema with outcome fields in <code>config/snapshot_schema.yaml</code>.</td>
      <td>Week 1</td>
    </tr>
    <tr>
      <td>Phase 5</td>
      <td>Implement outcome capture workflow (prompt: "What did we learn from this outcome?").</td>
      <td>Week 2</td>
    </tr>
    <tr>
      <td>Phase 6</td>
      <td>Install and evaluate <code>openclaw-superpowers</code>; test <code>create-skill</code> manually.</td>
      <td>Week 3</td>
    </tr>
    <tr>
      <td>Phase 7</td>
      <td>Enable autonomous skill writing with guardrails.</td>
      <td>Week 4</td>
    </tr>
    <tr>
      <td>Phase 8</td>
      <td>Enable Dreaming (<code>openclaw dreaming --enable</code>) and schedule overnight consolidation.</td>
      <td>Ongoing</td>
    </tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Non‑Negotiable Principles</h2>

<ol>
  <li><strong>No manual capture</strong> — If the system has to be told to remember, it's not memory, it's note‑taking.</li>
  <li><strong>Proactive recall</strong> — Context appears before you ask, not after.</li>
  <li><strong>Outcome‑driven learning</strong> — Plans are cheap. Outcomes are what matter.</li>
  <li><strong>Provenance</strong> — Every memory must have a source. You need to audit what the system "knows."</li>
  <li><strong>Local‑first</strong> — Your business data stays on your VM. No external vector DBs unless you explicitly choose them.</li>
</ol>

<hr>

<h2 style="color:#00A6A6;">Current Status</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Architecture defined and ready for implementation. This note describes the complete memory, learning, and self‑improvement architecture for TruckOps.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> No memory plugins have been installed yet. The foundation build (GCP VM, OpenClaw, workspace) has not been executed.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Use the Foundation Build Runbook to build the core foundation. Then enable the recommended memory stack:</p>

<ul>
  <li><code>memory-lancedb</code> (replace <code>memory-core</code>)</li>
  <li><code>memory-wiki</code></li>
  <li>Active Memory</li>
</ul>

<p>After the foundation is stable, evaluate <code>openclaw-superpowers</code> for self‑improvement, and begin using the Dispatch Agent with snapshots to feed the episodic memory loop.</p>
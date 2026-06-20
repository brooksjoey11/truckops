<!-- File: 08-memory-learning-self-improvement-architecture.md -->
<!-- This file contains: MEMORY LEARNING SELF-IMPROVEMENT ARCHITECTURE -->
<h1 style="color:#F97316;">MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE</h1>

<h3 style="color:#B8C7CC;">The dynamic intelligence layer that enables TruckOps to remember conversations, learn from interactions, reflect on its own performance, and improve itself over time.</h3>

<hr>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>This note defines how the TruckOps OpenClaw AI Operating System remembers, learns, reflects, and improves.</p>

<p>The purpose is to transform TruckOps from a system that merely stores records into a system that grows smarter with every conversation, every decision, and every outcome.</p>

<p>TruckOps should not just answer questions. It should:</p>

<ul>
  <li>Remember what you told it without you repeating yourself</li>
  <li>Recall relevant context automatically before you ask</li>
  <li>Learn from corrections and mistakes</li>
  <li>Recognize patterns across loads, brokers, lanes, and expenses</li>
  <li>Suggest improvements to its own behavior and to the business</li>
  <li>Write new skills during conversation without requiring code changes</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Core rule:</span> If the system learns something useful, it should be able to use that knowledge to make better decisions tomorrow—without being reminded.</p>

<p>This page explains:</p>

<ul>
  <li>How TruckOps stores and retrieves long-term memory</li>
  <li>How memory plugins work together</li>
  <li>How the system learns from conversations</li>
  <li>How the system reflects on its own performance</li>
  <li>How the system writes new skills</li>
  <li>How the system improves over time</li>
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
</ul>

<p>This document builds a brain for the file cabinet.</p>

<p>That brain:</p>

<ul>
  <li>Remembers every conversation</li>
  <li>Pulls up relevant past discussions automatically</li>
  <li>Learns from corrections and updates its knowledge</li>
  <li>Recognizes patterns like "this broker always pays late" or "this lane has weak reloads"</li>
  <li>Writes new skills when it discovers a useful new workflow</li>
  <li>Reflects on its own performance and suggests improvements</li>
</ul>

<p>TruckOps becomes smarter the more you use it.</p>

<hr>

<h2 style="color:#00A6A6;">The Memory Stack</h2>

<p>TruckOps uses a layered memory system. Each layer handles a different type of memory, working together seamlessly.</p>

<h3 style="color:#B8C7CC;">Layer 1: Short-Term Memory (The Conversation)</h3>

<p>This is the current chat session. The system remembers what you've discussed in the current conversation.</p>

<p><strong>How it works:</strong> OpenClaw handles this automatically. No setup required.</p>

<p><strong>Limitation:</strong> When you start a new session, this memory is lost. That's why you need the next layers.</p>

<hr>

<h3 style="color:#B8C7CC;">Layer 2: Long-Term Semantic Memory (Facts and Knowledge)</h3>

<p>This stores facts, preferences, and past conversations in a way that the system can search and retrieve.</p>

<p><span style="color:#FACC15; font-weight:600;">Default:</span> <strong>memory-core</strong> (Bundled, Default)</p>

<ul>
  <li>OpenClaw's built-in memory engine[reference:5]</li>
  <li>Stores memory in Markdown files indexed in a SQLite database[reference:6]</li>
  <li>Uses embeddings for vector search when an API key is configured[reference:7]</li>
  <li>Works out of the box—no extra setup required</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Recommended upgrade:</span> <strong>memory-lancedb</strong> (Bundled, Recommended)</p>

<ul>
  <li>Stores long-term memory in LanceDB, a local vector database[reference:8]</li>
  <li>Auto-recalls relevant memories before each response[reference:9]</li>
  <li>Auto-captures important facts after each conversation[reference:10]</li>
  <li>Supports semantic search ("remember that broker who paid late?")</li>
  <li>Must be enabled via <code>plugins.slots.memory = "memory-lancedb"</code>[reference:11]</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> Without long-term memory, you repeat yourself every session. With it, the system remembers.</p>

<p><span style="color:#FACC15; font-weight:600;">Recommended companion:</span> <strong>memory-wiki</strong> (Bundled, Recommended)</p>

<ul>
  <li>Compiles durable memory into a structured, navigable knowledge vault[reference:12]</li>
  <li>Sits beside the active memory plugin—does not replace it[reference:13]</li>
  <li>Maintains provenance (where knowledge came from)[reference:14]</li>
  <li>Creates an Obsidian-friendly wiki of everything the system knows[reference:15]</li>
  <li>Great for auditing what the system has learned</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> You can see exactly what the system remembers and where it came from.</p>

<hr>

<h3 style="color:#B8C7CC;">Layer 3: Episodic Memory (Events and Decisions)</h3>

<p>This stores sequences of events, decisions, and outcomes—not just facts, but the story of what happened.</p>

<p><strong>How it works:</strong> Uses Dispatch Snapshots from Document A.</p>

<p>Every time the Dispatch Agent considers loads and the owner makes a decision, the snapshot preserves:</p>

<ul>
  <li>What options were available</li>
  <li>What recommendation was made</li>
  <li>Why it was recommended</li>
  <li>What the owner decided</li>
  <li>What actually happened</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> The system learns from outcomes, not just from plans. It remembers that a load looked good on paper but turned out poorly—and factors that into future recommendations.</p>

<hr>

<h3 style="color:#B8C7CC;">Layer 4: Active Recall (Automatic Context)</h3>

<p>This runs before every response, pulling in relevant memory automatically.</p>

<p><span style="color:#FACC15; font-weight:600;">Plugin:</span> <strong>Active Memory</strong> (Bundled, Optional)</p>

<ul>
  <li>An optional plugin-owned blocking memory sub-agent[reference:16]</li>
  <li>Runs before the main reply for eligible conversational sessions[reference:17]</li>
  <li>Searches semantic memory for relevant context</li>
  <li>Injects the context into the conversation automatically[reference:18]</li>
  <li>You don't have to say "remember this" or "search memory" first[reference:19]</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> The system just knows. You don't need to remind it.</p>

<hr>

<h3 style="color:#B8C7CC;">Layer 5: Self-Improvement (Writing Skills)</h3>

<p>This is where the system writes its own new skills during conversation.</p>

<p><span style="color:#FACC15; font-weight:600;">Community Skill Library:</span> <strong>openclaw-superpowers</strong> (Community, Optional)</p>

<ul>
  <li>44+ plug-and-play skills for OpenClaw[reference:20]</li>
  <li>Includes <code>create-skill</code>—the system can write a new skill when it discovers a useful workflow[reference:21]</li>
  <li>Self-modification: the system can update its own skills[reference:22]</li>
  <li>Security guardrails to prevent dangerous self-modifications[reference:23]</li>
  <li>Persistent memory across sessions[reference:24]</li>
  <li>Self-recovery if something goes wrong[reference:25]</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> The system doesn't wait for you to write code. It learns a new workflow, writes a skill, and improves itself.</p>

<p><strong>Example:</strong> If the Dispatch Agent creates a new method for evaluating loads that works better than the existing method, it can capture that method as a new skill and use it going forward.</p>

<p><span style="color:#FACC15; font-weight:600;">Important Note on Community Skills:</span> <code>openclaw-superpowers</code> is a powerful community-built skill library[reference:26]. It is <strong>not</strong> an official OpenClaw plugin. While it can significantly enhance your agent's capabilities, using it means relying on third-party code that may not receive the same level of updates or support as bundled plugins. Evaluate its stability after your core foundation is operational.</p>

<hr>

<h3 style="color:#B8C7CC;">Layer 6: Reflection and Improvement (Level 6 Goal)</h3>

<p>This is the long-term goal: the system reflects on its own performance and suggests system-level improvements without being asked.</p>

<p><strong>How it works (future):</strong></p>

<ol>
  <li>Periodically reviews its own decisions</li>
  <li>Compares recommendations against outcomes</li>
  <li>Identifies patterns of success and failure</li>
  <li>Suggests updates to rules, configs, or skills</li>
  <li>Proposes new agents or workflows</li>
</ol>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> The system becomes a business partner, not just a tool. It proactively suggests improvements.</p>

<p><strong>Note:</strong> Layer 6 is a future goal. It requires the foundation layers (1–5) to be in place first.</p>

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
      <td>memory-core</td>
      <td>Bundled</td>
      <td><span style="color:#A5B4FC;">Default</span></td>
      <td>Baseline memory (Markdown + SQLite)</td>
    </tr>
    <tr>
      <td>memory-lancedb</td>
      <td>Bundled</td>
      <td><span style="color:#34D399;">Recommended</span></td>
      <td>Long-term semantic memory with vector search</td>
    </tr>
    <tr>
      <td>memory-wiki</td>
      <td>Bundled</td>
      <td><span style="color:#34D399;">Recommended</span></td>
      <td>Structured knowledge vault with provenance</td>
    </tr>
    <tr>
      <td>Active Memory</td>
      <td>Bundled</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Automatic recall before every response</td>
    </tr>
    <tr>
      <td>openclaw-superpowers</td>
      <td>Community</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Self-improvement, skill writing, self-recovery</td>
    </tr>
    <tr>
      <td>memory-lancedb-pro</td>
      <td>Community</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Enhanced LanceDB with hybrid retrieval and reranking[reference:27]</td>
    </tr>
    <tr>
      <td>openclaw-hybrid-memory</td>
      <td>Community</td>
      <td><span style="color:#FCD34D;">Optional</span></td>
      <td>Structured store + semantic recall + knowledge graph</td>
    </tr>
  </tbody>
</table>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> Only one plugin can own the active memory slot at a time via <code>plugins.slots.memory</code>[reference:28]. <code>memory-wiki</code> and <code>Active Memory</code> work alongside your active memory plugin—they do not replace it[reference:29][reference:30].</p>

<hr>

<h2 style="color:#00A6A6;">Memory Retention Policy</h2>

<p>Not everything should be kept forever. The system should forget what doesn't matter.</p>

<p><strong>What is retained permanently:</strong></p>

<ul>
  <li>Business records (loads, invoices, expenses, maintenance)</li>
  <li>Snapshots of decisions and outcomes</li>
  <li>Learned patterns and intelligence</li>
</ul>

<p><strong>What is retained temporarily and may fade:</strong></p>

<ul>
  <li>Conversations that don't produce actionable insights</li>
  <li>Low-relevance memories that are never recalled</li>
</ul>

<p><strong>How retention is determined:</strong></p>

<ul>
  <li><code>memory-lancedb</code> and <code>memory-wiki</code> handle this automatically with configurable decay</li>
  <li>The owner can review the knowledge vault in <code>memory-wiki</code> to audit what is being kept</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Self-Improvement Policy</h2>

<p>The <code>openclaw-superpowers</code> skill library enables self-improvement. It must be configured with guardrails.</p>

<p><strong>Allowed self-improvements:</strong></p>

<ul>
  <li>Writing new skills based on successful workflows</li>
  <li>Updating existing skills with improved methods</li>
  <li>Creating new config templates for discovered patterns</li>
</ul>

<p><strong>Disallowed self-improvements:</strong></p>

<ul>
  <li>Changing core system configuration without owner approval</li>
  <li>Deleting or overwriting critical skills</li>
  <li>Making changes that could break the system</li>
</ul>

<p><strong>How it works in practice:</strong></p>

<ol>
  <li>The system identifies a successful workflow</li>
  <li>It drafts a new skill</li>
  <li>It presents the skill for review (or auto-applies if configured)</li>
  <li>The skill becomes available in future sessions</li>
</ol>

<hr>

<h2 style="color:#00A6A6;">Reflection Protocol</h2>

<p>Reflection is how the system reviews its own performance and learns from outcomes.</p>

<p><strong>What reflection examines:</strong></p>

<ul>
  <li>Did the recommendation match the outcome?</li>
  <li>Was the recommendation accepted or rejected?</li>
  <li>Why was it rejected? (learn from owner decisions)</li>
  <li>What patterns are emerging across multiple interactions?</li>
</ul>

<p><strong>When reflection happens:</strong></p>

<ul>
  <li>After each major decision (dispatch, broker selection, invoice follow-up)</li>
  <li>During scheduled daily or weekly reviews</li>
  <li>When the owner asks for a pattern analysis</li>
</ul>

<p><strong>Output of reflection:</strong></p>

<ul>
  <li>Updated broker scores</li>
  <li>Refined dispatch rules</li>
  <li>New patterns added to memory</li>
  <li>Suggestions for system improvement</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Learning from Corrections</h2>

<p>When the owner corrects the system, that correction must be remembered.</p>

<p><strong>How it works:</strong></p>

<ol>
  <li>Owner says: "Actually, that broker paid on time last time, not late."</li>
  <li>System recognizes the correction.</li>
  <li>System updates the broker record in the database.</li>
  <li>System adds a note to memory: "Owner corrected the broker's payment status."</li>
  <li>System uses the corrected information in future decisions.</li>
</ol>

<p><span style="color:#FACC15; font-weight:600;">Why it matters:</span> The system gets smarter from your corrections. It doesn't make the same mistake twice.</p>

<hr>

<h2 style="color:#00A6A6;">Pattern Recognition</h2>

<p>Pattern recognition is how the system connects dots across separate interactions.</p>

<p><strong>Examples of patterns the system should recognize:</strong></p>

<ul>
  <li>"This lane has strong outbound but weak reloads."</li>
  <li>"This broker always pays late after a dispute."</li>
  <li>"This truck needs maintenance every 15,000 miles."</li>
  <li>"This fuel stop is consistently cheaper."</li>
  <li>"This driver performs best on regional loads."</li>
</ul>

<p><strong>How it works:</strong></p>

<ul>
  <li>The system reviews snapshots and records</li>
  <li>It identifies recurring patterns</li>
  <li>It stores patterns as intelligence in memory</li>
  <li>It applies patterns to future recommendations</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">The Path to Layer 6: Autonomous Improvement</h2>

<p>Layer 6 is the goal: the system suggests improvements without being asked.</p>

<p><strong>How we get there:</strong></p>

<table>
  <thead>
    <tr>
      <th>Step</th>
      <th>What Happens</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Start with <code>memory-core</code> (default) or upgrade to <code>memory-lancedb</code></td>
    </tr>
    <tr>
      <td>2</td>
      <td>Optionally enable <code>memory-wiki</code> for a knowledge vault</td>
    </tr>
    <tr>
      <td>3</td>
      <td>Optionally enable <code>Active Memory</code> for automatic recall</td>
    </tr>
    <tr>
      <td>4</td>
      <td>Optionally evaluate <code>openclaw-superpowers</code> for self-improvement</td>
    </tr>
    <tr>
      <td>5</td>
      <td>Use the system for real business decisions</td>
    </tr>
    <tr>
      <td>6</td>
      <td>System accumulates snapshots and outcomes</td>
    </tr>
    <tr>
      <td>7</td>
      <td>System identifies patterns and (optionally) writes new skills</td>
    </tr>
    <tr>
      <td>8</td>
      <td>System reviews its own performance periodically</td>
    </tr>
    <tr>
      <td>9</td>
      <td>System suggests config and rule updates</td>
    </tr>
    <tr>
      <td>10</td>
      <td>Owner reviews and approves improvements</td>
    </tr>
    <tr>
      <td>11</td>
      <td>System continues improving</td>
    </tr>
  </tbody>
</table>

<p>This is not a science project. This is the natural progression of a system that remembers, learns, and reflects.</p>

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
      <td>Foundation build: GCP VM, OpenClaw, workspace</td>
      <td>Foundation Build</td>
    </tr>
    <tr>
      <td>Phase 2</td>
      <td>Optionally enable <code>memory-lancedb</code> (recommended)</td>
      <td>Foundation Build</td>
    </tr>
    <tr>
      <td>Phase 3</td>
      <td>Optionally enable <code>memory-wiki</code> and <code>Active Memory</code></td>
      <td>Foundation Build</td>
    </tr>
    <tr>
      <td>Phase 4</td>
      <td>Optionally evaluate <code>openclaw-superpowers</code></td>
      <td>After foundation is stable</td>
    </tr>
    <tr>
      <td>Phase 5</td>
      <td>Use Dispatch Agent with snapshots</td>
      <td>Week 1</td>
    </tr>
    <tr>
      <td>Phase 6</td>
      <td>Review snapshots, identify patterns</td>
      <td>Week 2-4</td>
    </tr>
    <tr>
      <td>Phase 7</td>
      <td>System optionally creates new skills</td>
      <td>Month 1-2</td>
    </tr>
    <tr>
      <td>Phase 8</td>
      <td>System reflects on own performance</td>
      <td>Month 2-3</td>
    </tr>
    <tr>
      <td>Phase 9</td>
      <td>System suggests improvements</td>
      <td>Month 3-6</td>
    </tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">What This System Is Not</h2>

<p>This system is not a replacement for human judgment. The owner still makes the decisions. The system learns from those decisions and gets better at supporting them.</p>

<p>This system is not a black box. All memory can be audited. All skills can be reviewed. The system's learning is transparent.</p>

<p>This system is not magic. It requires use. The more you use it, the smarter it gets. It learns from real business data, not from theoretical training.</p>

<hr>

<h2 style="color:#00A6A6;">Current Status</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Architecture defined. This note describes the complete memory, learning, and self-improvement architecture for TruckOps.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> No memory plugins have been installed yet. The foundation build (GCP VM, OpenClaw, workspace) has not been executed.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Use the Foundation Build Runbook to build the core foundation. Once OpenClaw is running, consider enabling the recommended memory stack:</p>

<ul>
  <li><code>memory-lancedb</code> (recommended upgrade from <code>memory-core</code>)</li>
  <li><code>memory-wiki</code> (recommended knowledge vault)</li>
  <li><code>Active Memory</code> (optional automatic recall)</li>
</ul>

<p>Then, after the foundation is stable, evaluate <code>openclaw-superpowers</code> for self-improvement capabilities. Begin using the Dispatch Agent, capturing snapshots, and letting the system learn from real use.</p>

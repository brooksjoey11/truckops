<h1 style="color:#F97316;">DEVELOPMENT, TESTING & RELEASE PROCESS</h1>
<h3 style="color:#B8C7CC;">The process for safely building, testing, improving, releasing, and documenting TruckOps features without breaking the operational system.</h3>
<hr>

<h2 style="color:#00A6A6;">Purpose</h2>
<p>This note defines how the <strong>TruckOps OpenClaw AI Operating System</strong> should be developed, tested, upgraded, released, backed up, documented, and improved over time.</p>
<p>The purpose is to prevent TruckOps from becoming a messy pile of experiments, half-built agents, random scripts, temporary files, broken tools, and undocumented changes.</p>
<p>TruckOps is intended to become a real operating system for the business. That means changes should follow a clear path from idea to working feature.</p>
<p><span style="color:#FACC15; font-weight:600;">Core rule:</span> New work should not be added directly into the live operational system until it has been understood, built, tested, backed up, documented, and connected to the shared TruckOps architecture.</p>
<p>This note explains:</p>
<ul>
  <li>How new ideas become features</li>
  <li>How features move from development to operational use</li>
  <li>How to separate experiments from production</li>
  <li>How to test agents, tools, skills, scripts, and data changes</li>
  <li>How to protect the TruckOps workspace before upgrades</li>
  <li>How to document every meaningful change</li>
  <li>How to avoid disconnected mini-applications</li>
  <li>How to preserve useful lessons for future versions</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Plain-English Summary</h2>
<p>TruckOps should be built like this:</p>
<pre><code>Idea
  ↓
Architecture Placement
  ↓
Development Build
  ↓
Testing With Sample Or Copied Data
  ↓
Validation
  ↓
Backup
  ↓
Release Into Operational Workspace
  ↓
Verification
  ↓
Documentation Update
  ↓
Real Use
  ↓
Outcome Review
  ↓
Improved Future Version</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Plain-English meaning:</span> Do not just throw a new feature into the live system. Decide where it belongs, build it in a controlled way, test it, back up the current system, install it, verify it works, document it, and then use it.</p>
<hr>

<h2 style="color:#00A6A6;">Relationship To Foundation Build Runbook</h2>
<p>The workspace folders referenced in this note (<code>dev/</code>, <code>staging/</code>, <code>tests/</code>, <code>migrations/</code>, <code>releases/</code>, <code>backups/</code>, <code>archive/</code>) are <strong>created during the Foundation Build Runbook (Section 14: Workspace Setup Phase)</strong>.</p>
<p>The backup script referenced in this note (<code>$TRUCKOPS_HOME/tools/backup_truckops.sh</code>) is <strong>created during the Foundation Build Runbook (Section 21: Backup Strategy Before Changes)</strong>.</p>
<p>Use this note to understand <em>how</em> changes should flow. Use the runbook to <em>build</em> the workspace that supports that flow.</p>
<hr>

<h2 style="color:#00A6A6;">Why This Process Matters</h2>
<p>TruckOps is designed to become more useful over time. That only works if changes are organized.</p>
<p>Without a development and release process, the system can develop several problems:</p>
<ul>
  <li>Agents may duplicate work</li>
  <li>Files may get scattered</li>
  <li>Important rules may be buried in prompts instead of config files</li>
  <li>Scripts may be created without documentation</li>
  <li>Databases may change without migration notes</li>
  <li>Useful experiments may be forgotten</li>
  <li>Broken changes may be hard to undo</li>
  <li>The owner may not know which version is actually running</li>
</ul>
<p>This process keeps TruckOps understandable.</p>
<p><span style="color:#FACC15; font-weight:600;">Goal:</span> Every meaningful change should strengthen the shared TruckOps system instead of creating a disconnected side project.</p>
<hr>

<h2 style="color:#00A6A6;">Development Philosophy</h2>
<p>TruckOps development must follow the project's core philosophy:</p>
<blockquote>
  <p><strong>Start small. Prove usefulness. Save the data. Build intelligence from real use.</strong></p>
</blockquote>
<p>That means:</p>
<ol>
  <li>Do not overbuild early versions.</li>
  <li>Do not create a large system before proving the smaller version helps.</li>
  <li>Do not build features just because they are technically possible.</li>
  <li>Build practical tools that reduce owner workload.</li>
  <li>Save the data created by real use.</li>
  <li>Improve future versions based on actual outcomes.</li>
</ol>
<hr>

<h2 style="color:#00A6A6;">Three Working Areas</h2>
<p>TruckOps should be understood in three working areas:</p>
<table>
  <thead>
    <tr>
      <th>Area</th>
      <th>Purpose</th>
      <th>Plain-English Meaning</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Development</td>
      <td>Build or change something</td>
      <td>The workshop</td>
    </tr>
    <tr>
      <td>Testing / Staging</td>
      <td>Try it with sample or copied data</td>
      <td>The proving ground</td>
    </tr>
    <tr>
      <td>Production / Operational Use</td>
      <td>Use it for real business work</td>
      <td>The live system</td>
    </tr>
  </tbody>
</table>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Development work should not interfere with production records, live documents, active databases, or operational decisions.</p>
<hr>

<h2 style="color:#00A6A6;">Recommended Workspace Areas</h2>
<p>The TruckOps workspace should support development, testing, and production separation.</p>
<p>Base workspace:</p>
<pre><code>~/.openclaw/workspace/truckops/</code></pre>
<p>Recommended structure:</p>
<pre><code>~/.openclaw/workspace/truckops/
  agents/
  skills/
  config/
  data/
  databases/
  documents/
  logs/
  snapshots/
  tools/
  services/
  releases/
  backups/
  docs/bootstrap/
  dev/
  staging/
  tests/
  migrations/
  archive/</code></pre>
<p><span style="color:#A5B4FC; font-weight:600;">Note:</span> These folders are created during the <strong>Foundation Build Runbook (Section 14: Workspace Setup Phase)</strong>.</p>
<table>
  <thead>
    <tr>
      <th>Folder</th>
      <th>Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>dev/</code></td>
      <td>Experimental builds, drafts, scratch work, temporary prototypes</td>
    </tr>
    <tr>
      <td><code>staging/</code></td>
      <td>Test area for features before operational use</td>
    </tr>
    <tr>
      <td><code>tests/</code></td>
      <td>Validation files, test prompts, sample inputs, expected outputs</td>
    </tr>
    <tr>
      <td><code>migrations/</code></td>
      <td>Database changes, schema updates, data migration scripts</td>
    </tr>
    <tr>
      <td><code>releases/</code></td>
      <td>Release notes, version records, deployment summaries</td>
    </tr>
    <tr>
      <td><code>backups/</code></td>
      <td>Workspace backups before important changes</td>
    </tr>
    <tr>
      <td><code>archive/</code></td>
      <td>Retired versions, replaced notes, old scripts, deprecated files</td>
    </tr>
  </tbody>
</table>
<hr>

<h2 style="color:#00A6A6;">Feature Lifecycle</h2>
<p>Every TruckOps feature should move through the same basic lifecycle.</p>
<pre><code>Problem
  ↓
Feature Idea
  ↓
Architecture Placement
  ↓
Minimum Useful Version
  ↓
Build
  ↓
Test
  ↓
Release
  ↓
Use
  ↓
Review
  ↓
Improve</code></pre>
<hr>

<h2 style="color:#00A6A6;">Step 1: Define The Real Problem</h2>
<p>Every feature begins with a real-world problem.</p>
<p>Examples:</p>
<ul>
  <li>The owner needs help comparing loads.</li>
  <li>The owner forgets which brokers caused problems.</li>
  <li>Invoices can become overdue without a clear reminder.</li>
  <li>Fuel and expenses make the real profit hard to see.</li>
  <li>Maintenance risk needs to be considered before dispatch decisions.</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Question to answer:</span> What business pain does this feature reduce?</p>
<hr>

<h2 style="color:#00A6A6;">Step 2: Place It In The Architecture</h2>
<p>Before building anything, decide where the work belongs inside TruckOps.</p>
<p>The answer should not automatically be "new agent."</p>
<p>The correct answer may be:</p>
<ul>
  <li>New agent</li>
  <li>Existing agent upgrade</li>
  <li>New skill</li>
  <li>New tool</li>
  <li>New plugin</li>
  <li>New connector</li>
  <li>New database table</li>
  <li>New config file</li>
  <li>New dashboard view</li>
  <li>New workflow</li>
  <li>New report</li>
  <li>Foundation upgrade</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Architecture question:</span> Where does this belong in the shared TruckOps system?</p>
<hr>

<h2 style="color:#00A6A6;">Step 3: Define The Minimum Useful Version</h2>
<p>TruckOps should not start with the largest version of a feature.</p>
<p>The first version should answer:</p>
<ul>
  <li>What is the smallest version that would actually help?</li>
  <li>What does the owner need to input?</li>
  <li>What should the system return?</li>
  <li>What data should be saved?</li>
  <li>What future version could be added later?</li>
</ul>
<h3 style="color:#B8C7CC;">Example: Dispatch Agent</h3>
<table>
  <thead>
    <tr>
      <th>Version</th>
      <th>Capability</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>V1</td>
      <td>Owner manually provides load options; agent compares them and saves snapshot</td>
    </tr>
    <tr>
      <td>V2</td>
      <td>Agent uses saved history to recognize broker and lane patterns</td>
    </tr>
    <tr>
      <td>V3</td>
      <td>Agent connects to permitted load-board data sources</td>
    </tr>
    <tr>
      <td>V4</td>
      <td>Agent performs optional lightweight market monitoring</td>
    </tr>
  </tbody>
</table>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Build the smallest useful version first.</p>
<hr>

<h2 style="color:#00A6A6;">Step 4: Create A Development Ticket</h2>
<p>Each meaningful feature or change should have a development ticket, even if the ticket is only a simple Markdown note.</p>
<p>Suggested location:</p>
<pre><code>~/.openclaw/workspace/truckops/dev/tickets/</code></pre>
<p>Suggested filename:</p>
<pre><code>YYYY-MM-DD__FEATURE-NAME__DEV-TICKET.md</code></pre>
<h3 style="color:#B8C7CC;">Development Ticket Template</h3>
<pre><code># Development Ticket

## Title

## Date

## Problem

## Architecture Placement

## Minimum Useful Version

## Inputs Needed

## Outputs Expected

## Data Read

## Data Written

## Files Changed

## Databases Changed

## Tools / Skills Needed

## Test Plan

## Release Plan

## Rollback Plan

## Documentation Updates Needed

## Status
planned</code></pre>
<hr>

<h2 style="color:#00A6A6;">Step 5: Build In Development Area</h2>
<p>Build early versions in the development area first.</p>
<p>Suggested development paths:</p>
<pre><code>dev/agents/
dev/skills/
dev/tools/
dev/config/
dev/databases/
dev/test-data/
dev/tickets/</code></pre>
<p>Examples:</p>
<pre><code>dev/skills/truckops-dispatch-planner/
dev/tools/load_entry_parser.py
dev/config/dispatch_rules_test.yaml
dev/test-data/sample_loads.json</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Development files should be clearly marked as development files until released.</p>
<hr>

<h2 style="color:#00A6A6;">Step 6: Test With Sample Or Copied Data</h2>
<p>Do not test risky changes against the only copy of important business records.</p>
<p>Use:</p>
<ul>
  <li>Sample data</li>
  <li>Copied database files</li>
  <li>Copied documents</li>
  <li>Test prompts</li>
  <li>Known expected outputs</li>
</ul>
<p>Suggested test folder:</p>
<pre><code>tests/</code></pre>
<h3 style="color:#B8C7CC;">Test Types</h3>
<table>
  <thead>
    <tr>
      <th>Test Type</th>
      <th>Purpose</th>
      <th>Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>File test</td>
      <td>Confirm files can be read/written</td>
      <td>Agent reads <code>trucks.yaml</code></td>
    </tr>
    <tr>
      <td>Database test</td>
      <td>Confirm records save correctly</td>
      <td>Insert sample load into <code>loads.db</code></td>
    </tr>
    <tr>
      <td>Prompt test</td>
      <td>Confirm agent follows instructions</td>
      <td>Dispatch Agent compares three sample loads</td>
    </tr>
    <tr>
      <td>Snapshot test</td>
      <td>Confirm decision history is saved</td>
      <td>Recommendation saved to <code>snapshots/dispatch/</code></td>
    </tr>
    <tr>
      <td>Connector test</td>
      <td>Confirm external system access</td>
      <td>Future load-board, email, or fuel-card connection</td>
    </tr>
    <tr>
      <td>Regression test</td>
      <td>Confirm old behavior still works</td>
      <td>Existing Dispatch Agent test still passes after update</td>
    </tr>
  </tbody>
</table>
<p><span style="color:#A5B4FC; font-weight:600;">Connector test note:</span> When testing external connectors (load boards, fuel cards, factoring portals), respect platform permissions. Prefer official APIs, sandbox environments, or sample exports over live production testing.</p>
<hr>

<h2 style="color:#00A6A6;">Step 7: Validate Before Release</h2>
<p>Before release, the feature must be validated.</p>
<h3 style="color:#B8C7CC;">Validation Checklist</h3>
<ul>
  <li>Feature solves the original problem</li>
  <li>Feature belongs in the documented architecture</li>
  <li>Feature uses shared TruckOps data where appropriate</li>
  <li>Feature does not create disconnected mini-apps</li>
  <li>Required config files exist</li>
  <li>Required database tables exist</li>
  <li>Required skills exist</li>
  <li>Required tools are available</li>
  <li>Test data produces expected results</li>
  <li>Snapshots or logs are saved when needed</li>
  <li>Failure behavior is understandable</li>
  <li>Documentation updates are ready</li>
  <li>Rollback path exists</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Step 8: Backup Before Release</h2>
<p>Before releasing a feature into operational use, create a backup of the TruckOps workspace.</p>
<p>Use the backup script created in the <strong>Foundation Build Runbook (Section 21: Backup Strategy Before Changes)</strong>:</p>
<pre><code class="language-bash">"$TRUCKOPS_HOME/tools/backup_truckops.sh"</code></pre>
<p>Verify backup exists:</p>
<pre><code class="language-bash">ls -lah "$TRUCKOPS_HOME/backups"</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Backup rule:</span> No meaningful production change should happen without a recent backup.</p>
<hr>

<h2 style="color:#00A6A6;">Step 9: Release Into Operational Workspace</h2>
<p>After validation and backup, move the tested files from development or staging into the operational workspace.</p>
<h3 style="color:#B8C7CC;">Examples</h3>
<p>Skill release:</p>
<pre><code class="language-bash">cp -r "$TRUCKOPS_HOME/dev/skills/truckops-dispatch-planner" "$TRUCKOPS_HOME/skills/"</code></pre>
<p>Tool release:</p>
<pre><code class="language-bash">cp "$TRUCKOPS_HOME/dev/tools/load_entry_parser.py" "$TRUCKOPS_HOME/tools/"</code></pre>
<p>Config release:</p>
<pre><code class="language-bash">cp "$TRUCKOPS_HOME/dev/config/dispatch_rules.yaml" "$TRUCKOPS_HOME/config/dispatch_rules.yaml"</code></pre>
<p>Migration release:</p>
<pre><code class="language-bash">sqlite3 "$TRUCKOPS_HOME/databases/loads.db" < "$TRUCKOPS_HOME/migrations/2026-07-01__loads-update.sql"</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Released files should live in the standard TruckOps folders, not in <code>dev/</code>.</p>
<hr>

<h2 style="color:#00A6A6;">Step 10: Restart Or Refresh What Needs Refreshing</h2>
<p>Some changes require a refresh or restart before they are available.</p>
<table>
  <thead>
    <tr>
      <th>Change Type</th>
      <th>Likely Refresh Needed</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>New skill</td>
      <td>New session or OpenClaw Gateway restart</td>
    </tr>
    <tr>
      <td>New plugin</td>
      <td>Gateway restart</td>
    </tr>
    <tr>
      <td>New channel</td>
      <td>Gateway restart or channel reload</td>
    </tr>
    <tr>
      <td>New config file</td>
      <td>Usually no restart if read directly from file</td>
    </tr>
    <tr>
      <td>New database table</td>
      <td>No restart unless a running service caches schema</td>
    </tr>
    <tr>
      <td>New model provider</td>
      <td>Provider config reload or onboarding refresh</td>
    </tr>
  </tbody>
</table>
<p>Common restart command:</p>
<pre><code class="language-bash">openclaw gateway restart</code></pre>
<p>Status check:</p>
<pre><code class="language-bash">openclaw gateway status
openclaw status --deep || openclaw health</code></pre>
<hr>

<h2 style="color:#00A6A6;">Step 11: Verify Release</h2>
<p>After release, confirm the new feature works in the operational environment.</p>
<h3 style="color:#B8C7CC;">Release Verification Checklist</h3>
<ul>
  <li>OpenClaw Gateway is running</li>
  <li>Active channel works</li>
  <li>Relevant skill is visible or usable</li>
  <li>Relevant config file can be read</li>
  <li>Relevant database can be opened</li>
  <li>Feature produces expected output</li>
  <li>Feature saves expected record or snapshot</li>
  <li>No unexpected errors appear in logs</li>
</ul>
<h3 style="color:#B8C7CC;">Example Verification Commands</h3>
<pre><code class="language-bash">openclaw gateway status
tree -L 2 "$TRUCKOPS_HOME"
find "$TRUCKOPS_HOME/skills" -name SKILL.md -print
ls -lah "$TRUCKOPS_HOME/config"
ls -lah "$TRUCKOPS_HOME/databases"
ls -lah "$TRUCKOPS_HOME/snapshots"</code></pre>
<hr>

<h2 style="color:#00A6A6;">Step 12: Write A Release Note</h2>
<p>Every meaningful release should create a release note.</p>
<p>Suggested location:</p>
<pre><code>releases/</code></pre>
<p>Suggested filename:</p>
<pre><code>YYYY-MM-DD__VERSION__SHORT-DESCRIPTION.md</code></pre>
<h3 style="color:#B8C7CC;">Release Note Template</h3>
<pre><code># Release Note

## Version

## Date

## Summary

## Reason For Change

## Files Added

## Files Modified

## Files Removed

## Databases Changed

## Config Changed

## Skills Changed

## Tools Changed

## Plugins Changed

## Tests Performed

## Backup Created

## Verification Results

## Known Issues

## Rollback Instructions

## Documentation Updated

## Status
released</code></pre>
<hr>

<h2 style="color:#00A6A6;">Step 13: Update Joplin Documentation</h2>
<p>After a meaningful release, update the relevant Joplin notes.</p>
<p>Possible updates:</p>
<ul>
  <li>AI Context &amp; Development Log</li>
  <li>Foundation note</li>
  <li>Data, Memory &amp; Records Baseline</li>
  <li>Agent-specific note</li>
  <li>Runbook if the setup process changed</li>
  <li>System Architecture Baseline if architecture changed</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> If future AI instances need to know about the change, it belongs in Joplin or in a release note.</p>
<hr>

<h2 style="color:#00A6A6;">Step 14: Review Outcome After Real Use</h2>
<p>After the feature is used in the real workflow, review what happened.</p>
<p>Outcome review should answer:</p>
<ul>
  <li>Did the feature reduce owner workload?</li>
  <li>Did the feature give a better decision?</li>
  <li>Did it save the right data?</li>
  <li>Did the output make sense?</li>
  <li>Was anything missing?</li>
  <li>Should the feature be improved, simplified, or paused?</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Memory rule:</span> The outcome review should be saved. The system learns from what actually happened, not just from what was planned.</p>
<hr>

<h2 style="color:#00A6A6;">Change Types</h2>
<p>Not every change requires the same process. Use the change type to decide how much testing and documentation is needed.</p>
<table>
  <thead>
    <tr>
      <th>Change Type</th>
      <th>Examples</th>
      <th>Process Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Documentation-only</td>
      <td>Joplin wording update, note reorganization</td>
      <td>Document change in Development Log if meaningful</td>
    </tr>
    <tr>
      <td>Config change</td>
      <td>Dispatch scoring weights, broker thresholds</td>
      <td>Backup, test with sample scenario, record change</td>
    </tr>
    <tr>
      <td>Skill change</td>
      <td>New or revised <code>SKILL.md</code></td>
      <td>Test prompt, verify behavior, update release note</td>
    </tr>
    <tr>
      <td>Tool/script change</td>
      <td>Parser, backup script, import script</td>
      <td>Run test input, verify output, backup before release</td>
    </tr>
    <tr>
      <td>Database change</td>
      <td>New table, added column, migration</td>
      <td>Backup required, migration note required, test copy first</td>
    </tr>
    <tr>
      <td>Connector change</td>
      <td>Email, load board, fuel card, factoring portal</td>
      <td>Credential check, limited test, logging, release note</td>
    </tr>
    <tr>
      <td>Model/provider change</td>
      <td>Switch hosted model, add local model</td>
      <td>Test key workflows before relying on it</td>
    </tr>
    <tr>
      <td>OpenClaw upgrade</td>
      <td>New OpenClaw version</td>
      <td>Backup, status check before/after, release note</td>
    </tr>
  </tbody>
</table>
<hr>

<h2 style="color:#00A6A6;">Versioning Standard</h2>
<p>TruckOps should use simple version names.</p>
<table>
  <thead>
    <tr>
      <th>Version Type</th>
      <th>Meaning</th>
      <th>Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Foundation version</td>
      <td>Infrastructure and base system version</td>
      <td><code>foundation-v1.0</code></td>
    </tr>
    <tr>
      <td>Agent version</td>
      <td>Specific agent capability version</td>
      <td><code>dispatch-agent-v1.0</code></td>
    </tr>
    <tr>
      <td>Skill version</td>
      <td>Skill instruction version</td>
      <td><code>dispatch-planner-skill-v1.1</code></td>
    </tr>
    <tr>
      <td>Config version</td>
      <td>Rules/settings version</td>
      <td><code>dispatch-rules-v0.2</code></td>
    </tr>
  </tbody>
</table>
<h3 style="color:#B8C7CC;">Simple Version Meaning</h3>
<ul>
  <li><code>v0.x</code> = draft or planning version</li>
  <li><code>v1.0</code> = first usable version</li>
  <li><code>v1.1</code> = small improvement</li>
  <li><code>v2.0</code> = major capability upgrade</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Rollback Process</h2>
<p>Rollback means returning TruckOps to a previous working state if a release causes problems.</p>
<h3 style="color:#B8C7CC;">Rollback Rules</h3>
<ol>
  <li>Identify what changed.</li>
  <li>Stop using the broken feature.</li>
  <li>Restore files from backup if needed.</li>
  <li>Restore database from backup if needed.</li>
  <li>Restart OpenClaw Gateway if needed.</li>
  <li>Verify the previous working behavior.</li>
  <li>Record what happened in a release note or incident note.</li>
</ol>
<h3 style="color:#B8C7CC;">Rollback Command Pattern</h3>
<pre><code class="language-bash"># Example only. Replace backup filename with the correct one.
mkdir -p "$TRUCKOPS_HOME/restore-test"
tar -xzf "$TRUCKOPS_HOME/backups/truckops-backup-YYYYMMDD-HHMMSS.tar.gz" -C "$TRUCKOPS_HOME/restore-test"</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Validation:</span> Inspect the restored files before overwriting the live workspace:</p>
<pre><code class="language-bash">ls -lah "$TRUCKOPS_HOME/restore-test"
cat "$TRUCKOPS_HOME/restore-test/config/dispatch_rules.yaml"</code></pre>
<p>Only proceed with the full restore after confirming the backup contains what you expect.</p>
<hr>

<h2 style="color:#00A6A6;">Incident Notes</h2>
<p>If something breaks, create an incident note.</p>
<p>Suggested location:</p>
<pre><code>releases/incidents/</code></pre>
<h3 style="color:#B8C7CC;">Incident Note Template</h3>
<pre><code># Incident Note

## Date

## What Broke

## What Changed Before It Broke

## Symptoms

## Logs Checked

## Fix Applied

## Rollback Used
yes/no

## Data Lost
yes/no

## Lesson Learned

## Follow-Up Needed

## Status
resolved / unresolved</code></pre>
<hr>

<h2 style="color:#00A6A6;">Testing Standards By Agent</h2>
<h3 style="color:#B8C7CC;">Dispatch Agent Test</h3>
<p>Dispatch Agent should be tested with sample loads.</p>
<p>Expected test:</p>
<ul>
  <li>Provide three sample loads</li>
  <li>Include rate, miles, pickup, delivery, broker, timing, and deadhead</li>
  <li>Ask agent to compare options</li>
  <li>Agent should apply dispatch rules</li>
  <li>Agent should recommend one option</li>
  <li>Agent should explain why</li>
  <li>Agent should save a dispatch snapshot if configured</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Broker Intelligence Agent Test</h3>
<ul>
  <li>Provide sample broker history</li>
  <li>Include one good broker, one neutral broker, and one problem broker</li>
  <li>Agent should identify broker status correctly</li>
  <li>Agent should update broker notes or score</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Document Agent Test</h3>
<ul>
  <li>Provide sample document filenames or files</li>
  <li>Agent should classify document type</li>
  <li>Agent should link document to load, broker, invoice, truck, or expense</li>
  <li>Agent should mark missing fields instead of guessing</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Invoice &amp; Collections Agent Test</h3>
<ul>
  <li>Provide sample load and rate confirmation data</li>
  <li>Agent should create invoice draft or invoice record</li>
  <li>Agent should calculate due date</li>
  <li>Agent should mark aging status correctly</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Maintenance Agent Test</h3>
<ul>
  <li>Provide sample odometer and service history</li>
  <li>Agent should identify next service need</li>
  <li>Agent should warn if maintenance risk affects dispatch planning</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Fuel &amp; Expense Agent Test</h3>
<ul>
  <li>Provide sample fuel receipt data</li>
  <li>Agent should calculate fuel cost</li>
  <li>Agent should assign expense category</li>
  <li>Agent should link expense to truck and load when possible</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Cash Flow Agent Test</h3>
<ul>
  <li>Provide open invoices and upcoming expenses</li>
  <li>Agent should calculate expected cash position</li>
  <li>Agent should flag shortfall risk</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Profitability Agent Test</h3>
<ul>
  <li>Provide load revenue, fuel cost, deadhead, expenses, and broker data</li>
  <li>Agent should calculate estimated profit</li>
  <li>Agent should identify whether the load was truly profitable</li>
</ul>
<hr>

<h3 style="color:#B8C7CC;">Daily Briefing Agent Test</h3>
<ul>
  <li>Provide current status across dispatch, invoices, maintenance, cash flow, and documents</li>
  <li>Agent should produce a short priority list</li>
  <li>Agent should identify owner action items</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Release Readiness Checklist</h2>
<p>Before a feature is released, confirm:</p>
<ul>
  <li>The feature has a clear business purpose</li>
  <li>The feature belongs in the architecture</li>
  <li>The minimum useful version is defined</li>
  <li>The feature was built or drafted in development area</li>
  <li>The feature was tested with sample or copied data</li>
  <li>The feature passed validation</li>
  <li>A backup exists</li>
  <li>Required config files exist</li>
  <li>Required database changes are documented</li>
  <li>Required skill files exist</li>
  <li>Required tools are available</li>
  <li>Release note is written</li>
  <li>Joplin documentation is updated if needed</li>
  <li>Rollback path exists</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">What To Avoid</h2>
<ul>
  <li>Do not release untested features into operational use.</li>
  <li>Do not create disconnected mini-applications.</li>
  <li>Do not store business rules only inside a temporary chat.</li>
  <li>Do not make database changes without backup.</li>
  <li>Do not overwrite original documents.</li>
  <li>Do not store credentials in Joplin or normal config files.</li>
  <li>Do not build large features before the smaller version proves useful.</li>
  <li>Do not leave useful changes undocumented.</li>
  <li>Do not let development files masquerade as production files.</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Minimum Process For Small Changes</h2>
<p>Not every small change needs a full release ceremony.</p>
<p>For minor changes, use this shorter process:</p>
<ol>
  <li>Identify what is changing.</li>
  <li>Confirm it does not affect critical data.</li>
  <li>Make the change.</li>
  <li>Test it once.</li>
  <li>Document it if future AI instances need to know.</li>
</ol>
<p>Examples:</p>
<ul>
  <li>Minor wording change in a Joplin note</li>
  <li>Small adjustment to a placeholder skill</li>
  <li>Adding a new folder</li>
  <li>Adding a test prompt</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Current Status</h2>
<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Baseline finalized. This note defines the complete development, testing, release, backup, rollback, and documentation process for TruckOps.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> No operational release process has been executed yet because the live TruckOps foundation has not been built. This process should be used once the workspace, OpenClaw foundation, bootstrap package, initial config files, databases, tools, and skills exist.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Use the Foundation Build Runbook to create the workspace structure, including <code>dev/</code>, <code>staging/</code>, <code>tests/</code>, <code>migrations/</code>, <code>releases/</code>, <code>backups/</code>, and <code>archive/</code>. Then use this process when building Dispatch Agent V1.</p>

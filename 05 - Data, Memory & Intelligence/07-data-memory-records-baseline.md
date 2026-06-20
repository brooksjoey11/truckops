<h1 style="color:#F97316;">DATA, MEMORY & RECORDS BASELINE</h1>

<h3 style="color:#B8C7CC;">The shared data, memory, records, and intelligence structure for the TruckOps OpenClaw AI Operating System.</h3>

<hr>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>This note defines the data and records foundation for the TruckOps OpenClaw AI Operating System.</p>

<p>The purpose is to make sure TruckOps does not become a collection of disconnected agents, scattered files, temporary chats, or one-time answers. Every useful fact, decision, document, load, broker interaction, expense, dispatch comparison, invoice, maintenance event, and outcome should have a clear place to live.</p>

<p><span style="color:#FACC15; font-weight:600;">Core rule:</span> If TruckOps learns something useful, the system should know where to save it so future agents can use it.</p>

<p>This page defines:</p>

<ul>
  <li>What data TruckOps needs</li>
  <li>Where data should be stored</li>
  <li>Which data becomes business memory</li>
  <li>Which agents read and write each data type</li>
  <li>Which records must be preserved permanently</li>
  <li>How snapshots, decisions, and outcomes should be captured</li>
  <li>How the system becomes smarter from real use</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Relationship to Other Notes</h2>

<p>This document defines what data exists and where it lives.</p>

<p>For how TruckOps remembers conversations, reflects on its own performance, learns from corrections, and improves itself, see:</p>

<p><strong>DOCUMENT B: MEMORY, LEARNING & SELF-IMPROVEMENT ARCHITECTURE</strong></p>

<p>For how to build the actual workspace, install the memory plugins, and configure the learning stack, see:</p>

<p><strong>FOUNDATION BUILD RUNBOOK: GCP + VM + OPENCLAW INITIALIZATION</strong></p>

<hr>

<h2 style="color:#00A6A6;">Plain-English Summary</h2>

<p>TruckOps should not only answer questions. It should remember the business.</p>

<p>The system should remember:</p>

<ul>
  <li>Which loads were considered</li>
  <li>Which loads were rejected</li>
  <li>Which loads were booked</li>
  <li>Why the owner made a decision</li>
  <li>What happened afterward</li>
  <li>Which brokers paid well</li>
  <li>Which brokers caused problems</li>
  <li>Which lanes made money</li>
  <li>Which lanes wasted time</li>
  <li>Which expenses hurt profit</li>
  <li>Which trucks need attention</li>
  <li>Which documents are missing</li>
  <li>Which invoices are unpaid</li>
  <li>Which patterns repeat</li>
</ul>

<p>This is how TruckOps moves from being a chat assistant to being a business operating system.</p>

<hr>

<h2 style="color:#00A6A6;">Data Philosophy</h2>

<p><span style="color:#FACC15; font-weight:600;">Core philosophy:</span> Start small. Save the useful facts. Build intelligence from real use.</p>

<p>Early TruckOps data storage should be simple. The system does not need a complex enterprise database on day one. It needs a clean, understandable structure that can grow.</p>

<p>Initial storage can use:</p>

<ul>
  <li>YAML files for configuration and business rules</li>
  <li>SQLite databases for structured operational records</li>
  <li>Document folders for BOLs, rate confirmations, invoices, receipts, and other files</li>
  <li>Snapshot folders for AI-generated analysis, recommendations, and owner decisions</li>
  <li>Logs for system activity and troubleshooting</li>
  <li>Backups for recovery</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Important:</span> The system should not rely on memory inside a chat thread. If something matters to the business, it should be saved into the TruckOps workspace.</p>

<hr>

<h2 style="color:#00A6A6;">Data vs Memory vs Intelligence</h2>

<table>
  <thead>
    <tr>
      <th>Layer</th>
      <th>Meaning</th>
      <th>Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Data</td>
      <td>Raw or structured facts</td>
      <td>A load paid $2,400 for 780 loaded miles</td>
    </tr>
    <tr>
      <td>Record</td>
      <td>A saved business event or document</td>
      <td>A rate confirmation, BOL, invoice, repair bill, or fuel receipt</td>
    </tr>
    <tr>
      <td>Memory</td>
      <td>Useful history the system can use later</td>
      <td>This broker paid late twice and disputed detention once</td>
    </tr>
    <tr>
      <td>Snapshot</td>
      <td>A saved picture of a situation at a moment in time</td>
      <td>Dispatch options reviewed Monday morning before choosing a load</td>
    </tr>
    <tr>
      <td>Intelligence</td>
      <td>Patterns learned from saved history</td>
      <td>This lane looks profitable but usually leaves the truck in a weak reload market</td>
    </tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Shared Workspace Location</h2>

<p>The TruckOps data layer lives inside the shared TruckOps workspace:</p>

<pre><code>~/.openclaw/workspace/truckops/</code></pre>

<p>The concrete creation steps for this workspace and its subfolders are defined in the Foundation Build Runbook (Section 14: Workspace Setup Phase) .</p>

<p>Relevant folders:</p>

<pre><code>~/.openclaw/workspace/truckops/
  config/
  data/
  databases/
  documents/
  logs/
  snapshots/
  backups/
  docs/bootstrap/
  agents/
  skills/
  tools/
  services/
  releases/
  dev/
  staging/
  tests/
  migrations/
  archive/</code></pre>

<table>
  <thead>
    <tr>
      <th>Folder</th>
      <th>Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>config/</code></td>
      <td>Business rules, preferences, scoring settings, truck profiles, driver profiles</td>
    </tr>
    <tr>
      <td><code>data/</code></td>
      <td>General structured working data that does not yet require a database</td>
    </tr>
    <tr>
      <td><code>databases/</code></td>
      <td>SQLite databases for loads, brokers, documents, expenses, snapshots, invoices, maintenance, and other records</td>
    </tr>
    <tr>
      <td><code>documents/</code></td>
      <td>Original business documents and files</td>
    </tr>
    <tr>
      <td><code>logs/</code></td>
      <td>System logs, agent logs, errors, command outputs, and runtime records</td>
    </tr>
    <tr>
      <td><code>snapshots/</code></td>
      <td>Saved AI analyses, dispatch comparisons, recommendations, decisions, and outcomes</td>
    </tr>
    <tr>
      <td><code>backups/</code></td>
      <td>Local backups before offsite or cloud backup is added</td>
    </tr>
    <tr>
      <td><code>docs/bootstrap/</code></td>
      <td>Exported TruckOps Architecture Bootstrap Package from Joplin</td>
    </tr>
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
      <td><code>archive/</code></td>
      <td>Retired versions, replaced notes, old scripts, deprecated files</td>
    </tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Source-of-Truth Rules</h2>

<ol>
  <li>Configuration rules belong in <code>config/</code>.</li>
  <li>Business records belong in <code>databases/</code>.</li>
  <li>Original documents belong in <code>documents/</code>.</li>
  <li>AI-generated situational reports belong in <code>snapshots/</code>.</li>
  <li>System activity belongs in <code>logs/</code>.</li>
  <li>Project architecture and bootstrap files belong in <code>docs/bootstrap/</code>.</li>
  <li>Credentials do not belong in Joplin, public notes, snapshots, or normal config files.</li>
</ol>

<p><span style="color:#FACC15; font-weight:600;">Credential rule:</span> Secrets belong in <code>~/.openclaw/secrets.env</code> or a later formal secrets manager.</p>

<hr>

<h2 style="color:#00A6A6;">Core Data Categories</h2>

<h3 style="color:#B8C7CC;">1. Company Data</h3>

<p>Company data describes the business itself.</p>

<p>Includes:</p>

<ul>
  <li>Business name</li>
  <li>Entity type</li>
  <li>DOT number</li>
  <li>MC number</li>
  <li>Insurance information</li>
  <li>Factoring company</li>
  <li>Primary contacts</li>
  <li>Banking/accounting references</li>
  <li>Authority status</li>
  <li>Compliance dates</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>config/company.yaml</code></li>
  <li><code>documents/company/</code></li>
  <li><code>documents/insurance/</code></li>
  <li><code>documents/contracts/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Document Agent</li>
  <li>Daily Briefing Agent</li>
  <li>Future Administrative Assistant Agent</li>
</ul>

<p>Reference: Created by the Foundation Build Runbook (Section 16).</p>

<hr>

<h3 style="color:#B8C7CC;">2. Truck Data</h3>

<p>Truck data describes each truck in the business.</p>

<p>Includes:</p>

<ul>
  <li>Truck ID</li>
  <li>Unit number</li>
  <li>VIN</li>
  <li>Year, make, model</li>
  <li>Current location</li>
  <li>Assigned driver</li>
  <li>Odometer</li>
  <li>Fuel economy</li>
  <li>Maintenance status</li>
  <li>Insurance status</li>
  <li>Registration status</li>
  <li>IFTA-related notes</li>
  <li>Out-of-service status</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>config/trucks.yaml</code></li>
  <li><code>databases/trucks.db</code> (future)</li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Dispatch Agent</li>
  <li>Maintenance Agent</li>
  <li>Profitability Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p>Reference: Created by the Foundation Build Runbook (Section 16.1).</p>

<hr>

<h3 style="color:#B8C7CC;">3. Driver Data</h3>

<p>Driver data describes the owner and any future hired drivers.</p>

<p>Includes:</p>

<ul>
  <li>Driver ID</li>
  <li>Name</li>
  <li>Assigned truck</li>
  <li>Home base</li>
  <li>License status</li>
  <li>Medical card status</li>
  <li>Availability</li>
  <li>Hours-of-service notes</li>
  <li>Lane preferences</li>
  <li>Pay structure</li>
  <li>Performance notes</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>config/drivers.yaml</code></li>
  <li><code>databases/drivers.db</code> (future)</li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Dispatch Agent</li>
  <li>Maintenance Agent</li>
  <li>Profitability Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p>Reference: Created by the Foundation Build Runbook (Section 16.2).</p>

<hr>

<h3 style="color:#B8C7CC;">4. Broker Data</h3>

<p>Broker data records the business history with brokers.</p>

<p>Includes:</p>

<ul>
  <li>Broker name</li>
  <li>MC number</li>
  <li>Contact names</li>
  <li>Phone numbers</li>
  <li>Email addresses</li>
  <li>Payment speed</li>
  <li>Communication quality</li>
  <li>Detention behavior</li>
  <li>Cancellation history</li>
  <li>Dispute history</li>
  <li>Notes</li>
  <li>Score</li>
  <li>Preferred / neutral / avoid status</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>config/broker_rules.yaml</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/invoices.db</code></li>
  <li><code>snapshots/brokers/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Broker Intelligence Agent</li>
  <li>Dispatch Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Profitability Agent</li>
</ul>

<p>Reference: Created by the Foundation Build Runbook (Section 16.4 and Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">5. Load Data</h3>

<p>Load data records every load considered, rejected, booked, hauled, delivered, invoiced, and paid.</p>

<p>Includes:</p>

<ul>
  <li>Load ID</li>
  <li>Source</li>
  <li>Broker</li>
  <li>Pickup location</li>
  <li>Delivery location</li>
  <li>Pickup date/time</li>
  <li>Delivery date/time</li>
  <li>Loaded miles</li>
  <li>Deadhead miles</li>
  <li>Total miles</li>
  <li>Rate</li>
  <li>All-in rate per mile</li>
  <li>Commodity</li>
  <li>Weight</li>
  <li>Equipment type</li>
  <li>Appointment requirements</li>
  <li>Status</li>
  <li>Reason accepted or rejected</li>
  <li>Final outcome</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>databases/snapshots.db</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Dispatch Agent</li>
  <li>Broker Intelligence Agent</li>
  <li>Profitability Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p>Reference: Created by the Foundation Build Runbook (Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">6. Dispatch Snapshot Data</h3>

<p>A dispatch snapshot records the situation when the Dispatch Agent analyzes options.</p>

<p>A snapshot should include:</p>

<ul>
  <li>Owner's question</li>
  <li>Date/time</li>
  <li>Truck status</li>
  <li>Driver status</li>
  <li>Current location</li>
  <li>Available load options</li>
  <li>Loads rejected</li>
  <li>Loads recommended</li>
  <li>Reason for recommendation</li>
  <li>Owner's final decision</li>
  <li>Actual outcome</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>snapshots/dispatch/</code></li>
  <li><code>databases/snapshots.db</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Dispatch Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Dispatch snapshots are how TruckOps learns what actually worked instead of only remembering what looked good at the time.</p>

<p>Reference: Created by the Foundation Build Runbook (Section 14 and Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">7. Document Data</h3>

<p>Document data indexes business documents and links them to the correct load, broker, truck, invoice, expense, or maintenance event.</p>

<p>Documents include:</p>

<ul>
  <li>Rate confirmations</li>
  <li>BOLs</li>
  <li>PODs</li>
  <li>Invoices</li>
  <li>Fuel receipts</li>
  <li>Repair invoices</li>
  <li>Scale tickets</li>
  <li>Toll receipts</li>
  <li>Insurance documents</li>
  <li>Registration documents</li>
  <li>Inspection documents</li>
  <li>Contracts</li>
  <li>Permits</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>documents/</code></li>
  <li><code>documents/loads/</code></li>
  <li><code>documents/invoices/</code></li>
  <li><code>documents/fuel/</code></li>
  <li><code>documents/maintenance/</code></li>
  <li><code>databases/documents.db</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Document Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Maintenance Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Original documents should be preserved. Extracted data and summaries should be linked to the original file, not replace it.</p>

<p>Reference: Created by the Foundation Build Runbook (Section 14 and Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">8. Invoice And Collections Data</h3>

<p>Invoice data tracks what has been billed, what has been paid, and what is overdue.</p>

<p>Includes:</p>

<ul>
  <li>Invoice number</li>
  <li>Load ID</li>
  <li>Broker/customer</li>
  <li>Invoice date</li>
  <li>Due date</li>
  <li>Amount</li>
  <li>Factoring status</li>
  <li>Payment status</li>
  <li>Days outstanding</li>
  <li>Follow-up history</li>
  <li>Dispute status</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>databases/invoices.db</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>documents/invoices/</code></li>
  <li><code>snapshots/collections/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Invoice & Collections Agent</li>
  <li>Document Agent</li>
  <li>Cash Flow Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Revenue does not help the business until it becomes collected cash.</p>

<p>Reference: Created by the Foundation Build Runbook (Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">9. Fuel And Expense Data</h3>

<p>Fuel and expense data records the operating cost of the business.</p>

<p>Includes:</p>

<ul>
  <li>Fuel purchases</li>
  <li>Fuel location</li>
  <li>Gallons</li>
  <li>Price per gallon</li>
  <li>Total cost</li>
  <li>Truck ID</li>
  <li>Load ID if related</li>
  <li>Maintenance reserve</li>
  <li>Tolls</li>
  <li>Parking</li>
  <li>Scales</li>
  <li>Permits</li>
  <li>Insurance</li>
  <li>Truck payment</li>
  <li>Trailer payment</li>
  <li>Subscriptions</li>
  <li>Software tools</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>config/expense_categories.yaml</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>documents/fuel/</code></li>
  <li><code>documents/receipts/</code></li>
  <li><code>snapshots/expenses/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Fuel & Expense Agent</li>
  <li>Profitability Agent</li>
  <li>Cash Flow Agent</li>
  <li>Dispatch Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> A load can look profitable before costs and become weak after fuel, deadhead, maintenance reserve, and time are included.</p>

<p>Reference: Created by the Foundation Build Runbook (Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">10. Maintenance Data</h3>

<p>Maintenance data tracks truck health, service intervals, repairs, and downtime risk.</p>

<p>Includes:</p>

<ul>
  <li>Truck ID</li>
  <li>Service date</li>
  <li>Odometer</li>
  <li>Service type</li>
  <li>Shop/vendor</li>
  <li>Cost</li>
  <li>Parts replaced</li>
  <li>Next service due</li>
  <li>Warranty notes</li>
  <li>Downtime</li>
  <li>Related documents</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>config/trucks.yaml</code></li>
  <li><code>databases/maintenance.db</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>documents/maintenance/</code></li>
  <li><code>snapshots/maintenance/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Maintenance Agent</li>
  <li>Dispatch Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Dispatch decisions should account for equipment condition, not just rate and miles.</p>

<p>Reference: Created by the Foundation Build Runbook (Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">11. Cash Flow Data</h3>

<p>Cash flow data helps TruckOps understand whether the business can cover upcoming obligations.</p>

<p>Includes:</p>

<ul>
  <li>Expected income</li>
  <li>Expected payment dates</li>
  <li>Open invoices</li>
  <li>Upcoming bills</li>
  <li>Fuel needs</li>
  <li>Maintenance reserves</li>
  <li>Driver pay</li>
  <li>Truck payments</li>
  <li>Insurance</li>
  <li>Emergency reserve</li>
  <li>Shortfall warnings</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>databases/cash_flow.db</code></li>
  <li><code>databases/invoices.db</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>snapshots/cash-flow/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Cash Flow Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Daily Briefing Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Profit on paper and cash available today are not the same thing.</p>

<p>Reference: Created by the Foundation Build Runbook (Section 16.5).</p>

<hr>

<h3 style="color:#B8C7CC;">12. Profitability Data</h3>

<p>Profitability data turns raw business activity into useful business intelligence.</p>

<p>Includes:</p>

<ul>
  <li>Profit per load</li>
  <li>Profit per mile</li>
  <li>Profit per lane</li>
  <li>Profit per broker</li>
  <li>Profit per truck</li>
  <li>Profit per driver</li>
  <li>Deadhead impact</li>
  <li>Fuel impact</li>
  <li>Maintenance impact</li>
  <li>Time impact</li>
  <li>Weak-market penalty</li>
  <li>Reload advantage</li>
</ul>

<p>Primary Data:</p>

<ul>
  <li><code>databases/profitability.db</code> (future)</li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>databases/maintenance.db</code></li>
  <li><code>snapshots/profitability/</code></li>
</ul>

<p>Primary Agents:</p>

<ul>
  <li>Profitability Agent</li>
  <li>Dispatch Agent</li>
  <li>Broker Intelligence Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Cash Flow Agent</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> TruckOps should help answer, "What actually makes money?" not just "What pays a good rate?"</p>

<p>Reference: Created by the Foundation Build Runbook (Section 16.5).</p>

<hr>

<h2 style="color:#00A6A6;">Agent Read / Write Map</h2>

<table>
  <thead>
    <tr>
      <th>Agent</th>
      <th>Reads</th>
      <th>Writes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Dispatch Agent</td>
      <td>Trucks, drivers, brokers, loads, rules, fuel costs, maintenance status, lane history</td>
      <td>Dispatch snapshots, load comparisons, recommendations, rejected options, owner decisions, outcomes</td>
    </tr>
    <tr>
      <td>Broker Intelligence Agent</td>
      <td>Broker records, load outcomes, payment records, disputes, communication history</td>
      <td>Broker scores, broker warnings, broker notes, preferred/avoid status</td>
    </tr>
    <tr>
      <td>Document Agent</td>
      <td>Uploaded documents, email attachments, document folders</td>
      <td>Document index, extracted fields, missing-document flags, links to loads/invoices/expenses</td>
    </tr>
    <tr>
      <td>Invoice & Collections Agent</td>
      <td>Loads, rate confirmations, invoices, payment records, broker contacts</td>
      <td>Invoices, aging records, follow-up notes, payment status</td>
    </tr>
    <tr>
      <td>Maintenance Agent</td>
      <td>Truck data, odometer, repair records, maintenance schedules, load plans</td>
      <td>Maintenance alerts, service records, downtime notes, repair cost records</td>
    </tr>
    <tr>
      <td>Fuel & Expense Agent</td>
      <td>Fuel receipts, expenses, loads, mileage, driver pay rules</td>
      <td>Expense records, cost-per-mile data, fuel analysis</td>
    </tr>
    <tr>
      <td>Cash Flow Agent</td>
      <td>Invoices, payments, expenses, fuel, maintenance, payroll, bills</td>
      <td>Cash-flow forecast, shortfall warnings, reserve recommendations</td>
    </tr>
    <tr>
      <td>Profitability Agent</td>
      <td>Loads, expenses, fuel, brokers, lanes, truck data, driver data</td>
      <td>Profit reports, lane scores, broker performance, truck/driver performance</td>
    </tr>
    <tr>
      <td>Daily Briefing Agent</td>
      <td>Current operational status across all domains</td>
      <td>Daily briefing snapshots, owner action list, priority alerts</td>
    </tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Snapshot Policy</h2>

<p>Snapshots are one of the most important parts of TruckOps memory.</p>

<p>Each important AI-assisted decision should create a saved snapshot containing:</p>

<ul>
  <li>Date/time</li>
  <li>Owner question or request</li>
  <li>Data available at that moment</li>
  <li>Options considered</li>
  <li>Recommendation</li>
  <li>Reasoning summary</li>
  <li>Owner decision</li>
  <li>Later outcome</li>
  <li>Lessons learned</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Rule:</span> A recommendation without an outcome teaches the system less. Whenever possible, record what happened after the decision.</p>

<hr>

<h2 style="color:#00A6A6;">Decision And Outcome Memory</h2>

<p>TruckOps should preserve the link between:</p>

<pre><code>Situation
  ↓
Options
  ↓
Recommendation
  ↓
Owner Decision
  ↓
Result
  ↓
Lesson Learned</code></pre>

<p>This matters because the system should not only remember what it recommended. It should learn whether the recommendation actually worked.</p>

<p>Examples:</p>

<ul>
  <li>A load looked profitable but caused bad reload positioning.</li>
  <li>A broker had a good rate but paid slowly.</li>
  <li>A lane had strong outbound freight but weak return freight.</li>
  <li>A cheaper fuel stop created too much deadhead.</li>
  <li>A repair delay caused missed dispatch opportunity.</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Data Quality Rules</h2>

<ol>
  <li>Do not overwrite original documents.</li>
  <li>Do not delete business records without backup.</li>
  <li>Do not store secrets in normal project files.</li>
  <li>Every important record should have a date/time.</li>
  <li>Every load should have a status.</li>
  <li>Every document should have a type.</li>
  <li>Every expense should have a category.</li>
  <li>Every invoice should have a payment status.</li>
  <li>Every snapshot should preserve the owner's question and the final recommendation.</li>
  <li>When data is missing, mark it as missing instead of guessing.</li>
</ol>

<hr>

<h2 style="color:#00A6A6;">Record Status Standards</h2>

<p>Load Status:</p>

<ul>
  <li><code>considered</code></li>
  <li><code>rejected</code></li>
  <li><code>booked</code></li>
  <li><code>in_transit</code></li>
  <li><code>delivered</code></li>
  <li><code>invoiced</code></li>
  <li><code>paid</code></li>
  <li><code>cancelled</code></li>
  <li><code>disputed</code></li>
</ul>

<p>Invoice Status:</p>

<ul>
  <li><code>draft</code></li>
  <li><code>sent</code></li>
  <li><code>factored</code></li>
  <li><code>pending_payment</code></li>
  <li><code>paid</code></li>
  <li><code>overdue</code></li>
  <li><code>disputed</code></li>
</ul>

<p>Broker Status:</p>

<ul>
  <li><code>new</code></li>
  <li><code>trusted</code></li>
  <li><code>neutral</code></li>
  <li><code>watch</code></li>
  <li><code>avoid</code></li>
</ul>

<p>Document Status:</p>

<ul>
  <li><code>received</code></li>
  <li><code>processed</code></li>
  <li><code>linked</code></li>
  <li><code>missing_fields</code></li>
  <li><code>needs_review</code></li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Naming Standards</h2>

<p>Files should be named consistently so humans and agents can find them later.</p>

<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Consistent naming turns a cluttered folder into a searchable archive. Without it, agents and humans waste time guessing file contents.</p>

<p>Document Naming Pattern:</p>

<pre><code>YYYY-MM-DD__TYPE__LOADID_OR_BROKER__SHORT-DESCRIPTION.ext</code></pre>

<p>Examples:</p>

<pre><code>2026-07-02__RATE-CONF__LOAD-00014__ABC-BROKER.pdf
2026-07-03__BOL__LOAD-00014__DELIVERED.pdf
2026-07-03__FUEL-RECEIPT__TRUCK-1__LOVE-STATION.pdf
2026-07-05__REPAIR-INVOICE__TRUCK-1__BRAKES.pdf</code></pre>

<p>Snapshot Naming Pattern:</p>

<pre><code>YYYY-MM-DD-HHMM__AGENT__SHORT-TOPIC.md</code></pre>

<p>Examples:</p>

<pre><code>2026-07-02-0830__DISPATCH__NEXT-LOAD-OPTIONS.md
2026-07-03-1900__DAILY-BRIEFING__END-OF-DAY.md
2026-07-05-1015__CASH-FLOW__FUEL-AND-INVOICE-RISK.md</code></pre>

<hr>

<h2 style="color:#00A6A6;">Data Intake Methods</h2>

<p>TruckOps should support several intake methods over time.</p>

<table>
  <thead>
    <tr>
      <th>Method</th>
      <th>Use</th>
      <th>Stage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Manual chat entry</td>
      <td>Owner enters a load, expense, broker note, or decision in plain English</td>
      <td>V1</td>
    </tr>
    <tr>
      <td>Manual file upload</td>
      <td>Owner uploads PDFs, receipts, screenshots, or exports</td>
      <td>V1</td>
    </tr>
    <tr>
      <td>CSV import</td>
      <td>Fuel card, bank, factoring, or load-board exports</td>
      <td>V2</td>
    </tr>
    <tr>
      <td>Email intake</td>
      <td>Rate confirmations, invoices, BOLs, and receipts from email</td>
      <td>V2/V3</td>
    </tr>
    <tr>
      <td>Browser-assisted collection</td>
      <td>Permitted portal interaction where no API exists</td>
      <td>Later</td>
    </tr>
    <tr>
      <td>Official API connector</td>
      <td>Load boards, factoring, fuel cards, accounting, banking, or maintenance systems</td>
      <td>Later</td>
    </tr>
  </tbody>
</table>

<hr>

<h2 style="color:#00A6A6;">Privacy And Secrets Boundary</h2>

<p>TruckOps will eventually handle sensitive business information. The data layer must keep secrets separate from ordinary records.</p>

<p>Never store these in Joplin public notes, shared documents, snapshots, or normal config files:</p>

<ul>
  <li>Model provider API keys</li>
  <li>Load-board passwords</li>
  <li>Email passwords</li>
  <li>Fuel-card passwords</li>
  <li>Bank credentials</li>
  <li>Factoring portal credentials</li>
  <li>Private tokens</li>
  <li>OAuth secrets</li>
</ul>

<p>Early secrets location: <code>~/.openclaw/secrets.env</code></p>

<p>Later secrets location: GCP Secret Manager or another controlled secrets system.</p>

<hr>

<h2 style="color:#00A6A6;">Backup And Recovery Rules</h2>

<p>Business memory has value. It must be protected.</p>

<p>The backup process should include:</p>

<ul>
  <li>Configuration files</li>
  <li>SQLite databases</li>
  <li>Documents</li>
  <li>Snapshots</li>
  <li>Release notes</li>
  <li>Agent skills</li>
  <li>Logs needed for troubleshooting</li>
</ul>

<p>Backups should not casually include unencrypted secrets unless the backup process is specifically designed to protect them.</p>

<p><span style="color:#FACC15; font-weight:600;">Backup rule:</span> Before major changes, create a TruckOps workspace backup.</p>

<p>The backup script is created in the Foundation Build Runbook (Section 21: Backup Strategy Before Changes) .</p>

<hr>

<h2 style="color:#00A6A6;">How Intelligence Improves Over Time</h2>

<p>TruckOps becomes smarter by comparing recommendations against outcomes.</p>

<p>Examples of future intelligence:</p>

<ul>
  <li>Best lanes by actual profit, not posted rate</li>
  <li>Brokers ranked by payment behavior and operational friction</li>
  <li>Recurring weak reload markets</li>
  <li>Truck maintenance risk before accepting certain loads</li>
  <li>Fuel cost patterns by region</li>
  <li>Invoice delay patterns by broker</li>
  <li>Cash-flow pressure before it becomes a crisis</li>
  <li>Driver performance and dispatch fit as the fleet grows</li>
</ul>

<p><span style="color:#FACC15; font-weight:600;">Core intelligence rule:</span> Save the context, save the decision, save the outcome, then learn from the difference.</p>

<hr>

<h2 style="color:#00A6A6;">Dispatch Agent V1 Data Readiness Checklist</h2>

<p>Before the On-Demand Dispatch Intelligence Agent can become useful, the foundation must have the minimum required data. Use this checklist to confirm readiness.</p>

<p><span style="color:#FACC15; font-weight:600;">Note:</span> These files and databases are created during the Foundation Build Runbook (Sections 14–16). If any item is missing, the Dispatch Agent cannot function fully.</p>

<ul>
  <li><code>config/trucks.yaml</code> exists with at least one truck</li>
  <li><code>config/drivers.yaml</code> exists with at least one driver</li>
  <li><code>config/dispatch_rules.yaml</code> exists with scoring weights</li>
  <li><code>config/broker_rules.yaml</code> exists</li>
  <li><code>databases/brokers.db</code> exists with tables created</li>
  <li><code>databases/loads.db</code> exists with tables created</li>
  <li><code>databases/snapshots.db</code> exists with tables created</li>
  <li><code>snapshots/dispatch/</code> folder exists</li>
  <li>Manual load-entry method is defined (chat or file upload)</li>
  <li>Owner can save decisions and outcomes</li>
</ul>

<p><span style="color:#A5B4FC; font-weight:600;">Validation:</span> When all boxes are checked, the system is ready to begin building the Dispatch Agent V1.</p>

<hr>

<h2 style="color:#00A6A6;">Current Status</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Baseline finalized. This note defines the complete data and records structure for TruckOps.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> No production TruckOps data layer has been created yet. Initial YAML files, SQLite databases, document folders, snapshot folders, and backup rules should be created during or after the foundation build using the Foundation Build Runbook.</p>

<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Use the Foundation Build Runbook to create the workspace, config files, initial databases, and bootstrap package access. Then complete the Dispatch Agent V1 Data Readiness Checklist to confirm the system is ready for the first agent build.</p>
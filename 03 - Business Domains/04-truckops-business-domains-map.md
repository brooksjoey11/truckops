<!-- File: 05-truckops-business-domains-map.md -->
<!-- This file contains: TRUCKOPS BUSINESS DOMAINS MAP -->
<h1 style="color:#F97316;">TRUCKOPS BUSINESS DOMAINS MAP</h1>
<h3 style="color:#B8C7CC;">The operating map that defines the major business areas TruckOps supports, the agents that serve them, and the shared data each domain depends on.</h3>
<hr>

<h2 style="color:#00A6A6;">Purpose</h2>
<p>This note defines the major business domains inside the <strong>TruckOps OpenClaw AI Operating System</strong>.</p>
<p>The purpose is to make sure TruckOps is organized around the actual trucking business, not just around technical tools, random agents, disconnected notes, or isolated features.</p>
<p>Each domain represents a real part of the business that must be tracked, supported, analyzed, improved, or operated.</p>
<p><span style="color:#FACC15; font-weight:600;">Core rule:</span> Every new TruckOps feature, agent, tool, workflow, report, database, or automation should be placed inside a business domain before it is built.</p>
<p>This page answers:</p>
<ul>
  <li>What parts of the trucking business does TruckOps support?</li>
  <li>Which agents belong to each domain?</li>
  <li>What data does each domain need?</li>
  <li>What decisions does each domain support?</li>
  <li>How do domains connect to each other?</li>
  <li>Where should new ideas be routed?</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Plain-English Summary</h2>
<p>TruckOps is not just a dispatch helper.</p>
<p>TruckOps is meant to become the operating brain for a small trucking business.</p>
<p>That means it needs to understand the whole business:</p>
<ul>
  <li>The company</li>
  <li>The trucks</li>
  <li>The drivers</li>
  <li>The loads</li>
  <li>The brokers</li>
  <li>The documents</li>
  <li>The invoices</li>
  <li>The fuel</li>
  <li>The expenses</li>
  <li>The maintenance</li>
  <li>The cash flow</li>
  <li>The profit</li>
  <li>The daily priorities</li>
  <li>The lessons learned</li>
</ul>
<p>The business domains map keeps all of that organized.</p>
<hr>

<h2 style="color:#00A6A6;">Business Domain Model</h2>
<p>TruckOps should be viewed as a set of connected business domains:</p>
<pre><code>TruckOps Business Domains

Company & Administration
  ↓
Compliance & Authority
  ↓
Trucks & Drivers
  ↓
Dispatch & Load Operations
  ↓
Broker & Customer Intelligence
  ↓
Documents & Records
  ↓
Invoicing & Collections
  ↓
Fuel, Expenses & Cost Control
  ↓
Maintenance & Equipment
  ↓
Cash Flow & Financial Planning
  ↓
Profitability & Performance
  ↓
Daily Briefing & Owner Command
  ↓
Data, Memory & Intelligence
  ↓
Development, Testing & Releases
  ↓
Future Productization & Market Readiness</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Important:</span> These domains should work together. They are not separate mini-applications.</p>
<hr>

<h2 style="color:#00A6A6;">Domain Coverage Status</h2>
<p>This table shows which domains have dedicated notes and which are still covered only by this map.</p>
<table>
  <thead>
    <tr>
      <th>Domain</th>
      <th>Status</th>
      <th>Reference Note</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Company & Administration</td>
      <td><span style="color:#A5B4FC;">Partially Defined</span></td>
      <td>Data, Memory & Records Baseline</td>
    </tr>
    <tr>
      <td>Compliance & Authority</td>
      <td><span style="color:#A5B4FC;">Partially Defined</span></td>
      <td>Data, Memory & Records Baseline</td>
    </tr>
    <tr>
      <td>Trucks & Drivers</td>
      <td><span style="color:#A5B4FC;">Partially Defined</span></td>
      <td>Data, Memory & Records Baseline</td>
    </tr>
    <tr>
      <td>Dispatch & Load Operations</td>
      <td><span style="color:#34D399;">Fully Defined</span></td>
      <td>On-Demand Dispatch Intelligence Agent</td>
    </tr>
    <tr>
      <td>Broker & Customer Intelligence</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Documents & Records</td>
      <td><span style="color:#A5B4FC;">Partially Defined</span></td>
      <td>Data, Memory & Records Baseline</td>
    </tr>
    <tr>
      <td>Invoicing & Collections</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Fuel, Expenses & Cost Control</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Maintenance & Equipment</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Cash Flow & Financial Planning</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Profitability & Performance</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Daily Briefing & Owner Command</td>
      <td><span style="color:#A5B4FC;">Planned</span></td>
      <td>No dedicated note yet</td>
    </tr>
    <tr>
      <td>Data, Memory & Intelligence</td>
      <td><span style="color:#34D399;">Fully Defined</span></td>
      <td>Data, Memory & Records Baseline</td>
    </tr>
    <tr>
      <td>Development, Testing & Releases</td>
      <td><span style="color:#34D399;">Fully Defined</span></td>
      <td>Development, Testing & Release Process</td>
    </tr>
    <tr>
      <td>Future Productization & Market Readiness</td>
      <td><span style="color:#A5B4FC;">Conceptual</span></td>
      <td>This note</td>
    </tr>
  </tbody>
</table>
<hr>

<h2 style="color:#00A6A6;">Domain 1: Company & Administration</h2>
<p>This domain contains the basic business identity and administrative structure of TruckOps.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Business name</li>
  <li>Business entity information</li>
  <li>Contact information</li>
  <li>Operating profile</li>
  <li>Insurance references</li>
  <li>Factoring references</li>
  <li>Banking/accounting references</li>
  <li>Company policies and preferences</li>
  <li>Owner instructions</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/company.yaml</code></li>
  <li><code>documents/company/</code></li>
  <li><code>documents/insurance/</code></li>
  <li><code>documents/contracts/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Document Agent</li>
  <li>Daily Briefing Agent</li>
  <li>Future Administrative Assistant Agent</li>
</ul>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Company Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 2: Compliance & Authority</h2>
<p>This domain tracks the legal and operating authority side of the trucking business.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>DOT number</li>
  <li>MC number</li>
  <li>Authority status</li>
  <li>Insurance status</li>
  <li>Registration</li>
  <li>IFTA-related records</li>
  <li>Permits</li>
  <li>Inspections</li>
  <li>Safety-related documents</li>
  <li>Renewal dates and deadlines</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>documents/compliance/</code></li>
  <li><code>documents/insurance/</code></li>
  <li><code>documents/permits/</code></li>
  <li><code>databases/documents.db</code></li>
  <li><code>databases/compliance.db</code> (future)</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Document Agent</li>
  <li>Maintenance Agent</li>
  <li>Daily Briefing Agent</li>
  <li>Future Compliance Agent</li>
</ul>
<hr>

<h2 style="color:#00A6A6;">Domain 3: Trucks & Drivers</h2>
<p>This domain tracks the physical assets and people that move freight.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Truck profiles (ID, VIN, year, make, model, status)</li>
  <li>Driver profiles (name, license status, medical card, availability)</li>
  <li>Current location tracking</li>
  <li>Odometer readings</li>
  <li>Hours-of-service context</li>
  <li>Lane preferences</li>
  <li>Assignment mapping</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/trucks.yaml</code></li>
  <li><code>config/drivers.yaml</code></li>
  <li><code>databases/trucks.db</code> (future)</li>
  <li><code>databases/drivers.db</code> (future)</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Dispatch Agent</li>
  <li>Maintenance Agent</li>
  <li>Profitability Agent</li>
  <li>Daily Briefing Agent</li>
</ul>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Truck Data and Driver Data sections) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 4: Dispatch & Load Operations</h2>
<p>This is the movement-of-freight domain. It covers how trucks get loaded, where they go, what loads are accepted or rejected, and how dispatch decisions are made.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Current truck location</li>
  <li>Driver availability</li>
  <li>Load options</li>
  <li>Pickup and delivery timing</li>
  <li>Deadhead miles</li>
  <li>Loaded miles</li>
  <li>Rate per mile</li>
  <li>Reload markets</li>
  <li>Lane preferences</li>
  <li>Rejected loads</li>
  <li>Booked loads</li>
  <li>Dispatch snapshots</li>
  <li>Owner dispatch decisions</li>
  <li>Final load outcomes</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/trucks.yaml</code></li>
  <li><code>config/drivers.yaml</code></li>
  <li><code>config/dispatch_rules.yaml</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>databases/snapshots.db</code></li>
  <li><code>snapshots/dispatch/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li><strong>On-Demand Dispatch Intelligence Agent</strong> (Primary)</li>
  <li>Broker Intelligence Agent</li>
  <li>Profitability Agent</li>
  <li>Daily Briefing Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">First build priority:</span> <span style="background-color:#FACC15; color:#1a1a1a; padding:2px 8px; border-radius:4px;">This is the first operational domain</span> because the On-Demand Dispatch Intelligence Agent is the first planned real feature.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>On-Demand Dispatch Intelligence Agent</strong> note for the full agent definition, and <strong>Data, Memory & Records Baseline</strong> (Load Data and Dispatch Snapshot Data sections) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 5: Broker & Customer Intelligence</h2>
<p>This domain remembers who TruckOps does business with and whether they are worth working with again.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Broker names</li>
  <li>MC numbers</li>
  <li>Contacts</li>
  <li>Payment behavior</li>
  <li>Communication quality</li>
  <li>Rate behavior</li>
  <li>Detention behavior</li>
  <li>Cancellations</li>
  <li>Disputes</li>
  <li>Preferred brokers</li>
  <li>Brokers to watch</li>
  <li>Brokers to avoid</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/broker_rules.yaml</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/invoices.db</code></li>
  <li><code>snapshots/brokers/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Broker Intelligence Agent</li>
  <li>Dispatch Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Profitability Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> A good rate from a bad broker may not be a good business decision. This domain prevents repeating the same mistakes.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Broker Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 6: Documents & Records</h2>
<p>This domain manages the paper trail of the business.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
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
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>documents/</code></li>
  <li><code>documents/loads/</code></li>
  <li><code>documents/invoices/</code></li>
  <li><code>documents/fuel/</code></li>
  <li><code>documents/maintenance/</code></li>
  <li><code>databases/documents.db</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Document Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Maintenance Agent</li>
  <li>Daily Briefing Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Original documents should be preserved. Extracted data and summaries should be linked to the original file, not replace it.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Document Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 7: Invoicing & Collections</h2>
<p>This domain tracks money owed to the business.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Invoice drafts</li>
  <li>Sent invoices</li>
  <li>Factored invoices</li>
  <li>Payment status</li>
  <li>Due dates</li>
  <li>Overdue invoices</li>
  <li>Disputed invoices</li>
  <li>Follow-up reminders</li>
  <li>Collections notes</li>
  <li>Payment confirmations</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>databases/invoices.db</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>documents/invoices/</code></li>
  <li><code>snapshots/collections/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Invoice & Collections Agent</li>
  <li>Document Agent</li>
  <li>Cash Flow Agent</li>
  <li>Daily Briefing Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Revenue does not help the business until it becomes collected cash. This domain closes the loop from delivered load to received payment.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Invoice And Collections Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 8: Fuel, Expenses & Cost Control</h2>
<p>This domain tracks what the business spends to operate.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Fuel purchases</li>
  <li>Fuel price per gallon</li>
  <li>Gallons purchased</li>
  <li>Fuel stops</li>
  <li>Tolls</li>
  <li>Scales</li>
  <li>Parking</li>
  <li>Permits</li>
  <li>Repairs</li>
  <li>Insurance</li>
  <li>Truck payment</li>
  <li>Trailer payment</li>
  <li>Subscriptions</li>
  <li>Software costs</li>
  <li>Driver pay</li>
  <li>Operating cost per mile</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/expense_categories.yaml</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>documents/fuel/</code></li>
  <li><code>documents/receipts/</code></li>
  <li><code>snapshots/expenses/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Fuel & Expense Agent</li>
  <li>Profitability Agent</li>
  <li>Cash Flow Agent</li>
  <li>Dispatch Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> A load can look profitable before costs and become weak after fuel, deadhead, maintenance reserve, and time are included. This domain reveals true operating cost.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Fuel And Expense Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 9: Maintenance & Equipment</h2>
<p>This domain tracks truck health, service needs, repair history, and equipment readiness.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Truck profiles</li>
  <li>Trailer profiles (future)</li>
  <li>Odometer readings</li>
  <li>Preventive maintenance</li>
  <li>Repair history</li>
  <li>Service intervals</li>
  <li>Shop/vendor records</li>
  <li>Downtime</li>
  <li>Inspection issues</li>
  <li>Maintenance cost</li>
  <li>Dispatch risk due to equipment status</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/trucks.yaml</code></li>
  <li><code>databases/maintenance.db</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>documents/maintenance/</code></li>
  <li><code>snapshots/maintenance/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Maintenance Agent</li>
  <li>Dispatch Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Daily Briefing Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Dispatch decisions should account for equipment condition, not just rate and miles. A breakdown mid-load is more expensive than a skipped load.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Maintenance Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 10: Cash Flow & Financial Planning</h2>
<p>This domain tracks whether the business has enough money available for upcoming obligations.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Expected incoming payments</li>
  <li>Open invoices</li>
  <li>Payment timing</li>
  <li>Upcoming bills</li>
  <li>Fuel needs</li>
  <li>Maintenance reserves</li>
  <li>Driver pay</li>
  <li>Insurance</li>
  <li>Truck payments</li>
  <li>Emergency reserves</li>
  <li>Shortfall warnings</li>
  <li>Cash position snapshots</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>databases/cash_flow.db</code></li>
  <li><code>databases/invoices.db</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>databases/loads.db</code></li>
  <li><code>snapshots/cash-flow/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Cash Flow Agent</li>
  <li>Invoice & Collections Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Daily Briefing Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> Profit on paper and cash available today are not the same thing. This domain prevents cash crises before they happen.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Cash Flow Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 11: Profitability & Performance</h2>
<p>This domain turns operating history into business intelligence.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Profit per load</li>
  <li>Profit per mile</li>
  <li>Profit per lane</li>
  <li>Profit per broker</li>
  <li>Profit per truck</li>
  <li>Profit per driver</li>
  <li>Deadhead impact</li>
  <li>Fuel impact</li>
  <li>Time impact</li>
  <li>Maintenance impact</li>
  <li>Reload market impact</li>
  <li>Best/worst lanes</li>
  <li>Best/worst brokers</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>databases/profitability.db</code> (future)</li>
  <li><code>databases/loads.db</code></li>
  <li><code>databases/expenses.db</code></li>
  <li><code>databases/brokers.db</code></li>
  <li><code>databases/maintenance.db</code></li>
  <li><code>snapshots/profitability/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Profitability Agent</li>
  <li>Dispatch Agent</li>
  <li>Broker Intelligence Agent</li>
  <li>Fuel & Expense Agent</li>
  <li>Cash Flow Agent</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> TruckOps should help answer, "What actually makes money?" not just "What pays a good rate?" This domain is where the system proves its value.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> (Profitability Data section) for the full data definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 12: Daily Briefing & Owner Command</h2>
<p>This domain summarizes what the owner needs to know and do.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Daily priorities</li>
  <li>Dispatch status</li>
  <li>Open invoices</li>
  <li>Upcoming maintenance</li>
  <li>Cash-flow warnings</li>
  <li>Missing documents</li>
  <li>Broker issues</li>
  <li>Upcoming deadlines</li>
  <li>Owner action list</li>
  <li>System alerts</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>config/reporting_rules.yaml</code></li>
  <li><code>snapshots/daily-briefing/</code></li>
  <li>Read access across all operational databases</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Daily Briefing Agent</li>
  <li>All operational agents as data sources</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> The owner should not have to manually check every part of the business to know what matters today. This domain makes TruckOps a command center, not just a query tool.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 13: Data, Memory & Intelligence</h2>
<p>This domain controls how TruckOps stores, remembers, connects, and learns from business information.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Shared databases</li>
  <li>Snapshot policy</li>
  <li>Decision history</li>
  <li>Outcome history</li>
  <li>Document index</li>
  <li>Lessons learned</li>
  <li>Data quality rules</li>
  <li>Record status standards</li>
  <li>Naming standards</li>
  <li>Backup rules</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>databases/</code></li>
  <li><code>snapshots/</code></li>
  <li><code>documents/</code></li>
  <li><code>config/</code></li>
  <li><code>logs/</code></li>
  <li><code>backups/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>All agents</li>
  <li>Future Data Steward / Memory Agent (if needed)</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Core intelligence rule:</span> Save the context, save the decision, save the outcome, then learn from the difference.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Data, Memory & Records Baseline</strong> for the complete data, memory, and intelligence definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 14: Development, Testing & Releases</h2>
<p>This domain controls how TruckOps is built, tested, upgraded, released, and documented.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Development tickets</li>
  <li>Testing process</li>
  <li>Staging area</li>
  <li>Release notes</li>
  <li>Backups before release</li>
  <li>Rollback process</li>
  <li>Incident notes</li>
  <li>Versioning standards</li>
  <li>Feature validation</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>dev/</code></li>
  <li><code>staging/</code></li>
  <li><code>tests/</code></li>
  <li><code>migrations/</code></li>
  <li><code>releases/</code></li>
  <li><code>archive/</code></li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Foundation Operator Skill</li>
  <li>Future Release Manager Agent (if needed)</li>
  <li>All feature-building AI instances</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Why this matters:</span> TruckOps should improve without becoming chaotic or fragile. This domain keeps the system stable while it grows.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Reference:</span> See <strong>Development, Testing & Release Process</strong> for the complete development and release definition.</p>
<hr>

<h2 style="color:#00A6A6;">Domain 15: Future Productization & Market Readiness</h2>
<p>This domain preserves the possibility that TruckOps could later become a reusable marketable system, separate from private business data.</p>
<h3 style="color:#B8C7CC;">Includes</h3>
<ul>
  <li>Reusable system shell</li>
  <li>Generic agent framework</li>
  <li>Reusable config structure</li>
  <li>Reusable database schema</li>
  <li>Reusable dashboard concepts</li>
  <li>Reusable workflow logic</li>
  <li>Private-data separation</li>
  <li>Anonymized examples (if needed)</li>
  <li>Future packaging and deployment notes</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Data</h3>
<ul>
  <li><code>docs/productization/</code> (future)</li>
  <li><code>releases/</code></li>
  <li><code>archive/</code></li>
  <li>Sanitized copies of reusable patterns</li>
</ul>
<h3 style="color:#B8C7CC;">Primary Agents</h3>
<ul>
  <li>Future Productization Agent (if needed)</li>
  <li>Development / Release process</li>
</ul>
<p><span style="color:#FACC15; font-weight:600;">Rule:</span> Build for private usefulness first. Productization comes later only after the system proves itself in real use. Do not let productization thinking distract from building a working business tool.</p>
<hr>

<h2 style="color:#00A6A6;">Domain Dependency Map</h2>
<p>The domains depend on each other. They should not be built as isolated systems.</p>
<pre><code>Company & Administration
  ↓
Compliance & Authority
  ↓
Trucks & Drivers
  ↓
Dispatch & Load Operations
  ↓
Broker Intelligence
  ↓
Documents & Records
  ↓
Invoices + Expenses + Maintenance
  ↓
Cash Flow
  ↓
Profitability
  ↓
Daily Briefing
  ↓
Data, Memory & Intelligence
  ↓
Better Future Decisions</code></pre>
<p><span style="color:#FACC15; font-weight:600;">Plain-English meaning:</span> Dispatch decisions rely on trucks, drivers, brokers, costs, documents, maintenance, cash flow, and history. The value of TruckOps comes from connecting those pieces.</p>
<hr>

<h2 style="color:#00A6A6;">Business Domain Quick Reference</h2>
<p>At-a-glance mapping of agents to their primary domains.</p>
<table>
  <thead>
    <tr>
      <th>Agent</th>
      <th>Primary Domain</th>
      <th>Supporting Domains</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Dispatch Agent</td>
      <td>Dispatch & Load Operations</td>
      <td>Broker Intelligence, Maintenance, Fuel & Expense, Profitability, Cash Flow</td>
    </tr>
    <tr>
      <td>Broker Intelligence Agent</td>
      <td>Broker & Customer Intelligence</td>
      <td>Dispatch, Invoicing, Profitability</td>
    </tr>
    <tr>
      <td>Document Agent</td>
      <td>Documents & Records</td>
      <td>Administration, Compliance, Invoicing, Maintenance, Fuel & Expense</td>
    </tr>
    <tr>
      <td>Invoice & Collections Agent</td>
      <td>Invoicing & Collections</td>
      <td>Documents, Broker Intelligence, Cash Flow</td>
    </tr>
    <tr>
      <td>Maintenance Agent</td>
      <td>Maintenance & Equipment</td>
      <td>Dispatch, Expenses, Daily Briefing</td>
    </tr>
    <tr>
      <td>Fuel & Expense Agent</td>
      <td>Fuel, Expenses & Cost Control</td>
      <td>Profitability, Cash Flow, Dispatch</td>
    </tr>
    <tr>
      <td>Cash Flow Agent</td>
      <td>Cash Flow & Financial Planning</td>
      <td>Invoices, Expenses, Maintenance, Dispatch</td>
    </tr>
    <tr>
      <td>Profitability Agent</td>
      <td>Profitability & Performance</td>
      <td>Dispatch, Brokers, Fuel, Expenses, Maintenance</td>
    </tr>
    <tr>
      <td>Daily Briefing Agent</td>
      <td>Daily Briefing & Owner Command</td>
      <td>All operational domains</td>
    </tr>
  </tbody>
</table>
<hr>

<h2 style="color:#00A6A6;">How To Route New Ideas</h2>
<p>When the owner brings a new idea, problem, or feature request, future AI instances should route it using this sequence:</p>
<ol>
  <li><strong>Identify the real-world business problem.</strong> What is the owner trying to achieve or avoid?</li>
  <li><strong>Determine which domain owns the problem.</strong> Does this problem live in Dispatch? Invoicing? Maintenance? Something else?</li>
  <li><strong>Identify supporting domains.</strong> What other domains will this feature need to read from or write to?</li>
  <li><strong>Check whether an existing agent already covers the domain.</strong> Could the existing agent be extended instead of creating a new one?</li>
  <li><strong>Decide the implementation vehicle.</strong> New agent, existing agent upgrade, new skill, new tool, new database table, new config rule, new report, new workflow, or foundation upgrade?</li>
  <li><strong>Identify what data must be read.</strong> Which files, databases, or snapshots must the feature access?</li>
  <li><strong>Identify what data must be written.</strong> Which files, databases, or snapshots must the feature create or update?</li>
  <li><strong>Identify what should be saved as memory.</strong> What should be preserved so future decisions improve?</li>
  <li><strong>Document the change.</strong> Update the correct note or create a release record.</li>
</ol>
<p><span style="color:#FACC15; font-weight:600;">Routing rule:</span> Do not automatically create a new agent. First decide where the problem belongs. The answer might be a skill, a tool, or a config change, not a new agent.</p>

<h3 style="color:#B8C7CC;">Decision Tree For New Ideas</h3>
<pre><code>Is this a new business problem?
  ├── Yes → Which domain owns it?
  │   ├── Domain has an agent → Extend that agent (or add a skill/tool)
  │   ├── Domain has no agent → Create a new agent (but only after confirming it's not a skill or tool)
  │   └── Domain has partial coverage → Fill the gap
  ├── No → Is it an improvement to an existing feature?
  │   ├── Yes → Is it a config change? → Update config
  │   ├── Yes → Is it a skill change? → Update SKILL.md
  │   └── Yes → Is it a tool change? → Update tool
  └── No → Is it a foundational change? → Update foundation or runbook</code></pre>
<hr>

<h2 style="color:#00A6A6;">Minimum Domain Coverage Before Dispatch Agent V1</h2>
<p>Before Dispatch Agent V1 becomes useful, these domains need minimum coverage:</p>
<table>
  <thead>
    <tr>
      <th>Domain</th>
      <th>Minimum Needed</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Company & Administration</td>
      <td>Basic company profile</td>
    </tr>
    <tr>
      <td>Trucks & Drivers</td>
      <td>At least one truck, one driver, and basic profiles</td>
    </tr>
    <tr>
      <td>Dispatch & Load Operations</td>
      <td>Truck, driver, dispatch rules, manual load-entry method</td>
    </tr>
    <tr>
      <td>Broker & Customer Intelligence</td>
      <td>Basic broker records and broker scoring rules</td>
    </tr>
    <tr>
      <td>Fuel, Expenses & Cost Control</td>
      <td>Basic fuel cost and maintenance reserve assumptions</td>
    </tr>
    <tr>
      <td>Maintenance & Equipment</td>
      <td>Basic truck maintenance status</td>
    </tr>
    <tr>
      <td>Data, Memory & Intelligence</td>
      <td>Loads database, brokers database, snapshots database</td>
    </tr>
  </tbody>
</table>
<p>This allows the first Dispatch Agent to compare manually entered load options, apply business rules, consider broker quality, consider basic cost assumptions, save a dispatch snapshot, and preserve the owner's decision.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Readiness checklist:</span> See <strong>Data, Memory & Records Baseline</strong> (Dispatch Agent V1 Data Readiness Checklist) for the complete validation list.</p>
<hr>

<h2 style="color:#00A6A6;">What This Page Is Not</h2>
<p>This page does not replace the Foundation Build Runbook.</p>
<p>This page does not define database schemas in detail.</p>
<p>This page does not build agents.</p>
<p>This page defines the business map so future development has a place to belong. It is the <strong>organizing principle</strong> for all future work.</p>
<hr>

<h2 style="color:#00A6A6;">Current Status</h2>
<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Baseline finalized. This note defines the complete business domain map for TruckOps.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Implementation state:</span> The business domain map exists as architecture and planning guidance. The live TruckOps foundation has not yet been built. Operational domain data, agents, tools, and workflows are still planned.</p>
<p><span style="color:#A5B4FC; font-weight:600;">Next likely step:</span> Use this domain map when deciding where each new TruckOps feature belongs. Dispatch & Load Operations remains the first operational domain to move toward implementation. The Domain Coverage Status table above shows which domains need dedicated notes next.</p>

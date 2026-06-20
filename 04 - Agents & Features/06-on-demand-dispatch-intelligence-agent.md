<!-- File: 06-on-demand-dispatch-intelligence-agent.md -->
<!-- This file contains: ON-DEMAND DISPATCH INTELLIGENCE AGENT -->
<h1 style="color:#F97316;">ON-DEMAND DISPATCH INTELLIGENCE AGENT</h1>

<h2 style="color:#00A6A6;">Purpose</h2>

<p>The <strong>On-Demand Dispatch Intelligence Agent</strong> is a planned TruckOps agent designed to reduce the dispatch burden on the owner by quickly analyzing load-board options, truck status, driver status, business rules, and current operating conditions when the owner asks for help.</p>

<p>This agent is not intended to start as a massive continuous monitoring system. The first version is intended to be simple, useful, and focused: the owner queries the agent when planning or when something changes, and the agent builds a current dispatch snapshot and recommends the most optimized decision available based on the data present.</p>

<hr>

<h2 style="color:#00A6A6;">Core Idea</h2>

<p><span style="color:#FACC15; font-weight:600;">Operating Model:</span> On-demand dispatch intelligence.</p>

<p>The owner does not need the agent constantly scraping load boards or flooding him with information. The owner needs a dispatch resource that can be contacted when a dispatch decision needs to be made.</p>

<p>The agent should be able to answer questions such as:</p>

<ul>
  <li>What is the best plan for both trucks next week?</li>
  <li>What should Truck 1 do after delivery?</li>
  <li>Truck 2 is delayed at pickup. What is the best recovery move?</li>
  <li>Which of these available loads creates the best overall business outcome?</li>
  <li>Which load keeps the truck earning without creating unnecessary deadhead or idle time?</li>
</ul>

<p>The agent should not simply look for the highest-paying load. It should analyze the larger business picture and recommend the move that keeps the truck productive, positioned well, and earning across the planning window.</p>

<hr>

<h2 style="color:#00A6A6;">Problem It Solves</h2>

<p>Dispatch work can consume a large amount of owner time, especially with two trucks and multiple load boards. The owner has to compare loads, think through deadhead, watch timing, consider reload potential, account for driver limits, avoid weak markets, and make decisions quickly.</p>

<p>Without a system, much of this depends on memory, gut instinct, and manual comparison. The agent is intended to take that raw dispatch information, organize it, calculate what matters, and present the strongest options.</p>

<p>The goal is not to replace the owner’s judgment. The goal is to give the owner a faster and sharper view of the situation.</p>

<hr>

<h2 style="color:#00A6A6;">Primary Use Cases</h2>

<h3 style="color:#B8C7CC;">Weekly Planning</h3>

<p>Before the week starts, the owner can query the agent to help plan the next several days for both trucks.</p>

<p><span style="color:#FACC15; font-weight:600;">Example:</span></p>

<blockquote>
  <p>Plan next week for both trucks using current load-board options, our lane preferences, driver limits, and revenue targets.</p>
</blockquote>

<p>The agent should compare available options and recommend a plan that reduces deadhead, avoids weak markets, considers reload potential, and keeps both trucks productive.</p>

<h3 style="color:#B8C7CC;">Daily Next-Load Planning</h3>

<p>When a truck is about to deliver or become empty, the owner can query the agent for the next best move.</p>

<p><span style="color:#FACC15; font-weight:600;">Example:</span></p>

<blockquote>
  <p>Truck 1 will be empty in Dallas Tuesday morning. Find the best next move.</p>
</blockquote>

<p>The agent should evaluate nearby loads, rate quality, all-in miles, reload market, timing, and expected profit.</p>

<h3 style="color:#B8C7CC;">Pivot And Recovery Planning</h3>

<p>When a plan breaks, the owner can give the agent the updated situation and ask for a recovery plan.</p>

<p><span style="color:#FACC15; font-weight:600;">Example:</span></p>

<blockquote>
  <p>Truck 2 arrived for pickup, but the load will not be ready until tomorrow. Rebuild the plan for Truck 2.</p>
</blockquote>

<p>The agent should compare whether waiting is worth it, whether another load nearby is better, whether detention changes the decision, and whether moving to a better freight market creates a stronger outcome.</p>

<hr>

<h2 style="color:#00A6A6;">Core Principle</h2>

<p><span style="color:#FACC15; font-weight:600;">Principle:</span> Optimize asset utilization, not just single-load revenue.</p>

<p>A truck is an earning asset. The agent should help keep that asset moving profitably while reducing dead time, empty miles, weak positioning, and bad follow-on options.</p>

<p>A load that pays well may still be the wrong move if it leaves the truck in a dead market or forces too much empty repositioning. A lower-paying load may be better if it positions the truck near another strong load, keeps the driver moving, and improves the weekly result.</p>

<p>The agent should evaluate:</p>

<ul>
  <li>Load revenue</li>
  <li>Loaded miles</li>
  <li>Deadhead miles</li>
  <li>All-in rate per mile</li>
  <li>Fuel cost</li>
  <li>Driver pay</li>
  <li>Maintenance reserve</li>
  <li>Broker quality</li>
  <li>Pickup and delivery timing</li>
  <li>Driver availability</li>
  <li>Truck status</li>
  <li>Reload potential</li>
  <li>Weak markets</li>
  <li>Preferred lanes</li>
  <li>Weather or timing issues when relevant</li>
  <li>Projected weekly revenue</li>
</ul>

<hr>

<h2 style="color:#00A6A6;">Meaning Of 24/7</h2>

<p>In this project, <strong>24/7</strong> means the system is always available to be queried.</p>

<p>It does not mean the Dispatch Agent must continuously scrape load boards, constantly push alerts, or act as a nonstop market surveillance system.</p>

<p><span style="color:#FACC15; font-weight:600;">Correct Model:</span></p>

<blockquote>
  <p>Always available → queried when needed → builds current snapshot → recommends options</p>
</blockquote>

<hr>

<h2 style="color:#00A6A6;">Version 1 Scope</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Version 1:</span> On-demand dispatch intelligence.</p>

<p>The first version should stay focused on proving the agent is useful. It should not be overbuilt.</p>

<p>Version 1 should:</p>

<ul>
  <li>Accept owner dispatch queries on demand</li>
  <li>Build a current situation snapshot</li>
  <li>Query load boards only when needed</li>
  <li>Apply stored business rules</li>
  <li>Compare available load options</li>
  <li>Match options to Truck 1 or Truck 2</li>
  <li>Calculate real business value</li>
  <li>Consider reload markets and positioning</li>
  <li>Recommend the strongest available option</li>
  <li>Explain the reason for the recommendation clearly</li>
</ul>

<p>The first test is simple: does it work, and is it useful?</p>

<hr>

<h2 style="color:#00A6A6;">Foundation Compatibility</h2>

<p><span style="color:#FACC15; font-weight:600;">Assessment:</span> The existing GCP VM + Docker + OpenClaw foundation theoretically supports this feature.</p>

<p>The foundation gives the project the base runtime needed for this agent:</p>

<ul>
  <li>Always-available cloud VM</li>
  <li>Docker-capable environment</li>
  <li>OpenClaw agent framework</li>
  <li>Chat or dashboard access</li>
  <li>Ability to run scripts, connectors, and tools</li>
  <li>Ability to store rules, profiles, notes, and business data</li>
</ul>

<p>The Dispatch Agent does not require replacing the foundation. It requires adding an application layer on top of it.</p>

<p><span style="color:#FACC15; font-weight:600;">Required Application Layer:</span></p>

<ul>
  <li>Dispatch rules file</li>
  <li>Truck profiles</li>
  <li>Driver profile for hired driver</li>
  <li>Broker memory</li>
  <li>Load-board connectors</li>
  <li>Load storage</li>
  <li>Scoring logic</li>
  <li>Planning logic</li>
  <li>Snapshot history</li>
</ul>

<p>Because Version 1 is on-demand instead of constantly running, it should be lighter and more realistic for the early foundation.</p>

<hr>

<h2 style="color:#00A6A6;">Learning Tradeoff</h2>

<p>The on-demand design misses some learning opportunities that a continuous market watcher would have captured. A constantly running system could observe rate changes, lane movement, broker reposting behavior, and fast-moving load opportunities throughout the day.</p>

<p>That does not need to be solved first.</p>

<p>The better first step is to make the agent useful on demand. Once it works, the system can start saving every query, snapshot, recommendation, decision, and outcome. That creates a dispatch history without requiring constant scraping.</p>

<p>Over time, saved snapshots become the learning layer.</p>

<hr>

<h2 style="color:#00A6A6;">Planned Evolution</h2>

<h3 style="color:#B8C7CC;">Version 1: On-Demand Dispatch Intelligence</h3>

<p>The owner queries the agent when planning or when a problem occurs. The agent builds a snapshot, evaluates available options, and recommends the strongest move based on current data.</p>

<h3 style="color:#B8C7CC;">Version 2: Automatic Snapshot And Query History</h3>

<p>Every dispatch query, snapshot, load option, rejected option, recommendation, owner decision, and final outcome is saved automatically.</p>

<p>This allows the agent to build memory from real use without needing constant load-board monitoring.</p>

<h3 style="color:#B8C7CC;">Version 3: Pattern Recognition From Saved Dispatch History</h3>

<p>The agent begins using saved history to recognize lane patterns, broker patterns, reload market quality, rate behavior, delay risks, and common bad decisions.</p>

<p>This improves recommendations because the agent is no longer relying only on the current snapshot. It can compare the current situation against past situations.</p>

<h3 style="color:#B8C7CC;">Version 4: Optional Lightweight Market Watcher</h3>

<p>After the on-demand system proves useful, a limited watcher can be added for specific lanes, trucks, markets, or planning windows.</p>

<p>This should not be a full-time flood of information. It should be targeted and useful.</p>

<hr>

<h2 style="color:#00A6A6;">Development Philosophy</h2>

<p>This agent fits the TruckOps development philosophy:</p>

<blockquote>
  <p>Start small. Prove usefulness. Save the data. Build intelligence from real use.</p>
</blockquote>

<p>The purpose of this note is to capture the concept before implementation. The idea is not to build everything at once. The idea is to preserve the thinking, define the shape of the agent, confirm that it fits the foundation, and create a practical path for building it later.</p>

<hr>

<h2 style="color:#00A6A6;">Status</h2>

<p><span style="color:#A5B4FC; font-weight:600;">Status:</span> Concept refined. Feature remains planned. Implementation not yet started.</p>

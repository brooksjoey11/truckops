# Archive

## Purpose

This folder stores retired, superseded, historical, deprecated, or reference-only TruckOps artifacts.

Archive content must remain available for history, audit, and decision reconstruction, but archived content must not be treated as current operating guidance.

---

## Archive Rule

If an artifact is no longer current but may explain why the project changed, move it here instead of deleting it.

---

## What Belongs Here

Archive the following:

- Superseded architecture drafts
- Deprecated agent specifications
- Old implementation plans
- Prior runbook versions
- Retired prompts
- Replaced diagrams
- Historical audit reports
- Outdated decision notes
- Obsolete configuration examples
- Previous release artifacts

---

## What Does Not Belong Here

Do not archive:

- Current operating instructions
- Active runbooks
- Current agent manifests
- Current production configuration
- Active credentials or secrets
- Current compliance records
- Current business records
- Active release notes
- Required test fixtures

---

## Required Archive Header

Every archived artifact must begin with:

```
# [Original Title]

**Archive Status:** Archived
**Archived Date:** YYYY-MM-DD
**Original Path:** path/to/original-file.md
**Reason Archived:** [specific reason]
**Superseded By:** path/to/current-file.md or `None`
**Do Not Use For Current Operations:** Yes
```

---

## Archive Naming Standard

Use this pattern:

```
YYYY-MM-DD__original-file-name.md
```

Example:

```
2026-06-20__old-dispatch-agent-draft.md
```

---

## Archive Index

Maintain an index when archived files are added.

| Archived File | Original Path | Archived Date | Reason | Superseded By |
|---|---|---|---|---|
| None yet | None | None | None | None |

---

## Retrieval Rule

Archived material may be used for:

- Historical understanding
- Audit trail review
- Decision reconstruction
- Comparing prior and current designs

Archived material must not be used for:

- Current setup
- Current development
- Current deployment
- Current agent behavior
- Current operating procedure

---

## Current Status

No archived artifacts are currently listed.

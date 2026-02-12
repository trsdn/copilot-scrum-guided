---
name: issue-triage
description: "Triage open issues and present findings to PO for prioritization decisions"
---

# Issue Triage

Query open GitHub issues that need attention, score them, and present findings to the PO for prioritization decisions.

## Step 1: Gather Issues

```bash
# Open issues without milestones
gh issue list --state open --json number,title,labels,createdAt,updatedAt --no-milestone

# Open issues without labels
gh issue list --state open --json number,title,labels | jq '[.[] | select(.labels | length == 0)]'

# Stale issues (no update in 30+ days)
gh issue list --state open --json number,title,updatedAt | jq '[.[] | select(.updatedAt < (now - 2592000 | todate))]'

# All open issues for scoring
gh issue list --state open --json number,title,labels,body --limit 100
```

## Step 2: ICE Scoring

Score each issue on three dimensions (1-3 each):

| Dimension | 3 (High) | 2 (Medium) | 1 (Low) |
|-----------|----------|------------|---------|
| **Impact** | Core functionality, user-facing | Improves quality or DX | Nice-to-have, cosmetic |
| **Confidence** | Well-understood, clear path | Some unknowns, reasonable plan | Speculative, needs research |
| **Effort** | Config-only, <1 session | Minor code + tests | Multi-session, new infrastructure |

**Score** = Impact × Confidence / Effort

| Score | Priority |
|-------|----------|
| ≥ 4 | `priority:high` |
| 2–3 | `priority:medium` |
| < 2 | `priority:low` |

## Step 3: Triage Report

```markdown
## Issue Triage — [Date]

### Needs Attention
| # | Title | Score | Suggested Priority | Issue |
|---|-------|-------|-------------------|-------|
| 1 | #N — Title | X.X | high/medium/low | Missing labels |

### Quick Wins (High score, low effort)
- #N: [description] — Score: X.X

### Needs Investigation
- #N: [description] — Insufficient info to score

### Stale Issues (>30 days)
- #N: [description] — Last updated [date]
```

## Step 4: Present to PO

**⛔ CONSENT GATE — DO NOT SKIP**

```
ask_user: "Issue triage complete. Found [N] issues needing attention:

- [X] missing labels
- [Y] missing milestones
- [Z] stale (>30 days)

Top quick wins: #A, #B, #C

How should we proceed?"
  choices: [
    "Apply suggested labels and priorities",
    "Let me review the full triage report first",
    "Close stale issues",
    "Skip — I'll handle triage manually"
  ]
```

**WAIT for PO response.** Do not apply labels or close issues without PO approval.

## Step 5: Apply Decisions

Based on PO's response:

```bash
# Apply priority label
gh issue edit <number> --add-label "priority:high"

# Optionally assign to a milestone
gh issue edit <number> --milestone "Sprint X"

# Close stale issues (only with PO approval)
gh issue close <number> --comment "Closed during triage — stale >30 days. Reopen if still needed."
```

## Guidelines

- Never close issues without PO approval
- When in doubt about scoring, mark as "Needs Investigation"
- Prefer labeling over closing — information is valuable
- Present findings neutrally — let the PO make prioritization calls

---
name: sprint-review
description: "PO-driven sprint review: present deliverables for PO acceptance or rejection."
---

# Sprint Review — PO-Driven

You are the **Scrum Master** presenting sprint results. The **human is the Product Owner**.

**This is a demo and acceptance ceremony. Do NOT start new work.**

**Operating model**: PO-driven. The PO must **explicitly accept or reject** deliverables. No auto-acceptance.

## Step 1: Gather Evidence

```bash
# Commits this sprint
git log --oneline --since="8 hours ago"

# Uncommitted changes
git status
git diff --stat

# Merged PRs
gh pr list --state merged --limit 15

# Closed issues
gh issue list --state closed --limit 20

# Still in progress
gh issue list --state open --label "status:in-progress"
```

**If uncommitted changes exist**: STOP and ask PO whether to commit first.

## Step 2: Delivery Report

Present to the PO:

```markdown
## Sprint N Review — [Date]

### Delivered
| # | Issue | PR | Outcome |
|---|-------|----|---------|
| N | Title | #M | ✅ Done / ⚠️ Partial / ❌ Blocked |

### Sprint Metrics
| Metric | Value |
|--------|-------|
| Issues planned | |
| Issues completed | |
| Issues carried over | |
| PRs merged | |
| Files changed | |
| Lines +/- | |
| Tests (before → after) | |
| New tests written | |
```

## Step 3: Present to PO for Acceptance

**⛔ CONSENT GATE — DO NOT SKIP**

```
ask_user: "Sprint N delivered X/Y planned issues. Here's the summary:

[Key deliverables in 2-3 sentences]

Do you accept these deliverables?"
  choices: [
    "Accepted — all looks good",
    "Accepted with notes — I have feedback",
    "Changes requested — some items need rework",
    "Rejected — significant issues"
  ]
```

**WAIT for PO response.** Do NOT proceed until PO explicitly accepts or rejects.

### If PO accepts:
- Document acceptance in sprint log
- Proceed to issue cleanup (Step 4)

### If PO accepts with notes:
```
ask_user: "What notes or feedback do you have?"
```
- Document feedback in sprint log
- Create issues for any follow-up work
- Proceed to cleanup

### If PO requests changes:
```
ask_user: "Which items need rework? What changes are needed?"
```
- Document requested changes
- Move affected items back to Planned
- Create new issues if needed

### If PO rejects:
```
ask_user: "What are the significant issues? Should we discuss before proceeding?"
```
- Document rejection and reasons
- Move items back to Planned with PO's feedback
- Do NOT proceed to retro without resolving

## Step 4: Issue Cleanup

For each issue touched:
- **DONE** → Close with summary, move to Done on board
- **Partial** → Comment progress, move back to Planned
- **Blocked** → Label, document why

Create issues for any discovered work:
```bash
gh issue create --title "[Type]: Description" --label "priority:X" --body "..."
```

## Step 5: Carry-over

```markdown
### Carry-over Items
- #N: [What's left, why not completed]
```

Move incomplete items back to Planned with notes.

## Step 6: Notify

```bash
scripts/copilot-notify.sh "📋 Sprint N Review" "Done: X/Y issues. PO: [accepted/changes requested]"
```

## Step 7: Suggest Next Steps

```
ask_user: "Sprint review is complete. Ready for the retrospective?"
  choices: [
    "Yes — run /sprint-retro now",
    "Not yet — I need a break first",
    "Skip retro this time"
  ]
```

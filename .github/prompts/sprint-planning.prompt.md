---
name: sprint-planning
description: "PO-driven sprint planning: triage backlog, score ICE, present candidates for PO to select scope."
---

# Sprint Planning — PO-Driven

You are the **Scrum Master** running sprint planning. The **human is the Product Owner**.

**Operating model**: PO-driven. You propose, the PO decides. **NEVER select sprint scope autonomously.**

**No code changes during planning. Only issue management, research, and documentation.**

## Step 1: Review Issue Status

```bash
gh issue list --label "status:planned"
gh issue list --label "status:in-progress"
gh issue list --label "priority:high"
gh issue list --label "priority:medium"
gh issue list --limit 30
```

## Step 2: Triage Unlabeled Issues

Score using ICE framework:

| Dimension | High (3) | Medium (2) | Low (1) |
|-----------|----------|------------|---------|
| **Impact** | Core functionality or risk | Improves robustness | Nice-to-have |
| **Confidence** | Strong evidence | Some evidence | Speculative |
| **Effort** | Config-only, < 1 sprint | Minor code + validation | Multi-sprint |

Score = Impact × Confidence / Effort. ≥4 = high, 2-3 = medium, <2 = low.

```bash
gh issue edit N --add-label "priority:high"
```

## Step 3: Elaborate Top Issues

For high-priority issues missing detail:
- Acceptance criteria
- Approach sketch (direction, not full plan)
- Dependencies
- Risks

## Step 4: Research Open Questions

If issues need research before prioritization:
- Search codebase, review documentation
- Document findings on the issue

## Step 5: Create New Issues

Capture ideas discovered during discussion:
```bash
gh issue create --title "[Type]: Description" --label "priority:X" --body "..."
```

## Step 6: Present Sprint Candidates to PO

**⛔ CONSENT GATE — DO NOT SKIP**

Present the top 7 candidates by ICE score to the PO. Use `ask_user` tool:

```
Present candidates in a table:

| # | Issue | Priority | ICE Score | Est. Effort |
|---|-------|----------|-----------|-------------|
| 1 | #N: Title | high | 6.0 | Small |
| 2 | #M: Title | high | 4.5 | Medium |
| ... | ... | ... | ... | ... |

Then ask:
ask_user: "Which of these issues should go into Sprint N?"
  choices: [
    "All recommended",
    "Only the top 5",
    "Only high priority issues",
    "Let me pick individually"
  ]
```

**WAIT for PO to select scope.** Do NOT proceed until the PO responds.

If PO says "let me pick individually", present each issue and ask yes/no.

## Step 7: Define Sprint Goal

After PO selects scope, propose a one-sentence sprint goal:

```
ask_user: "Proposed sprint goal: '[goal]'. Does this capture it?"
  choices: ["Yes", "Adjust it"]
```

Label all sprint items with `sprint:N` (incrementing from last sprint).

## Step 8: Finalize Sprint

**MANDATORY**: Add `status:planned` label and assign milestone for all PO-approved items.

```bash
gh issue edit N --add-label "status:planned" --milestone "Sprint X"
```

Verify by listing planned issues: `gh issue list --label "status:planned" --milestone "Sprint X"`

## Step 9: Present Summary

```markdown
## Sprint N Planning — [Date]

### Sprint Goal
[One sentence theme — PO approved]

### Sprint Backlog (PO selected)
| # | Title | Priority | Est. Effort |
|---|-------|----------|-------------|

### Dependencies
- #Y depends on #X

### Sprint Assignments
- Issues triaged: N
- Issues elaborated: N
- New issues created: N
- Labeled status:planned: N

### Velocity Reference
Prior sprint: X issues in ~Yh (from docs/sprints/velocity.md)

### Next Step
Run `/sprint-start` when ready to begin execution.
```

**DO NOT auto-proceed to sprint execution.** Planning is done. The PO will trigger `/sprint-start` when ready.

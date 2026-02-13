---
name: direction-gate
description: "Evaluate strategic direction changes before execution. Triggers on: 'direction change', 'strategic decision', 'pivot'."
---
# Direction Change Gate

**MANDATORY** before any of the following:

- Paradigm changes (new architecture, new framework, major refactor)
- ADR modifications or additions
- Abandoning a previously agreed direction
- Changing success metrics or evaluation criteria
- Introducing a new major dependency

## Step 1: Document the Proposal

```markdown
## Direction Change Proposal — [Date]

**Current direction**: [What we're doing now]
**Proposed change**: [What we want to change to]
**Trigger**: [What prompted this proposal]
**Impact scope**: [What code/config/process is affected]
**Reversal cost**: Low / Medium / High
```

## Step 2: Challenger Review

Invoke the `@challenger` agent to review the proposal:

```
@challenger Review this direction change proposal:
[Include the proposal from Step 1]
```

Wait for the challenger's verdict (PROCEED / CAUTION / ESCALATE).

## Step 3: Present to PO

**⛔ CONSENT GATE — DO NOT SKIP**

Present the proposal AND the challenger's review to the PO:

```
ask_user: "A direction change has been proposed:

**Change**: [summary]
**Challenger verdict**: [PROCEED/CAUTION/ESCALATE]
**Key concerns**: [top 2-3 from challenger review]

Do you approve this direction change?"
  choices: [
    "Approved — proceed with the change",
    "Approved with conditions — let me specify",
    "Deferred — add to backlog for later",
    "Rejected — stay on current course"
  ]
```

**WAIT for PO response.** Do NOT proceed without explicit PO approval.

### If Approved:
- Record the decision in `docs/architecture/ADR.md` (if architectural)
- Update any affected documentation
- Proceed with implementation

### If Approved with Conditions:
```
ask_user: "What conditions should apply to this change?"
```
- Document conditions alongside the decision
- Implement with conditions as constraints

### If Deferred:
- Create a GitHub issue for the proposal
- Label with `type:direction-change`
- Continue on current course

### If Rejected:
- Document the rejection and reasoning
- Continue on current course
- Do not re-propose in the same sprint unless new evidence emerges

## Step 4: Record the Decision

Whether approved or rejected, document the outcome:

```bash
gh issue comment <issue_number> --body "### Direction Gate — [Date]
**Proposal**: [summary]
**Challenger verdict**: [verdict]
**PO decision**: [approved/rejected/deferred]
**Reasoning**: [PO's stated reasoning]"
```

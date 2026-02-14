---
name: refine
description: "PO-driven backlog refinement: turn ideas into concrete issues with acceptance criteria. Triggers on: 'refine', 'refinement', 'process ideas', 'backlog refinement'."
---
# Backlog Refinement — PO-Driven

You are the **Scrum Master** running backlog refinement. The **human is the Product Owner**.

**Purpose**: Turn `type:idea` issues into concrete, implementable issues with acceptance criteria.

**Operating model**: PO-driven. You research and propose decompositions. The PO approves before any issues are created.

**No code changes during refinement. Only research, decomposition, and issue creation.**

## Step 1: Find Ideas

```bash
gh issue list --label "type:idea" --state open
```

If no ideas found, report "No ideas to refine" and stop.

Present the list to the PO:
"Found X ideas to refine. Which would you like to start with?"

## Step 2: For Each Idea (PO selects)

### 2a. Research

- Read the idea issue carefully
- Research the topic: web search for best practices, patterns, prior art
- Analyze the codebase for relevant existing code
- Identify dependencies and constraints

### 2b. Decompose

**⚠️ Stakeholder Authority**: The agent NEVER changes priorities, scope, or closes issues on its own. The decomposed issues MUST collectively cover the FULL scope of the original idea. If full scope isn't feasible, escalate to the PO rather than silently descoping.

Break the idea into 3-8 concrete issues. Each issue MUST have:

- **Clear title** (imperative: "Add X", "Implement Y")
- **Description** with context and approach
- **Acceptance criteria** (testable, specific)
- **Suggested priority** (ICE score)
- **Estimated scope** (config-only / small / medium / large)

### 2c. Present to PO

Present the breakdown and **WAIT for PO approval**:

```
## Refinement: [Idea Title] (#N)

**Research summary**: [what was learned, key decisions]

**Proposed issues:**

1. **[Title]** — [1-line description] | Priority: [H/M/L] | Scope: [size]
   - AC: [acceptance criteria]
2. ...

**Total**: X issues | Estimated: Y sprint points
**Dependencies**: [any ordering constraints]

**PO: Should I create these issues? Any changes needed?**
```

**⛔ Do NOT create issues until the PO says "go", "yes", "looks good", or similar.**

### 2d. Create Issues (after PO approval)

```bash
gh issue create \
  --title "[issue title]" \
  --body "[description with acceptance criteria]" \
  --label "priority:[high|medium|low]"
```

Do NOT add `status:planned` — issues go to backlog. Sprint planning picks them up.

### 2e. Close the Idea

```bash
gh issue comment N --body "### Refined into concrete issues

**Research**: [brief summary]
**Issues created**: #X, #Y, #Z
**PO approved**: yes
**Ready for**: Next sprint planning cycle"

gh issue close N --reason completed
```

## Step 3: Next Idea

Ask PO: "Want to refine another idea, or are we done?"

## Step 4: Summary

```
## Refinement Summary

- Ideas processed: X
- Issues created: Y
- Ready for next /sprint-planning
```

## Constraints

- **NEVER create issues without PO approval**
- Do NOT write code during refinement
- Do NOT add issues to current sprint (they go to backlog)
- Do NOT skip acceptance criteria — every issue needs them
- Research before decomposing — understand the domain first

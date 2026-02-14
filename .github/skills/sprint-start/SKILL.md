---
name: sprint-start
description: "PO-driven sprint execution with quality gates and daily huddles. Triggers on: 'sprint start', 'start sprint', 'begin sprint', 'let's go'."
---
# Sprint Start — PO-Driven

You are the **Scrum Master**. The **human is the Product Owner**.

**Operating model**: PO-driven. You MUST present the execution plan and **WAIT for PO to say "go"** before writing any code.

## Step 1: Gather State

```bash
git log --oneline -10
git status
git stash list
gh issue list --label "priority:high"
gh issue list --label "status:in-progress"
```

Read any context from the last sprint.

## Step 2: Load Sprint Backlog

Load the Planned items from labels and milestone (set during `/sprint-planning`):

```bash
gh issue list --milestone "Sprint N" --label "status:planned"
```

Determine the sprint number from `docs/sprints/velocity.md` (increment from last sprint).

## Step 3: Present Execution Plan

**⛔ CONSENT GATE — DO NOT SKIP**

Present the execution plan to the PO:

```markdown
## Sprint N Execution Plan

### Sprint Goal
[from planning]

### Execution Order
1. #A: [Title] — [approach: what agent/method, estimated effort]
2. #B: [Title] — [approach]
3. #C: [Title] — [approach]
...

### Dependencies
- #B depends on #A (must complete first)

### Quality Gates
- Every PR: lint + types + tests (min 3)
- CI green before merge
- Huddle after each issue (will check in with you)

### Estimated Duration
Based on velocity: ~X hours for Y issues
```

Then use `ask_user`:

```
ask_user: "Here's the execution plan for Sprint N. Ready to start?"
  choices: [
    "Go — start execution",
    "Reorder the issues first",
    "Remove an issue from scope",
    "Add an issue to scope",
    "Not yet — I have questions"
  ]
```

**WAIT for PO to say "go" or "start".** Do NOT write any code until PO approves.

If PO wants to reorder, adjust, or ask questions — address their input and ask again.

## Step 4: Create Sprint Log

After PO says "go", create a sprint log:

```bash
mkdir -p docs/sprints
cat > docs/sprints/sprint-N-log.md << 'EOF'
# Sprint N Log — [Date]

**Goal**: [sprint goal]
**Planned**: [number] issues
**PO consent**: ✅ Approved

## Huddles

[Huddles will be appended here after each issue completes]
EOF
```

## Step 5: Execute (issue by issue)

Send notification:
```bash
scripts/copilot-notify.sh "🚀 Sprint N Starting" "Goal: [theme]. Issues: #A, #B, #C..."
```

### 5a. Start Issue
Transition to in-progress and create branch:
```bash
gh issue edit N --remove-label "status:planned" --add-label "status:in-progress"
git checkout -b <branch-name> main
```

### Pre-Implementation Check

Before writing code for each issue:
1. **Read the acceptance criteria** on the issue — they define "done"
2. **For new modules**: define the interface first (function signatures, types, contracts) before implementation
3. **Write test stubs** from the acceptance criteria before writing production code

This is not full spec-driven development — it's just-enough precision to prevent the agent from building the wrong thing.

### 5b. Implementation Flow
```
implement → lint/type-check → write unit tests → validate → code review → PR → wait for CI → merge
```

### 5c. Quality Gates

**⛔ TEST GATE**: Every feature PR MUST include unit tests.
- Use `@test-engineer` agent after implementation, before PR
- Minimum 3 tests per feature (happy path, edge case, parameter effect)
- Tests must verify **actual behavior**, not just "runs without error"

**⛔ CI GATE** (after PR creation, before merge):
- Push PR, then **wait 3-5 minutes** for CI pipeline to complete
- Run: `gh run list --branch <branch> --limit 3`
- ALL checks must show ✓ (green). If any show ✗ (red):
  1. Run `gh run view <run-id> --log-failed` to get failure details
  2. Fix the issue on the branch
  3. Push and wait for CI again
  4. **Do NOT merge on red. No exceptions.**
- Only after CI is green: `gh pr merge <number> --squash --delete-branch`

**⛔ DEFINITION OF DONE** (see copilot-instructions.md for full checklist):
- Code + lint + types clean
- Unit tests (min 3, behavior-verifying)
- **CI green** (verified with `gh run list`)
- PR reviewed + squash-merged
- Issue closed with summary
- **Status labels removed**: `gh issue close N` (removes status labels)

### 5d. 🔄 Interactive Huddle (after each issue completes)

**⛔ PO INTERACTION GATE — DO NOT SKIP**

After each issue completes, present results to the PO and ask for direction.

**1. Comment on the completed issue** (persistent record):
```bash
gh issue comment N --body "### Huddle — Sprint X, Issue X/Y done

**Outcome**: [what was delivered]
**Key learning**: [anything discovered]
**Drift**: ✅ on track / ⚠️ [drift description]
**Next**: #M — [title]"
```

**2. Append to sprint log** (`docs/sprints/sprint-N-log.md`)

**3. Present to PO and ask for direction:**

```
ask_user: "Issue #N is done: [brief outcome]. Sprint progress: X/Y issues complete.

Key learning: [anything notable]

Drift check:
- [ ] This issue was in the PO-approved sprint plan
- [ ] No unplanned scope added
- [ ] Files changed relate to sprint issues
- [ ] Sprint goal still achievable
⚠️ If any unchecked → flag to PO before continuing

Next up: #M — [title]

Is the plan still valid?"
  choices: [
    "Continue as planned",
    "Reprioritize — let's discuss",
    "Skip the next issue",
    "Stop the sprint here"
  ]
```

**WAIT for PO response.** If PO wants to reprioritize, discuss and adjust.

## Constraints

- **Sub-agents**: ≤2 concurrent (avoid resource exhaustion)
- **WIP**: 1 issue at a time — finish before starting next
- **Sprint focus**: Never silently abandon an in-progress issue

## ⛔ Agent Dispatch Rules

**NEVER use the generic `task` agent type (Haiku) for code changes.**

| Task | Agent Type | Model |
|------|-----------|-------|
| Code implementation | `@code-developer` | Sonnet |
| Writing tests | `@test-engineer` | Sonnet |
| Code review | `code-review` (built-in) | Sonnet |
| Research/docs | `@research-agent` / `@documentation-agent` | Sonnet |
| Quick file search | `explore` (built-in) | Haiku (OK) |
| Build/test commands | `task` (built-in) | Haiku (OK) |

**⛔ CI GATE**: After creating a PR, wait 3-5 minutes for CI. Run `gh run list --branch <branch> --limit 3` and verify ALL checks show ✓. If any show ✗, run `gh run view <run-id> --log-failed`, fix, push, and wait again. **Do NOT merge on red. No exceptions.**

## Output Format

```markdown
## Sprint N — [Date]

### Sprint Backlog (PO approved)
1. #N: [Title] (priority, approach)
2. #M: [Title] (priority, approach)

### Progress
- [X] #N — Done (PR #P)
- [ ] #M — Next
```

When all issues are done or PO stops the sprint → inform PO and suggest `/sprint-review`.

---
name: subagent-dispatch
description: "Dispatch subagents for parallel work. Triggers on: 'dispatch subagents', 'use subagents', 'parallel execution'."
---
# Subagent Dispatch

Execute implementation plans by dispatching independent subagents for each task. Each subagent runs in a fresh context with explicit instructions.

## Prerequisites

**⛔ REQUIRES a PO-approved plan before starting.**

The plan must exist (typically in `docs/plans/`) and the PO must have explicitly approved it. If no approved plan exists:

```
ask_user: "No approved plan found. Would you like to create one first?"
  choices: [
    "Yes — let's write a plan",
    "I already have one — let me point you to it",
    "Skip the plan — just execute"
  ]
```

If PO says "skip the plan", remind them of the risk and proceed only with explicit confirmation.

## Dispatch Process

### Step 1: Parse the Plan

Extract independent tasks from the approved plan. For each task, identify:
- Task ID and description
- Input files / dependencies
- Expected output
- Which agent type to use

### Step 2: Dispatch Subagents

For each independent task:

```
task(
  agent_type: "<appropriate-agent>",
  prompt: "
    Context: [project context]
    Task: [specific task from plan]
    Input: [what files/state to start from]
    Output: [what the result should be]
    Constraints: [any rules or conventions]
  "
)
```

**Rules:**
- One subagent per task — fresh context each time
- Independent tasks can run in parallel
- Dependent tasks must run sequentially
- Include ALL necessary context in the prompt (subagents have no memory)

### Step 3: Two-Stage Review

After each subagent completes:

1. **Agent review**: Verify the output matches expectations
   - Check files were created/modified as expected
   - Run relevant tests
   - Check lint/types

2. **Present to PO**: Show results and ask for confirmation

```
ask_user: "Task [N/M] complete: [description]

Result: [summary of what was done]
Tests: [pass/fail]

Continue to next task?"
  choices: [
    "Continue — looks good",
    "Continue but note: [I'll type feedback]",
    "Stop — need to discuss",
    "Redo this task"
  ]
```

### Step 4: Completion

After all tasks:

```
ask_user: "All [N] tasks from the plan are complete.

Summary:
[List of completed tasks with outcomes]

Should I create a PR?"
  choices: [
    "Yes — create PR",
    "Not yet — run full tests first",
    "Not yet — I want to review changes"
  ]
```

## Guidelines

- Never dispatch subagents without a PO-approved plan
- Provide complete context to each subagent — they can't ask questions
- Verify each subagent's output before proceeding to the next
- If a subagent fails twice, attempt the task directly or escalate to PO
- Use the appropriate agent type (see Agent Dispatch Rules in copilot-instructions.md)

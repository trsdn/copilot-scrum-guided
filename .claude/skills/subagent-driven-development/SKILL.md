---
name: subagent-driven-development
description: "Use when executing implementation plans with independent tasks in the current session. Triggers on: 'use subagents', 'dispatch subagents', 'subagent development', 'execute with subagents', 'execute the plan'. REQUIRES a user-approved plan before starting — never begin without explicit user consent."
---

# Subagent-Driven Development

Execute plan by dispatching fresh subagent per task, with two-stage review after each.

**Core principle:** Fresh subagent per task + two-stage review = high quality, fast iteration

**⛔ PO GATE**: REQUIRES a PO-approved plan before starting. Never begin without explicit consent.

## The Process

1. Read plan, extract all tasks with full text, create TodoWrite
2. For each task:
   a. Dispatch implementer subagent
   b. Implementer implements + tests + commits
   c. Dispatch spec reviewer → verify code matches plan
   d. Dispatch code quality reviewer → verify quality
   e. Fix any issues found by reviewers
   f. Mark task complete
3. After all tasks: dispatch final code reviewer for entire implementation

## Agent Dispatch Rules

| Task | Agent Type | Model |
|------|-----------|-------|
| Implementation | `code-developer` | Sonnet |
| Spec review | `code-review` | Sonnet |
| Quality review | `code-review` | Sonnet |
| Tests | `test-engineer` | Sonnet |

## Red Flags

**Never:**
- Skip reviews
- Dispatch multiple implementation subagents in parallel
- Make subagent read plan file (provide full text instead)
- Accept "close enough" on spec compliance
- Start without PO-approved plan

**If subagent asks questions:**
- Answer clearly and completely
- Provide additional context if needed

**If reviewer finds issues:**
- Implementer fixes them
- Reviewer reviews again
- Repeat until approved

---
name: writing-plans
description: "Create comprehensive implementation plans with bite-sized TDD tasks"
---

# Writing Plans

Create a zero-context implementation plan that any developer (human or agent) can pick up and execute without additional explanation.

## When to Write a Plan

- Before implementing a multi-file feature
- Before a refactor that touches 3+ files
- Before any work estimated at >30 minutes
- When the PO requests a plan before execution

## Plan Structure

Save plans to: `docs/plans/YYYY-MM-DD-<feature-name>.md`

```markdown
# Plan: [Feature Name]

**Issue**: #N
**Date**: YYYY-MM-DD
**Status**: Draft / Approved / In Progress / Done

## Problem Statement

[1-2 sentences: what problem does this solve?]

## Approach

[1 paragraph: how will we solve it? Key design decisions.]

## Tasks

### Task 1: [Name] (2-5 min)
**File**: `path/to/file.py`
**Test**: `tests/test_file.py::TestClass::test_name`
**Do**:
1. [Specific step]
2. [Specific step]
**Done when**: [Concrete verification]

### Task 2: [Name] (2-5 min)
...

## Out of Scope

- [Things we're explicitly NOT doing]

## Risks

- [Risk]: [Mitigation]
```

## Task Guidelines

Each task must be:

- **2-5 minutes** to implement — if longer, split it
- **TDD**: Write the test first, then the implementation
- **Self-contained**: No implicit context needed
- **Verifiable**: Clear "done when" criteria

## Principles

- **DRY** — Don't Repeat Yourself. Reuse existing utilities and patterns
- **YAGNI** — You Ain't Gonna Need It. Only build what the plan requires
- **TDD** — Every task starts with a failing test

## After Writing

Present the plan to the PO for approval:

```
ask_user: "Here's the implementation plan for [feature]:

[N] tasks, estimated [X] minutes total.
Key decisions: [1-2 bullet points]

Approve this plan?"
  choices: [
    "Approved — start execution",
    "Approved with changes — let me specify",
    "Needs revision — [I'll explain]",
    "Too complex — simplify"
  ]
```

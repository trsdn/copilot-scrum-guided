---
name: orchestrate-feature
description: "Full feature pipeline: implement → test → review → close. Triggers on: 'orchestrate feature', 'full pipeline'."
---
# Orchestrate Feature

Full pipeline for implementing a feature from issue to merged PR.

## Prerequisites
- GitHub issue exists with acceptance criteria
- Issue is assigned to current sprint

## Pipeline

### 1. Understand the Issue
```bash
gh issue view <number>
```
Read acceptance criteria, linked issues, and any discussion.

### 2. Create Branch
```bash
git checkout -b feat/<issue-number>-<short-name> main
```

### 3. Implement
Use `@code-developer` agent for implementation:
- Follow existing patterns
- Type hints throughout
- Docstrings for public APIs

### 4. Write Tests
Use `@test-engineer` agent:
- Minimum 3 tests per feature
- Happy path, edge case, error case
- Tests verify behavior, not just "runs without error"

### 5. Quality Checks
```bash
uv run ruff check src/ tests/
uv run ruff format src/ tests/
uv run mypy src/
uv run pytest tests/ -v
```

### 6. Code Review
Use `code-review` prompt to review changes.

### 7. Create PR
Use `create-pr` prompt to create a properly formatted PR.

### 8. Wait for CI
```bash
gh run list --branch feat/<branch-name>
```
**⛔ Do NOT merge until CI is green.**

### 9. Close Issue
```bash
gh issue close <number> --comment "Implemented in PR #M. [summary]"
```

Remove any remaining status labels (closing the issue signals "Done").

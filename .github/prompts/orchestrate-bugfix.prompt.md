---
name: orchestrate-bugfix
description: "Full bugfix pipeline: reproduce → write regression test → fix → verify → review."
---

# Orchestrate Bugfix

Full pipeline for fixing a bug from issue to merged PR.

## Prerequisites
- GitHub issue exists with reproduction steps
- Issue is assigned to current sprint

## Pipeline

### 1. Understand the Bug
```bash
gh issue view <number>
```
Read reproduction steps, expected vs actual behavior.

### 2. Create Branch
```bash
git checkout -b fix/<issue-number>-<short-name> main
```

### 3. Write Regression Test First
Use `@test-engineer` agent:
- Write a test that reproduces the bug
- **Test MUST fail before the fix** (confirms it catches the bug)
- Run and verify it fails:
```bash
uv run pytest tests/test_<module>.py -v -k "test_regression"
```

### 4. Implement Fix
Use `@code-developer` agent:
- Minimal change to fix the bug
- Don't refactor unrelated code

### 5. Verify Fix
```bash
uv run pytest tests/ -v
```
- Regression test now passes
- All other tests still pass

### 6. Quality Checks
```bash
uv run ruff check src/ tests/
uv run mypy src/
```

### 7. Code Review
Use `code-review` prompt.

### 8. Create PR
Use `create-pr` prompt. Reference the issue: `fixes #N`.

### 9. Wait for CI
```bash
gh run list --branch fix/<branch-name>
```
**⛔ Do NOT merge until CI is green.**

### 10. Close Issue
```bash
gh issue close <number> --comment "Fixed in PR #M. Regression test added."
```

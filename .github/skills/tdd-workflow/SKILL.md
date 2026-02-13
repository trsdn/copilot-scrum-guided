---
name: tdd-workflow
description: "Test-Driven Development workflow. Triggers on: 'TDD', 'test first', 'write tests'."
---
# TDD Workflow

> **When to use**: RECOMMENDED for all feature issues. REQUIRED when the issue has Given/When/Then acceptance criteria. The acceptance criteria on the issue ARE your test specifications.

Write failing tests first, then implement code to make them pass.

## The TDD Cycle

```
1. RED    → Write a failing test
2. GREEN  → Write minimal code to pass
3. REFACTOR → Improve code, keep tests green
```

## Workflow Steps

### Step 1: Parse Acceptance Criteria

Convert each Given/When/Then into a test case.

### Step 2: Write Test File First

Create test file before implementation file.

### Step 3: Run Test (Expect Failure)

```bash
uv run pytest tests/test_feature.py -v
```

Expected: RED (failing test)

### Step 4: Implement Minimum Code

Write just enough to make the test pass.

### Step 5: Run Test (Expect Pass)

```bash
uv run pytest tests/test_feature.py -v
```

Expected: GREEN (all pass)

### Step 6: Refactor

Improve code quality while keeping tests green.

### Step 7: Repeat for Next Criterion

## Test Structure Template (Python/pytest)

```python
"""Tests for [feature] - Issue #XXX"""
import pytest

class TestFeatureName:
    """Tests for [acceptance criteria group]"""

    @pytest.fixture
    def setup_data(self):
        """Given: [precondition]"""
        return create_test_data()

    def test_happy_path(self, setup_data):
        """Given [X], when [Y], then [Z]"""
        result = function_under_test(setup_data)
        assert result == expected_value

    def test_edge_case(self):
        """Edge case: [description]"""
        pass

    def test_error_case(self):
        """Error case: [description]"""
        with pytest.raises(ValueError):
            function_under_test(invalid_input)
```

## Checklist Before Implementation

- [ ] All acceptance criteria have corresponding tests
- [ ] Test file created before implementation file
- [ ] Tests run and fail for the right reason
- [ ] Edge cases identified and have tests

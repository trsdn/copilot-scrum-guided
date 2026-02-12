---
name: code-review
description: "Structured code review with security, performance, and correctness checks."
---

# Code Review

Perform thorough, structured code reviews focusing on security, performance, maintainability, and correctness.

## Review Process

### 1. Understand the Change

```bash
git diff main...HEAD
# Or for a specific PR
gh pr diff <number>
```

### 2. Review Checklist

#### Security 🔒
- [ ] No hardcoded secrets, API keys, or passwords
- [ ] Input validation on all user inputs
- [ ] SQL injection prevention (parameterized queries)
- [ ] Sensitive data not logged
- [ ] Dependencies are up to date

#### Performance ⚡
- [ ] No N+1 query patterns
- [ ] Expensive operations not in loops
- [ ] Appropriate caching where needed

#### Code Quality 📐
- [ ] Single responsibility principle
- [ ] DRY (Don't Repeat Yourself)
- [ ] Meaningful variable/function names
- [ ] Functions are reasonably sized (< 50 lines)
- [ ] Error handling is comprehensive

#### Testing 🧪
- [ ] New code has tests
- [ ] Edge cases covered
- [ ] Tests are readable and maintainable

#### Documentation 📝
- [ ] Public APIs documented
- [ ] Complex logic has comments
- [ ] README updated if needed

### 3. Comment Format

Severity levels:
- 🔴 **BLOCKER** — Must fix before merge
- 🟠 **MAJOR** — Should fix, significant issue
- 🟡 **MINOR** — Nice to fix, minor issue
- 🔵 **SUGGESTION** — Optional improvement
- 💚 **PRAISE** — Highlight good code

### 4. Generate Review Summary

```markdown
## Review Summary

**Overall:** ✅ Approved / ⚠️ Changes Requested / ❌ Needs Work

### Stats
- Files reviewed: X
- Issues found: X (Y blockers, Z major)

### Required Changes
1. 🔴 [Description]

### Suggestions
1. 🔵 [Description]
```

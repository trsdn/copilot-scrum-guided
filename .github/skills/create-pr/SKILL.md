---
name: create-pr
description: "Create GitHub pull requests. Triggers on: 'create PR', 'pull request', 'submit PR'."
---
# Create Pull Request

Creates GitHub PRs with conventional commit-style titles.

## PR Title Format

```
<type>(<scope>): <summary>
```

### Types (required)

| Type       | Description                    | Changelog |
|------------|--------------------------------|-----------|
| `feat`     | New feature                    | Yes       |
| `fix`      | Bug fix                        | Yes       |
| `perf`     | Performance improvement        | Yes       |
| `test`     | Adding/correcting tests        | No        |
| `docs`     | Documentation only             | No        |
| `refactor` | Code change (no fix or feature)| No        |
| `build`    | Build system or dependencies   | No        |
| `ci`       | CI configuration               | No        |
| `chore`    | Routine tasks, maintenance     | No        |

### Summary Rules

- Use imperative present tense: "Add" not "Added"
- Capitalize first letter
- No period at the end

## Steps

1. **Check current state**:
   ```bash
   git status
   git diff --stat
   git log origin/main..HEAD --oneline
   ```

2. **Analyze changes** to determine type, scope, summary

3. **Push branch**:
   ```bash
   git push -u origin HEAD
   ```

4. **Create PR**:
   ```bash
   gh pr create --draft --title "<type>(<scope>): <summary>" --body "..."
   ```

## Examples

```
feat(auth): Add JWT token refresh endpoint
fix(api): Resolve timeout on large queries
test(utils): Add edge case tests for date parsing
docs: Update API reference for v2 endpoints
```

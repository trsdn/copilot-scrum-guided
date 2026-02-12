---
name: github-issues
description: 'Create, update, and manage GitHub issues using MCP tools. Use this skill when users want to create bug reports, feature requests, or task issues, update existing issues, add labels/assignees/milestones, or manage issue workflows. Triggers on requests like "create an issue", "file a bug", "request a feature", "update issue X", or any GitHub issue management task.'
---

# GitHub Issues

Manage GitHub issues using the GitHub MCP server tools.

## Workflow

1. **Determine action**: Create, update, or query?
2. **Gather context**: Get repo info, existing labels, milestones
3. **Structure content**: Use appropriate template
4. **Execute**: Call the appropriate tool
5. **Confirm**: Report the issue URL to user

## Creating Issues

### Title Guidelines

- Start with type prefix when useful: `[Bug]`, `[Feature]`, `[Docs]`
- Be specific and actionable
- Keep under 72 characters

### Body Structure

#### Bug Report
```markdown
## Description
[What's broken]

## Steps to Reproduce
1. Step 1
2. Step 2

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]
```

#### Feature Request
```markdown
## Summary
[What feature is needed]

## Motivation
[Why is it needed]

## Proposed Solution
[How it should work]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
```

#### Task
```markdown
## Description
[What needs to be done]

## Approach
[How to do it]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
```

## Common Labels

| Label | Use For |
|-------|---------|
| `bug` | Something isn't working |
| `enhancement` | New feature or improvement |
| `documentation` | Documentation updates |
| `priority:high` | Urgent issues (ICE ≥ 4) |
| `priority:medium` | Important issues (ICE 2-3) |
| `priority:low` | Nice-to-have (ICE < 2) |

## Tips

- Always confirm the repository context before creating issues
- Ask for missing critical information rather than guessing
- Link related issues when known: `Related to #123`

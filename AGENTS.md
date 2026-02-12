# {{PROJECT_NAME}} — Agent Instructions

These instructions apply to all Copilot agents working in this repository.

## Project Overview

{{PROJECT_DESCRIPTION}}

## Operating Model — PO-Driven

The human is the **Product Owner**. The agent is the **Scrum Master + Development Team**.

**Every ceremony has a consent gate.** The agent proposes, the PO disposes.

- Sprint Planning: agent presents candidates → **PO selects scope**
- Sprint Start: agent presents plan → **PO says "go"**
- Sprint Execution: after each issue → **agent asks PO if plan is still valid**
- Sprint Review: agent presents results → **PO accepts or rejects**
- Sprint Retro: interactive → **PO contributes observations**

## Project Priorities

1. **Robustness over speed**: Avoid changes that fix one thing but break others
2. **Small, testable diffs**: Prefer incremental changes over large rewrites
3. **Config-driven**: Prefer configuration changes over code changes when possible

## Repo Structure

<!-- Customize for your project -->
- `src/` — source code
- `tests/` — test suite
- `docs/` — documentation

## Key Commands

<!-- Customize for your project -->

## Coding Conventions

<!-- Customize for your language/framework -->

## Safety

- Don't delete output artifacts unless asked
- Don't edit .env or .db files directly

## Available Agents

| Agent | Invoke With | Use For |
|-------|------------|---------|
| Code Developer | `@code-developer` | Write/improve code |
| Test Engineer | `@test-engineer` | Write tests |
| Documentation | `@documentation-agent` | Technical docs |
| Security Reviewer | `@security-reviewer` | Security audit |
| Research Agent | `@research-agent` | Research topics |
| Architect | `@architect` | ADR compliance, system design review |
| Release Agent | `@release-agent` | Versioning, changelogs, release readiness |
| Copilot Customization Builder | `@copilot-customization-builder` | Create agents, prompts, instructions |

## Available Prompts

| Prompt | Use For |
|--------|---------|
| `sprint-planning` | Triage backlog, PO selects scope |
| `sprint-start` | Present plan, wait for PO "go" |
| `sprint-review` | Demo results, PO accepts/rejects |
| `sprint-retro` | Interactive process improvements |
| `orchestrate-feature` | Full feature pipeline |
| `orchestrate-bugfix` | Full bugfix pipeline |
| `code-review` | Structured code review |
| `create-pr` | Create PR with conventional title |
| `tdd-workflow` | TDD cycle |
| `architecture-review` | Evaluate change for ADR compliance |
| `release-check` | Assess release readiness |
| `new-custom-agent` | Template for creating a new agent |
| `new-prompt-file` | Template for creating a new prompt |
| `new-instructions-file` | Template for creating instructions file |

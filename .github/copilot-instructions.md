# {{PROJECT_NAME}} Copilot Instructions

These instructions apply to all Copilot Chat work in this repository.

## Project Overview

{{PROJECT_NAME}} — {{PROJECT_DESCRIPTION}}

## Operating Model

This project uses **PO-driven Scrum** with GitHub Copilot CLI:
- **Human** = Product Owner (drives ceremonies, selects scope, accepts deliverables)
- **Agent** = Scrum Master + Dev Team (proposes, implements, waits for PO approval)

## Key Rules

1. **Always wait for PO approval** before starting work
2. **Use slash commands** for sprint ceremonies: `/sprint-planning`, `/sprint-start`, `/sprint-review`, `/sprint-retro`
3. **Follow Definition of Done** — lint, types, tests (min 3), CI green, PR reviewed
4. **Use GitHub Issues** as the only task tracking system
5. **ICE scoring** for prioritization: Impact × Confidence / Effort

## Key Commands

```bash
uv run pytest tests/ -v                          # Run tests
uv run ruff check src/ && uv run ruff format src/ # Lint and format
uv run mypy src/                                  # Type check
```

## Sprint Discipline

When working on an issue, protect the sprint focus:
1. Acknowledge new ideas
2. Remind about the current issue
3. Offer to create a new issue
4. Only context-switch if PO explicitly confirms

## Safety

- Don't delete output artifacts unless asked
- Don't commit secrets
- Don't modify ADRs without PO confirmation
- Run tests after changes

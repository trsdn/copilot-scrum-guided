# {{PROJECT_NAME}} Copilot Instructions

These instructions apply to all Copilot Chat work in this repository.

See `docs/constitution/PROCESS.md` for the full development process constitution (stakeholder model, ceremonies, DoD, ICE scoring, board flow).

See `AGENTS.md` for available agents and prompts.

## Project Overview

{{PROJECT_NAME}} — {{PROJECT_DESCRIPTION}}

## Project Priorities

1. **Quality over speed**: Every change must be tested and reviewed
2. **Small, testable diffs**: Prefer incremental changes over large rewrites
3. **Config-driven**: Prefer configuration changes over code changes when possible
4. **PO control**: Always present options and wait for PO decisions

## Coding Conventions

- Python 3.11+ with type hints where they improve clarity
- Pydantic for configuration models
- Typer for CLI
- pytest for testing
- Keep code readable; avoid clever one-liners
- Preserve existing public APIs unless explicitly asked to change
- **Python 3.14 compat**: No leading zeros in integer literals

## Development Principles

- **YAGNI** — Don't build it until you need it. No speculative features, no "while we're at it" additions. If it's not in the current issue, it goes to the backlog.
- **KISS** — Choose the simplest solution that works. Prefer config over code, stdlib over dependency, flat over nested.
- **DRY** — Don't repeat yourself. Extract shared logic, but don't over-abstract prematurely.
- **Boy Scout Rule** — Leave the code cleaner than you found it. Small improvements (rename, extract, simplify) are welcome in any PR — but don't bundle large refactors with feature work.
- **Eliminate Waste** — Don't write tests that test nothing. Don't document what's obvious. Don't automate what runs once. Every artifact must earn its existence.

## Key Commands

```bash
uv run pytest tests/ -v                          # Run tests
uv run ruff check src/ && uv run ruff format src/ # Lint and format
uv run mypy src/                                  # Type check
```

## Architectural Decisions — DO NOT VIOLATE

Full details in `docs/architecture/ADR.md`. Record all architectural decisions there. Do NOT modify ADRs without explicit PO confirmation.

## Sprint Discipline (Scrum Master Role)

**When working on an issue, protect the sprint focus.** If new work is suggested mid-task:

1. **Acknowledge** the idea — don't ignore it
2. **Remind** we're mid-sprint on issue #N
3. **Offer to create a new issue** for the idea so it doesn't get lost
4. **Only context-switch** if the PO explicitly confirms

Never silently abandon an in-progress issue to chase a new idea.

## Verification Before Completion

**No completion claims without fresh verification evidence.**

Before claiming work is complete, fixed, or passing:

1. **Identify**: What command proves this claim?
2. **Run**: Execute the full command (fresh, not cached)
3. **Read**: Check output, exit code, failure count
4. **Verify**: Does output confirm the claim?
5. **Only then**: Make the claim

| Claim | Requires | NOT Sufficient |
|-------|----------|----------------|
| "Tests pass" | Test output: 0 failures | "Should pass", previous run |
| "Lint clean" | Linter output: 0 errors | Partial check |
| "Bug fixed" | Regression test: red→green | "Code changed" |
| "Build succeeds" | Build exit code 0 | "Linter passed" |

## Known Agent Limitations

| Issue | Workaround |
|-------|------------|
| Agents sometimes describe code instead of creating files | For new modules, write files directly |
| Agents may reuse existing class/function names | Specify unique names in the prompt |
| Agents can't create files in non-existent directories | `mkdir -p` before dispatching |
| Agents may report "success" without completing | Verify agent output independently |

## Agent Dispatch Rules

**NEVER use the generic `task` agent type (Haiku) for code changes.** It lacks reasoning capacity for multi-file edits.

| Task | Agent Type | Model | Why |
|------|-----------|-------|-----|
| Code changes, new modules | `code-developer` | Sonnet | Multi-file reasoning |
| Writing tests | `test-engineer` | Sonnet | Behavior understanding |
| Code review | `code-review` (built-in) | Sonnet | Architectural judgment |
| Research | `research-agent` | Sonnet | Synthesis |
| Documentation | `documentation-agent` | Sonnet | Technical writing |
| Security audit | `security-reviewer` | Sonnet | Vulnerability analysis |
| File search | `explore` (built-in) | Haiku | Pattern matching |
| Running commands | `task` (built-in) | Haiku | Pass/fail only |

**⛔ CI Gate**: After creating a PR, wait 3-5 minutes for CI. Verify green with `gh run list --branch <branch>` BEFORE merging.

## Notifications (ntfy)

Push notifications via ntfy.sh when tasks complete or input is needed:

```bash
scripts/copilot-notify.sh "Task completed"                    # Quick notify
scripts/copilot-notify.sh "✅ Backtest Done" "HYP-087 passed" # With title
make notify MSG="All tests passing"                            # Via Makefile
```

## Safety

- Don't delete or overwrite output artifacts unless explicitly asked
- Don't commit secrets or credentials
- Don't edit `.env` or `.db` files directly
- Don't modify `docs/architecture/ADR.md` without PO confirmation
- Run tests after making changes

## Makefile Shortcuts

```bash
make help          # Show all commands
make check         # Lint + types + tests
make fix           # Auto-fix lint + format
make test-quick    # Fast fail test
make coverage      # Tests with coverage
make security      # Bandit security scan
make notify MSG="Done!"
```

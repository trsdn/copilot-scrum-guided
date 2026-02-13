# {{PROJECT_NAME}} Copilot Instructions

These instructions apply to all Copilot Chat work in this repository.

See `docs/constitution/PROCESS.md` for the full development process constitution (stakeholder model, ceremonies, DoD, ICE scoring, label flow).

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

## Development Principles

- **YAGNI** — Don't build it until you need it. No speculative features, no "while we're at it" additions. If it's not in the current issue, it goes to the backlog.
- **Boy Scout Rule** — Leave the code cleaner than you found it. Small improvements (rename, extract, simplify) are welcome in any PR — but don't bundle large refactors with feature work.
- **Issue-Level Precision** — Sprint-level planning is agile, but each issue needs testable acceptance criteria before implementation starts. "Improve X" is not actionable; "X should return Y when given Z" is.

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

### Drift Control

Sprint scope is locked once the PO approves the plan. Discovered work goes to backlog — never into the current sprint. Every huddle includes a drift check. Flag any drift to the PO immediately.

## Workflow Gates — NEVER Skip

- **Direction Changes → Gate**: Any strategic direction change MUST go through `direction-gate` prompt, with PO approval required.
- **Every Sprint → Challenger**: Challenger agent reviews deliverables at sprint review and scope at planning. Presents findings to PO.

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
| Custom agents only have `edit` + `view` tools — no `create`, no `bash` | Use `general-purpose` agent type for new file creation, or pre-create empty files before dispatching |
| Agents may reuse existing class/function names | Specify unique names in the prompt |
| Agents can't create files in non-existent directories | `mkdir -p` before dispatching |
| `tools` YAML frontmatter does NOT grant additional tools to sub-agents | Platform limitation — use `general-purpose` with custom instructions in prompt |
| Agents may report "success" without completing | Verify agent output independently |

### Pre-Creation Pattern (for custom agents needing new files)

```
1. mkdir -p <target_directory>
2. Create empty/stub files with `create` tool
3. Dispatch custom agent: "Edit the file at <path> to contain..."
```

**Alternative**: Use `general-purpose` agent and include the custom agent's instructions in the prompt.

## Agent Dispatch Rules

**Prefer built-in agents when they suffice.** They have full toolsets (bash, create, grep, glob, edit, view). Only use custom agents when you need their specialized domain knowledge — and remember custom agents only have `edit` + `view` tools.

### Built-in Features

- **Plan mode** (`[[PLAN]]` prefix or Shift+Tab): Creates structured implementation plans before touching code. Use for any multi-step task — analyze codebase, create plan.md with todos, wait for approval before implementing.
- **SQL database**: Per-session SQLite for todo tracking, batch processing, and structured data.

### Built-in Agents (full toolset)

| Agent Type | Use For | Tools |
|-----------|---------|-------|
| `explore` | Codebase search, finding files, answering questions about code | `grep` + `glob` + `view` |
| `task` | Running commands (tests, builds, lints), pass/fail results | Full CLI tools |
| `code-review` | Reviewing code changes, PR diffs, spotting bugs | Full CLI tools |
| `general-purpose` | Multi-step tasks needing full toolset, creating new files | Full toolset (`create`, `bash`, `edit`, `view`, `grep`, `glob`) |

### Custom Agents (edit + view only)

Use custom agents when their domain expertise adds value beyond what built-in agents provide. They can only edit existing files — they cannot create files, run commands, or search.

| Task | Agent Type | Why custom? |
|------|-----------|-------------|
| Edit existing code | `code-developer` | Project conventions, architecture awareness |
| Edit existing tests | `test-engineer` | Test patterns, coverage strategy |
| Edit existing docs | `documentation-agent` | Doc style, structure conventions |
| Research topics | `research-agent` | Domain expertise |
| Security audit | `security-reviewer` | Security checklist, threat model |
| Adversarial review | `challenger` | Structured devil's advocate |
| CI diagnosis | `ci-fixer` | CI/CD patterns, log analysis |

### When custom agents need new files

Custom agents **cannot** `create` files. Use one of these patterns:

1. **Pre-create**: `mkdir -p dir/ && create` stub files, then dispatch custom agent to edit them
2. **General-purpose with instructions**: Use `general-purpose` agent type and include the custom agent's instructions in the prompt

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

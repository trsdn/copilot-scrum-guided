# Copilot Scrum Guided

> **Optimized for GitHub Copilot CLI**

A template repository for **PO-driven Scrum development** powered by GitHub Copilot CLI. The human is the Product Owner who manually drives each sprint phase. The agent is the Scrum Master + development team but always waits for PO approval before proceeding.

> See [copilot-scrum-autonomous](https://github.com/trsdn/copilot-scrum-autonomous) for the autonomous variant where the agent also acts as PO.

## Operating Model

| Role | Who | Responsibility |
|------|-----|----------------|
| **Product Owner** | Human | Strategic direction, scope selection, acceptance, process decisions |
| **Scrum Master + Dev Team** | Copilot Agent | Backlog management, sprint execution, quality gates, implementation |

The agent **proposes**, the PO **disposes**. Every ceremony has a consent gate where the PO must approve before the agent proceeds.

## Sprint Cycle

Each phase is triggered manually via slash commands. The agent never auto-proceeds to the next phase.

```
/sprint-planning → PO approves scope → /sprint-start → PO says "go" → execute → /sprint-review → PO accepts → /sprint-retro
```

### Ceremony Flow

```
┌──────────────────────────────────────────────────────────────┐
│  1. /sprint-planning                                         │
│     Agent triages backlog, scores ICE, presents candidates   │
│     ⛔ PO selects which issues go into the sprint            │
├──────────────────────────────────────────────────────────────┤
│  2. /sprint-start                                            │
│     Agent presents execution plan with ordering              │
│     ⛔ PO must say "go" before any code is written           │
├──────────────────────────────────────────────────────────────┤
│  3. Execute (automatic after PO consent)                     │
│     Agent implements issue by issue                          │
│     ⛔ After each issue: presents results, asks PO if valid  │
├──────────────────────────────────────────────────────────────┤
│  4. /sprint-review                                           │
│     Agent presents delivery report + metrics                 │
│     ⛔ PO must explicitly accept or reject deliverables      │
├──────────────────────────────────────────────────────────────┤
│  5. /sprint-retro                                            │
│     Interactive: agent presents, PO contributes observations │
│     ⛔ PO approves action items                              │
└──────────────────────────────────────────────────────────────┘
```

## Key Features

- **Same quality infrastructure** as the autonomous variant: ICE scoring, Definition of Done, quality gates, CI/CD
- **Human control at every phase**: PO drives scope, accepts deliverables, contributes to retros
- **Specialized agents**: Code developer, test engineer, security reviewer, documentation agent, research agent
- **Push notifications**: ntfy.sh integration for task completion and input needed alerts
- **Sprint velocity tracking**: Data-driven sprint sizing from historical performance
- **GitHub Issues as task system**: Project board with Backlog → Planned → In Progress → Done flow

## Getting Started

### 1. Use this template

Click **"Use this template"** on GitHub to create a new repository from this template.

### 2. Customize placeholders

Search for `{{PROJECT_NAME}}` and `{{PROJECT_DESCRIPTION}}` in `AGENTS.md`, `.github/copilot-instructions.md`, `pyproject.toml`, and other files. Replace with your project details.

### 3. Set up GitHub Project Board

Create a GitHub Project board with columns: **Backlog**, **Planned**, **In Progress**, **Validation**, **Done**.

### 4. Configure notifications (optional)

```bash
echo 'export NTFY_TOPIC="your-secret-topic"' >> ~/.zshrc
source ~/.zshrc
```

Install the [ntfy app](https://ntfy.sh) on your phone and subscribe to your topic.

### 5. Start your first sprint

```bash
# In your Copilot CLI session:
/sprint-planning
```

## Slash Commands Reference

| Command | Ceremony | What Happens |
|---------|----------|--------------|
| `/sprint-planning` | Sprint Planning | Agent triages backlog, scores ICE, presents candidates → **PO selects scope** |
| `/sprint-start` | Sprint Start | Agent presents plan → **PO says "go"** → execution begins |
| `/sprint-review` | Sprint Review | Agent presents deliverables → **PO accepts or rejects** |
| `/sprint-retro` | Sprint Retro | Interactive retrospective → **PO contributes + approves action items** |

## When to Use This vs Autonomous

| Use **Guided** (this template) when... | Use **Autonomous** when... |
|----------------------------------------|---------------------------|
| You want hands-on control over every phase | You trust the agent to run sprints end-to-end |
| The project is early-stage and direction is uncertain | The project has established patterns and priorities |
| You're learning the Scrum process with Copilot | You want fire-and-forget sprint execution |
| Multiple stakeholders need to approve scope | You're the sole decision-maker and time-constrained |
| You want to contribute observations during retros | You're OK with async sprint summaries |

## Sprint Documentation & Artifacts

Every sprint produces structured documentation that creates an audit trail and preserves knowledge across sessions.

### Where Things Are Stored

| Artifact | Location | Created By | Purpose |
|----------|----------|------------|---------|
| Sprint log | `docs/sprints/sprint-N-log.md` | Sprint Start | Huddle decisions, learnings, plan changes during execution |
| Velocity data | `docs/sprints/velocity.md` | Sprint Retro | Sprint-over-sprint performance tracking |
| Issue comments | GitHub Issues | Huddles | Traceable audit trail per issue |
| Implementation plans | `docs/plans/` | Planning / Writing Plans | Detailed implementation specs |
| ADRs | `docs/architecture/ADR.md` | As needed | Immutable architectural decisions |
| Process rules | `docs/constitution/PROCESS.md` | Sprint Retro | Evolving process constitution |

### The Huddle Documentation Rule

After each issue is completed, a **daily huddle** is performed. In PO-driven mode, the agent **presents results to the PO and asks if the plan is still valid**. Huddles are documented in **two places**:

1. **Comment on the completed GitHub issue** — permanent audit trail:
   ```bash
   gh issue comment 42 --body "### Huddle — Sprint 5, Issue 3/7 done
   **Outcome**: Implemented rate limiter with token bucket, 95% coverage
   **Key learning**: Redis connection pooling needed for production
   **PO Decision**: Agreed to re-prioritize #45 above #43
   **Next**: #45 — Connection pool configuration"
   ```

2. **Append to sprint log** (`docs/sprints/sprint-N-log.md`) — context for retros:
   ```markdown
   ### Huddle — After Issue #42 (2025-01-15 14:30)
   **Completed**: #42 — Rate limiter implemented
   **Sprint progress**: 3/7 issues done
   **PO feedback**: Approved, reorder remaining issues
   **Next up**: #45 — Connection pool configuration
   ```

### Sprint Log Template

Created at sprint start (`docs/sprints/sprint-N-log.md`):

```markdown
# Sprint N Log — [Date]

**Goal**: [One-sentence sprint goal]
**Planned**: [N] issues
**PO**: [approved at sprint-start]

## Huddles
[Appended after each issue — includes PO feedback]
```

### Velocity Tracking

Updated each sprint retro in `docs/sprints/velocity.md`:

```markdown
| Sprint | Date | Goal | Planned | Done | Carry | ~Hours | Issues/Hr | Notes |
|--------|------|------|---------|------|-------|--------|-----------|-------|
| 1      | ...  | ...  | 7       | 7    | 0     | 3.0    | 2.3       | First sprint |
| 2      | ...  | ...  | 7       | 5    | 2     | 3.5    | 1.4       | PO reduced scope mid-sprint |
```

This data drives sprint sizing — the agent presents velocity history when proposing sprint scope to the PO.

## Project Structure

```
├── AGENTS.md                        # Project-specific agent instructions
├── .github/
│   ├── copilot-instructions.md      # Main Copilot instructions (PO-driven model)
│   ├── agents/                      # Specialized agent definitions
│   │   ├── code-developer.agent.md
│   │   ├── test-engineer.agent.md
│   │   ├── documentation-agent.agent.md
│   │   ├── security-reviewer.agent.md
│   │   ├── research-agent.agent.md
│   │   ├── architect.agent.md
│   │   ├── release-agent.agent.md
│   │   └── copilot-customization-builder.agent.md
│   ├── prompts/                     # Reusable workflow prompts (PO consent gates)
│   │   ├── sprint-planning.prompt.md
│   │   ├── sprint-start.prompt.md
│   │   ├── sprint-review.prompt.md
│   │   ├── sprint-retro.prompt.md
│   │   ├── orchestrate-feature.prompt.md
│   │   ├── orchestrate-bugfix.prompt.md
│   │   ├── code-review.prompt.md
│   │   ├── create-pr.prompt.md
│   │   ├── tdd-workflow.prompt.md
│   │   ├── architecture-review.prompt.md
│   │   ├── release-check.prompt.md
│   │   ├── new-custom-agent.prompt.md
│   │   ├── new-prompt-file.prompt.md
│   │   └── new-instructions-file.prompt.md
│   ├── workflows/
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
├── docs/
│   ├── constitution/
│   │   ├── PROCESS.md
│   │   └── PHILOSOPHY.md
│   ├── architecture/ADR.md
│   ├── research/
│   │   └── JOURNAL.md
│   └── sprints/
│       ├── velocity.md
│       └── SPRINT-LOG-TEMPLATE.md
├── scripts/copilot-notify.sh
├── Makefile
└── pyproject.toml
```

## License

MIT

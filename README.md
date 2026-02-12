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

Search for `{{PROJECT_NAME}}` and `{{PROJECT_DESCRIPTION}}` in `CLAUDE.md`, `pyproject.toml`, and other files. Replace with your project details.

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

## Project Structure

```
├── CLAUDE.md                          # Main agent instructions (PO-guided model)
├── .claude/
│   ├── settings.json                  # Permissions, hooks, skills, agents
│   ├── hooks/
│   │   ├── ntfy-notify.sh             # Push notification hook
│   │   └── session-reminder.sh        # PO-mode reminder
│   ├── skills/
│   │   ├── sprint-planning/SKILL.md   # PO-driven planning
│   │   ├── sprint-start/SKILL.md      # PO-consent execution
│   │   ├── sprint-review/SKILL.md     # PO-acceptance review
│   │   ├── sprint-retro/SKILL.md      # Interactive retrospective
│   │   └── ...                        # Other skills (same as autonomous)
│   └── agents/
│       ├── code-developer.md
│       ├── test-engineer.md
│       └── ...
├── docs/
│   ├── constitution/PROCESS.md        # Guided stakeholder model
│   ├── architecture/ADR.md            # Architecture decisions
│   └── sprints/velocity.md            # Velocity tracker
├── .github/
│   ├── workflows/ci.yml               # CI pipeline
│   ├── ISSUE_TEMPLATE/                # Bug/feature templates
│   └── PULL_REQUEST_TEMPLATE.md
├── Makefile                           # Developer shortcuts
└── pyproject.toml                     # Python project config
```

## License

MIT

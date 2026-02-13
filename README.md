# Copilot Scrum Guided

[![Optimized for GitHub Copilot CLI](https://img.shields.io/badge/Optimized%20for-GitHub%20Copilot%20CLI-blue?logo=github)](https://docs.github.com/en/copilot)
[![Framework Docs](https://img.shields.io/badge/Framework-AI--Scrum-6c63ff)](https://trsdn.github.io/ai-scrum/)

A template repository for **PO-driven Scrum development** powered by GitHub Copilot CLI. The human is the Product Owner who manually drives each sprint phase. The agent is the Scrum Master + development team but always waits for PO approval before proceeding.

> See [copilot-scrum-autonomous](https://github.com/trsdn/copilot-scrum-autonomous) for the autonomous variant where the agent also acts as PO.
>
> 📖 **[Read the full framework documentation →](https://trsdn.github.io/ai-scrum/)**

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
- **Specialized agents**: Code developer, test engineer, security reviewer, documentation agent, research agent, architect, challenger, CI fixer
- **Push notifications**: ntfy.sh integration for task completion and input needed alerts
- **Sprint velocity tracking**: Data-driven sprint sizing from historical performance
- **GitHub Issues as task system**: Labels (`status:planned` → `status:in-progress` → `status:validation` → closed) + Milestones for sprint grouping

## Prerequisites

- **GitHub Copilot subscription** (Pro, Pro+, Business, or Enterprise) — [plans](https://github.com/features/copilot/plans)
- **Copilot CLI** installed — [installation guide](https://docs.github.com/en/copilot/concepts/agents/about-copilot-cli)
- **Experimental mode** (optional but recommended) — enables Autopilot mode for longer tasks:
  ```bash
  copilot --experimental    # Enable on first launch (persisted in config)
  ```
  Press `Shift+Tab` inside a session to cycle between Interactive, Plan, and Autopilot modes.

## Getting Started

### 1. Use this template

Click **"Use this template"** on GitHub to create a new repository from this template.

### 2. Customize placeholders

Search for `{{PROJECT_NAME}}` and `{{PROJECT_DESCRIPTION}}` in `AGENTS.md`, `.github/copilot-instructions.md`, `pyproject.toml`, and other files. Replace with your project details.

### 3. Set up status labels and milestones

Create these labels in your repository: `status:planned`, `status:in-progress`, `status:validation`. Create milestones for each sprint (`Sprint 1`, `Sprint 2`, etc.). Issues without a status label are in the backlog; closed issues are done.

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

## How PO Interaction Works

The agent uses the `ask_user` tool throughout ceremonies to get PO input. Here are examples of what that looks like in practice:

```
# During planning
ask_user: "Which of these issues should go into Sprint N?"
  choices: ["All 7 recommended", "Only high priority (3)", "Let me pick individually"]

# During sprint start
ask_user: "Here's the execution plan. Ready to start?"
  choices: ["Go", "Reorder first", "Remove an issue"]

# During huddles
ask_user: "Issue #N is done. Is the plan still valid?"
  choices: ["Continue as planned", "Reprioritize", "Stop sprint"]

# During review
ask_user: "Do you accept these deliverables?"
  choices: ["Accepted", "Accepted with notes", "Changes requested"]
```

The PO never needs to type complex commands — the agent presents multiple-choice options at every consent gate. This keeps the interaction efficient while ensuring the PO stays in control.

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
│   │   ├── copilot-customization-builder.agent.md
│   │   ├── challenger.agent.md
│   │   └── ci-fixer.agent.md
│   ├── skills/                      # Reusable workflow skills (works in CLI + VS Code)
│   │   ├── sprint-planning/SKILL.md
│   │   ├── sprint-start/SKILL.md
│   │   ├── sprint-review/SKILL.md
│   │   ├── sprint-retro/SKILL.md
│   │   ├── orchestrate-feature/SKILL.md
│   │   ├── orchestrate-bugfix/SKILL.md
│   │   ├── code-review/SKILL.md
│   │   ├── create-pr/SKILL.md
│   │   ├── tdd-workflow/SKILL.md
│   │   ├── architecture-review/SKILL.md
│   │   ├── release-check/SKILL.md
│   │   ├── new-custom-agent/SKILL.md
│   │   ├── new-prompt-file/SKILL.md
│   │   ├── new-instructions-file/SKILL.md
│   │   ├── direction-gate/SKILL.md
│   │   ├── subagent-dispatch/SKILL.md
│   │   ├── writing-plans/SKILL.md
│   │   ├── web-research/SKILL.md
│   │   ├── issue-triage/SKILL.md
│   │   └── refine/SKILL.md
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

## Philosophy

> **The AI-Scrum Manifesto** — see [`docs/constitution/PHILOSOPHY.md`](docs/constitution/PHILOSOPHY.md)

*We have come to value:*
- **Structured collaboration** over unguided generation
- **Verified evidence** over claimed completion
- **Sprint discipline** over feature chasing
- **Continuous process improvement** over static workflows

*Inspired by the [Agile Manifesto](https://agilemanifesto.org), adapted for human-AI collaboration.*

<details>
<summary><strong>How the Agile Manifesto maps to AI-Scrum</strong></summary>

#### Values

| Agile Manifesto (2001) | AI-Scrum (2025) | Why It Changed |
|------------------------|-----------------|----------------|
| Individuals and interactions over processes | Structured collaboration over unguided generation | The agent needs clear scope from the PO — not open-ended freedom |
| Working software over documentation | Verified evidence over claimed completion | The agent will *say* it works — make it *prove* it works |
| Customer collaboration over contracts | Consent gates over blind trust | The PO's approval at each phase ensures alignment |
| Responding to change over following a plan | Sprint discipline over feature chasing | The agent *loves* to chase — the PO keeps it focused |

#### The 12 Principles

| Agile Principle | AI-Scrum Equivalent |
|----------------|-------------------|
| Satisfy customer through early, continuous delivery | Small, tested diffs — one feature per PR |
| Welcome changing requirements | Welcome scope changes — route through backlog |
| Deliver working software frequently | Sprint cycles with CI verification |
| Business people and developers work together daily | Human brings judgment; agent brings throughput |
| Build around motivated individuals, trust them | The agent is not a junior dev — give it constraints, not motivation |
| Face-to-face conversation | Huddles documented in two places (issue + sprint log) |
| Working software is primary measure of progress | Evidence before assertions, always |
| Sustainable development, constant pace | Velocity is descriptive, not prescriptive |
| Continuous attention to technical excellence | Quality gates are non-negotiable |
| Simplicity — maximize work not done | Prefer config over code, existing over new |
| Best architectures emerge from self-organizing teams | Best architecture emerges from small, tested diffs |
| Regularly reflect and adjust | Process improvements compound |

</details>

## License

MIT

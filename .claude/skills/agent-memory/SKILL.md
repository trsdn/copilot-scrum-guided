---
name: agent-memory
description: "Use this skill when the user asks to save, remember, recall, or organize memories. Triggers on: 'remember this', 'save this', 'note this', 'what did we discuss about...', 'check your notes', 'clean up memories'. Also use proactively when discovering valuable findings worth preserving."
---

# Agent Memory

A persistent memory space for storing knowledge that survives across conversations.

**Location:** `.claude/skills/agent-memory/memories/`

## Proactive Usage

Save memories when you discover something worth preserving:
- Research findings that took effort to uncover
- Non-obvious patterns or gotchas in the codebase
- Solutions to tricky problems
- Architectural decisions and their rationale
- In-progress work that may be resumed later

Check memories when starting related work:
- Before investigating a problem area
- When working on a feature you've touched before
- When resuming work after a conversation break

## Folder Structure

Organize memories into category folders. No predefined structure — create categories that make sense for the content.

Guidelines:
- Use kebab-case for folder and file names
- Consolidate or reorganize as the knowledge base evolves

## Frontmatter

All memories must include frontmatter with a `summary` field:

```yaml
---
summary: "1-2 line description of what this memory contains"
created: 2025-01-15
---
```

Optional fields: `updated`, `status` (in-progress | resolved | blocked | abandoned), `tags`, `related`.

## Search Workflow

```bash
# List categories
ls .claude/skills/agent-memory/memories/

# View all summaries
rg "^summary:" .claude/skills/agent-memory/memories/ --no-ignore --hidden

# Search summaries for keyword
rg "^summary:.*keyword" .claude/skills/agent-memory/memories/ --no-ignore --hidden -i
```

## Operations

### Save
```bash
mkdir -p .claude/skills/agent-memory/memories/category-name/
cat > .claude/skills/agent-memory/memories/category-name/filename.md << 'EOF'
---
summary: "Brief description"
created: 2025-01-15
---

# Title

Content here...
EOF
```

### Maintain
- **Update**: Add `updated` field when content changes
- **Delete**: Remove irrelevant memories
- **Consolidate**: Merge related memories

---
name: notify
description: 'Send push notifications to mobile via ntfy.sh. Use this skill to notify the user when tasks complete, when input is needed, or for important alerts. Triggers on: "notify me", "send notification", "alert me", "ping me", or when completing long-running tasks.'
---

# Notify Skill

Send push notifications to mobile devices via [ntfy.sh](https://ntfy.sh).

## Configuration

```bash
export NTFY_TOPIC="your-secret-topic"
```

## How to Send Notifications

### Basic notification
```bash
curl -s -d "Your message here" ntfy.sh/$NTFY_TOPIC
```

### With title and priority
```bash
curl -s \
  -H "Title: Task Complete" \
  -H "Priority: high" \
  -H "Tags: white_check_mark" \
  -d "Sprint N complete — 7/7 issues done" \
  ntfy.sh/$NTFY_TOPIC
```

### Common Tags (emoji)
- `white_check_mark` ✅ - Success
- `warning` ⚠️ - Warning
- `x` ❌ - Error
- `question` ❓ - Input needed
- `hourglass` ⏳ - In progress

## When to Notify

1. **Task completion** - When a long-running task finishes
2. **Input needed** - When PO decision is required
3. **Errors** - When something fails unexpectedly

## Setup Instructions

1. Install ntfy app on your phone ([iOS](https://apps.apple.com/app/ntfy/id1625396347) / [Android](https://play.google.com/store/apps/details?id=io.heckel.ntfy))
2. Subscribe to your topic in the app
3. Set the environment variable:
   ```bash
   echo 'export NTFY_TOPIC="your-secret-topic"' >> ~/.zshrc
   source ~/.zshrc
   ```
4. Test: `curl -d "Test notification" ntfy.sh/$NTFY_TOPIC`

#!/bin/bash
# Hook: Send push notifications to iOS/Android via ntfy.sh
# Used by Stop, Notification, and SessionEnd hooks.
#
# Claude Code passes all context as JSON via stdin:
#   hook_event_name — Stop, Notification, SessionEnd
#   notification_type — for Notification: permission_prompt, idle_prompt, etc.
#   message — for Notification: human-readable description
#   reason — for SessionEnd: clear, logout, prompt_input_exit, etc.
#   stop_hook_active — for Stop: true if hook already triggered continuation

# Load NTFY_TOPIC from ~/.zshrc if not already in environment
if [ -z "${NTFY_TOPIC:-}" ]; then
  NTFY_TOPIC=$(sed -n 's/^export NTFY_TOPIC="\(.*\)"/\1/p' ~/.zshrc 2>/dev/null || true)
fi
if [ -z "$NTFY_TOPIC" ]; then
  exit 0  # No topic configured, skip silently
fi
NTFY_URL="https://ntfy.sh/${NTFY_TOPIC}"

# Read JSON from stdin
INPUT=$(cat /dev/stdin 2>/dev/null || echo "{}")

# Parse fields using python3 (available on macOS, no jq dependency)
EVENT=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('hook_event_name','unknown'))" 2>/dev/null)
NOTIF_TYPE=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('notification_type',''))" 2>/dev/null)
NOTIF_MSG=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('message',''))" 2>/dev/null)
STOP_ACTIVE=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('stop_hook_active', False))" 2>/dev/null)
END_REASON=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('reason',''))" 2>/dev/null)

# For Stop hooks, skip if already active (prevent loops)
if [ "$EVENT" = "Stop" ] && [ "$STOP_ACTIVE" = "True" ]; then
  exit 0
fi

case "$EVENT" in
  Stop)
    TITLE="Claude finished"
    MESSAGE="Claude has finished and is waiting for your input."
    PRIORITY="default"
    TAGS="white_check_mark"
    ;;
  Notification)
    case "$NOTIF_TYPE" in
      permission_prompt)
        TITLE="Claude needs permission"
        MESSAGE="${NOTIF_MSG:-Claude is waiting for you to approve a tool call.}"
        PRIORITY="high"
        TAGS="key"
        ;;
      idle_prompt)
        TITLE="Claude is idle"
        MESSAGE="${NOTIF_MSG:-Claude is waiting for your input.}"
        PRIORITY="default"
        TAGS="hourglass"
        ;;
      *)
        TITLE="Claude notification"
        MESSAGE="${NOTIF_MSG:-Notification: $NOTIF_TYPE}"
        PRIORITY="default"
        TAGS="bell"
        ;;
    esac
    ;;
  SessionEnd)
    TITLE="Session ended"
    MESSAGE="Claude Code session ended (${END_REASON:-unknown reason})."
    PRIORITY="low"
    TAGS="wave"
    ;;
  *)
    TITLE="Claude Code"
    MESSAGE="Event: $EVENT"
    PRIORITY="default"
    TAGS="robot_face"
    ;;
esac

# Send notification (fire-and-forget, don't block Claude)
curl -s -o /dev/null \
  -H "Title: $TITLE" \
  -H "Priority: $PRIORITY" \
  -H "Tags: $TAGS" \
  -d "$MESSAGE" \
  "$NTFY_URL" &

exit 0

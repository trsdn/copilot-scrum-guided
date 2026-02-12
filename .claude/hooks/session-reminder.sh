#!/bin/bash
# Hook: UserPromptSubmit — remind agent about PO-driven mode
# Reads session_id from JSON stdin provided by Claude Code to create a stable guard file.

INPUT=$(cat /dev/stdin)
SESSION_ID=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id','unknown'))" 2>/dev/null)

# Fallback if no session_id available
if [ -z "$SESSION_ID" ] || [ "$SESSION_ID" = "unknown" ]; then
  SESSION_ID="fallback"
fi

GUARD_FILE="/tmp/claude_session_reminder_${SESSION_ID}"

if [ ! -f "$GUARD_FILE" ]; then
  touch "$GUARD_FILE"
  echo '{"suppressOutput":true,"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"PO-driven mode: Always present options and wait for PO approval before proceeding. Use ask_user tool for PO decisions."}}'
fi

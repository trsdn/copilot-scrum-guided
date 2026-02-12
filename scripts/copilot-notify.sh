#!/usr/bin/env bash
# Send push notifications via ntfy.sh
# Usage:
#   copilot-notify.sh "message"                    # Simple notification
#   copilot-notify.sh "Title" "message body"       # With custom title
#   copilot-notify.sh "Title" "body" "high"        # With priority

set -euo pipefail

if [ -z "${NTFY_TOPIC:-}" ]; then
    echo "⚠️  NTFY_TOPIC not set — skipping notification"
    exit 0
fi

if [ $# -eq 0 ]; then
    echo "Usage: copilot-notify.sh <message> [title] [priority]"
    exit 1
fi

if [ $# -eq 1 ]; then
    # Simple message
    curl -s -d "$1" "ntfy.sh/$NTFY_TOPIC" > /dev/null
elif [ $# -eq 2 ]; then
    # Title + body
    curl -s \
        -H "Title: $1" \
        -d "$2" \
        "ntfy.sh/$NTFY_TOPIC" > /dev/null
else
    # Title + body + priority
    curl -s \
        -H "Title: $1" \
        -H "Priority: $3" \
        -d "$2" \
        "ntfy.sh/$NTFY_TOPIC" > /dev/null
fi

echo "📱 Notification sent"

#!/bin/bash
# Smart notification helper for Claude Code
# Usage: notify.sh "title" "message" [level]
# Levels: info (silent), warn (sound), error (sound+sticky)

TITLE="${1:-Claude Code}"
MESSAGE="${2:-Notification}"
LEVEL="${3:-info}"
LOG_DIR="$HOME/.claude/orchestration-logs"
LOG_FILE="$LOG_DIR/notifications-$(date +%Y-%m-%d).log"

echo "[$(date '+%H:%M:%S')] [$LEVEL] $TITLE: $MESSAGE" >> "$LOG_FILE"

case "$LEVEL" in
  info)
    osascript -e "display notification \"$MESSAGE\" with title \"Claude Code\" subtitle \"$TITLE\"" 2>/dev/null
    ;;
  warn)
    osascript -e "display notification \"$MESSAGE\" with title \"Claude Code\" subtitle \"$TITLE\" sound name \"Blow\"" 2>/dev/null
    ;;
  error)
    osascript -e "display notification \"$MESSAGE\" with title \"Claude Code\" subtitle \"$TITLE\" sound name \"Sosumi\"" 2>/dev/null
    # Also play alert sound for attention
    afplay /System/Library/Sounds/Sosumi.aiff 2>/dev/null &
    ;;
esac

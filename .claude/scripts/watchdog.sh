#!/bin/bash
# Watchdog script - monitors CMUX tmux sessions for stalled agents
# Run via launchd or manually: ./watchdog.sh
#
# Checks:
# 1. Are tmux sessions alive?
# 2. Has any pane been idle too long (no output)?
# 3. Is any pane stuck on a permission prompt?

TMUX_BIN="$HOME/local/bin/tmux"
LOG_DIR="$HOME/.claude/orchestration-logs"
LOG_FILE="$LOG_DIR/watchdog-$(date +%Y-%m-%d).log"
IDLE_THRESHOLD=1800  # 30 minutes without activity = stalled

log() {
  echo "[$(date '+%H:%M:%S')] $1" >> "$LOG_FILE"
}

notify() {
  local title="$1"
  local message="$2"
  osascript -e "display notification \"$message\" with title \"Claude Code\" subtitle \"$title\" sound name \"Blow\"" 2>/dev/null
}

# Check tmux is available
if [ ! -x "$TMUX_BIN" ]; then
  echo "tmux not found at $TMUX_BIN"
  exit 1
fi

# Get all tmux sessions
SESSIONS=$("$TMUX_BIN" list-sessions -F '#{session_name}' 2>/dev/null)
if [ -z "$SESSIONS" ]; then
  log "INFO No tmux sessions running"
  exit 0
fi

STALLED_COUNT=0
TOTAL_PANES=0

for SESSION in $SESSIONS; do
  PANES=$("$TMUX_BIN" list-panes -t "$SESSION" -F '#{pane_id}:#{pane_current_command}:#{pane_activity}' 2>/dev/null)

  for PANE_INFO in $PANES; do
    PANE_ID=$(echo "$PANE_INFO" | cut -d: -f1)
    PANE_CMD=$(echo "$PANE_INFO" | cut -d: -f2)
    PANE_ACTIVITY=$(echo "$PANE_INFO" | cut -d: -f3)

    TOTAL_PANES=$((TOTAL_PANES + 1))
    NOW=$(date +%s)
    IDLE_TIME=$((NOW - PANE_ACTIVITY))

    if [ "$IDLE_TIME" -gt "$IDLE_THRESHOLD" ]; then
      IDLE_MIN=$((IDLE_TIME / 60))
      log "STALLED Session=$SESSION Pane=$PANE_ID Cmd=$PANE_CMD Idle=${IDLE_MIN}min"
      STALLED_COUNT=$((STALLED_COUNT + 1))
    else
      log "OK Session=$SESSION Pane=$PANE_ID Cmd=$PANE_CMD Idle=${IDLE_TIME}s"
    fi
  done
done

if [ "$STALLED_COUNT" -gt 0 ]; then
  notify "Watchdog" "$STALLED_COUNT agent(s) inactif(s) depuis 30+ min"
  log "ALERT $STALLED_COUNT/$TOTAL_PANES pane(s) stalled"
else
  log "ALL OK $TOTAL_PANES pane(s) active"
fi

echo "Checked $TOTAL_PANES panes, $STALLED_COUNT stalled"

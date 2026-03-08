#!/bin/bash
# Health check script - run at SessionStart or manually
# Checks MCP servers, tmux, and logs results

LOG_DIR="$HOME/.claude/orchestration-logs"
LOG_FILE="$LOG_DIR/health-$(date +%Y-%m-%d).log"
NOTIFY_ERRORS=""

log() {
  echo "[$(date '+%H:%M:%S')] $1" >> "$LOG_FILE"
}

notify() {
  local title="$1"
  local message="$2"
  osascript -e "display notification \"$message\" with title \"Claude Code\" subtitle \"$title\"" 2>/dev/null
}

# --- MCP Server Checks ---

# Check Figma Console (HTTP on localhost:3845)
if curl -s --max-time 3 http://127.0.0.1:3845/mcp > /dev/null 2>&1; then
  log "OK  Figma MCP (HTTP 127.0.0.1:3845)"
else
  log "FAIL Figma MCP - not responding on port 3845"
  NOTIFY_ERRORS="${NOTIFY_ERRORS}Figma MCP down. "
fi

# Check if npx-based MCP servers can be resolved
for server in "@supabase/mcp-server-supabase" "@modelcontextprotocol/server-github" "@upstash/context7-mcp"; do
  if npx --yes "$server" --help > /dev/null 2>&1; then
    log "OK  $server (resolvable)"
  else
    log "WARN $server - may not be installed (will install on first use)"
  fi
done

# --- tmux Check ---
TMUX_BIN="$HOME/local/bin/tmux"
if [ -x "$TMUX_BIN" ]; then
  SESSIONS=$("$TMUX_BIN" list-sessions 2>/dev/null | wc -l | tr -d ' ')
  log "OK  tmux available - $SESSIONS active session(s)"
else
  log "FAIL tmux not found at $TMUX_BIN"
  NOTIFY_ERRORS="${NOTIFY_ERRORS}tmux missing. "
fi

# --- Disk Space Check ---
DISK_AVAIL=$(df -g "$HOME" | tail -1 | awk '{print $4}')
if [ "$DISK_AVAIL" -lt 5 ]; then
  log "WARN Disk space low: ${DISK_AVAIL}GB remaining"
  NOTIFY_ERRORS="${NOTIFY_ERRORS}Disk low (${DISK_AVAIL}GB). "
else
  log "OK  Disk space: ${DISK_AVAIL}GB available"
fi

# --- Report ---
if [ -n "$NOTIFY_ERRORS" ]; then
  notify "Health Check" "$NOTIFY_ERRORS"
  log "ALERT Notification sent: $NOTIFY_ERRORS"
  echo "HEALTH_CHECK_ISSUES: $NOTIFY_ERRORS"
  exit 1
else
  log "ALL OK - health check passed"
  echo "OK"
  exit 0
fi

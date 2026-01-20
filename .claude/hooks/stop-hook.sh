#!/bin/bash

# ============================================================
# RALPH Stop Hook
# Intercepts Claude's exit attempts for autonomous looping
# ============================================================

# Configuration file path
CONFIG_FILE=".claude/ralph-state.json"
LOG_DIR="docs/ralph-logs"

# Read current state
if [ -f "$CONFIG_FILE" ]; then
    ACTIVE=$(jq -r '.active // false' "$CONFIG_FILE" 2>/dev/null)
    ITERATION=$(jq -r '.iteration // 0' "$CONFIG_FILE" 2>/dev/null)
    MAX_ITERATIONS=$(jq -r '.maxIterations // 20' "$CONFIG_FILE" 2>/dev/null)
    COMPLETION_PROMISE=$(jq -r '.completionPromise // "DONE"' "$CONFIG_FILE" 2>/dev/null)
    ORIGINAL_PROMPT=$(jq -r '.originalPrompt // ""' "$CONFIG_FILE" 2>/dev/null)
    START_TIME=$(jq -r '.startTime // 0' "$CONFIG_FILE" 2>/dev/null)
    TIMEOUT_SECONDS=$(jq -r '.timeoutSeconds // 3600' "$CONFIG_FILE" 2>/dev/null)
    LOG_ENABLED=$(jq -r '.logEnabled // true' "$CONFIG_FILE" 2>/dev/null)
    SESSION_ID=$(jq -r '.sessionId // ""' "$CONFIG_FILE" 2>/dev/null)
else
    # No config = no RALPH mode, allow exit
    exit 0
fi

# If RALPH not active, allow normal exit
if [ "$ACTIVE" != "true" ]; then
    exit 0
fi

# Get current timestamp
CURRENT_TIME=$(date +%s)

# Calculate elapsed time
ELAPSED=$((CURRENT_TIME - START_TIME))

# Function to log iteration
log_iteration() {
    if [ "$LOG_ENABLED" = "true" ]; then
        mkdir -p "$LOG_DIR"
        LOG_FILE="$LOG_DIR/ralph-session-$SESSION_ID.md"

        if [ ! -f "$LOG_FILE" ]; then
            echo "# RALPH Session: $SESSION_ID" > "$LOG_FILE"
            echo "" >> "$LOG_FILE"
            echo "**Started:** $(date -d @$START_TIME '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
            echo "**Prompt:** $ORIGINAL_PROMPT" >> "$LOG_FILE"
            echo "**Max Iterations:** $MAX_ITERATIONS" >> "$LOG_FILE"
            echo "**Timeout:** ${TIMEOUT_SECONDS}s" >> "$LOG_FILE"
            echo "" >> "$LOG_FILE"
            echo "---" >> "$LOG_FILE"
            echo "" >> "$LOG_FILE"
            echo "## Iterations" >> "$LOG_FILE"
            echo "" >> "$LOG_FILE"
        fi

        echo "### Iteration $ITERATION - $(date '+%H:%M:%S')" >> "$LOG_FILE"
        echo "- Elapsed: ${ELAPSED}s" >> "$LOG_FILE"
        echo "- Status: $1" >> "$LOG_FILE"
        echo "" >> "$LOG_FILE"
    fi
}

# Function to complete and cleanup
complete_ralph() {
    local REASON=$1

    # Log completion
    log_iteration "COMPLETED - $REASON"

    if [ "$LOG_ENABLED" = "true" ]; then
        LOG_FILE="$LOG_DIR/ralph-session-$SESSION_ID.md"
        echo "---" >> "$LOG_FILE"
        echo "" >> "$LOG_FILE"
        echo "## Summary" >> "$LOG_FILE"
        echo "" >> "$LOG_FILE"
        echo "- **Total Iterations:** $ITERATION" >> "$LOG_FILE"
        echo "- **Total Time:** ${ELAPSED}s" >> "$LOG_FILE"
        echo "- **Exit Reason:** $REASON" >> "$LOG_FILE"
        echo "- **Completed:** $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    fi

    # Deactivate RALPH
    jq '.active = false' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

    # Allow exit
    exit 0
}

# Read Claude's last output from stdin
CLAUDE_OUTPUT=$(cat)

# Check 1: Completion promise found?
if echo "$CLAUDE_OUTPUT" | grep -q "$COMPLETION_PROMISE"; then
    complete_ralph "Completion promise found: $COMPLETION_PROMISE"
fi

# Check 2: Max iterations reached?
if [ "$ITERATION" -ge "$MAX_ITERATIONS" ]; then
    complete_ralph "Max iterations reached: $MAX_ITERATIONS"
fi

# Check 3: Timeout reached?
if [ "$ELAPSED" -ge "$TIMEOUT_SECONDS" ]; then
    complete_ralph "Timeout reached: ${TIMEOUT_SECONDS}s"
fi

# None of the exit conditions met - continue looping
# Increment iteration counter
NEW_ITERATION=$((ITERATION + 1))
jq ".iteration = $NEW_ITERATION" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

# Log this iteration
log_iteration "CONTINUING"

# Output the prompt to re-inject (goes to Claude)
echo ""
echo "---"
echo ""
echo "🔄 **RALPH Loop - Iteration $NEW_ITERATION/$MAX_ITERATIONS** (${ELAPSED}s elapsed)"
echo ""
echo "Continue working on the task. When complete, include '$COMPLETION_PROMISE' in your response."
echo ""
echo "**Original task:** $ORIGINAL_PROMPT"
echo ""

# Exit code 2 = block exit and show message to Claude
exit 2
